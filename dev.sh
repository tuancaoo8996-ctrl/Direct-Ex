#!/bin/bash

echo "==============================="
echo " Directus Extension Dev Script "
echo "==============================="

# 1. Check .env
if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        echo "Creating .env from .env.example"
        cp ".env.example" ".env"
        echo ""
        echo "⚠️  IMPORTANT: Please edit .env file with your configuration!"
        echo "   Especially change:"
        echo "   - POSTGRES_PASSWORD"
        echo "   - KEY and SECRET (generate strong random values)"
        echo "   - ADMIN_PASSWORD"
        echo ""
        read -p "Press Enter after you've edited .env file, or Ctrl+C to exit..."
    else
        echo "Error: .env.example not found"
        exit 1
    fi
fi

# 2. Build Extensions
echo "Building Directus extensions..."

# Build Bulk Update Extension
BULK_UPDATE_PATH="extensions/directus-extension-bulk-update"
if [ -d "$BULK_UPDATE_PATH" ]; then
    echo "Building bulk-update extension..."
    cd "$BULK_UPDATE_PATH"
    
    if [ ! -d "node_modules" ]; then
        echo "Installing npm dependencies..."
        npm install
        if [ $? -ne 0 ]; then
            echo "Error: Failed to install dependencies for bulk-update extension"
            exit 1
        fi
    fi
    
    echo "Running build..."
    npm run build
    if [ $? -ne 0 ]; then
        echo "Error: Failed to build bulk-update extension"
        cd ../..
        exit 1
    fi
    cd ../..
    echo "✓ bulk-update extension built successfully"
else
    echo "Error: Extension path not found: $BULK_UPDATE_PATH"
    exit 1
fi

# Build Currency Format Extension
CURRENCY_FORMAT_PATH="extensions/directus-extension-currency-format"
if [ -d "$CURRENCY_FORMAT_PATH" ]; then
    echo "Building currency-format extension..."
    cd "$CURRENCY_FORMAT_PATH"
    
    if [ ! -d "node_modules" ]; then
        echo "Installing npm dependencies..."
        npm install
        if [ $? -ne 0 ]; then
            echo "Error: Failed to install dependencies for currency-format extension"
            exit 1
        fi
    fi
    
    echo "Running build..."
    npm run build
    if [ $? -ne 0 ]; then
        echo "Error: Failed to build currency-format extension"
        echo "Trying to reinstall dependencies..."
        rm -rf node_modules package-lock.json
        npm install
        npm run build
        if [ $? -ne 0 ]; then
            echo "Error: Failed to build currency-format extension after reinstall"
            cd ../..
            exit 1
        fi
    fi
    cd ../..
    echo "✓ currency-format extension built successfully"
else
    echo "Error: Extension path not found: $CURRENCY_FORMAT_PATH"
    exit 1
fi

# 3. Stop & remove containers + volumes
echo "Stopping containers and removing volumes..."
docker compose down -v
if [ $? -ne 0 ]; then
    echo "Warning: Some containers may not exist yet, continuing..."
fi

# 4. Start containers
echo "Starting containers..."
docker compose up --build -d
if [ $? -ne 0 ]; then
    echo "Error: Failed to start Docker containers"
    exit 1
fi

# 5. Wait for Directus to be ready
echo "Waiting for Directus to start..."
MAX_RETRIES=30
RETRY_COUNT=0
DIRECTUS_READY=false

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    if curl -s -f http://localhost:8056/server/health > /dev/null 2>&1; then
        DIRECTUS_READY=true
        break
    fi
    RETRY_COUNT=$((RETRY_COUNT + 1))
    sleep 2
done

if [ "$DIRECTUS_READY" = false ]; then
    echo "Warning: Directus may not be fully ready, but continuing..."
else
    echo "✓ Directus is ready"
    # Wait a bit more for Directus to fully initialize
    echo "Waiting for Directus to fully initialize..."
    sleep 5
fi

# 6. Import Mock Data (Optional)
echo ""
echo "Importing mock data..."

# Read .env variables
if [ -f ".env" ]; then
    ADMIN_EMAIL=$(grep "^ADMIN_EMAIL=" .env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    ADMIN_PASSWORD=$(grep "^ADMIN_PASSWORD=" .env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    PUBLIC_URL=$(grep "^PUBLIC_URL=" .env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
fi

if [ -z "$PUBLIC_URL" ]; then
    PUBLIC_URL="http://localhost:8056"
fi

if [ -n "$ADMIN_EMAIL" ] && [ -n "$ADMIN_PASSWORD" ]; then
    # Function to import collection data
    import_collection_data() {
        local collection_name=$1
        local json_file=$2
        local token=$3
        local base_url=$4
        
        if [ ! -f "$json_file" ]; then
            echo "  ⚠ File not found: $json_file"
            return 1
        fi
        
        # Check if jq is available for JSON parsing
        if ! command -v jq &> /dev/null; then
            echo "  ⚠ jq not found, using curl directly..."
            # Use curl to import
            response=$(curl -s -w "\n%{http_code}" -X POST "$base_url/items/$collection_name" \
                -H "Authorization: Bearer $token" \
                -H "Content-Type: application/json" \
                -d @"$json_file")
            
            http_code=$(echo "$response" | tail -n1)
            body=$(echo "$response" | sed '$d')
            
            if [ "$http_code" -eq 200 ] || [ "$http_code" -eq 201 ]; then
                echo "  ✓ Imported data to $collection_name"
                return 0
            elif [ "$http_code" -eq 409 ]; then
                echo "  ⚠ Items already exist in $collection_name, skipping..."
                return 0
            elif [ "$http_code" -eq 403 ]; then
                echo "  ⚠ Collection '$collection_name' does not exist or no permission"
                echo "     Please create the collection in Directus Admin first"
                return 1
            else
                echo "  ⚠ Failed to import $collection_name (HTTP $http_code)"
                return 1
            fi
        else
            # Use jq to parse and import
            item_count=$(jq '. | length' "$json_file")
            if [ "$item_count" -eq 0 ]; then
                echo "  ⚠ No data in $json_file"
                return 1
            fi
            
            response=$(curl -s -w "\n%{http_code}" -X POST "$base_url/items/$collection_name" \
                -H "Authorization: Bearer $token" \
                -H "Content-Type: application/json" \
                -d @"$json_file")
            
            http_code=$(echo "$response" | tail -n1)
            
            if [ "$http_code" -eq 200 ] || [ "$http_code" -eq 201 ]; then
                echo "  ✓ Imported $item_count items to $collection_name"
                return 0
            elif [ "$http_code" -eq 409 ]; then
                echo "  ⚠ Items already exist in $collection_name, skipping..."
                return 0
            elif [ "$http_code" -eq 403 ]; then
                echo "  ⚠ Collection '$collection_name' does not exist or no permission"
                echo "     Please create the collection in Directus Admin first"
                return 1
            else
                echo "  ⚠ Failed to import $collection_name (HTTP $http_code)"
                return 1
            fi
        fi
    }
    
    # Login to get token
    echo "Logging in to Directus..."
    login_response=$(curl -s -X POST "$PUBLIC_URL/auth/login" \
        -H "Content-Type: application/json" \
        -d "{\"email\":\"$ADMIN_EMAIL\",\"password\":\"$ADMIN_PASSWORD\"}")
    
    # Extract token (try with jq first, fallback to grep/sed)
    if command -v jq &> /dev/null; then
        token=$(echo "$login_response" | jq -r '.data.access_token // empty')
    else
        token=$(echo "$login_response" | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)
    fi
    
    if [ -z "$token" ] || [ "$token" = "null" ]; then
        echo "⚠ Failed to get access token, skipping mock data import"
        echo "  Response: $login_response"
    else
        echo "✓ Logged in successfully"
        
        # Note: Collections are auto-created by Directus from db/init.sql tables
        # We just need to wait a bit for Directus to detect them
        echo "Waiting for Directus to detect collections from database..."
        sleep 3
        
        # Import collections
        echo ""
        echo "Importing mock data..."
        imported_count=0
        total_collections=3
        
        if import_collection_data "categories" "mock-data/categories-sample-data.json" "$token" "$PUBLIC_URL"; then
            imported_count=$((imported_count + 1))
        fi
        
        if import_collection_data "suppliers" "mock-data/suppliers-sample-data.json" "$token" "$PUBLIC_URL"; then
            imported_count=$((imported_count + 1))
        fi
        
        if import_collection_data "products" "mock-data/products-sample-data.json" "$token" "$PUBLIC_URL"; then
            imported_count=$((imported_count + 1))
        fi
        
        if [ $imported_count -gt 0 ]; then
            echo "✓ Mock data imported successfully ($imported_count/$total_collections collections)"
        fi
    fi
else
    echo "⚠ Admin credentials not found in .env, skipping mock data import"
    echo "  To enable auto-import, ensure ADMIN_EMAIL and ADMIN_PASSWORD are set in .env"
fi

echo ""
# Ensure PUBLIC_URL is set correctly
if [ -z "$PUBLIC_URL" ]; then
    PUBLIC_URL="http://localhost:8056"
fi

echo "========================================"
echo " Directus is ready at $PUBLIC_URL"
echo " Extensions loaded:"
echo "  - bulk-update (API Endpoint)"
echo "  - currency-format (Display)"
if [ -n "$imported_count" ] && [ $imported_count -gt 0 ]; then
    echo "  - Mock data imported"
fi
echo "========================================"
