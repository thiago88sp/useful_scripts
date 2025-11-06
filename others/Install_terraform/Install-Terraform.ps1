# -----------------------------------------------------------
# Script: Install-Terraform.ps1
# Description: Automates Terraform installation on Windows
# Version: 1.0
# Terraform Version: 1.13.5
# -----------------------------------------------------------

$terraformVersion = "1.13.5"
$downloadUrl = "https://releases.hashicorp.com/terraform/$terraformVersion/terraform_${terraformVersion}_windows_amd64.zip"
$zipPath = "$env:TEMP\terraform.zip"
$installPath = "C:\Terraform"

Write-Host "==== Terraform Installer for Windows ====" -ForegroundColor Cyan

# 1. Download Terraform ZIP
Write-Host "Downloading Terraform $terraformVersion..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath -UseBasicParsing

# 2. Create installation folder
if (!(Test-Path -Path $installPath)) {
    Write-Host "Creating installation directory at $installPath" -ForegroundColor Yellow
    New-Item -Path $installPath -ItemType Directory | Out-Null
}

# 3. Extract ZIP
Write-Host "Extracting Terraform..." -ForegroundColor Yellow
Expand-Archive -Path $zipPath -DestinationPath $installPath -Force

# 4. Add to PATH
$envPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)

if ($envPath -notlike "*$installPath*") {
    Write-Host "Adding Terraform to system PATH..." -ForegroundColor Yellow
    [System.Environment]::SetEnvironmentVariable("Path", "$envPath;$installPath", [System.EnvironmentVariableTarget]::Machine)
} else {
    Write-Host "Terraform already exists in PATH." -ForegroundColor Green
}

# 5. Cleanup
Remove-Item $zipPath -Force

Write-Host "Terraform installation completed successfully!" -ForegroundColor Green
Write-Host "Close and reopen PowerShell, then run: terraform --version"