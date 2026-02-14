# Disable-FastStartup.ps1
# Disables Windows Fast Startup feature
# Version: 1.0

<#
.SYNOPSIS
    Disables Windows Fast Startup feature

.DESCRIPTION
    This script disables Fast Startup (also known as Hybrid Shutdown):
    - Ensures a full shutdown when you turn off your PC
    - Can help resolve boot issues
    - Allows BIOS updates to apply properly
    
    WHAT THIS DOES (in simple terms):
    Fast Startup makes Windows start faster by not fully shutting down.
    Instead, it saves some system information and loads it when you start up.
    While this makes startup faster, it can cause problems with updates,
    dual-boot systems, and hardware changes. This script disables it for
    a more reliable full shutdown.
    
    IMPACT:
    - Your PC will fully shut down when you turn it off
    - Startup may be slightly slower (a few seconds)
    - Better compatibility with dual-boot systems
    - Updates and BIOS changes apply more reliably
    - Can fix certain boot and hardware issues
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Disable-FastStartup.ps1
    Disables fast startup with user confirmation

.EXAMPLE
    .\Disable-FastStartup.ps1 -CreateRestorePoint -Silent
    Creates restore point and disables without prompts

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Undo_Disable_Fast_Startup.reg
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
Write-Host "  Disable Fast Startup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Show what this script does
Write-Host "About Fast Startup:" -ForegroundColor Yellow
Write-Host "Fast Startup makes Windows boot faster by saving system state" -ForegroundColor White
Write-Host "to disk instead of fully shutting down." -ForegroundColor White
Write-Host ""
Write-Host "Why disable it?" -ForegroundColor Yellow
Write-Host "  • Ensures updates apply properly" -ForegroundColor White
Write-Host "  • Better compatibility with dual-boot systems" -ForegroundColor White
Write-Host "  • Can fix boot and hardware detection issues" -ForegroundColor White
Write-Host "  • Allows BIOS updates to apply correctly" -ForegroundColor White
Write-Host ""
Write-Host "Trade-off:" -ForegroundColor Yellow
Write-Host "  • Boot time may increase by a few seconds" -ForegroundColor White
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to disable Fast Startup?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Disabling Fast Startup"
}

# Path to the fast startup registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Disable_Fast_Startup.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Fast Startup settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Fast Startup has been disabled." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What was changed:" -ForegroundColor Yellow
    Write-Host "  • Fast Startup disabled" -ForegroundColor White
    Write-Host "  • PC will fully shut down when powered off" -ForegroundColor White
    Write-Host "  • Updates and changes will apply more reliably" -ForegroundColor White
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Undo_Disable_Fast_Startup.reg" -ForegroundColor White
    Write-Host ""
    Write-Host "NOTE: The change takes effect immediately for future shutdowns." -ForegroundColor Cyan
} else {
    Write-Host "ERROR: Failed to apply some or all changes." -ForegroundColor Red
    Write-Host "Please check if the registry file exists and try running as administrator." -ForegroundColor Yellow
}

Write-Host ""
Write-Separator

Wait-ForKeyPress
