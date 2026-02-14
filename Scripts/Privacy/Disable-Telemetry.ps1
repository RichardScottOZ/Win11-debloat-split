# Disable-Telemetry.ps1
# Disables Windows telemetry and diagnostic data collection
# Version: 1.0

<#
.SYNOPSIS
    Disables Windows telemetry and diagnostic data collection

.DESCRIPTION
    This script disables various Windows telemetry features including:
    - Diagnostic data collection
    - Activity history tracking
    - App launch tracking
    - Targeted advertising
    
    WHAT THIS DOES (in simple terms):
    Windows constantly sends information about your computer usage back to Microsoft.
    This includes what apps you use, what websites you visit, and how you use your PC.
    This script stops Windows from collecting and sending this data.
    
    IMPACT:
    - Your privacy is improved
    - Less data is sent to Microsoft
    - Some Windows features that rely on this data may not work as well
    - Windows will still receive important updates
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Disable-Telemetry.ps1
    Runs the script with prompts for confirmation

.EXAMPLE
    .\Disable-Telemetry.ps1 -CreateRestorePoint
    Creates a restore point before disabling telemetry

.EXAMPLE
    .\Disable-Telemetry.ps1 -Silent
    Runs without any prompts

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Undo_Disable_Telemetry.reg
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
Write-Host "  Windows Telemetry Disabling Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Show what this script does
Write-Host "This script will disable:" -ForegroundColor Yellow
Write-Host "  • Diagnostic data collection" -ForegroundColor White
Write-Host "  • Activity history tracking" -ForegroundColor White
Write-Host "  • App launch tracking" -ForegroundColor White
Write-Host "  • Targeted advertising" -ForegroundColor White
Write-Host ""
Write-Host "IMPORTANT: This improves your privacy but some Windows features" -ForegroundColor Yellow
Write-Host "that rely on telemetry data may not work as expected." -ForegroundColor Yellow
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to proceed?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Disabling Telemetry"
}

# Path to the telemetry registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Disable_Telemetry.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Telemetry and diagnostic data settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Telemetry has been disabled. Changes will take full effect after a restart." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What was changed:" -ForegroundColor Yellow
    Write-Host "  • Diagnostic data set to minimum level" -ForegroundColor White
    Write-Host "  • Activity history disabled" -ForegroundColor White
    Write-Host "  • App launch tracking disabled" -ForegroundColor White
    Write-Host "  • Targeted ads disabled" -ForegroundColor White
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Undo_Disable_Telemetry.reg" -ForegroundColor White
} else {
    Write-Host "ERROR: Failed to apply some or all changes." -ForegroundColor Red
    Write-Host "Please check if the registry file exists and try running as administrator." -ForegroundColor Yellow
}

Write-Host ""
Write-Separator

# Ask about restart if not in silent mode
if (-not $Silent) {
    Write-Host ""
    $restart = Get-UserConfirmation -Message "Do you want to restart your computer now?" -DefaultYes $false
    if ($restart) {
        Write-Host ""
        Write-Host "Restarting computer in 10 seconds..." -ForegroundColor Yellow
        Write-Host "Close any open files and save your work!" -ForegroundColor Red
        Start-Sleep -Seconds 10
        Restart-Computer
    }
}

Wait-ForKeyPress
