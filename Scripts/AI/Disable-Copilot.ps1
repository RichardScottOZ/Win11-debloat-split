# Disable-Copilot.ps1
# Disables and removes Microsoft Copilot from Windows
# Version: 1.0

<#
.SYNOPSIS
    Disables and removes Microsoft Copilot from Windows 11

.DESCRIPTION
    This script disables the Microsoft Copilot AI assistant in Windows 11:
    - Removes Copilot icon from taskbar
    - Disables Copilot keyboard shortcut (Win + C)
    - Prevents Copilot from starting automatically
    - Removes Copilot integration from Windows
    
    WHAT THIS DOES (in simple terms):
    Microsoft Copilot is an AI assistant built into Windows 11. It can answer
    questions and help with tasks, but some users prefer not to have it.
    This script completely removes Copilot from your Windows experience.
    
    IMPACT:
    - Copilot button removed from taskbar
    - Win + C shortcut no longer opens Copilot
    - No AI assistant suggestions in Windows
    - You can't use Copilot features without re-enabling it
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Disable-Copilot.ps1
    Runs the script with prompts for confirmation

.EXAMPLE
    .\Disable-Copilot.ps1 -CreateRestorePoint
    Creates a restore point before disabling Copilot

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    Windows 11 only feature
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Undo_Disable_Copilot.reg
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
Write-Host "  Disable Microsoft Copilot" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check Windows version
$osVersion = [System.Environment]::OSVersion.Version
if ($osVersion.Major -lt 10 -or ($osVersion.Major -eq 10 -and $osVersion.Build -lt 22000)) {
    Write-Host "This script is designed for Windows 11 only." -ForegroundColor Yellow
    Write-Host "Copilot is not available on your version of Windows." -ForegroundColor Yellow
    Wait-ForKeyPress
    exit 0
}

# Show what this script does
Write-Host "This script will:" -ForegroundColor Yellow
Write-Host "  • Remove Copilot from taskbar" -ForegroundColor White
Write-Host "  • Disable Copilot keyboard shortcut (Win + C)" -ForegroundColor White
Write-Host "  • Disable Copilot integration in Windows" -ForegroundColor White
Write-Host "  • Prevent Copilot from starting automatically" -ForegroundColor White
Write-Host ""
Write-Host "NOTE: This is a Windows 11 feature only" -ForegroundColor Cyan
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to disable Copilot?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Disabling Copilot"
}

# Path to the Copilot registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Disable_Copilot.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Microsoft Copilot settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Microsoft Copilot has been disabled." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What was changed:" -ForegroundColor Yellow
    Write-Host "  • Copilot removed from taskbar" -ForegroundColor White
    Write-Host "  • Copilot keyboard shortcut disabled" -ForegroundColor White
    Write-Host "  • Copilot integration disabled" -ForegroundColor White
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Undo_Disable_Copilot.reg" -ForegroundColor White
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
