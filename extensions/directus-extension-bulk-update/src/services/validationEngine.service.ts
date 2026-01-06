import { ValidationRules, FieldValidationRule } from '../types/bulkUpdate.type';
import { HttpError } from '../errors/httpError';

export class ValidationEngine {
    private rules: ValidationRules;

    constructor(rules: ValidationRules) {
        this.rules = rules;
    }

    validateField(
        fieldName: string,
        value: any,
        existingValue?: any
    ): void {
        const fieldRules = this.getFieldRules(fieldName);

        if (!fieldRules || fieldRules.length === 0) {
            return;
        }

        for (const rule of fieldRules) {
            this.applyRule(fieldName, value, rule, existingValue);
        }
    }

    validateFields(fieldsToUpdate: Record<string, any>, existingItem: any): void {
        for (const [fieldName, value] of Object.entries(fieldsToUpdate)) {
            const existingValue = existingItem?.[fieldName];
            this.validateField(fieldName, value, existingValue);
        }
    }

    async validateFieldsWithContext(
        fieldsToUpdate: Record<string, any>,
        existingItem: any,
        context: any,
        accountability: any
    ): Promise<void> {
        for (const [fieldName, value] of Object.entries(fieldsToUpdate)) {
            const existingValue = existingItem?.[fieldName];
            await this.validateFieldWithContext(fieldName, value, existingValue, context, accountability);
        }
    }

    async validateFieldWithContext(
        fieldName: string,
        value: any,
        existingValue: any,
        context: any,
        accountability: any
    ): Promise<void> {
        const fieldRules = this.getFieldRules(fieldName);

        if (!fieldRules || fieldRules.length === 0) {
            return;
        }

        for (const rule of fieldRules) {
            await this.applyRuleWithContext(fieldName, value, rule, existingValue, context, accountability);
        }
    }

    private getFieldRules(fieldName: string): FieldValidationRule[] {
        const fieldSpecificRules = this.rules.fields?.[fieldName];
        const globalRules = this.rules.global;

        const normalizeRules = (rules: FieldValidationRule | FieldValidationRule[] | undefined): FieldValidationRule[] => {
            if (!rules) return [];
            return Array.isArray(rules) ? rules : [rules];
        };

        const fieldRules = normalizeRules(fieldSpecificRules);
        const globalRulesArray = normalizeRules(globalRules);

        return fieldRules.length > 0 ? fieldRules : globalRulesArray;
    }

    private applyRule(
        fieldName: string,
        value: any,
        rule: FieldValidationRule,
        _existingValue?: any
    ): void {
        if (rule.required && (value === undefined || value === null)) {
            throw new HttpError(
                400,
                rule.message || `Field '${fieldName}' is required`
            );
        }

        // Skip other validations if value is null/undefined (unless required)
        if (value === undefined || value === null) {
            return;
        }

        // Type validation
        if (rule.type) {
            this.validateType(fieldName, value, rule.type, rule.message);
        }

        // Min validation
        if (rule.min !== undefined) {
            this.validateMin(fieldName, value, rule.min, rule.message);
        }

        // Max validation
        if (rule.max !== undefined) {
            this.validateMax(fieldName, value, rule.max, rule.message);
        }

        // Pattern validation (regex)
        if (rule.pattern) {
            this.validatePattern(fieldName, value, rule.pattern, rule.message);
        }

        // Enum validation
        if (rule.enum && rule.enum.length > 0) {
            this.validateEnum(fieldName, value, rule.enum, rule.message);
        }

        // Custom validators
        if (rule.validator) {
            this.validateCustom(fieldName, value, rule.validator, rule.message);
        }
    }

    private async applyRuleWithContext(
        fieldName: string,
        value: any,
        rule: FieldValidationRule,
        _existingValue: any,
        context: any,
        accountability: any
    ): Promise<void> {
        if (rule.required && (value === undefined || value === null)) {
            throw new HttpError(
                400,
                rule.message || `Field '${fieldName}' is required`
            );
        }

        // Skip other validations if value is null/undefined (unless required)
        if (value === undefined || value === null) {
            return;
        }

        // Type validation
        if (rule.type) {
            this.validateType(fieldName, value, rule.type, rule.message);
        }

        // Min validation
        if (rule.min !== undefined) {
            this.validateMin(fieldName, value, rule.min, rule.message);
        }

        // Max validation
        if (rule.max !== undefined) {
            this.validateMax(fieldName, value, rule.max, rule.message);
        }

        // Pattern validation (regex)
        if (rule.pattern) {
            this.validatePattern(fieldName, value, rule.pattern, rule.message);
        }

        // Enum validation
        if (rule.enum && rule.enum.length > 0) {
            this.validateEnum(fieldName, value, rule.enum, rule.message);
        }

        // Custom validators
        if (rule.validator) {
            this.validateCustom(fieldName, value, rule.validator, rule.message);
        }

        if (rule.existsIn) {
            await this.validateExistsIn(fieldName, value, rule.existsIn, context, accountability);
        }
    }

