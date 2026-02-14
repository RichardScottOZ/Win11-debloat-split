# Disable-Animations.ps1
# Disables Windows animations and visual effects
# Version: 1.0

<#
.SYNOPSIS
    Disables Windows animations and visual effects for better performance

.DESCRIPTION
    Windows 11 includes many animations and visual effects that make the
    interface look smooth and modern. However, these can slow down older
    computers. This script disables these effects for better performance.
    
    WHAT THIS DOES (in simple terms):
    Turns off the smooth animations when you open/close windows, minimize
    apps, and navigate menus. Everything will feel more "snappy" and instant
    instead of smoothly animated.
    
    IMPACT:
    - Windows feels faster and more responsive
    - Reduced system resource usage
    - Better for older or slower computers
    - Interface looks less "smooth" but more direct
    - Improves performance in some cases
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Disable-Animations.ps1
    Disables animations with user confirmation

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Enable_Animations.reg
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
Write-Host "  Disable Animations" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Show what this script does
Write-Host "This script will:" -ForegroundColor Yellow
Write-Host "  • Disable window animations" -ForegroundColor White
Write-Host "  • Turn off smooth scrolling effects" -ForegroundColor White
Write-Host "  • Remove visual effects" -ForegroundColor White
Write-Host "  • Make interface more responsive" -ForegroundColor White
Write-Host ""
Write-Host "BENEFITS:" -ForegroundColor Green
Write-Host "  • Faster, more responsive feel" -ForegroundColor White
Write-Host "  • Better performance on older PCs" -ForegroundColor White
Write-Host "  • Reduced system resource usage" -ForegroundColor White
Write-Host "  • More immediate interface response" -ForegroundColor White
Write-Host ""
Write-Host "RECOMMENDED FOR:" -ForegroundColor Green
Write-Host "  • Older computers" -ForegroundColor White
Write-Host "  • Performance-focused users" -ForegroundColor White
Write-Host "  • Users who prefer snappy response over smooth animations" -ForegroundColor White
Write-Host ""
Write-Host "TRADE-OFF:" -ForegroundColor Yellow
Write-Host "  • Interface will look less smooth/modern" -ForegroundColor White
Write-Host "  • Everything happens instantly instead of smoothly" -ForegroundColor White
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to disable animations?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Disabling Animations"
}

# Path to the animations registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Disable_Animations.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Animation and visual effects settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Animations have been disabled." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What changed:" -ForegroundColor Yellow
    Write-Host "  • Window animations turned off" -ForegroundColor White
    Write-Host "  • Visual effects minimized" -ForegroundColor White
    Write-Host "  • Interface now more snappy/immediate" -ForegroundColor White
    Write-Host "  • Better performance on slower systems" -ForegroundColor White
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Enable_Animations.reg" -ForegroundColor White
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
    } else {
        Write-Host ""
        Write-Host "Changes will take effect after restarting Windows Explorer or logging off/on." -ForegroundColor Yellow
    }
}

Wait-ForKeyPress
