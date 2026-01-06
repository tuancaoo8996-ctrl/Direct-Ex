import { HttpError } from '../errors/httpError';

export function validateConditionFields(
  condition: Record<string, any>,
  collectionSchema: any,
  collectionName: string,
  path: string = ''
): void {
  if (!condition || typeof condition !== 'object' || Array.isArray(condition)) {
    throw new HttpError(400, `Invalid condition format${path ? ` at '${path}'` : ''}`);
  }

  for (const [key, value] of Object.entries(condition)) {
    const currentPath = path ? `${path}.${key}` : key;

    if (key.startsWith('_')) {
      continue;
    }

    if (!collectionSchema.fields || !collectionSchema.fields[key]) {
      throw new HttpError(
        400,
        `Field '${key}'${path ? ` in condition path '${currentPath}'` : ''} does not exist in collection '${collectionName}'`
      );
    }

    if (value && typeof value === 'object' && !Array.isArray(value)) {
      const hasOperator = Object.keys(value).some(k => k.startsWith('_'));
      
      if (hasOperator) {
        continue;
      } else {
        validateConditionFields(value, collectionSchema, collectionName, currentPath);
      }
    }
  }
}

export function extractConditionFields(condition: Record<string, any>): string[] {
  const fields: string[] = [];

  for (const [key, value] of Object.entries(condition)) {
    if (key.startsWith('_')) {
      continue;
    }

    fields.push(key);

    if (value && typeof value === 'object' && !Array.isArray(value)) {
      const hasOperator = Object.keys(value).some(k => k.startsWith('_'));
      if (!hasOperator) {
        const nestedFields = extractConditionFields(value);
        fields.push(...nestedFields.map(f => `${key}.${f}`));
      }
    }
  }

  return fields;
}

