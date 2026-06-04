#  init-security.ps1
#  Usage: run ..\init-security.ps1 inside a new repo folder

# Check if current directory is a Git repo
if (-not (Test-Path ".git")) {
    Write-Host "[ERROR] Not a git repository" -ForegroundColor Red
    exit 1
}

# Check dependencies
if (-not (Get-Command gitleaks -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] gitleaks not found. Run: scoop install gitleaks" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] gitleaks $(gitleaks version)" -ForegroundColor Green

if (-not (Get-Command pre-commit -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] pre-commit not found. Run: pip install pre-commit" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] pre-commit $(pre-commit --version)" -ForegroundColor Green

# Copy template files (skip if already exist)
foreach ($file in @(".gitignore", ".pre-commit-config.yaml")) {
    $src = "$PSScriptRoot\$file"
    if (Test-Path $file) {
        Write-Host "[SKIP] $file already exists" -ForegroundColor Yellow
    } elseif (Test-Path $src) {
        Copy-Item $src $file
        Write-Host "[OK] $file copied" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] $file not found in template directory" -ForegroundColor Red
        exit 1
    }
}

# Install hook and run initial scan
pre-commit install | Out-Null
Write-Host "[OK] pre-commit hook installed" -ForegroundColor Green
Write-Host ""
Write-Host "Scanning existing files..." -ForegroundColor Cyan
pre-commit run --all-files

Write-Host ""
Write-Host "=============================" -ForegroundColor Cyan
Write-Host " Done" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan