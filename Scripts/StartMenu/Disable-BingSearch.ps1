# Disable-BingSearch.ps1
# Disables Bing web search in Windows Start menu
# Version: 1.0

<#
.SYNOPSIS
    Disables Bing web search in Windows Start menu

.DESCRIPTION
    When you search in the Start menu, Windows normally searches the web
    using Bing and shows web results mixed with your local files and apps.
    This script disables web search so you only see local results.
    
    WHAT THIS DOES (in simple terms):
    When you press the Windows key and start typing to search, you'll only
    see apps, files, and settings on your computer - no web results from Bing.
    
    IMPACT:
    - Faster search results (only searches your computer)
    - No web results cluttering your search
    - Better privacy (searches stay on your PC)
    - Cleaner, more focused search experience
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Disable-BingSearch.ps1
    Disables Bing search with user confirmation

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Undo_Disable_Bing_Cortana_In_Search.reg
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
Write-Host "  Disable Bing Search in Start Menu" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Show what this script does
Write-Host "This script will:" -ForegroundColor Yellow
Write-Host "  • Disable Bing web search in Start menu" -ForegroundColor White
Write-Host "  • Remove web results from Start search" -ForegroundColor White
Write-Host "  • Make search show only local results" -ForegroundColor White
Write-Host ""
Write-Host "BENEFITS:" -ForegroundColor Green
Write-Host "  • Faster search (searches only your PC)" -ForegroundColor White
Write-Host "  • Cleaner results (no web clutter)" -ForegroundColor White
Write-Host "  • Better privacy (searches don't go online)" -ForegroundColor White
Write-Host "  • More focused search experience" -ForegroundColor White
Write-Host ""
Write-Host "NOTE: You can still search the web using a browser" -ForegroundColor Cyan
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to disable Bing search?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Disabling Bing Search"
}

# Path to the Bing search registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Disable_Bing_Cortana_In_Search.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Bing search in Start menu"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Bing web search has been disabled in Start menu." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What changed:" -ForegroundColor Yellow
    Write-Host "  • Start menu search now shows only local results" -ForegroundColor White
    Write-Host "  • No more web results from Bing" -ForegroundColor White
    Write-Host "  • Faster, cleaner search experience" -ForegroundColor White
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Undo_Disable_Bing_Cortana_In_Search.reg" -ForegroundColor White
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
