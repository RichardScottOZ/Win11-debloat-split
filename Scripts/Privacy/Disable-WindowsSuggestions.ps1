# Disable-WindowsSuggestions.ps1
# Disables tips, suggestions, and ads across Windows
# Version: 1.0

<#
.SYNOPSIS
    Disables Windows tips, tricks, suggestions, and advertisements

.DESCRIPTION
    This script disables intrusive suggestions and ads that appear throughout Windows:
    - Start menu suggestions
    - Lock screen tips and tricks
    - File Explorer ads
    - Settings page suggestions
    - Notification suggestions
    
    WHAT THIS DOES (in simple terms):
    Windows shows you suggestions, tips, and advertisements in many places like
    the Start menu, lock screen, and File Explorer. This script turns off all
    these suggestions so you have a cleaner, less cluttered experience.
    
    IMPACT:
    - Cleaner user interface without ads
    - No more app suggestions in Start menu
    - No tips on the lock screen
    - Less distracting experience overall
    - You won't see helpful Windows tips anymore
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Disable-WindowsSuggestions.ps1
    Runs the script with prompts for confirmation

.EXAMPLE
    .\Disable-WindowsSuggestions.ps1 -CreateRestorePoint -Silent
    Creates restore point and runs without prompts

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Undo_Disable_Windows_Suggestions.reg
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
Write-Host "  Disable Windows Suggestions" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Show what this script does
Write-Host "This script will disable:" -ForegroundColor Yellow
Write-Host "  • Start menu app suggestions" -ForegroundColor White
Write-Host "  • Lock screen tips and tricks" -ForegroundColor White
Write-Host "  • File Explorer advertisements" -ForegroundColor White
Write-Host "  • Settings page suggestions" -ForegroundColor White
Write-Host "  • Notification suggestions" -ForegroundColor White
Write-Host "  • Windows welcome experience" -ForegroundColor White
Write-Host ""
Write-Host "BENEFIT: Cleaner interface with fewer distractions" -ForegroundColor Green
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
    New-SystemRestorePoint -Description "Before Disabling Windows Suggestions"
}

# Path to the suggestions registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Disable_Windows_Suggestions.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Windows suggestions and ads settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Windows suggestions and ads have been disabled." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What was changed:" -ForegroundColor Yellow
    Write-Host "  • Start menu suggestions removed" -ForegroundColor White
    Write-Host "  • Lock screen tips disabled" -ForegroundColor White
    Write-Host "  • File Explorer ads removed" -ForegroundColor White
    Write-Host "  • Settings suggestions disabled" -ForegroundColor White
    Write-Host "  • Welcome experience disabled" -ForegroundColor White
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Undo_Disable_Windows_Suggestions.reg" -ForegroundColor White
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
