# Win11 Debloat Split - Individual Debloating Scripts

Welcome! This repository contains **individual scripts** that let you customize Windows 11 exactly how you want it. Each script handles one specific thing, so you only change what you need.

## 📋 What is This?

Windows 11 comes with many features that not everyone wants or needs. This collection of scripts lets you:
- Remove bloatware apps you don't use
- Disable privacy-invasive features
- Turn off AI features like Copilot and Recall
- Customize the appearance and behavior of Windows
- Improve performance and reduce clutter

**Based on:** [Win11Debloat by Raphire](https://github.com/Raphire/Win11Debloat)

## 🎯 Why Use Individual Scripts?

Unlike all-in-one debloating tools, these individual scripts give you **precise control**:
- ✅ Only change what you want
- ✅ Understand exactly what each script does
- ✅ Easy to reverse any changes
- ✅ No risk of breaking features you actually use
- ✅ Simple, documented, beginner-friendly

## 🚀 Quick Start

### Prerequisites
1. **Windows 11** (some scripts work on Windows 10)
2. **Administrator access** on your computer
3. **5 minutes** of your time

### How to Run Any Script

1. **Download this repository**
   - Click the green "Code" button above
   - Select "Download ZIP"
   - Extract the ZIP file to a folder

2. **Right-click PowerShell and select "Run as Administrator"**
   - Press Windows key
   - Type "PowerShell"
   - Right-click "Windows PowerShell"
   - Click "Run as administrator"

3. **Navigate to the script folder**
   ```powershell
   cd C:\Path\To\Win11-debloat-split\Scripts
   ```

4. **Allow script execution** (one-time setup)
   ```powershell
   Set-ExecutionPolicy -Scope Process -Force Unrestricted
   ```

5. **Run the script you want**
   ```powershell
   .\Privacy\Disable-Telemetry.ps1
   ```

## 📚 Available Scripts

### 🔒 Privacy Scripts (`Scripts/Privacy/`)

| Script | What It Does | Recommended For |
|--------|--------------|-----------------|
| `Disable-Telemetry.ps1` | Stops Windows from sending your usage data to Microsoft | Everyone who values privacy |
| `Disable-WindowsSuggestions.ps1` | Removes ads and suggestions throughout Windows | Anyone who finds suggestions annoying |

**Learn More:** [Privacy Scripts Documentation](Docs/Privacy-Scripts.md)

### 🤖 AI Features (`Scripts/AI/`)

| Script | What It Does | Recommended For |
|--------|--------------|-----------------|
| `Disable-Copilot.ps1` | Removes Microsoft Copilot AI assistant | Users who don't want AI assistance |
| `Disable-WindowsRecall.ps1` | Disables AI screenshot feature that records your screen | Privacy-conscious users |
| `Disable-ClickToDo.ps1` | Turns off AI text and image analysis | Users who find it intrusive |

**Learn More:** [AI Features Documentation](Docs/AI-Scripts.md)

### 🗑️ App Removal (`Scripts/AppRemoval/`)

| Script | What It Does | Recommended For |
|--------|--------------|-----------------|
| `Remove-BloatwareApps.ps1` | Removes common pre-installed apps you don't need | Everyone - frees up space |
| `Remove-GamingApps.ps1` | Removes Xbox and gaming-related apps | Non-gamers |
| `Remove-CommunicationApps.ps1` | Removes Mail, Calendar, and Teams | Users who use other email clients |

**Learn More:** [App Removal Documentation](Docs/AppRemoval-Scripts.md)

### 🎨 Appearance (`Scripts/Appearance/`)

| Script | What It Does | Recommended For |
|--------|--------------|-----------------|
| `Enable-DarkMode.ps1` | Switches to dark theme | Night owls and dark theme lovers |
| `Disable-Animations.ps1` | Turns off visual animations | Performance-focused users |
| `Disable-Transparency.ps1` | Removes transparent effects | Better performance on older PCs |

**Learn More:** [Appearance Documentation](Docs/Appearance-Scripts.md)

### ⚙️ System Tweaks (`Scripts/System/`)

| Script | What It Does | Recommended For |
|--------|--------------|-----------------|
| `Disable-FastStartup.ps1` | Ensures full shutdown (better for updates) | Dual-boot users, troubleshooters |
| `Disable-MouseAcceleration.ps1` | Turns off mouse acceleration | Gamers, precise work |
| `Disable-StickyKeys.ps1` | Disables Sticky Keys shortcut | Gamers (prevents accidental activation) |

**Learn More:** [System Scripts Documentation](Docs/System-Scripts.md)

### 📊 Windows Update (`Scripts/WindowsUpdate/`)

| Script | What It Does | Recommended For |
|--------|--------------|-----------------|
| `Disable-AutomaticUpdates.ps1` | Lets you control when updates install | Users who want update control |
| `Disable-DeliveryOptimization.ps1` | Stops sharing updates with other PCs | Users with limited bandwidth |
| `Prevent-AutoReboot.ps1` | Stops automatic restarts after updates | Everyone - very annoying otherwise |

**Learn More:** [Windows Update Documentation](Docs/WindowsUpdate-Scripts.md)

### 🖥️ Taskbar (`Scripts/Taskbar/`)

| Script | What It Does | Recommended For |
|--------|--------------|-----------------|
| `Align-Taskbar-Left.ps1` | Moves taskbar icons to the left (like Windows 10) | Windows 10 users upgrading to 11 |
| `Hide-Widgets.ps1` | Removes the widgets button | Users who don't use widgets |
| `Hide-TaskView.ps1` | Removes Task View button | Users who don't use virtual desktops |

**Learn More:** [Taskbar Documentation](Docs/Taskbar-Scripts.md)

### 📁 File Explorer (`Scripts/FileExplorer/`)

| Script | What It Does | Recommended For |
|--------|--------------|-----------------|
| `Show-FileExtensions.ps1` | Shows file extensions (.txt, .jpg, etc.) | Everyone - important for security |
| `Show-HiddenFiles.ps1` | Shows hidden files and folders | Advanced users, troubleshooters |
| `Set-Explorer-OpenToThisPC.ps1` | Opens File Explorer to "This PC" instead of Quick Access | Users who prefer classic view |

**Learn More:** [File Explorer Documentation](Docs/FileExplorer-Scripts.md)

### 📱 Start Menu (`Scripts/StartMenu/`)

| Script | What It Does | Recommended For |
|--------|--------------|-----------------|
| `Disable-StartRecommended.ps1` | Removes "Recommended" section | Cleaner Start menu |
| `Disable-BingSearch.ps1` | Disables Bing web search in Start menu | Faster, cleaner search |
| `Clear-StartPins.ps1` | Removes all pinned apps from Start | Fresh start customization |

**Learn More:** [Start Menu Documentation](Docs/StartMenu-Scripts.md)

## ⚠️ Important Information

### Safety First
- ✅ **Create a restore point** before running scripts (most scripts offer this option)
- ✅ **Read what each script does** before running it
- ✅ **Start with one script at a time** to see the effects
- ✅ **Most changes can be undone** using the registry files in `Regfiles/Undo/`

### Will This Break Windows?
**No!** These scripts only change settings and remove optional apps. They don't:
- ❌ Delete system files
- ❌ Break Windows Update
- ❌ Remove essential Windows features
- ❌ Prevent you from undoing changes

### Can I Undo Changes?
**Yes!** Each script that modifies the registry has a corresponding undo file:
- Located in: `Regfiles/Undo/`
- Just double-click the undo file to revert changes
- Apps can be reinstalled from Microsoft Store

## 🆘 Troubleshooting

### "Scripts are disabled on this system"
Run this in PowerShell (as Administrator):
```powershell
Set-ExecutionPolicy -Scope Process -Force Unrestricted
```

### "Access Denied" or "Permission Denied"
- Make sure you're running PowerShell **as Administrator**
- Right-click PowerShell → "Run as administrator"

### Changes didn't apply
1. Try restarting Windows Explorer (most scripts offer this)
2. Log off and log back on
3. Restart your computer

### Want to undo everything?
1. Use Windows System Restore if you created a restore point
2. Or manually run undo registry files from `Regfiles/Undo/`
3. Reinstall apps from Microsoft Store if needed

## 🎓 Learning Resources

New to this? Check out our beginner guides:
- [Understanding Windows Registry](Docs/Understanding-Registry.md)
- [What is PowerShell?](Docs/What-is-PowerShell.md)
- [Safe Debloating Practices](Docs/Safe-Debloating.md)

## 🤝 Contributing

Want to add more scripts or improve documentation? Contributions welcome!

## 📄 License

MIT License - Feel free to use and modify

## 🙏 Credits

- Original tool: [Win11Debloat by Raphire](https://github.com/Raphire/Win11Debloat)
- Split and documented for individual use
- Community contributions

## ⚖️ Disclaimer

These scripts modify Windows settings. While tested and safe, use at your own risk. Always create a restore point before making changes. Microsoft may change Windows in future updates, potentially affecting these scripts.

---

**Ready to start?** Pick a script from the categories above and follow the [Quick Start](#-quick-start) guide!

**Have questions?** Check the [Troubleshooting](#-troubleshooting) section or open an issue.

**Want to learn more?** Read the detailed documentation for each category
