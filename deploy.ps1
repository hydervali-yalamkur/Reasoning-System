# Reasoning System - Azure Deployment Script
# Run this script after making changes to deploy to Azure

Write-Host "🚀 Reasoning System Deployment to Azure" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Refresh PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Variables
$ACR_NAME = "Reasoning Systemregistry"
$BACKEND_IMAGE = "Reasoning Systemregistry.azurecr.io/backend:latest"
$FRONTEND_IMAGE = "Reasoning Systemregistry.azurecr.io/frontend:latest"

Write-Host "`n📦 Step 1: Building Docker Images..." -ForegroundColor Yellow

# Build Backend
Write-Host "Building backend..." -ForegroundColor Gray
Set-Location "C:\Users\sailo\Reasoning System\Reasoning System\backend"
docker build -t $BACKEND_IMAGE .
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Backend build failed!" -ForegroundColor Red
    exit 1
}

# Build Frontend
Write-Host "Building frontend..." -ForegroundColor Gray
Set-Location "C:\Users\sailo\Reasoning System\Reasoning System\frontend"
docker build -t $FRONTEND_IMAGE .
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Frontend build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "`n✅ Step 1 Complete: Images built successfully!" -ForegroundColor Green

Write-Host "`n🔐 Step 2: Logging into Azure Container Registry..." -ForegroundColor Yellow
az acr login --name $ACR_NAME
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ ACR login failed!" -ForegroundColor Red
    exit 1
}

Write-Host "`n📤 Step 3: Pushing Images to Azure..." -ForegroundColor Yellow

# Push Backend
Write-Host "Pushing backend..." -ForegroundColor Gray
docker push $BACKEND_IMAGE
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Backend push failed!" -ForegroundColor Red
    exit 1
}

# Push Frontend
Write-Host "Pushing frontend..." -ForegroundColor Gray
docker push $FRONTEND_IMAGE
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Frontend push failed!" -ForegroundColor Red
    exit 1
}

Write-Host "`n✅ Deployment Complete!" -ForegroundColor Green
Write-Host "🌐 Your app should update in 1-2 minutes" -ForegroundColor Cyan
Write-Host "`n📊 Monitor deployment:" -ForegroundColor Yellow
Write-Host "   az containerapp logs show --name Reasoning System-backend --resource-group rg-Reasoning System-prod --follow" -ForegroundColor Gray
