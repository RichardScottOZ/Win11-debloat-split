# Quick Reference Guide

## 🚀 One-Command Script Execution

Copy and paste these commands into PowerShell (run as Administrator) to quickly execute common scripts.

### First Time Setup
```powershell
Set-ExecutionPolicy -Scope Process -Force Unrestricted
cd C:\Path\To\Win11-debloat-split\Scripts
```
*(Replace the path with where you extracted the files)*

---

## 🔒 Privacy & Security (Recommended for Everyone)

### Essential Privacy Scripts
```powershell
# Disable telemetry (RECOMMENDED)
.\Privacy\Disable-Telemetry.ps1 -CreateRestorePoint

# Remove Windows suggestions and ads
.\Privacy\Disable-WindowsSuggestions.ps1

# Show file extensions (SECURITY MUST-HAVE)
.\FileExplorer\Show-FileExtensions.ps1
```

### Disable AI Features
```powershell
# Disable Copilot
.\AI\Disable-Copilot.ps1

# Disable Windows Recall
.\AI\Disable-WindowsRecall.ps1
```

---

## 🗑️ Remove Unnecessary Apps

### See What Would Be Removed First
```powershell
# List bloatware that would be removed
.\AppRemoval\Remove-BloatwareApps.ps1 -ListOnly
```

### Remove Bloatware
```powershell
# Remove common bloatware
.\AppRemoval\Remove-BloatwareApps.ps1 -CreateRestorePoint
```

---

## 🎨 Appearance Customization

```powershell
# Enable dark mode
.\Appearance\Enable-DarkMode.ps1

# Disable animations (faster performance)
.\Appearance\Disable-Animations.ps1

# Disable transparency effects (better performance on older PCs)
.\Appearance\Disable-Transparency.ps1
```

---

## ⚙️ System Tweaks

```powershell
# Disable fast startup (better for dual-boot)
.\System\Disable-FastStartup.ps1

# Disable mouse acceleration (better for gaming)
.\System\Disable-MouseAcceleration.ps1

# Disable sticky keys shortcut
.\System\Disable-StickyKeys.ps1
```

---

## 📱 Start Menu & Search

```powershell
# Disable Bing web search in Start menu
.\StartMenu\Disable-BingSearch.ps1

# Disable recommended section
.\StartMenu\Disable-StartRecommended.ps1
```

---

## 🖥️ Taskbar Customization

```powershell
# Align taskbar to left (Windows 10 style)
.\Taskbar\Align-Taskbar-Left.ps1

# Hide widgets button
.\Taskbar\Hide-Widgets.ps1

# Hide Task View button
.\Taskbar\Hide-TaskView.ps1
```

---

## 📁 File Explorer Settings

```powershell
# Show file extensions (HIGHLY RECOMMENDED)
.\FileExplorer\Show-FileExtensions.ps1

# Show hidden files
.\FileExplorer\Show-HiddenFiles.ps1

# Open File Explorer to "This PC"
.\FileExplorer\Set-Explorer-OpenToThisPC.ps1
```

---

## 📊 Windows Update Control

```powershell
# Prevent automatic restarts after updates
.\WindowsUpdate\Prevent-AutoReboot.ps1

# Disable delivery optimization (P2P updates)
.\WindowsUpdate\Disable-DeliveryOptimization.ps1
```

---

## 🎮 For Gamers

```powershell
# Disable mouse acceleration
.\System\Disable-MouseAcceleration.ps1

# Disable sticky keys shortcut
.\System\Disable-StickyKeys.ps1

# Keep gaming apps, remove other bloatware
.\AppRemoval\Remove-BloatwareApps.ps1
# (Gaming apps like Xbox are NOT removed by this script)
```

---

## 💼 For Office/Productivity Users

```powershell
# Show file extensions (important for work files)
.\FileExplorer\Show-FileExtensions.ps1

# Disable suggestions and ads
.\Privacy\Disable-WindowsSuggestions.ps1

# Disable fast startup (better for docking stations)
.\System\Disable-FastStartup.ps1
```

---

## 🔋 For Laptop Users (Battery Saving)

```powershell
# Enable dark mode (saves battery on OLED)
.\Appearance\Enable-DarkMode.ps1

# Disable transparency effects
.\Appearance\Disable-Transparency.ps1

# Disable animations
.\Appearance\Disable-Animations.ps1

# Disable delivery optimization
.\WindowsUpdate\Disable-DeliveryOptimization.ps1
```

---

## 🛡️ Maximum Privacy Setup

Run these scripts for maximum privacy:

```powershell
# Disable telemetry
.\Privacy\Disable-Telemetry.ps1 -CreateRestorePoint

# Remove suggestions
.\Privacy\Disable-WindowsSuggestions.ps1

# Disable Copilot
.\AI\Disable-Copilot.ps1

# Disable Windows Recall
.\AI\Disable-WindowsRecall.ps1

# Disable Bing search
.\StartMenu\Disable-BingSearch.ps1
```

---

## ⚡ Performance-Focused Setup

For better performance on older or slower PCs:

```powershell
# Remove bloatware
.\AppRemoval\Remove-BloatwareApps.ps1 -CreateRestorePoint

# Disable animations
.\Appearance\Disable-Animations.ps1

# Disable transparency
.\Appearance\Disable-Transparency.ps1

# Disable fast startup
.\System\Disable-FastStartup.ps1
```

---

## 🔄 How to Undo Changes

### Method 1: Use Undo Registry Files
1. Navigate to `Regfiles\Undo\` folder
2. Double-click the corresponding undo file
3. Restart Windows Explorer or log off/on

### Method 2: System Restore
1. Open Control Panel
2. Search for "Recovery"
3. Click "Open System Restore"
4. Choose the restore point created before changes
5. Follow the wizard

### Method 3: Reinstall Apps
1. Open Microsoft Store
2. Search for the app name
3. Click "Get" or "Install"

---

## 💡 Pro Tips

### Create a Restore Point Before Everything
```powershell
# Create a manual restore point
Checkpoint-Computer -Description "Before Win11 Debloat" -RestorePointType "MODIFY_SETTINGS"
```

### Run Multiple Scripts at Once
```powershell
# Run several scripts in sequence
.\Privacy\Disable-Telemetry.ps1 -Silent
.\Privacy\Disable-WindowsSuggestions.ps1 -Silent
.\FileExplorer\Show-FileExtensions.ps1 -Silent
```

### Check What's Currently Set
Open Windows Settings to see current values:
- **Privacy**: Settings → Privacy & security
- **Personalization**: Settings → Personalization
- **System**: Settings → System

---

## ⚠️ Important Reminders

1. ✅ Always run PowerShell as Administrator
2. ✅ Read what each script does before running it
3. ✅ Create restore points for important changes
4. ✅ Test one script at a time if you're unsure
5. ✅ Keep the Regfiles folder - you need it for undoing changes

---

## 🆘 Emergency: Undo Everything

If something goes wrong and you want to undo all changes:

1. **Use System Restore** (if you created a restore point)
   - Type "Create a restore point" in Start menu
   - Click "System Restore"
   - Choose restore point from before changes

2. **Reset Windows** (last resort - keeps your files)
   - Settings → System → Recovery
   - Click "Reset PC"
   - Choose "Keep my files"

---

## 📞 Need Help?

- Check the [Beginner's Guide](Beginners-Guide.md)
- Read the [Troubleshooting Section](../README.md#troubleshooting)
- Review individual script documentation
- Check the original [Win11Debloat Wiki](https://github.com/Raphire/Win11Debloat/wiki)

---

**Remember:** You're in control! Only run the scripts you want, when you want.
