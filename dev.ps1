Write-Host "==============================="
Write-Host " Directus Extension Dev Script "
Write-Host "==============================="

# 1. Check .env
if (-Not (Test-Path ".env")) {
    if (Test-Path ".env.example") {
        Write-Host "Creating .env from .env.example"
        Copy-Item ".env.example" ".env"
        Write-Host ""
        Write-Host "⚠️  IMPORTANT: Please edit .env file with your configuration!" -ForegroundColor Yellow
        Write-Host "   Especially change:"
        Write-Host "   - POSTGRES_PASSWORD"
        Write-Host "   - KEY and SECRET (generate strong random values)"
        Write-Host "   - ADMIN_PASSWORD"
        Write-Host ""
        Read-Host "Press Enter after you've edited .env file, or Ctrl+C to exit"
    } else {
        Write-Error ".env.example not found"
        exit 1
    }
}

# 2. Build Extensions
Write-Host "Building Directus extensions..."

# Build Bulk Update Extension
$bulkUpdatePath = "extensions/directus-extension-bulk-update"
if (Test-Path $bulkUpdatePath) {
    Write-Host "Building bulk-update extension..."
    Push-Location $bulkUpdatePath
    
    if (-Not (Test-Path "node_modules")) {
        Write-Host "Installing npm dependencies..."
        npm install
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed to install dependencies for bulk-update extension"
            Pop-Location
            exit 1
        }
    }
    
    Write-Host "Running build..."
    npm run build
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to build bulk-update extension"
        Pop-Location
        exit 1
    }
    
    Pop-Location
    Write-Host "✓ bulk-update extension built successfully" -ForegroundColor Green
} else {
    Write-Error "Extension path not found: $bulkUpdatePath"
    exit 1
}

# Build Currency Format Extension
$currencyFormatPath = "extensions/directus-extension-currency-format"
if (Test-Path $currencyFormatPath) {
    Write-Host "Building currency-format extension..."
    Push-Location $currencyFormatPath
    
    if (-Not (Test-Path "node_modules")) {
        Write-Host "Installing npm dependencies..."
        npm install
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed to install dependencies for currency-format extension"
            Pop-Location
            exit 1
        }
    }
    
    Write-Host "Running build..."
    npm run build
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Build failed, trying to reinstall dependencies..." -ForegroundColor Yellow
        Remove-Item -Recurse -Force node_modules -ErrorAction SilentlyContinue
        Remove-Item -Force package-lock.json -ErrorAction SilentlyContinue
        npm install
        npm run build
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed to build currency-format extension after reinstall"
            Pop-Location
            exit 1
        }
    }
    
    Pop-Location
    Write-Host "✓ currency-format extension built successfully" -ForegroundColor Green
} else {
    Write-Error "Extension path not found: $currencyFormatPath"
    exit 1
}

# 3. Stop & remove containers + volumes
Write-Host "Stopping containers and removing volumes..."
docker compose down -v
if ($LASTEXITCODE -ne 0) {
    Write-Warning "Some containers may not exist yet, continuing..."
}

# 4. Start containers
Write-Host "Starting containers..."
docker compose up --build -d
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to start Docker containers"
    exit 1
}

# 5. Wait for Directus to be ready
Write-Host "Waiting for Directus to start..."
Start-Sleep -Seconds 10

Write-Host "========================================"
Write-Host " Directus is ready at http://localhost:8056"
Write-Host " Extensions loaded:"
Write-Host "  - bulk-update (API Endpoint)"
Write-Host "  - currency-format (Display)"
Write-Host "========================================"
