# The Not-So-Smart AutoSave II

A simple yet effective autosave mod for *Kingdom Come: Deliverance II*. If you often forget to save, this mod acts as your (slightly dim-witted) companion, triggering autosaves at set intervals so you can focus on your adventure.

---

## Features

✅ **Automatic Saving** – Simulates F5 at regular intervals to ensure consistent saves.

⚙️ **Customizable Intervals & Delay** – Configure save frequency and initial delay in `config.ini`.

🔕 **Discreet Operation** – Runs in the background with a system tray icon showing a countdown to the next autosave.

📜 **Optional Logging** – Enable logs to track save events (`autosave.log` in the mod folder).

🕹 **Supports Multiple Launchers** – Works with Steam and Epic Games Launcher (custom launcher support coming soon).

---

## Requirements

- **Kingdom Come: Deliverance II** (Game)
- **[Unlimited Saving II Mod](https://www.nexusmods.com/kingdomcomedeliverance2/mods/14)**
- **[AutoHotKey](http://autohotkey.com/)**
- **Windows OS**

---

## Installation Guide

### Step 1: Install Unlimited Saving II Mod
Follow the instructions on its [Nexus Mods page](https://www.nexusmods.com/kingdomcomedeliverance2/mods/14).

### Step 2: Download and Extract This Mod
Extract **The Not-So-Smart AutoSave II** mod archive and move the entire folder into your game's Mods directory:

```
SteamLibrary\steamapps\common\KingdomComeDeliverance2\Mods\The Not-So-Smart AutoSave
```

### Step 3: Configure the Mod
Edit `config.ini` using Notepad and adjust:

- `SaveInterval` – Set the autosave interval.
- `InitialDelay` – Delay before the first autosave.
- `EnableLogging` – Set to `true` to enable logging.
- `Platform` – 
  - `1` for **Steam**
  - `2` for **Epic Games** (requires a desktop shortcut named `Kingdom Come Deliverance II.url`)

---

## Launching the Game

**Run via Vortex Mod Manager (Optional)**

1. Open **Vortex**.
2. Add a custom tool pointing to:
   ```
   <Your Game Directory>\Mods\The Not-So-Smart AutoSave\StartGameWithAutoSave.vbs
   ```
3. (Optional) Set this tool as the default launcher.

**Direct Launch**

- **Steam Users:** The mod launches the game using the URL: `steam://rungameid/379430`
- **Epic Users:** Ensure you have a desktop shortcut named `Kingdom Come Deliverance II.url`. The mod will use this to start the game.

---

## Using the Mod

- **Autosaves occur at the configured interval.**
- **Tray icon** shows a countdown to the next save.
- **Logging** (if enabled) records autosave events in `autosave.log`.
- **The mod exits when the game is closed.**

---

## FAQ & Troubleshooting

### ❓ Do I really need the Unlimited Saving II mod?
Yes, it removes save restrictions. Without it, F5 quicksaving may not work.

### ❓ The mod isn’t saving my game!
- Ensure **Unlimited Saving II** is installed.
- Press `F5` manually to confirm if saving works.
- Check `config.ini` to ensure a valid save interval.

### ❓ I don’t see the tray icon. Is the mod running?
Try running `StartGameWithAutoSave.vbs` directly or check your Vortex setup.

### ❓ How do I change the initial delay before the first autosave?
Edit `InitialDelay` in `config.ini`.

### ❓ The mod saved at a bad time. What do I do?
Reload an earlier save. Keep multiple save files to avoid issues.

### ❓ How do I enable logging?
Set `EnableLogging=true` in `config.ini`.

---

## Uninstallation

### Via Vortex
- Remove the mod from the **Mods** tab.
- Delete the custom launcher from the **Dashboard**.
- Uninstall **Unlimited Saving II** if you no longer need it.

### Manual Removal
- Delete the `The Not-So-Smart AutoSave` folder from your game's `Mods` directory.
- Remove any shortcuts or custom references.

---

## Disclaimer
**The Not-So-Smart AutoSave II mod is provided as-is.** We are not responsible for any lost progress or unintended save timing. **Always keep backup saves!**

---

## Credits & Support

👨‍💻 **Developed by:** ImPJs

💖 **Special Thanks:** To all players who hate losing progress as much as we do.

🚀 **Need help? Found a bug?** Post a comment on the mod page or reach out for support.

Enjoy the game, and happy autosaving! 🎮
