# How to Undo Changes

Made changes you don't like? No problem! This guide shows you how to undo any changes made by these scripts.

## 🔄 Quick Undo Methods

### Method 1: Use Undo Registry Files (EASIEST)

Every script that modifies the Windows registry has a corresponding undo file.

**Steps:**
1. Open File Explorer
2. Navigate to the `Regfiles\Undo\` folder in this repository
3. Find the undo file for the change you want to reverse
   - Example: If you ran `Disable-Telemetry.ps1`, look for `Undo_Disable_Telemetry.reg`
4. **Double-click** the undo file
5. Click "Yes" when asked if you want to make changes
6. Restart Windows Explorer or log off/on to see changes

**Undo File Naming Convention:**
- `Undo_` prefix + description of the feature
- Example: `Undo_Disable_Telemetry.reg` undoes telemetry disabling
- Example: `Enable_Dark_Mode.reg` would be undone by `Undo_Enable_Dark_Mode.reg` (actually called `Enable_Light_Mode.reg`)

---

### Method 2: System Restore (RECOMMENDED BEFORE BIG CHANGES)

If you created a restore point before making changes, you can go back to that exact state.

**Steps:**
1. Press **Windows Key + R**
2. Type: `rstrui.exe`
3. Press Enter
4. Click "Next"
5. Select the restore point you created (look for the description like "Before Disabling Telemetry")
6. Click "Next" and then "Finish"
7. Your computer will restart and restore to that point

**Important Notes:**
- This reverses ALL system changes made since the restore point
- Your personal files are not affected
- Recently installed programs may need to be reinstalled

---

### Method 3: Reinstall Apps from Microsoft Store

If you removed apps and want them back:

**Steps:**
1. Open **Microsoft Store**
   - Press Windows Key
   - Type "Microsoft Store"
   - Click to open
2. Search for the app name
   - Example: "Clipchamp", "Xbox", "Mail and Calendar"
3. Click "Get" or "Install"
4. Wait for the app to download and install

**Common Apps to Reinstall:**
- **Mail and Calendar**: Search for "Mail and Calendar"
- **Xbox Game Bar**: Search for "Xbox Game Bar"
- **Clipchamp**: Search for "Clipchamp"
- **Microsoft To Do**: Search for "Microsoft To Do"
- **Phone Link**: Search for "Phone Link"

---

## 📋 Specific Undo Instructions

### Undoing Telemetry Changes
**File:** `Regfiles\Undo\Enable_Telemetry.reg`

Double-click this file to re-enable Windows telemetry.

### Undoing Dark Mode
**File:** `Regfiles\Undo\Enable_Light_Mode.reg`

Double-click to switch back to light mode.

### Undoing Taskbar Alignment
**File:** `Regfiles\Undo\Align_Taskbar_Center.reg`

Double-click to center taskbar icons again.

### Undoing Copilot Disable
**File:** `Regfiles\Undo\Enable_Copilot.reg`

Double-click to re-enable Copilot.

### Undoing File Extension Display
**File:** `Regfiles\Undo\Hide_Extensions_For_Known_File_Types.reg`

Double-click to hide file extensions again (not recommended for security).

### Undoing Bing Search Disable
**File:** `Regfiles\Undo\Enable_Bing_Cortana_In_Search.reg`

Double-click to re-enable Bing web search in Start menu.

---

## 🛡️ If Something Goes Wrong

### Windows Won't Boot Properly

1. **Safe Mode Boot:**
   - Restart your computer
   - Press F8 repeatedly during startup
   - Select "Safe Mode"
   - Once in Safe Mode, use System Restore

2. **Recovery Options:**
   - If you can't get to Safe Mode
   - Use Windows installation media
   - Select "Repair your computer"
   - Choose "Troubleshoot" → "System Restore"

### Registry Files Won't Run

If double-clicking registry files doesn't work:

1. Right-click the .reg file
2. Select "Merge" or "Open with" → "Registry Editor"
3. Confirm you want to add the information

### Scripts Won't Run

If you get errors running scripts:

1. **Check Administrator Rights:**
   - Right-click PowerShell
   - Select "Run as administrator"

2. **Set Execution Policy:**
   ```powershell
   Set-ExecutionPolicy -Scope Process -Force Unrestricted
   ```

3. **Verify File Paths:**
   - Make sure you're in the correct directory
   - Check that all files are extracted

---

## 🔍 Checking Current Settings

### Check if Telemetry is Enabled/Disabled
1. Settings → Privacy & security → Diagnostics & feedback
2. Look at "Diagnostic data" setting

### Check if Dark Mode is Enabled
1. Settings → Personalization → Colors
2. Look at "Choose your mode"

### Check Taskbar Alignment
1. Look at your taskbar
2. Icons centered = Windows 11 default
3. Icons left = Windows 10 style

### Check if File Extensions are Showing
1. Open File Explorer
2. Look at any file
3. If you see `.txt`, `.jpg`, etc., extensions are showing

---

## ⚠️ Important Reminders

### What Gets Undone vs What Doesn't

**✅ Things that can be easily undone:**
- Registry changes (use undo files)
- Taskbar/appearance settings
- Privacy settings
- System tweaks

**❓ Things that need manual undo:**
- Removed apps (reinstall from Microsoft Store)
- Some system services (may need manual restart)

**❌ Things that can't be undone:**
- N/A - These scripts don't make permanent irreversible changes

### Best Practices

1. **Test One Change at a Time**
   - Easier to identify what you want to undo
   - Less overwhelming

2. **Create Restore Points**
   - Before making major changes
   - Especially before running multiple scripts

3. **Document Your Changes**
   - Keep notes on what scripts you ran
   - Easier to undo later if needed

4. **Don't Panic**
   - Most changes are cosmetic or minor
   - Windows won't break from these scripts
   - There's always a way to undo

---

## 🆘 Emergency Reset

If you want to undo EVERYTHING and start fresh:

### Option 1: System Restore (Recommended)
Use the earliest restore point before you started making changes.

### Option 2: Windows Reset (Last Resort)
This will reset Windows but keep your personal files.

**Steps:**
1. Settings → System → Recovery
2. Click "Reset PC"
3. Choose "Keep my files"
4. Follow the wizard

**WARNING:** This will:
- ✅ Keep your personal files (documents, photos, etc.)
- ❌ Remove all installed programs
- ❌ Reset all Windows settings to default

---

## 💡 Pro Tips

### Before Making Changes
```powershell
# Create a restore point
Checkpoint-Computer -Description "Before Win11 Debloat" -RestorePointType "MODIFY_SETTINGS"
```

### Test in Safe Mode
If a change causes issues, boot to Safe Mode and undo it there.

### Keep This Repository
Don't delete the `Regfiles` folder - you need it for undoing changes!

### Document Everything
Keep a text file noting:
- What scripts you ran
- When you ran them
- What restore points you created

---

## 📞 Still Need Help?

1. Check the [Beginner's Guide](Beginners-Guide.md)
2. Review the [Troubleshooting Section](../README.md#troubleshooting)
3. Look at the original [Win11Debloat Wiki](https://github.com/Raphire/Win11Debloat/wiki/Reverting-Changes)

---

**Remember:** Almost everything can be undone! Don't worry if you change your mind about something.
