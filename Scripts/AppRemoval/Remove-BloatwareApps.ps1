# Remove-BloatwareApps.ps1
# Removes common bloatware apps from Windows
# Version: 1.0

<#
.SYNOPSIS
    Removes common bloatware applications from Windows 11

.DESCRIPTION
    This script removes pre-installed bloatware apps that many users don't need:
    - Clipchamp (video editor)
    - 3D Builder
    - Cortana
    - Microsoft Tips
    - And many more unnecessary apps
    
    WHAT THIS DOES (in simple terms):
    Windows comes with many pre-installed apps that you might never use.
    These apps take up space and can slow down your system. This script
    removes the most common bloatware apps that most users don't need.
    
    IMPACT:
    - Frees up disk space
    - Cleaner Start menu
    - Slightly faster system performance
    - Apps can be reinstalled from Microsoft Store if needed
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.PARAMETER ListOnly
    Only lists the apps that would be removed without actually removing them

.EXAMPLE
    .\Remove-BloatwareApps.ps1 -ListOnly
    Shows what apps would be removed without removing them

.EXAMPLE
    .\Remove-BloatwareApps.ps1 -CreateRestorePoint
    Creates a restore point and removes bloatware apps

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    
    Most apps can be reinstalled from the Microsoft Store if needed.
#>

[CmdletBinding()]
param(
    [switch]$CreateRestorePoint,
    [switch]$Silent,
    [switch]$ListOnly
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
Write-Host "  Remove Bloatware Apps" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Define list of bloatware apps to remove
$bloatwareApps = @(
    "Clipchamp.Clipchamp",
    "Microsoft.3DBuilder",
    "Microsoft.549981C3F5F10",  # Cortana
    "Microsoft.BingNews",
    "Microsoft.BingWeather",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",  # Tips app
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.People",
    "Microsoft.PowerAutomateDesktop",
    "Microsoft.Todos",
    "Microsoft.WindowsAlarms",
    "Microsoft.WindowsCommunicationsApps",  # Mail and Calendar
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.WindowsMaps",
    "Microsoft.WindowsSoundRecorder",
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxApp",
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.YourPhone",  # Phone Link
    "Microsoft.ZuneMusic",  # Groove Music
    "Microsoft.ZuneVideo",  # Movies & TV
    "MicrosoftTeams"
)

# Function to get installed app
function Get-InstalledApp {
    param([string]$AppName)
    return Get-AppxPackage -Name $AppName -ErrorAction SilentlyContinue
}

# Show what this script does
Write-Host "This script will remove the following types of apps:" -ForegroundColor Yellow
Write-Host "  • Pre-installed Microsoft apps you likely don't use" -ForegroundColor White
Write-Host "  • Xbox gaming apps (if not a gamer)" -ForegroundColor White
Write-Host "  • Cortana voice assistant" -ForegroundColor White
Write-Host "  • Bloatware and promotional apps" -ForegroundColor White
Write-Host ""

# Check which apps are currently installed
Write-Host "Scanning for installed bloatware apps..." -ForegroundColor Cyan
Write-Host ""

$installedApps = @()
foreach ($app in $bloatwareApps) {
    $installed = Get-InstalledApp -AppName $app
    if ($installed) {
        $installedApps += $installed
        Write-Host "  [Found] $($installed.Name)" -ForegroundColor Yellow
    }
}

Write-Host ""

if ($installedApps.Count -eq 0) {
    Write-Host "No bloatware apps found on this system." -ForegroundColor Green
    Write-Host "Either they were already removed or they're not installed." -ForegroundColor Green
    Wait-ForKeyPress
    exit 0
}

Write-Host "Found $($installedApps.Count) bloatware apps installed." -ForegroundColor Cyan
Write-Host ""

# If ListOnly mode, just show the apps and exit
if ($ListOnly) {
    Write-Host "Apps that would be removed:" -ForegroundColor Yellow
    foreach ($app in $installedApps) {
        Write-Host "  • $($app.Name)" -ForegroundColor White
    }
    Write-Host ""
    Write-Host "Run without -ListOnly parameter to actually remove these apps." -ForegroundColor Cyan
    Wait-ForKeyPress
    exit 0
}

Write-Host "IMPORTANT: Most of these apps can be reinstalled" -ForegroundColor Yellow
Write-Host "from the Microsoft Store if you need them later." -ForegroundColor Yellow
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to remove these apps?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Removing Bloatware Apps"
}

# Remove apps
Write-Host ""
Write-Host "Removing bloatware apps..." -ForegroundColor Cyan
Write-Host ""

$successCount = 0
$failCount = 0

foreach ($app in $installedApps) {
    Write-Host "Removing: $($app.Name)" -ForegroundColor Yellow
    try {
        Remove-AppxPackage -Package $app.PackageFullName -ErrorAction Stop
        Write-Host "  ✓ Removed successfully" -ForegroundColor Green
        $successCount++
    }
    catch {
        Write-Host "  ✗ Failed to remove: $_" -ForegroundColor Red
        $failCount++
    }
    Write-Host ""
}

# Display results
Write-Host ""
Write-Separator
Write-Host ""

Write-Host "RESULTS:" -ForegroundColor Cyan
Write-Host "  Successfully removed: $successCount apps" -ForegroundColor Green
if ($failCount -gt 0) {
    Write-Host "  Failed to remove: $failCount apps" -ForegroundColor Red
}
Write-Host ""

if ($successCount -gt 0) {
    Write-Host "Bloatware apps have been removed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "To reinstall any app:" -ForegroundColor Yellow
    Write-Host "  Open Microsoft Store and search for the app name" -ForegroundColor White
}

Write-Host ""
Write-Separator

Wait-ForKeyPress
