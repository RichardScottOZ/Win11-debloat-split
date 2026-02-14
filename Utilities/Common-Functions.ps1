# Common-Functions.ps1
# Utility functions shared across all debloat scripts
# Version: 1.0

<#
.SYNOPSIS
    Common utility functions for Win11Debloat scripts

.DESCRIPTION
    This module provides shared functions used by individual debloat scripts:
    - Registry operations
    - User validation
    - Logging
    - Error handling
#>

# Function to import registry file with error handling
function Import-RegistryFile {
    <#
    .SYNOPSIS
        Imports a registry file with proper error handling
    
    .PARAMETER Path
        Path to the .reg file to import
    
    .PARAMETER Description
        Description of what this registry change does (for logging)
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        
        [Parameter(Mandatory=$false)]
        [string]$Description = "Registry modification"
    )
    
    if (-not (Test-Path $Path)) {
        Write-Warning "Registry file not found: $Path"
        return $false
    }
    
    try {
        Write-Host "Applying: $Description" -ForegroundColor Cyan
        $result = reg import "$Path" 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Successfully applied: $Description" -ForegroundColor Green
            return $true
        } else {
            Write-Warning "Failed to apply registry changes: $result"
            return $false
        }
    }
    catch {
        Write-Error "Error importing registry file: $_"
        return $false
    }
}

# Function to check if running as administrator
function Test-IsAdministrator {
    <#
    .SYNOPSIS
        Checks if the current PowerShell session has administrator privileges
    #>
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Function to require administrator privileges
function Require-Administrator {
    <#
    .SYNOPSIS
        Ensures the script is running with administrator privileges, exits if not
    #>
    if (-not (Test-IsAdministrator)) {
        Write-Host ""
        Write-Host "ERROR: This script requires administrator privileges!" -ForegroundColor Red
        Write-Host "Please right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Press any key to exit..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }
}

# Function to create system restore point
function New-SystemRestorePoint {
    <#
    .SYNOPSIS
        Creates a system restore point before making changes
    
    .PARAMETER Description
        Description for the restore point
    #>
    param(
        [Parameter(Mandatory=$false)]
        [string]$Description = "Win11Debloat Script Changes"
    )
    
    Write-Host ""
    Write-Host "Creating system restore point..." -ForegroundColor Cyan
    
    try {
        # Enable System Restore if not already enabled
        Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        
        # Create restore point
        Checkpoint-Computer -Description $Description -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
        Write-Host "✓ System restore point created successfully" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Warning "Could not create system restore point: $_"
        Write-Host "You can continue without a restore point, but changes will be harder to revert." -ForegroundColor Yellow
        return $false
    }
}

# Function to restart Windows Explorer
function Restart-Explorer {
    <#
    .SYNOPSIS
        Restarts Windows Explorer to apply changes
    #>
    Write-Host ""
    Write-Host "Restarting Windows Explorer to apply changes..." -ForegroundColor Cyan
    
    try {
        Stop-Process -Name "explorer" -Force -ErrorAction Stop
        Start-Sleep -Seconds 2
        Start-Process "explorer.exe"
        Write-Host "✓ Windows Explorer restarted" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Warning "Could not restart Windows Explorer: $_"
        Write-Host "You may need to restart manually or log off/on to see changes." -ForegroundColor Yellow
        return $false
    }
}

# Function to prompt user for confirmation
function Get-UserConfirmation {
    <#
    .SYNOPSIS
        Prompts user for yes/no confirmation
    
    .PARAMETER Message
        Message to display to the user
    
    .PARAMETER DefaultYes
        If true, defaults to Yes when user presses Enter
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [Parameter(Mandatory=$false)]
        [bool]$DefaultYes = $true
    )
    
    $prompt = if ($DefaultYes) { " [Y/n]" } else { " [y/N]" }
    
    do {
        $response = Read-Host "$Message$prompt"
        
        if ([string]::IsNullOrWhiteSpace($response)) {
            return $DefaultYes
        }
        
        $response = $response.Trim().ToLower()
        
        if ($response -eq 'y' -or $response -eq 'yes') {
            return $true
        }
        elseif ($response -eq 'n' -or $response -eq 'no') {
            return $false
        }
        else {
            Write-Host "Please answer 'y' or 'n'" -ForegroundColor Yellow
        }
    } while ($true)
}

# Function to write a separator line
function Write-Separator {
    <#
    .SYNOPSIS
        Writes a separator line to the console
    #>
    param(
        [Parameter(Mandatory=$false)]
        [string]$Character = "=",
        
        [Parameter(Mandatory=$false)]
        [int]$Length = 70
    )
    
    Write-Host ($Character * $Length) -ForegroundColor DarkGray
}

# Function to wait for user input before exiting
function Wait-ForKeyPress {
    <#
    .SYNOPSIS
        Waits for user to press a key before continuing
    
    .PARAMETER Message
        Message to display before waiting
    #>
    param(
        [Parameter(Mandatory=$false)]
        [string]$Message = "Press any key to exit..."
    )
    
    Write-Host ""
    Write-Host $Message -ForegroundColor Cyan
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Export functions for use in other scripts
Export-ModuleMember -Function @(
    'Import-RegistryFile',
    'Test-IsAdministrator',
    'Require-Administrator',
    'New-SystemRestorePoint',
    'Restart-Explorer',
    'Get-UserConfirmation',
    'Write-Separator',
    'Wait-ForKeyPress'
)