    private validateType(fieldName: string, value: any, expectedType: string, customMessage?: string): void {
        let actualType: string = typeof value;
        
        if (expectedType === 'array' && Array.isArray(value)) {
            actualType = 'array';
        } else if (expectedType === 'object' && !Array.isArray(value) && value !== null && typeof value === 'object') {
            actualType = 'object';
        }

        if (actualType !== expectedType) {
            throw new HttpError(
                400,
                customMessage || `Field '${fieldName}' must be of type '${expectedType}', got '${actualType}'`
            );
        }
    }

    private validateMin(fieldName: string, value: any, min: number, customMessage?: string): void {
        let actualValue: number;

        if (typeof value === 'number') {
            actualValue = value;
        } else if (typeof value === 'string' || Array.isArray(value)) {
            actualValue = value.length;
        } else {
            return;
        }

        if (actualValue < min) {
            throw new HttpError(
                400,
                customMessage || `Field '${fieldName}' must be >= ${min}`
            );
        }
    }

    private validateMax(fieldName: string, value: any, max: number, customMessage?: string): void {
        let actualValue: number;

        if (typeof value === 'number') {
            actualValue = value;
        } else if (typeof value === 'string' || Array.isArray(value)) {
            actualValue = value.length;
        } else {
            return;
        }

        if (actualValue > max) {
            throw new HttpError(
                400,
                customMessage || `Field '${fieldName}' must be <= ${max}`
            );
        }
    }

    private validatePattern(fieldName: string, value: any, pattern: string, customMessage?: string): void {
        if (typeof value !== 'string') {
            throw new HttpError(
                400,
                `Field '${fieldName}' must be a string to validate against pattern`
            );
        }

        try {
            const regex = new RegExp(pattern);
            if (!regex.test(value)) {
                throw new HttpError(
                    400,
                    customMessage || `Field '${fieldName}' does not match required pattern`
                );
            }
        } catch (error: any) {
            if (error instanceof HttpError) {
                throw error;
            }
            throw new HttpError(400, `Invalid regex pattern for field '${fieldName}': ${error.message}`);
        }
    }

    private validateEnum(fieldName: string, value: any, allowedValues: any[], customMessage?: string): void {
        if (!allowedValues.includes(value)) {
            throw new HttpError(
                400,
                customMessage || `Field '${fieldName}' must be one of: ${allowedValues.join(', ')}`
            );
        }
    }

    private validateCustom(fieldName: string, value: any, validator: string, customMessage?: string): void {
        switch (validator) {
            case 'email':
                if (typeof value !== 'string' || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
                    throw new HttpError(
                        400,
                        customMessage || `Field '${fieldName}' must be a valid email address`
                    );
                }
                break;

            case 'url':
                if (typeof value !== 'string') {
                    throw new HttpError(400, `Field '${fieldName}' must be a string for URL validation`);
                }
                try {
                    new URL(value);
                } catch {
                    throw new HttpError(
                        400,
                        customMessage || `Field '${fieldName}' must be a valid URL`
                    );
                }
                break;

            case 'uuid':
                if (typeof value !== 'string' || !/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(value)) {
                    throw new HttpError(
                        400,
                        customMessage || `Field '${fieldName}' must be a valid UUID`
                    );
                }
                break;

            case 'positive':
                if (typeof value !== 'number' || value <= 0) {
                    throw new HttpError(
                        400,
                        customMessage || `Field '${fieldName}' must be a positive number`
                    );
                }
                break;

            case 'nonNegative':
                if (typeof value !== 'number' || value < 0) {
                    throw new HttpError(
                        400,
                        customMessage || `Field '${fieldName}' must be a non-negative number`
                    );
                }
                break;

            case 'integer':
                if (typeof value !== 'number' || !Number.isInteger(value)) {
                    throw new HttpError(
                        400,
                        customMessage || `Field '${fieldName}' must be an integer`
                    );
                }
                break;

            default:
                throw new HttpError(400, `Unknown validator '${validator}' for field '${fieldName}'`);
        }
    }

    private async validateExistsIn(
        fieldName: string,
        value: any,
        existsInConfig: { collection: string; message?: string },
        context: any,
        accountability: any
    ): Promise<void> {
        const { collection, message } = existsInConfig;
        const { services, getSchema } = context;

        if (!services?.ItemsService) {
            throw new HttpError(500, 'Internal server error: ItemsService not available');
        }

        const schema = await getSchema();
        if (!schema.collections[collection]) {
            throw new HttpError(400, `Collection '${collection}' specified in existsIn validation does not exist`);
        }

        if (value === null || value === undefined) {
            return;
        }

        const itemsService = new services.ItemsService(collection, {
            schema,
            accountability
        });

        try {
            const referencedItem = await itemsService.readOne(value);
            if (!referencedItem) {
                throw new HttpError(
                    404,
                    message || `Field '${fieldName}': Referenced item with id '${value}' does not exist in collection '${collection}'`
                );
            }
        } catch (error: any) {
            if (error.status === 404 || error.message?.includes('not found')) {
                throw new HttpError(
                    404,
                    message || `Field '${fieldName}': Referenced item with id '${value}' does not exist in collection '${collection}'`
                );
            }
            throw error;
        }
    }
}

