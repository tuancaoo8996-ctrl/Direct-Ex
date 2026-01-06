# Directus Extensions - Bulk Update & Currency Format

This project provides two Directus extensions: a **Bulk Update API Endpoint** that enables efficient batch updates with validation, and a **Currency Format Display** extension that formats numeric fields as currency with multiple currency and locale support.

## What It Does

This project contains two production-ready Directus extensions designed to enhance your CMS workflow. The **Bulk Update Extension** provides a REST API endpoint (`POST /directus-extension-bulk-update/:collection`) that allows you to update multiple items in a collection simultaneously, either by specifying individual item IDs or using condition-based filters. It includes comprehensive validation support, dry-run mode, error handling with stop-on-error options, and detailed result reporting. The **Currency Format Extension** is a display component that automatically formats numeric fields (integer, float, decimal, bigInteger) as currency with support for 8 currencies (USD, EUR, GBP, JPY, VND, CNY, KRW, SGD) and 8 locales, with customizable decimal places and optional currency symbol display.

## Why It's Useful

The Bulk Update Extension eliminates the need for multiple API calls when updating many items, significantly reducing processing time and network overhead. It's especially valuable for administrative tasks, data migrations, bulk status updates, and scheduled maintenance operations. The built-in validation engine ensures data integrity by supporting type checking, min/max constraints, pattern matching, enum validation, and relationship validation before committing changes. The Currency Format Extension improves data presentation in the Directus admin panel by automatically formatting monetary values according to regional standards, making financial data more readable and professional without requiring manual formatting in each collection.

## How to Install/Use It

### Prerequisites

- Docker and Docker Compose
- Node.js 18+ (for building extensions)

### Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd newExtension
   ```

2. **Create `.env` file:**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration (especially passwords and secret keys)
   ```

3. **Run the setup script:**
   
   **Windows (PowerShell):**
   ```powershell
   .\dev.ps1
   ```
   
   **Mac/Linux (Bash):**
   ```bash
   ./dev.sh
   ```

   The script will automatically build both extensions and start Directus with Docker.

### Usage

#### Bulk Update Extension

**API Endpoint:** `POST /directus-extension-bulk-update/:collection`

**Update by IDs:**
```bash
POST http://localhost:8056/directus-extension-bulk-update/products
Authorization: Bearer <token>
Content-Type: application/json

{
  "items": [
    { "id": 1, "status": "active", "price": 99.99 },
    { "id": 2, "status": "active", "price": 149.99 }
  ],
  "options": {
    "dryRun": false,
    "stopOnError": false
  },
  "validation": {
    "fields": {
      "price": { "type": "number", "min": 0 },
      "status": { "enum": ["active", "inactive"] }
    }
  }
}
```

**Update by Condition:**
```bash
POST http://localhost:8056/directus-extension-bulk-update/products
Authorization: Bearer <token>
Content-Type: application/json

{
  "condition": { "status": { "_eq": "draft" } },
  "data": { "status": "published" },
  "options": { "dryRun": false }
}
```

#### Currency Format Extension

1. Navigate to your Directus collection
2. Select a numeric field (integer, float, decimal, or bigInteger)
3. Go to the field's display settings
4. Choose "Currency Formatter" from display options
5. Configure:
   - **Currency**: Select from USD, EUR, GBP, JPY, VND, CNY, KRW, SGD
   - **Locale**: Choose locale (en-US, en-GB, de-DE, fr-FR, vi-VN, ja-JP, zh-CN, ko-KR)
   - **Show Currency Symbol**: Toggle to show/hide symbol
   - **Minimum Decimal Places**: Set decimal places (0-10)

### Development

**Watch mode** (auto-rebuild on changes):
```bash
cd extensions/directus-extension-bulk-update
npm run dev

# Or for currency extension:
cd extensions/directus-extension-currency-format
npm run dev
```

With `EXTENSIONS_AUTO_RELOAD` enabled in `docker-compose.yml`, extensions will automatically reload in Directus when rebuilt.

## Project Structure

```
newExtension/
├── extensions/
│   ├── directus-extension-bulk-update/     # API Endpoint Extension
│   └── directus-extension-currency-format/ # Display Extension
├── uploads/                                 # Directus uploads folder
├── db/                                      # Database init scripts
├── docker-compose.yml
└── README.md
```

## Notes

- Directus runs at: `http://localhost:8056`
- Container names have prefix `newproject_`
- Database port: `5433`
- Extensions auto-reload is enabled for development

## Design Decisions

**Bulk Update Extension:**
- **Validation Engine**: Implemented a flexible validation engine that supports both field-specific and global rules, allowing different validation strategies per use case without code changes.
- **Condition vs Items**: Two update modes (by IDs vs by condition) provide flexibility for different scenarios - precise updates vs bulk filtering operations.
- **Dry Run Mode**: Included to allow users to test validation and see results without committing changes, crucial for production environments.

**Currency Format Extension:**
- **Intl.NumberFormat API**: Used native browser API for currency formatting to ensure proper locale-specific formatting without external dependencies.
- **Vue 3 Composition API**: Leveraged Composition API with computed properties for reactive formatting that updates automatically when props change.
- **Graceful Fallback**: Implemented fallback formatting if locale/currency combination is not supported, ensuring the extension never breaks the UI.
- **Symbol Toggle**: Currency symbol can be hidden for cases where only numeric formatting is needed while maintaining currency-specific decimal handling.


## What I'd Do Next With More Time
**Currency Format Extension:**
- **More Currencies**: Expand currency support to include all major world currencies (currently 8, could expand to 100+).
- **Custom Currency**: Allow users to define custom currency symbols and formatting rules.
- **Currency Conversion**: Add optional real-time currency conversion display based on exchange rates.
- **Theme Integration**: Better integration with Directus theme variables for consistent styling.
- **Accessibility**: Improve accessibility with proper ARIA labels and screen reader support.

**Project Improvements:**
- **Error Handling**: Implement more granular error codes and messages for better debugging.

Note: Effort for this assignment : 
This is a fairly new product to me. To be honest, getting familiar with it took quite a bit of time to read the documentation, set up the environment, and do testing and development, especially since it doesn’t seem to support a hot-reload mechanism. For the currency-format feature alone, building and testing already took around 3 hours. As for the bulk-update API endpoint, I believe it took even more time.