import { BulkUpdatePayload, BulkUpdateResult, ItemsUpdatePayload, ConditionUpdatePayload } from '../types/bulkUpdate.type';
import { HttpError } from '../errors/httpError';
import { ValidationEngine } from './validationEngine.service';
import { validateConditionFields } from '../utils/schemaValidator.util';

export async function bulkUpdateService(
  collection: string,
  payload: BulkUpdatePayload,
  accountability: any,
  context: any
): Promise<BulkUpdateResult> {
  const { services, getSchema } = context;

  if (!services?.ItemsService) {
    throw new HttpError(500, 'Internal server error: ItemsService not available');
  }

  const schema = await getSchema();
  if (!schema?.collections?.[collection]) {
    throw new HttpError(404, `Collection '${collection}' does not exist`);
  }

  const collectionSchema = schema.collections[collection];
  const itemsService = new services.ItemsService(collection, {
    schema,
    accountability
  });

  const validationEngine = payload.validation ? new ValidationEngine(payload.validation) : null;
  const { stopOnError = false, dryRun = false } = payload.options || {};

  if ('items' in payload) {
    return await processItemsUpdate(
      collection,
      payload,
      itemsService,
      validationEngine,
      collectionSchema,
      stopOnError,
      dryRun,
      context,
      accountability
    );
  }

  if ('condition' in payload) {
    return await processConditionUpdate(
      collection,
      payload,
      itemsService,
      validationEngine,
      collectionSchema,
      stopOnError,
      dryRun,
      context,
      accountability
    );
  }

  throw new HttpError(400, 'Invalid payload: must contain either "items" or "condition" with "data"');
}

async function processItemsUpdate(
  collection: string,
  payload: ItemsUpdatePayload,
  itemsService: any,
  validationEngine: ValidationEngine | null,
  collectionSchema: any,
  stopOnError: boolean,
  dryRun: boolean,
  context: any,
  accountability: any
): Promise<BulkUpdateResult> {
  const { items } = payload;

  const result: BulkUpdateResult = {
    total: items.length,
    successful: 0,
    failed: 0,
    items: [],
    options: {
      dryRun,
      stopOnError
    }
  };

  for (const item of items) {
    const { id, ...fieldsToUpdate } = item;
    
    try {
      for (const fieldName of Object.keys(fieldsToUpdate)) {
        if (!collectionSchema.fields?.[fieldName]) {
          throw new HttpError(400, `Field '${fieldName}' does not exist in collection '${collection}'`);
        }
      }

      if (validationEngine) {
        try {
          await validationEngine.validateFieldsWithContext(
            fieldsToUpdate,
            null,
            context,
            accountability
          );
        } catch (validationError: any) {
          if (validationError instanceof HttpError) {
            throw validationError;
          }
          throw new HttpError(400, `Validation failed for item '${id}': ${validationError.message || 'Unknown validation error'}`);
        }
      }

      if (dryRun) {
        result.items.push({
          id,
          success: true
        });
        result.successful++;
      } else {
        try {
          await itemsService.updateOne(id, fieldsToUpdate);
          result.items.push({
            id,
            success: true
          });
          result.successful++;
        } catch (updateError: any) {
          const errorMessage = updateError.message || String(updateError) || '';
          const errorStatus = updateError.status || updateError.statusCode;
          
          const notFoundPatterns = [
            'not found',
            'doesn\'t exist',
            'does not exist',
            'record not found',
            'item not found',
            'no item found',
            'no record found'
          ];
          
          const errorMessageLower = errorMessage.toLowerCase();
          const isNotFound = notFoundPatterns.some(pattern => 
            errorMessageLower.includes(pattern.toLowerCase())
          );

          if (errorStatus === 404 || isNotFound) {
            throw new HttpError(404, `Item with id '${id}' not found in collection '${collection}'`);
          }
          
          if (errorStatus === 403 || errorMessageLower.includes('permission') || errorMessageLower.includes('forbidden')) {
            throw new HttpError(403, `Forbidden: insufficient permissions to update item '${id}' in collection '${collection}'`);
          }
          
          throw new HttpError(errorStatus || 500, `Failed to update item '${id}' in collection '${collection}': ${errorMessage || 'Unknown error'}`);
        }
      }
    } catch (error: any) {
      const errorMessage = error instanceof HttpError ? error.message : (error.message || 'Unknown error');
      result.items.push({
        id,
        success: false,
        error: errorMessage
      });
      result.failed++;

      if (stopOnError) {
        return result;
      }
    }
  }

  return result;
}

async function processConditionUpdate(
  collection: string,
  payload: ConditionUpdatePayload,
  itemsService: any,
  validationEngine: ValidationEngine | null,
  collectionSchema: any,
  stopOnError: boolean,
  dryRun: boolean,
  context: any,
  accountability: any
): Promise<BulkUpdateResult> {
  const { condition, data } = payload;

  validateConditionFields(condition, collectionSchema, collection);

  for (const fieldName of Object.keys(data)) {
    if (!collectionSchema.fields?.[fieldName]) {
      throw new HttpError(400, `Field '${fieldName}' in update data does not exist in collection '${collection}'`);
    }
  }

  const matchingItems = await itemsService.readByQuery({
    filter: condition,
    limit: -1
  });

  if (!matchingItems || !Array.isArray(matchingItems)) {
    throw new HttpError(500, 'Invalid response from query - expected array of items');
  }

  const items = matchingItems;

  if (items.length === 0) {
    return {
      total: 0,
      successful: 0,
      failed: 0,
      items: [],
      options: {
        dryRun,
        stopOnError
      }
    };
  }

  const result: BulkUpdateResult = {
    total: items.length,
    successful: 0,
    failed: 0,
    items: [],
    options: {
      dryRun,
      stopOnError
    }
  };

  for (const existingItem of items) {
    const id = existingItem.id;
    if (id === undefined || id === null) {
      result.items.push({
        id: 'unknown',
        success: false,
        error: 'Item missing id field'
      });
      result.failed++;
      if (stopOnError) {
        return result;
      }
      continue;
    }

    try {
      if (validationEngine) {
        await validationEngine.validateFieldsWithContext(
          data,
          existingItem,
          context,
          accountability
        );
      }

      if (dryRun) {
        result.items.push({ id, success: true });
        result.successful++;
      } else {
        await itemsService.updateOne(id, data);
        result.items.push({ id, success: true });
        result.successful++;
      }
    } catch (error: any) {
      const errorMessage = error instanceof HttpError ? error.message : (error.message || 'Unknown error');
      result.items.push({ id, success: false, error: errorMessage });
      result.failed++;

      if (stopOnError) {
        return result;
      }
    }
  }

  return result;
}