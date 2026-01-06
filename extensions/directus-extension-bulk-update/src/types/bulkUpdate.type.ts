export interface BulkUpdateItem {
    id: string | number;
    [key: string]: any;
}

export interface BulkUpdateOptions {
    stopOnError?: boolean;
    dryRun?: boolean;
}

export interface FieldValidationRule {
    min?: number;
    max?: number;
    type?: 'string' | 'number' | 'boolean' | 'array' | 'object';
    required?: boolean;
    pattern?: string;
    enum?: any[];
    validator?: 'email' | 'url' | 'uuid' | 'positive' | 'nonNegative' | 'integer';
    existsIn?: {
        collection: string;
        message?: string;
    };
    message?: string;
}

export interface ValidationRules {
    fields?: Record<string, FieldValidationRule | FieldValidationRule[]>;
    global?: FieldValidationRule | FieldValidationRule[];
}

export interface ConditionUpdatePayload {
    condition: Record<string, any>;
    data: Record<string, any>;
    options?: BulkUpdateOptions;
    validation?: ValidationRules;
}

export interface ItemsUpdatePayload {
    items: BulkUpdateItem[];
    options?: BulkUpdateOptions;
    validation?: ValidationRules;
}

export type BulkUpdatePayload = ItemsUpdatePayload | ConditionUpdatePayload;

export interface BulkUpdateResult {
    total: number;
    successful: number;
    failed: number;
    items: Array<{
        id: string | number;
        success: boolean;
        error?: string;
    }>;
    options: {
        dryRun: boolean;
        stopOnError: boolean;
    };
}
