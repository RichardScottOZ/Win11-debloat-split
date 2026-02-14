# Align-Taskbar-Left.ps1
# Aligns Windows 11 taskbar icons to the left (Windows 10 style)
# Version: 1.0

<#
.SYNOPSIS
    Aligns taskbar icons to the left side like Windows 10

.DESCRIPTION
    Windows 11 centers taskbar icons by default. This script moves them
    to the left side like in Windows 10 and earlier versions.
    
    WHAT THIS DOES (in simple terms):
    Makes your Windows 11 taskbar look more like Windows 10 by putting
    the Start button and app icons on the left side of the taskbar
    instead of the center.
    
    IMPACT:
    - Taskbar icons move to the left
    - More familiar layout for Windows 10 users
    - Some users find left-aligned icons easier to use
    - Purely cosmetic change - no performance impact
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Align-Taskbar-Left.ps1
    Aligns taskbar to left with user confirmation

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    Windows 11 only (Windows 10 already has left-aligned taskbar)
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Align_Taskbar_Center.reg
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
Write-Host "  Align Taskbar to Left" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check Windows version
$osVersion = [System.Environment]::OSVersion.Version
if ($osVersion.Major -lt 10 -or ($osVersion.Major -eq 10 -and $osVersion.Build -lt 22000)) {
    Write-Host "This script is for Windows 11 only." -ForegroundColor Yellow
    Write-Host "Windows 10 and earlier already have left-aligned taskbar icons." -ForegroundColor Yellow
    Wait-ForKeyPress
    exit 0
}

# Show what this script does
Write-Host "This script will:" -ForegroundColor Yellow
Write-Host "  • Move taskbar icons to the left" -ForegroundColor White
Write-Host "  • Make taskbar look like Windows 10" -ForegroundColor White
Write-Host ""
Write-Host "Windows 11 centers taskbar icons by default." -ForegroundColor Cyan
Write-Host "This change makes it look more like Windows 10 and earlier versions." -ForegroundColor Cyan
Write-Host ""
Write-Host "BENEFITS:" -ForegroundColor Green
Write-Host "  • More familiar layout for Windows 10 users" -ForegroundColor White
Write-Host "  • Shorter distance to click Start button" -ForegroundColor White
Write-Host "  • Personal preference - some find it easier to use" -ForegroundColor White
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to align taskbar icons to the left?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Aligning Taskbar Left"
}

# Path to the taskbar alignment registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Align_Taskbar_Left.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Taskbar alignment settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Taskbar has been aligned to the left." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What changed:" -ForegroundColor Yellow
    Write-Host "  • Start button now on the left" -ForegroundColor White
    Write-Host "  • Taskbar icons aligned to the left" -ForegroundColor White
    Write-Host "  • Layout similar to Windows 10" -ForegroundColor White
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Align_Taskbar_Center.reg" -ForegroundColor White
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
        Write-Host "Changes will be visible after restarting Windows Explorer or logging off/on." -ForegroundColor Yellow
    }
}

Wait-ForKeyPress
