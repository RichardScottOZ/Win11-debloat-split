# Show-FileExtensions.ps1
# Shows file extensions for known file types
# Version: 1.0

<#
.SYNOPSIS
    Shows file extensions for all file types in Windows Explorer

.DESCRIPTION
    By default, Windows hides file extensions (like .txt, .exe, .jpg).
    This makes it hard to identify file types and can be a security risk.
    This script makes Windows show all file extensions.
    
    WHAT THIS DOES (in simple terms):
    When you look at files in File Explorer, you'll now see the full filename
    including the extension. For example, "document.txt" instead of just "document".
    
    WHY THIS MATTERS:
    - **SECURITY**: Prevents malicious files from hiding (virus.jpg.exe looks like an image but is actually a program)
    - **CLARITY**: You always know what type of file you're dealing with
    - **PROFESSIONALISM**: Standard practice for anyone working with files
    
    IMPACT:
    - File extensions become visible (.txt, .pdf, .exe, etc.)
    - Easier to identify file types
    - Better security against malware
    - No negative effects
    
.PARAMETER CreateRestorePoint
    Creates a system restore point before making changes (recommended)

.PARAMETER Silent
    Run without prompts (assumes yes to all questions)

.EXAMPLE
    .\Show-FileExtensions.ps1
    Shows file extensions with user confirmation

.NOTES
    Author: Based on Win11Debloat by Raphire
    Requires: Administrator privileges
    
    You can undo these changes by running the corresponding undo registry file
    located in Regfiles/Undo/Undo_Show_Extensions_For_Known_File_Types.reg
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
Write-Host "  Show File Extensions" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Show what this script does
Write-Host "This script will:" -ForegroundColor Yellow
Write-Host "  • Make file extensions visible in File Explorer" -ForegroundColor White
Write-Host "  • Show .txt, .exe, .pdf, .jpg, etc. on all files" -ForegroundColor White
Write-Host ""
Write-Host "WHY THIS IS IMPORTANT:" -ForegroundColor Green
Write-Host "  • SECURITY: Prevents malware from hiding as fake file types" -ForegroundColor White
Write-Host "  • CLARITY: You always know exactly what type of file it is" -ForegroundColor White
Write-Host "  • RECOMMENDED: This is a security best practice" -ForegroundColor White
Write-Host ""
Write-Host "Example: 'virus.jpg.exe' would show as 'virus.jpg' with extensions" -ForegroundColor Yellow
Write-Host "         hidden, looking like a safe image file. With extensions" -ForegroundColor Yellow
Write-Host "         shown, you'd see it's actually an .exe program file!" -ForegroundColor Yellow
Write-Host ""

# Get user confirmation if not in silent mode
if (-not $Silent) {
    $proceed = Get-UserConfirmation -Message "Do you want to show file extensions?" -DefaultYes $true
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
    New-SystemRestorePoint -Description "Before Showing File Extensions"
}

# Path to the file extensions registry file
$regFilePath = Join-Path $PSScriptRoot "..\..\Regfiles\Show_Extensions_For_Known_File_Types.reg"

# Apply registry changes
Write-Host ""
$success = Import-RegistryFile -Path $regFilePath -Description "File extension visibility settings"

# Display results
Write-Host ""
Write-Separator
Write-Host ""

if ($success) {
    Write-Host "SUCCESS!" -ForegroundColor Green
    Write-Host ""
    Write-Host "File extensions are now visible in File Explorer." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What you'll see:" -ForegroundColor Yellow
    Write-Host "  Before: 'document', 'photo', 'program'" -ForegroundColor White
    Write-Host "  After:  'document.txt', 'photo.jpg', 'program.exe'" -ForegroundColor White
    Write-Host ""
    Write-Host "Security tip: Be cautious of files with double extensions!" -ForegroundColor Red
    Write-Host "  Example: 'photo.jpg.exe' is NOT an image - it's a program" -ForegroundColor Red
    Write-Host ""
    Write-Host "To undo these changes:" -ForegroundColor Yellow
    Write-Host "  Run: Regfiles\Undo\Undo_Show_Extensions_For_Known_File_Types.reg" -ForegroundColor White
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
