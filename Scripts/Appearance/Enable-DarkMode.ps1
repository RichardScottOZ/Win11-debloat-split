# Enable-DarkMode.ps1
# Enables dark mode for Windows and apps
# Version: 1.0

<#
.SYNOPSIS
    Enables dark mode for Windows system and applications

.DESCRIPTION
    This script enables Windows dark mode:
    - System dark mode (taskbar, Start menu, settings)
    - App dark mode (apps that support dark themes)
    
    WHAT THIS DOES (in simple terms):
    Changes Windows from light colors to dark colors. This makes the
    interface easier on the eyes, especially at night, and can help
    reduce eye strain.
    
    IMPACT:
    - Windows interface uses dark colors
    - Apps that support dark mode will use it
    - Easier on the eyes in low-light conditions
    - May help reduce eye strain
    - Can save battery on OLED screens
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Enable-DarkMode.ps1
    Enables dark mode with user confirmation

.EXAMPLE
    .\Enable-DarkMode.ps1 -Silent
    Enables dark mode without prompts

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Undo_Enable_Dark_Mode.reg
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
Write-Host "  Enable Dark Mode" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Show what this script does
Write-Host "This script will enable:" -ForegroundColor Yellow
Write-Host "  • System dark mode (taskbar, Start, Settings)" -ForegroundColor White
Write-Host "  • App dark mode (for apps that support it)" -ForegroundColor White
Write-Host ""
Write-Host "BENEFITS:" -ForegroundColor Green
Write-Host "  • Easier on the eyes in low-light conditions" -ForegroundColor White
Write-Host "  • Can help reduce eye strain" -ForegroundColor White
Write-Host "  • Saves battery on OLED screens" -ForegroundColor White
Write-Host "  • Modern, sleek appearance" -ForegroundColor White
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to enable dark mode?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Enabling Dark Mode"
}

# Path to the dark mode registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Enable_Dark_Mode.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Dark mode settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Dark mode has been enabled." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What was changed:" -ForegroundColor Yellow
    Write-Host "  • System uses dark theme" -ForegroundColor White
    Write-Host "  • Apps use dark theme (when supported)" -ForegroundColor White
    Write-Host ""
    Write-Host "NOTE: Some apps may need to be restarted to apply dark mode." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Undo_Enable_Dark_Mode.reg" -ForegroundColor White
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
        Write-Host "Changes will take effect after logging off and back on." -ForegroundColor Yellow
    }
}

Wait-ForKeyPress
