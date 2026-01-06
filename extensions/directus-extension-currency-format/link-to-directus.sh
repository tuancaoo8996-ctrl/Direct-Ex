#!/bin/bash

# Format Currency Extension - Link to Directus
# This script helps you link the extension to your Directus instance

echo "🔗 Format Currency Extension - Directus Linker"
echo "=============================================="
echo ""

# Check if Directus path is provided
if [ -z "$1" ]; then
    echo "Usage: ./link-to-directus.sh /path/to/directus"
    echo ""
    echo "Example:"
    echo "  ./link-to-directus.sh ~/projects/my-directus"
    echo ""
    echo "Or use npm run link for interactive mode:"
    echo "  npm run link"
    exit 1
fi

DIRECTUS_PATH="$1"
EXTENSION_NAME="format-currency"

# Check if Directus path exists
if [ ! -d "$DIRECTUS_PATH" ]; then
    echo "❌ Error: Directus path does not exist: $DIRECTUS_PATH"
    exit 1
fi

# Create extensions directory if it doesn't exist
EXTENSIONS_DIR="$DIRECTUS_PATH/extensions"
if [ ! -d "$EXTENSIONS_DIR" ]; then
    echo "📁 Creating extensions directory..."
    mkdir -p "$EXTENSIONS_DIR"
fi

# Build the extension first
echo "🔨 Building extension..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    exit 1
fi

# Create symlink
LINK_PATH="$EXTENSIONS_DIR/$EXTENSION_NAME"

if [ -L "$LINK_PATH" ]; then
    echo "⚠️  Symlink already exists. Removing old link..."
    rm "$LINK_PATH"
elif [ -d "$LINK_PATH" ]; then
    echo "⚠️  Directory already exists. Please remove it manually: $LINK_PATH"
    exit 1
fi

echo "🔗 Creating symlink..."
ln -s "$(pwd)" "$LINK_PATH"

if [ $? -eq 0 ]; then
    echo "✅ Extension linked successfully!"
    echo ""
    echo "📍 Linked to: $LINK_PATH"
    echo ""
    echo "Next steps:"
    echo "1. Restart your Directus instance"
    echo "2. The extension will be available as 'Currency Formatter'"
    echo ""
    echo "For development with auto-reload:"
    echo "  npm run dev"
else
    echo "❌ Failed to create symlink"
    exit 1
fi
