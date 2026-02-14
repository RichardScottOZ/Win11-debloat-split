# Disable-WindowsRecall.ps1
# Disables Windows Recall AI feature
# Version: 1.0

<#
.SYNOPSIS
    Disables Windows Recall AI feature in Windows 11

.DESCRIPTION
    This script disables Windows Recall, an AI feature that takes screenshots
    of your activity to help you find things later.
    
    WHAT THIS DOES (in simple terms):
    Windows Recall is an AI feature that constantly takes screenshots of everything
    you do on your computer. It then uses AI to let you search through your past
    activity. Many users have privacy concerns about this feature.
    This script disables Recall completely.
    
    IMPACT:
    - Recall will not take screenshots of your activity
    - You cannot search through past activity using Recall
    - Better privacy as your screen activity is not recorded
    - Less disk space used
    - Reduced system resource usage
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Disable-WindowsRecall.ps1
    Runs the script with prompts for confirmation

.EXAMPLE
    .\Disable-WindowsRecall.ps1 -CreateRestorePoint -Silent
    Creates restore point and runs without prompts

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    Windows 11 only feature (available on newer builds with Copilot+ PCs)
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Undo_Disable_AI_Recall.reg
#>

[CmdletBinding()]
param(
    [switch]$CreateRestorePoint,
    [switch]$Silent
)

# Import common functions
$CommonFunctionsPath = Join-Path $PSScriptRoot "..\..\Utilities\Common-Functions.ps1"
if (Test-Path $CommonFunctionsPath) {
    . $CommonFunctionsPath
} else {
    Write-Error "Common-Functions.ps1 not found. Please ensure the Utilities folder is present."
    exit 1
}

# Ensure script is running as administrator
Require-Administrator

# Display header
Clear-Host
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Disable Windows Recall" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check Windows version
$osVersion = [System.Environment]::OSVersion.Version
if ($osVersion.Major -lt 10 -or ($osVersion.Major -eq 10 -and $osVersion.Build -lt 22000)) {
    Write-Host "This script is designed for Windows 11 only." -ForegroundColor Yellow
    Write-Host "Windows Recall is not available on your version of Windows." -ForegroundColor Yellow
    Wait-ForKeyPress
    exit 0
}

# Show what this script does
Write-Host "About Windows Recall:" -ForegroundColor Yellow
Write-Host "Windows Recall is an AI feature that takes continuous screenshots" -ForegroundColor White
Write-Host "of your activity to help you search through what you've done." -ForegroundColor White
Write-Host ""
Write-Host "This script will:" -ForegroundColor Yellow
Write-Host "  • Disable Windows Recall completely" -ForegroundColor White
Write-Host "  • Stop screenshot collection" -ForegroundColor White
Write-Host "  • Improve your privacy" -ForegroundColor White
Write-Host "  • Free up disk space" -ForegroundColor White
Write-Host ""
Write-Host "PRIVACY NOTE: Many users prefer to disable this feature" -ForegroundColor Green
Write-Host "due to privacy concerns about constant screenshot collection." -ForegroundColor Green
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to disable Windows Recall?" -DefaultYes $true
    if (-not $proceed) {
        Write-Host ""
        Write-Host "Operation cancelled by user." -ForegroundColor Yellow
        Wait-ForKeyPress
        exit 0
    }
}

Write-Host ""
Write-Separator

# Create restore point if requested
if ($CreateRestorePoint) {
    New-SystemRestorePoint -Description "Before Disabling Windows Recall"
}

# Path to the Recall registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Disable_AI_Recall.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Windows Recall AI settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Windows Recall has been disabled." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What was changed:" -ForegroundColor Yellow
    Write-Host "  • Recall screenshot collection disabled" -ForegroundColor White
    Write-Host "  • Recall AI analysis disabled" -ForegroundColor White
    Write-Host "  • Privacy improved" -ForegroundColor White
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Undo_Disable_AI_Recall.reg" -ForegroundColor White
} else {
    Write-Host "ERROR: Failed to apply some or all changes." -ForegroundColor Red
    Write-Host "Please check if the registry file exists and try running as administrator." -ForegroundColor Yellow
}

Write-Host ""
Write-Separator

# Note about restart
if ($success -and -not $Silent) {
    Write-Host ""
    Write-Host "NOTE: Changes will take full effect after a system restart." -ForegroundColor Cyan
    $restart = Get-UserConfirmation -Message "Do you want to restart your computer now?" -DefaultYes $false
    if ($restart) {
        Write-Host ""
        Write-Host "Restarting computer in 10 seconds..." -ForegroundColor Yellow
        Write-Host "Close any open files and save your work!" -ForegroundColor Red
        Start-Sleep -Seconds 10
        Restart-Computer -Force
    }
}

Wait-ForKeyPress
