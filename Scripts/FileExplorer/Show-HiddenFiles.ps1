# Show-HiddenFiles.ps1
# Shows hidden files and folders in File Explorer
# Version: 1.0

<#
.SYNOPSIS
    Shows hidden files and folders in Windows Explorer

.DESCRIPTION
    By default, Windows hides certain system files and folders.
    This script makes all hidden files and folders visible.
    
    WHAT THIS DOES (in simple terms):
    Makes Windows show files and folders that are normally hidden.
    This includes system files, hidden configuration files, and folders
    like AppData that Windows hides by default.
    
    IMPACT:
    - You'll see more files and folders in File Explorer
    - System and hidden files become visible
    - Useful for troubleshooting and advanced configuration
    - Be careful not to delete system files
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Show-HiddenFiles.ps1
    Shows hidden files with user confirmation

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    
    CAUTION: Be careful when deleting hidden files - some are system files
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Hide_Hidden_Folders.reg
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
Write-Host "  Show Hidden Files and Folders" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Show what this script does
Write-Host "This script will:" -ForegroundColor Yellow
Write-Host "  • Make hidden files and folders visible" -ForegroundColor White
Write-Host "  • Show system files (grayed out)" -ForegroundColor White
Write-Host "  • Make AppData and other hidden folders visible" -ForegroundColor White
Write-Host ""
Write-Host "WHO SHOULD USE THIS:" -ForegroundColor Green
Write-Host "  • Troubleshooters" -ForegroundColor White
Write-Host "  • Advanced users" -ForegroundColor White
Write-Host "  • People who need to access AppData folder" -ForegroundColor White
Write-Host "  • Developers" -ForegroundColor White
Write-Host ""
Write-Host "CAUTION:" -ForegroundColor Red
Write-Host "  • Be careful not to delete or modify hidden system files" -ForegroundColor Yellow
Write-Host "  • These files are hidden for a reason (system protection)" -ForegroundColor Yellow
Write-Host "  • Only change files if you know what you're doing" -ForegroundColor Yellow
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to show hidden files?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Showing Hidden Files"
}

# Path to the hidden files registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Show_Hidden_Folders.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Hidden files visibility settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Hidden files and folders are now visible." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What you'll see:" -ForegroundColor Yellow
    Write-Host "  • Hidden folders like AppData" -ForegroundColor White
    Write-Host "  • System files (shown grayed/dimmed)" -ForegroundColor White
    Write-Host "  • Configuration files that were hidden" -ForegroundColor White
    Write-Host ""
    Write-Host "REMEMBER:" -ForegroundColor Red
    Write-Host "  • Don't delete system files (grayed out files)" -ForegroundColor Yellow
    Write-Host "  • Be cautious when modifying hidden files" -ForegroundColor Yellow
    Write-Host "  • When in doubt, leave it alone!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Hide_Hidden_Folders.reg" -ForegroundColor White
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
