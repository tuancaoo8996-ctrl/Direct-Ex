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
$maxRetries = 30
$retryCount = 0
$directusReady = $false

while ($retryCount -lt $maxRetries) {
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:8056/server/health" -Method Get -TimeoutSec 2 -ErrorAction SilentlyContinue
        if ($response.StatusCode -eq 200) {
            $directusReady = $true
            break
        }
    } catch {
        # Continue retrying
    }
    $retryCount++
    Start-Sleep -Seconds 2
}

if (-not $directusReady) {
    Write-Warning "Directus may not be fully ready, but continuing..."
} else {
    Write-Host "✓ Directus is ready" -ForegroundColor Green
    Write-Host "Waiting for Directus to fully initialize..."
    Start-Sleep -Seconds 5
}

# 6. Import Mock Data (Optional)
Write-Host ""
Write-Host "Importing mock data..."

# Read .env variables
$adminEmail = $null
$adminPassword = $null
$publicUrl = $null
$importedCount = 0

if (Test-Path ".env") {
    $envContent = Get-Content ".env"
    foreach ($line in $envContent) {
        if ($line -match "^ADMIN_EMAIL=(.+)") {
            $adminEmail = $matches[1].Trim('"', "'", " ")
        }
        if ($line -match "^ADMIN_PASSWORD=(.+)") {
            $adminPassword = $matches[1].Trim('"', "'", " ")
        }
        if ($line -match "^PUBLIC_URL=(.+)") {
            $publicUrl = $matches[1].Trim('"', "'", " ")
        }
    }
}

if ([string]::IsNullOrEmpty($publicUrl)) {
    $publicUrl = "http://localhost:8056"
}

if (-not [string]::IsNullOrEmpty($adminEmail) -and -not [string]::IsNullOrEmpty($adminPassword)) {
    # Function to import collection data
    function Import-CollectionData {
        param(
            [string]$CollectionName,
            [string]$JsonFile,
            [string]$Token,
            [string]$BaseUrl
        )
        
        if (-not (Test-Path $JsonFile)) {
            Write-Host "  ⚠ File not found: $JsonFile" -ForegroundColor Yellow
            return $false
        }
        
        $jsonContent = Get-Content $JsonFile -Raw
        $items = $jsonContent | ConvertFrom-Json
        
        if ($items.Count -eq 0) {
            Write-Host "  ⚠ No data in $JsonFile" -ForegroundColor Yellow
            return $false
        }
        
        $headers = @{
            "Authorization" = "Bearer $Token"
            "Content-Type" = "application/json"
        }
        
        try {
            $response = Invoke-RestMethod -Uri "$BaseUrl/items/$CollectionName" `
                -Method Post `
                -Headers $headers `
                -Body $jsonContent `
                -ErrorAction Stop
            
            Write-Host "  ✓ Imported $($items.Count) items to $CollectionName" -ForegroundColor Green
            return $true
        } catch {
            $statusCode = $null
            $errorBody = $_.ErrorDetails.Message
            if ($_.Exception.Response) {
                $statusCode = [int]$_.Exception.Response.StatusCode
            }
            
            if ($statusCode -eq 409) {
                Write-Host "  ⚠ Items already exist in $CollectionName, skipping..." -ForegroundColor Yellow
                return $true
            } elseif ($statusCode -eq 403) {
                Write-Host "  ⚠ Collection '$CollectionName' does not exist or no permission" -ForegroundColor Yellow
                if ($errorBody) {
                    Write-Host "     Response: $errorBody"
                }
                Write-Host "     Please create the collection in Directus Admin first"
                return $false
            } else {
                Write-Host "  ⚠ Failed to import $CollectionName" -ForegroundColor Yellow
                if ($statusCode) {
                    Write-Host "     HTTP Status: $statusCode"
                }
                if ($errorBody) {
                    Write-Host "     Response: $errorBody"
                } else {
                    Write-Host "     Error: $($_.Exception.Message)"
                }
                return $false
            }
        }
    }
    
    # Login to get token
    Write-Host "Logging in to Directus..."
    $loginBody = @{
        email = $adminEmail
        password = $adminPassword
    } | ConvertTo-Json
    
    try {
        $loginResponse = Invoke-RestMethod -Uri "$publicUrl/auth/login" `
            -Method Post `
            -ContentType "application/json" `
            -Body $loginBody `
            -ErrorAction Stop
        
        $token = $loginResponse.data.access_token
        
        if ([string]::IsNullOrEmpty($token) -or $token -eq "null") {
            Write-Host "⚠ Failed to get access token, skipping mock data import" -ForegroundColor Yellow
            Write-Host "  Response: $($loginResponse | ConvertTo-Json)"
        } else {
            Write-Host "✓ Logged in successfully" -ForegroundColor Green
            
            # Note: Collections are auto-created by Directus from db/init.sql tables
            # We just need to wait a bit for Directus to detect them
            Write-Host "Waiting for Directus to detect collections from database..."
            Start-Sleep -Seconds 3
            
            # Import collections
            Write-Host ""
            Write-Host "Importing mock data..."
            $importedCount = 0
            $totalCollections = 3
            
            if (Import-CollectionData "categories" "mock-data/categories-sample-data.json" $token $publicUrl) {
                $importedCount++
            }
            
            if (Import-CollectionData "suppliers" "mock-data/suppliers-sample-data.json" $token $publicUrl) {
                $importedCount++
            }
            
            if (Import-CollectionData "products" "mock-data/products-sample-data.json" $token $publicUrl) {
                $importedCount++
            }
            
            if ($importedCount -gt 0) {
                Write-Host "✓ Mock data imported successfully ($importedCount/$totalCollections collections)" -ForegroundColor Green
            }
        }
    } catch {
        Write-Host "⚠ Failed to login to Directus, skipping mock data import" -ForegroundColor Yellow
        Write-Host "  Error: $($_.Exception.Message)"
    }
} else {
    Write-Host "⚠ Admin credentials not found in .env, skipping mock data import" -ForegroundColor Yellow
    Write-Host "  To enable auto-import, ensure ADMIN_EMAIL and ADMIN_PASSWORD are set in .env"
}

Write-Host ""
Write-Host "========================================"
Write-Host " Directus is ready at $publicUrl"
Write-Host " Extensions loaded:"
Write-Host "  - bulk-update (API Endpoint)"
Write-Host "  - currency-format (Display)"
if ($importedCount -gt 0) {
    Write-Host "  - Mock data imported"
}
Write-Host "========================================"
