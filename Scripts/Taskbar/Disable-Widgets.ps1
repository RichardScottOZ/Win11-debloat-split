# Disable-Widgets.ps1
# Disables Windows Widgets feature
# Version: 1.0

<#
.SYNOPSIS
    Disables Windows Widgets feature and removes it from taskbar

.DESCRIPTION
    Windows 11 includes a Widgets feature that shows news, weather, and other
    information. This script completely disables the Widgets feature.
    
    WHAT THIS DOES (in simple terms):
    Removes the Widgets button from your taskbar and disables the Widgets
    service entirely. Widgets show news, weather, and other information
    that updates throughout the day.
    
    IMPACT:
    - Widgets button removed from taskbar
    - Widgets feature completely disabled
    - No background updates for widget content
    - Slightly reduced system resource usage
    - Cleaner taskbar
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Disable-Widgets.ps1
    Disables widgets with user confirmation

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    Windows 11 only feature
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Enable_Widgets_Service.reg
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
Write-Host "  Disable Windows Widgets" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Show what this script does
Write-Host "This script will:" -ForegroundColor Yellow
Write-Host "  • Remove Widgets button from taskbar" -ForegroundColor White
Write-Host "  • Disable Widgets service" -ForegroundColor White
Write-Host "  • Stop background widget updates" -ForegroundColor White
Write-Host ""
Write-Host "BENEFITS:" -ForegroundColor Green
Write-Host "  • Cleaner taskbar" -ForegroundColor White
Write-Host "  • Reduced system resource usage" -ForegroundColor White
Write-Host "  • No distracting news/weather updates" -ForegroundColor White
Write-Host "  • More focus on your work" -ForegroundColor White
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to disable Windows Widgets?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Disabling Widgets"
}

# Path to the widgets registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Disable_Widgets_Service.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Windows Widgets settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Windows Widgets has been disabled." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What changed:" -ForegroundColor Yellow
    Write-Host "  • Widgets button removed from taskbar" -ForegroundColor White
    Write-Host "  • Widgets service disabled" -ForegroundColor White
    Write-Host "  • No more background updates" -ForegroundColor White
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Enable_Widgets_Service.reg" -ForegroundColor White
} else {
    Write-Host "ERROR: Failed to apply some or all changes." -ForegroundColor Red
    Write-Host "Please check if the registry file exists and try running as administrator." -ForegroundColor Yellow
}

Write-Host ""
Write-Separator

# Restart Explorer to apply changes immediately
if (-not $Silent) {
    Write-Host ""
    $restartExplorer = Get-UserConfirmation -Message "Restart Windows Explorer to apply changes now?" -DefaultYes $true
    if ($restartExplorer) {
        Restart-Explorer
    }
}

Wait-ForKeyPress
