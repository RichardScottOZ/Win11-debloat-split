# Run-Debloat-Menu.ps1
# Interactive menu for running debloat scripts
# Version: 1.0

<#
.SYNOPSIS
    Interactive menu for selecting and running Windows debloat scripts

.DESCRIPTION
    This script provides a simple text-based menu to help you discover
    and run individual debloat scripts. Perfect for users who prefer
    a menu-driven interface over running scripts directly.
    
.EXAMPLE
    .\Run-Debloat-Menu.ps1
    Displays the interactive menu

.NOTES
    Author: Win11Debloat Split Project
    Requires: Administrator privileges
#>

# Ensure script is running as administrator
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host ""
    Write-Host "ERROR: This script requires administrator privileges!" -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Set execution policy for this session
Set-ExecutionPolicy -Scope Process -Force Bypass -ErrorAction SilentlyContinue

function Show-Header {
    Clear-Host
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host "         Windows 11 Debloat - Individual Scripts Menu" -ForegroundColor Cyan
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Show-MainMenu {
    Show-Header
    Write-Host "Select a category:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1. Privacy & Telemetry" -ForegroundColor White
    Write-Host "  2. AI Features (Copilot, Recall, etc.)" -ForegroundColor White
    Write-Host "  3. Remove Apps" -ForegroundColor White
    Write-Host "  4. Appearance & Themes" -ForegroundColor White
    Write-Host "  5. System Tweaks" -ForegroundColor White
    Write-Host "  6. Windows Update Settings" -ForegroundColor White
    Write-Host "  7. Taskbar Customization" -ForegroundColor White
    Write-Host "  8. File Explorer Settings" -ForegroundColor White
    Write-Host "  9. Start Menu Customization" -ForegroundColor White
    Write-Host ""
    Write-Host "  H. Help & Documentation" -ForegroundColor Green
    Write-Host "  Q. Quit" -ForegroundColor Red
    Write-Host ""
}

function Show-PrivacyMenu {
    Show-Header
    Write-Host "Privacy & Telemetry Scripts:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1. Disable Telemetry (RECOMMENDED)" -ForegroundColor White
    Write-Host "     └─ Stops Windows from sending usage data to Microsoft" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  2. Disable Windows Suggestions & Ads" -ForegroundColor White
    Write-Host "     └─ Removes ads and suggestions throughout Windows" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  B. Back to Main Menu" -ForegroundColor Cyan
    Write-Host ""
}

function Show-AIMenu {
    Show-Header
    Write-Host "AI Features Scripts:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1. Disable Copilot" -ForegroundColor White
    Write-Host "     └─ Removes Microsoft Copilot AI assistant" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  2. Disable Windows Recall" -ForegroundColor White
    Write-Host "     └─ Stops AI from taking screenshots of your activity" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  B. Back to Main Menu" -ForegroundColor Cyan
    Write-Host ""
}

function Show-AppRemovalMenu {
    Show-Header
    Write-Host "App Removal Scripts:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1. Remove Bloatware Apps (POPULAR)" -ForegroundColor White
    Write-Host "     └─ Removes pre-installed apps you likely don't use" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  B. Back to Main Menu" -ForegroundColor Cyan
    Write-Host ""
}

function Show-AppearanceMenu {
    Show-Header
    Write-Host "Appearance Scripts:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1. Enable Dark Mode" -ForegroundColor White
    Write-Host "     └─ Switch to dark theme (easier on eyes)" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  B. Back to Main Menu" -ForegroundColor Cyan
    Write-Host ""
}

function Show-SystemMenu {
    Show-Header
    Write-Host "System Tweaks Scripts:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1. Disable Fast Startup" -ForegroundColor White
    Write-Host "     └─ Ensures full shutdown (better for dual-boot)" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  B. Back to Main Menu" -ForegroundColor Cyan
    Write-Host ""
}

function Show-UpdateMenu {
    Show-Header
    Write-Host "Windows Update Scripts:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1. Prevent Automatic Restarts (POPULAR)" -ForegroundColor White
    Write-Host "     └─ Stops surprise restarts after updates" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  B. Back to Main Menu" -ForegroundColor Cyan
    Write-Host ""
}

function Show-TaskbarMenu {
    Show-Header
    Write-Host "Taskbar Scripts:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1. Align Taskbar to Left (Windows 10 style)" -ForegroundColor White
    Write-Host "     └─ Move taskbar icons to the left" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  2. Disable Widgets" -ForegroundColor White
    Write-Host "     └─ Remove Widgets button from taskbar" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  B. Back to Main Menu" -ForegroundColor Cyan
    Write-Host ""
}

function Show-ExplorerMenu {
    Show-Header
    Write-Host "File Explorer Scripts:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1. Show File Extensions (SECURITY MUST-HAVE)" -ForegroundColor White
    Write-Host "     └─ Shows .txt, .exe, .jpg extensions for security" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  B. Back to Main Menu" -ForegroundColor Cyan
    Write-Host ""
}

function Show-StartMenuScripts {
    Show-Header
    Write-Host "Start Menu Scripts:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1. Disable Bing Search" -ForegroundColor White
    Write-Host "     └─ Remove web results from Start menu search" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  B. Back to Main Menu" -ForegroundColor Cyan
    Write-Host ""
}

function Run-Script {
    param([string]$ScriptPath, [string]$ScriptName)
    
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host "Running: $ScriptName" -ForegroundColor Cyan
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Press any key to continue or Ctrl+C to cancel..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    
    if (Test-Path $ScriptPath) {
        & $ScriptPath
    } else {
        Write-Host ""
        Write-Host "ERROR: Script not found at: $ScriptPath" -ForegroundColor Red
        Write-Host "Press any key to continue..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
}

function Show-Help {
    Show-Header
    Write-Host "Help & Documentation:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "GETTING STARTED:" -ForegroundColor Green
    Write-Host "  1. Select a category from the main menu" -ForegroundColor White
    Write-Host "  2. Choose a script to run" -ForegroundColor White
    Write-Host "  3. Follow the on-screen instructions" -ForegroundColor White
    Write-Host "  4. Most changes can be undone using files in Regfiles/Undo/" -ForegroundColor White
    Write-Host ""
    Write-Host "DOCUMENTATION FILES:" -ForegroundColor Green
    Write-Host "  • README.md - Main documentation" -ForegroundColor White
    Write-Host "  • Docs/Beginners-Guide.md - Complete beginner's guide" -ForegroundColor White
    Write-Host "  • Docs/Quick-Reference.md - Quick command reference" -ForegroundColor White
    Write-Host ""
    Write-Host "RECOMMENDED FOR EVERYONE:" -ForegroundColor Green
    Write-Host "  • Show File Extensions (Security)" -ForegroundColor White
    Write-Host "  • Disable Telemetry (Privacy)" -ForegroundColor White
    Write-Host "  • Prevent Auto-Restart (Convenience)" -ForegroundColor White
    Write-Host ""
    Write-Host "SAFETY:" -ForegroundColor Green
    Write-Host "  • Most scripts offer to create a restore point" -ForegroundColor White
    Write-Host "  • Changes can be undone" -ForegroundColor White
    Write-Host "  • Scripts explain what they do before running" -ForegroundColor White
    Write-Host ""
    Write-Host "Press any key to return to main menu..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Main menu loop
$quit = $false
while (-not $quit) {
    Show-MainMenu
    $choice = Read-Host "Enter your choice"
    
    switch ($choice.ToUpper()) {
        "1" {
            $subQuit = $false
            while (-not $subQuit) {
                Show-PrivacyMenu
                $subChoice = Read-Host "Enter your choice"
                switch ($subChoice.ToUpper()) {
                    "1" { Run-Script "$PSScriptRoot\Scripts\Privacy\Disable-Telemetry.ps1" "Disable Telemetry" }
                    "2" { Run-Script "$PSScriptRoot\Scripts\Privacy\Disable-WindowsSuggestions.ps1" "Disable Windows Suggestions" }
                    "B" { $subQuit = $true }
                }
            }
        }
        "2" {
            $subQuit = $false
            while (-not $subQuit) {
                Show-AIMenu
                $subChoice = Read-Host "Enter your choice"
                switch ($subChoice.ToUpper()) {
                    "1" { Run-Script "$PSScriptRoot\Scripts\AI\Disable-Copilot.ps1" "Disable Copilot" }
                    "2" { Run-Script "$PSScriptRoot\Scripts\AI\Disable-WindowsRecall.ps1" "Disable Windows Recall" }
                    "B" { $subQuit = $true }
                }
            }
        }
        "3" {
            $subQuit = $false
            while (-not $subQuit) {
                Show-AppRemovalMenu
                $subChoice = Read-Host "Enter your choice"
                switch ($subChoice.ToUpper()) {
                    "1" { Run-Script "$PSScriptRoot\Scripts\AppRemoval\Remove-BloatwareApps.ps1" "Remove Bloatware Apps" }
                    "B" { $subQuit = $true }
                }
            }
        }
        "4" {
            $subQuit = $false
            while (-not $subQuit) {
                Show-AppearanceMenu
                $subChoice = Read-Host "Enter your choice"
                switch ($subChoice.ToUpper()) {
                    "1" { Run-Script "$PSScriptRoot\Scripts\Appearance\Enable-DarkMode.ps1" "Enable Dark Mode" }
                    "B" { $subQuit = $true }
                }
            }
        }
        "5" {
            $subQuit = $false
            while (-not $subQuit) {
                Show-SystemMenu
                $subChoice = Read-Host "Enter your choice"
                switch ($subChoice.ToUpper()) {
                    "1" { Run-Script "$PSScriptRoot\Scripts\System\Disable-FastStartup.ps1" "Disable Fast Startup" }
                    "B" { $subQuit = $true }
                }
            }
        }
        "6" {
            $subQuit = $false
            while (-not $subQuit) {
                Show-UpdateMenu
                $subChoice = Read-Host "Enter your choice"
                switch ($subChoice.ToUpper()) {
                    "1" { Run-Script "$PSScriptRoot\Scripts\WindowsUpdate\Prevent-AutoReboot.ps1" "Prevent Auto-Restart" }
                    "B" { $subQuit = $true }
                }
            }
        }
        "7" {
            $subQuit = $false
            while (-not $subQuit) {
                Show-TaskbarMenu
                $subChoice = Read-Host "Enter your choice"
                switch ($subChoice.ToUpper()) {
                    "1" { Run-Script "$PSScriptRoot\Scripts\Taskbar\Align-Taskbar-Left.ps1" "Align Taskbar Left" }
                    "2" { Run-Script "$PSScriptRoot\Scripts\Taskbar\Disable-Widgets.ps1" "Disable Widgets" }
                    "B" { $subQuit = $true }
                }
            }
        }
        "8" {
            $subQuit = $false
            while (-not $subQuit) {
                Show-ExplorerMenu
                $subChoice = Read-Host "Enter your choice"
                switch ($subChoice.ToUpper()) {
                    "1" { Run-Script "$PSScriptRoot\Scripts\FileExplorer\Show-FileExtensions.ps1" "Show File Extensions" }
                    "B" { $subQuit = $true }
                }
            }
        }
        "9" {
            $subQuit = $false
            while (-not $subQuit) {
                Show-StartMenuScripts
                $subChoice = Read-Host "Enter your choice"
                switch ($subChoice.ToUpper()) {
                    "1" { Run-Script "$PSScriptRoot\Scripts\StartMenu\Disable-BingSearch.ps1" "Disable Bing Search" }
                    "B" { $subQuit = $true }
                }
            }
        }
        "H" { Show-Help }
        "Q" { 
            $quit = $true
            Write-Host ""
            Write-Host "Thank you for using Win11 Debloat Scripts!" -ForegroundColor Green
            Write-Host ""
        }
    }
}
