import { HttpError } from '../errors/httpError';
import { BulkUpdatePayload, BulkUpdateOptions, ValidationRules, FieldValidationRule } from '../types/bulkUpdate.type';

export function validateBulkUpdateRequest(body: any): BulkUpdatePayload {
  const { items, condition, data, options, validation } = body;

  const hasItems = items !== undefined;
  const hasCondition = condition !== undefined && data !== undefined;

  if (!hasItems && !hasCondition) {
    throw new HttpError(400, 'Either `items` array or `condition` with `data` must be provided');
  }

  if (hasItems && hasCondition) {
    throw new HttpError(400, 'Cannot provide both `items` and `condition` - use one or the other');
  }

  const normalizedOptions: BulkUpdateOptions = {
    stopOnError: options?.stopOnError ?? false,
    dryRun: options?.dryRun ?? false
  };

  if (hasItems) {
    if (!Array.isArray(items) || items.length === 0) {
      throw new HttpError(400, '`items` is required and must be a non-empty array');
    }

    for (let i = 0; i < items.length; i++) {
      const item = items[i];
      
      if (!item || typeof item !== 'object') {
        throw new HttpError(400, `Item at index ${i} must be an object`);
      }

      if (item.id === undefined || item.id === null) {
        throw new HttpError(400, `Item at index ${i} must have an 'id' field`);
      }

      const fieldsToUpdate = Object.keys(item).filter(key => key !== 'id');
      if (fieldsToUpdate.length === 0) {
        throw new HttpError(400, `Item at index ${i} must have at least one field to update (besides 'id')`);
      }
    }

    const normalizedValidation = validation ? validateValidationRules(validation) : undefined;

    return {
      items,
      options: normalizedOptions,
      validation: normalizedValidation
    };
  }

  if (hasCondition) {
    if (!condition || typeof condition !== 'object' || Array.isArray(condition)) {
      throw new HttpError(400, '`condition` must be an object');
    }

    if (Object.keys(condition).length === 0) {
      throw new HttpError(400, '`condition` cannot be empty');
    }

    if (!data || typeof data !== 'object' || Array.isArray(data)) {
      throw new HttpError(400, '`data` must be an object');
    }

    if (Object.keys(data).length === 0) {
      throw new HttpError(400, '`data` cannot be empty - at least one field must be provided for update');
    }

    const normalizedValidation = validation ? validateValidationRules(validation) : undefined;

    return {
      condition,
      data,
      options: normalizedOptions,
      validation: normalizedValidation
    };
  }

  throw new HttpError(400, 'Invalid request format');
}

function validateValidationRules(validation: any): ValidationRules {
  if (!validation || typeof validation !== 'object') {
    throw new HttpError(400, '`validation` must be an object');
  }

  const rules: ValidationRules = {};

  if (validation.global !== undefined) {
    rules.global = validateFieldRules(validation.global, 'global');
  }

  if (validation.fields !== undefined) {
    if (typeof validation.fields !== 'object' || Array.isArray(validation.fields)) {
      throw new HttpError(400, '`validation.fields` must be an object');
    }

    rules.fields = {};
    for (const [fieldName, fieldRules] of Object.entries(validation.fields)) {
      rules.fields[fieldName] = validateFieldRules(fieldRules, `fields.${fieldName}`);
    }
  }

  return rules;
}

function validateFieldRules(rules: any, path: string): FieldValidationRule | FieldValidationRule[] {
  if (Array.isArray(rules)) {
    return rules.map((rule, index) => validateSingleRule(rule, `${path}[${index}]`));
  } else if (rules && typeof rules === 'object') {
    return validateSingleRule(rules, path);
  } else {
    throw new HttpError(400, `Validation rule at '${path}' must be an object or array of objects`);
  }
}

function validateSingleRule(rule: any, path: string): FieldValidationRule {
  if (!rule || typeof rule !== 'object') {
    throw new HttpError(400, `Validation rule at '${path}' must be an object`);
  }

  const validatedRule: FieldValidationRule = {};

  if (rule.min !== undefined) {
    if (typeof rule.min !== 'number') {
      throw new HttpError(400, `Validation rule 'min' at '${path}' must be a number`);
    }
    validatedRule.min = rule.min;
  }

  if (rule.max !== undefined) {
    if (typeof rule.max !== 'number') {
      throw new HttpError(400, `Validation rule 'max' at '${path}' must be a number`);
    }
    validatedRule.max = rule.max;
  }

  if (rule.type !== undefined) {
    const validTypes = ['string', 'number', 'boolean', 'array', 'object'];
    if (!validTypes.includes(rule.type)) {
      throw new HttpError(400, `Validation rule 'type' at '${path}' must be one of: ${validTypes.join(', ')}`);
    }
    validatedRule.type = rule.type;
  }

  if (rule.required !== undefined) {
    if (typeof rule.required !== 'boolean') {
      throw new HttpError(400, `Validation rule 'required' at '${path}' must be a boolean`);
    }
    validatedRule.required = rule.required;
  }

  if (rule.pattern !== undefined) {
    if (typeof rule.pattern !== 'string') {
      throw new HttpError(400, `Validation rule 'pattern' at '${path}' must be a string`);
    }
    try {
      new RegExp(rule.pattern);
    } catch {
      throw new HttpError(400, `Validation rule 'pattern' at '${path}' is not a valid regex`);
    }
    validatedRule.pattern = rule.pattern;
  }

  if (rule.enum !== undefined) {
    if (!Array.isArray(rule.enum)) {
      throw new HttpError(400, `Validation rule 'enum' at '${path}' must be an array`);
    }
    validatedRule.enum = rule.enum;
  }

  if (rule.validator !== undefined) {
    const validValidators = ['email', 'url', 'uuid', 'positive', 'nonNegative', 'integer'];
    if (!validValidators.includes(rule.validator)) {
      throw new HttpError(400, `Validation rule 'validator' at '${path}' must be one of: ${validValidators.join(', ')}`);
    }
    validatedRule.validator = rule.validator;
  }

  if (rule.existsIn !== undefined) {
    if (!rule.existsIn || typeof rule.existsIn !== 'object' || Array.isArray(rule.existsIn)) {
      throw new HttpError(400, `Validation rule 'existsIn' at '${path}' must be an object`);
    }
    if (!rule.existsIn.collection || typeof rule.existsIn.collection !== 'string') {
      throw new HttpError(400, `Validation rule 'existsIn.collection' at '${path}' must be a non-empty string`);
    }
    if (rule.existsIn.message !== undefined && typeof rule.existsIn.message !== 'string') {
      throw new HttpError(400, `Validation rule 'existsIn.message' at '${path}' must be a string`);
    }
    validatedRule.existsIn = {
      collection: rule.existsIn.collection,
      message: rule.existsIn.message
    };
  }

  if (rule.message !== undefined) {
    if (typeof rule.message !== 'string') {
      throw new HttpError(400, `Validation rule 'message' at '${path}' must be a string`);
    }
    validatedRule.message = rule.message;
  }

  return validatedRule;
}
