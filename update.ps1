Write-Host "🚀 Starting client update..." -ForegroundColor Cyan
Set-Location $PSScriptRoot

if (!(Test-Path ".git")) {
    Write-Host "❌ Not a git repo" -ForegroundColor Red
    exit 1
}

# Save current commit (rollback point)
$rollbackCommit = git rev-parse HEAD

git fetch origin
git pull origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️ Update failed, rolling back..." -ForegroundColor Yellow
    git reset --hard $rollbackCommit
    exit 1
}

Write-Host "✅ Update successful" -ForegroundColor Green
Write-Host "🔄 Restarting client..." -ForegroundColor Cyan