# Format Currency - Directus Display Extension

A powerful currency formatter display extension for Directus that supports multiple currencies and locales with customizable formatting options.

## Features

- 🌍 **Multiple Currency Support**: USD, EUR, GBP, JPY, VND, CNY, KRW, SGD
- 🗺️ **Multiple Locale Support**: en-US, en-GB, de-DE, fr-FR, vi-VN, ja-JP, zh-CN, ko-KR
- 💰 **Toggle Currency Symbol**: Show or hide currency symbols
- 🔢 **Configurable Decimal Places**: Set minimum decimal places (0-10)
- ✅ **Type Support**: Works with integer, bigInteger, float, and decimal field types
- 🎯 **Null Handling**: Gracefully handles null, undefined, and empty values

## Installation

### Method 1: Copy to Extensions Folder

1. Build the extension:
   ```bash
   npm run build
   ```

2. Copy the entire folder to your Directus extensions directory:
   ```bash
   cp -r format-currency /path/to/directus/extensions/
   ```

3. Restart your Directus instance

### Method 2: Symlink for Development

1. Navigate to the extension directory:
   ```bash
   cd /path/to/format-currency
   ```

2. Link the extension:
   ```bash
   npm run link
   ```

3. Follow the prompts to link to your Directus instance

4. Restart your Directus instance

## Development

### Setup

1. Install dependencies:
   ```bash
   npm install
   ```

### Build

Build the extension once:
```bash
npm run build
```

### Watch Mode

Run in development mode with auto-rebuild on file changes:
```bash
npm run dev
```

This will watch for changes and rebuild automatically without minification for easier debugging.

### Validate

Validate the extension structure:
```bash
npm run validate
```

## Usage

1. **Navigate to your Directus collection**
2. **Select a numeric field** (integer, float, decimal, or bigInteger)
3. **Go to the field's display settings**
4. **Choose "Currency Formatter"** from the display options
5. **Configure the options**:
   - **Currency**: Select from available currencies (default: USD)
   - **Locale**: Choose the locale for number formatting (default: en-US)
   - **Show Currency Symbol**: Toggle to show/hide the currency symbol (default: true)
   - **Minimum Decimal Places**: Set the number of decimal places (default: 2)

## Configuration Options

### Currency Options
- `USD` - US Dollar ($)
- `EUR` - Euro (€)
- `GBP` - British Pound (£)
- `JPY` - Japanese Yen (¥)
- `VND` - Vietnamese Dong (₫)
- `CNY` - Chinese Yuan (¥)
- `KRW` - South Korean Won (₩)
- `SGD` - Singapore Dollar (S$)

### Locale Options
- `en-US` - English (United States)
- `en-GB` - English (United Kingdom)
- `de-DE` - German (Germany)
- `fr-FR` - French (France)
- `vi-VN` - Vietnamese (Vietnam)
- `ja-JP` - Japanese (Japan)
- `zh-CN` - Chinese (China)
- `ko-KR` - Korean (South Korea)

## Examples

### With Symbol
- **USD, en-US**: `$1,234.56`
- **EUR, de-DE**: `1.234,56 €`
- **VND, vi-VN**: `1.234.567 ₫`

### Without Symbol
- **USD, en-US**: `1,234.56`
- **EUR, de-DE**: `1.234,56`
- **JPY, ja-JP**: `1,235`

## Requirements

- Directus `^10.10.0`
- Vue `^3.5.26`
