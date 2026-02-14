# Beginner's Guide to Windows Debloating

## What is "Debloating"?

**Debloating** means removing unnecessary programs and features from Windows to make it:
- Faster
- More private
- Less cluttered
- More personalized to your needs

Think of it like decluttering your house - you're removing things you don't need to make room for what you do need.

## Is This Safe?

**Yes!** These scripts are safe because:
1. ✅ They only change settings and remove optional apps
2. ✅ They don't delete system files Windows needs
3. ✅ Most changes can be easily undone
4. ✅ You can choose exactly what to change
5. ✅ Each script explains what it does before doing it

## Do I Need to Be a Computer Expert?

**No!** This guide is written for regular users. You don't need to know programming or be a "tech person."

## What You'll Need

1. **A Windows 11 computer** (some scripts work on Windows 10 too)
2. **Administrator access** (you need to be able to make changes to your computer)
3. **10-20 minutes** depending on how much you want to change
4. **Ability to follow simple steps**

## Before You Start - Important!

### 1. Create a Backup
It's always good practice to create a system restore point. Most scripts offer to do this for you automatically.

### 2. Read What Each Script Does
Don't just run scripts blindly! Each script has a description that explains:
- What it changes
- Why you might want to do it
- What the effects will be

### 3. Start Small
Begin with one or two scripts. See how you like the changes before doing more.

### 4. Know How to Undo
Keep in mind that you can undo most changes:
- Use the undo registry files in `Regfiles/Undo/`
- Use Windows System Restore
- Reinstall apps from Microsoft Store

## Step-by-Step: Your First Script

Let's walk through running your first script together.

### Step 1: Download the Scripts
1. Go to the repository main page
2. Click the green "Code" button
3. Click "Download ZIP"
4. Save the file to your Downloads folder
5. Right-click the ZIP file and select "Extract All"
6. Choose where to extract (like your Desktop)

### Step 2: Open PowerShell as Administrator
1. Click the Windows Start button (or press the Windows key)
2. Type: `powershell`
3. You'll see "Windows PowerShell" in the results
4. **RIGHT-CLICK** on it
5. Select "Run as administrator"
6. Click "Yes" when asked if you want to allow changes

### Step 3: Allow Scripts to Run
In the PowerShell window that opened, type this command and press Enter:
```powershell
Set-ExecutionPolicy -Scope Process -Force Bypass
```

**What this does:** Tells Windows it's okay to run these scripts (just for this session).

### Step 4: Navigate to the Scripts Folder
In PowerShell, type:
```powershell
cd C:\Users\YourUsername\Desktop\Win11-debloat-split\Scripts
```

**Replace `YourUsername` with your actual Windows username!**

**Tip:** If you extracted to a different location, use that path instead.

### Step 5: Run Your First Script
Let's try a safe, recommended script - showing file extensions:

```powershell
.\FileExplorer\Show-FileExtensions.ps1
```

**What happens:**
1. The script shows you what it will do
2. It asks if you want to proceed
3. Type `y` and press Enter to continue
4. It makes the changes
5. It shows you the results

That's it! You've run your first script!

## Recommended Scripts for Beginners

If you're not sure where to start, here are the most popular and safe scripts:

### 1. Show File Extensions (HIGHLY RECOMMENDED)
```powershell
.\FileExplorer\Show-FileExtensions.ps1
```
**Why:** Security and clarity. Everyone should do this.

### 2. Disable Telemetry
```powershell
.\Privacy\Disable-Telemetry.ps1
```
**Why:** Improves privacy without breaking anything.

### 3. Disable Windows Suggestions
```powershell
.\Privacy\Disable-WindowsSuggestions.ps1
```
**Why:** Removes annoying ads and suggestions.

### 4. Remove Bloatware Apps
```powershell
.\AppRemoval\Remove-BloatwareApps.ps1 -ListOnly
```
**Note:** Use `-ListOnly` first to see what would be removed!
```powershell
.\AppRemoval\Remove-BloatwareApps.ps1
```
**Why:** Frees up space and removes apps you don't use.

### 5. Enable Dark Mode
```powershell
.\Appearance\Enable-DarkMode.ps1
```
**Why:** Easier on the eyes, especially at night.

## Understanding the Results

After running a script, you'll see:
- ✓ Green checkmarks = Success
- ✗ Red X marks = Something failed
- Yellow warnings = Pay attention to these
- Information about what changed

## Common Questions

### Q: Will this void my warranty?
**A:** No, you're just changing settings.

### Q: Will Windows Update still work?
**A:** Yes! These scripts don't affect Windows Update.

### Q: Can I update Windows after running these scripts?
**A:** Yes, updates work normally.

### Q: What if I don't like the changes?
**A:** Most scripts tell you how to undo them. Usually by running an undo registry file.

### Q: Will this speed up my computer?
**A:** Some scripts can help, especially removing bloatware and disabling animations, but don't expect miracles.

### Q: Can I run multiple scripts at once?
**A:** Yes, but it's better to run them one at a time so you can see what each one does.

### Q: Do I need to restart my computer?
**A:** Most changes work immediately or after restarting Windows Explorer. A few require a full restart.

### Q: What if something goes wrong?
**A:** Use System Restore to go back to before you made changes. This is why creating a restore point is important!

## Getting Help

If you run into problems:

1. **Read the error message** - It usually tells you what's wrong
2. **Check the Troubleshooting section** in the main README
3. **Make sure you ran PowerShell as Administrator**
4. **Verify you're in the right folder**
5. **Check that you downloaded all the files**

## Next Steps

Once you're comfortable:
1. Explore other categories of scripts
2. Read the detailed documentation for each category
3. Customize Windows exactly how you want it

Remember: **Take your time, read carefully, and start with simple changes!**

## Glossary for Beginners

**Administrator / Admin:** A user account with permission to make system changes

**PowerShell:** A command-line tool built into Windows for running scripts

**Registry:** A database where Windows stores settings (like a settings file)

**Bloatware:** Pre-installed software you didn't ask for and probably don't need

**Telemetry:** Data that Windows sends back to Microsoft about how you use your computer

**Restore Point:** A backup of your system settings you can go back to

**Script:** A file containing commands that automate tasks

**File Extension:** The part after the dot in a filename (.txt, .exe, .jpg)

---

**You're ready to start!** Remember: Read, understand, then act. You've got this! 🚀
