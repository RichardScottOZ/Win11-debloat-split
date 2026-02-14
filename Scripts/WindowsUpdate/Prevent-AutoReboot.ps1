# Prevent-AutoReboot.ps1
# Prevents automatic restarts after Windows Updates
# Version: 1.0

<#
.SYNOPSIS
    Prevents Windows from automatically restarting after updates

.DESCRIPTION
    By default, Windows can automatically restart your computer after
    installing updates, even if you're in the middle of work. This script
    prevents those automatic restarts.
    
    WHAT THIS DOES (in simple terms):
    Stops Windows from restarting your computer on its own after updates.
    You'll still need to restart eventually to complete updates, but it
    will wait for you to choose when to do it.
    
    IMPACT:
    - No surprise restarts while you're working
    - You control when your computer restarts
    - Updates still install normally
    - You'll need to manually restart when convenient
    - Windows will remind you to restart
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Prevent-AutoReboot.ps1
    Prevents auto-restart with user confirmation

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    
    IMPORTANT: You should still restart your computer after updates
    when you have a chance. Windows will remind you.
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Allow_Auto_Reboot.reg
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
Write-Host "  Prevent Automatic Restarts" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Show what this script does
Write-Host "This script will:" -ForegroundColor Yellow
Write-Host "  • Prevent automatic restarts after updates" -ForegroundColor White
Write-Host "  • Give you control over when to restart" -ForegroundColor White
Write-Host "  • Stop surprise restarts during work" -ForegroundColor White
Write-Host ""
Write-Host "HOW IT WORKS:" -ForegroundColor Cyan
Write-Host "  • Windows will still install updates normally" -ForegroundColor White
Write-Host "  • You'll be notified when a restart is needed" -ForegroundColor White
Write-Host "  • You choose when to restart" -ForegroundColor White
Write-Host "  • No more losing unsaved work to surprise restarts!" -ForegroundColor White
Write-Host ""
Write-Host "IMPORTANT: You should still restart after updates" -ForegroundColor Yellow
Write-Host "when you get a chance. Security updates need a restart to apply." -ForegroundColor Yellow
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to prevent automatic restarts?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Preventing Auto-Restart"
}

# Path to the auto-reboot prevention registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Prevent_Auto_Reboot.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "Automatic restart settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Automatic restarts have been disabled." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What this means:" -ForegroundColor Yellow
    Write-Host "  • Windows won't restart automatically after updates" -ForegroundColor White
    Write-Host "  • You'll see notifications when restart is needed" -ForegroundColor White
    Write-Host "  • You choose when to restart" -ForegroundColor White
    Write-Host "  • Your work is safer from surprise restarts" -ForegroundColor White
    Write-Host ""
    Write-Host "REMEMBER: Still restart when convenient!" -ForegroundColor Red
    Write-Host "Security updates need a restart to fully protect your PC." -ForegroundColor Red
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Allow_Auto_Reboot.reg" -ForegroundColor White
} else {
    Write-Host "ERROR: Failed to apply some or all changes." -ForegroundColor Red
    Write-Host "Please check if the registry file exists and try running as administrator." -ForegroundColor Yellow
}

Write-Host ""
Write-Separator

Wait-ForKeyPress
