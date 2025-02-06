──────────────────────────────────────────────
PROJECT README
──────────────────────────────────────────────

THE NOT-SO-SMART AUTOSAVE II
For Kingdom Come: Deliverance II

Welcome to The Not-So-Smart AutoSave II mod for Kingdom Come: Deliverance II.
If you’re tired of losing progress because you forget to save, this mod acts as your reliable (if a bit dim-witted) companion that automatically triggers saves at set intervals—so you can focus on your adventure.

──────────────────────────────────────────────
FEATURES

• Automatic Saving
The mod sends F5 at regular intervals so that your game is saved automatically.

• Customizable Interval and Initial Delay
Edit the configuration file (config.ini) to set how often your game saves and how long the mod waits before performing the first autosave (So you have time to load into the game properly).

• Discreet Operation
Runs quietly in the background, with a system tray icon that displays a countdown until the next autosave.

• Optional Logging
Enable logging to record every autosave event (logs are written to autosave.log in the mod folder).

• Multiple Launcher Support
Choose whether your game is installed via Steam or Epic (Custom Launcher option coming soon):

For Steam, the mod launches via the URL steam://rungameid/379430.
For Epic, Use the “Create Desktop Shortcut” feature within the Epic Games Launcher. The mod will use this desktop shortcut (named "Kingdom Come Deliverance II.url") to open up the game
──────────────────────────────────────────────
REQUIREMENTS

• Kingdom Come: Deliverance II Game
• Unlimited Saving II mod - https://www.nexusmods.com/kingdomcomedeliverance2/mods/14
• AutoHotKey - http://autohotkey.com/
• Windows OS

──────────────────────────────────────────────
CONFIGURATION

The mod uses a configuration file (config.ini) located in the mod’s root folder. Edit this file using a plain text editor (such as Notepad).

──────────────────────────────────────────────
INSTALLATION GUIDE

Install the Unlimited Saving II mod (from its Nexus Mods page - URL above) as instructed by its documentation.

Download and extract The Not-So-Smart AutoSave II mod archive.

Move the entire "The Not-So-Smart AutoSave" folder into your game's Mods directory: Example: *\SteamLibrary\steamapps\common\KingdomComeDeliverance2\Mods\The Not-So-Smart AutoSave

Configure the mod: 
• Open config.ini in the mod folder and adjust SaveInterval, InitialDelay, EnableLogging, and Platform as needed. 
• For Epic, ensure Platform is set to 2 and that you have created the desktop shortcut as noted above. 
• For Steam, set Platform to 1. 

──────────────────────────────────────────────
SETUP IN VORTEX MOD MANAGER (OPTIONAL): 

• Open Vortex. 
• Add a custom tool pointing to: <Your Game Directory>\Mods\The Not-So-Smart AutoSave\StartGameWithAutoSave.vbs 
• Optionally, set this tool as primary if you wish to launch your game through it by default.

──────────────────────────────────────────────
LAUNCHING THE GAME

• If you launch via Vortex (or by running StartGameWithAutoSave.vbs directly), the mod will first start the AutoSave script (AutoSaveScript.ahk) so that autosaving begins immediately. 

• Then, based on your Platform setting:
For Steam (Platform=1), the mod will launch the game using the Steam URL.
For Epic (Platform=2), the mod will look for the desktop shortcut "Kingdom Come Deliverance II.url" on your Desktop (or OneDrive\Desktop) and launch it.
──────────────────────────────────────────────
USING THE MOD

• Automatic Saving: The mod will automatically save your game at the intervals you set. (Unlimited Saving II mod enables F5 saving at all times; our mod simply simulates F5 presses on a timed basis.)

• Tray Icon Countdown: A small tray icon shows the countdown until the next autosave.

• Logging: If enabled, autosave events are logged to autosave.log in the mod folder.

• Shutdown: The mod/ahk script automatically exits when Kingdom Come: Deliverance II closes.

──────────────────────────────────────────────
FAQ & TROUBLESHOOTING

Q: Do I really need the Unlimited Saving II mod?
A: Yes, Unlimited Saving II is required to bypass the normal saving restrictions. It allows F5 saving to work without limitations.

Q: The mod isn’t saving my game!
A: Check that Unlimited Saving II is installed and working (press f5, does it save?) Verify that SaveInterval in config.ini is set to a reasonable value. Also, ensure the game window is active and the mod’s tray icon appears.

Q: I don’t see the tray icon. Is the mod running?
A: If the tray icon is missing, try running StartGameWithAutoSave.vbs directly or double-check your Vortex setup.

Q: How can I change the initial delay before the first autosave?
A: Edit the InitialDelay value in config.ini.

Q: The mod saved at an inopportune time and broke my game. What now?
A: Reload an earlier save. It’s always a good idea to keep multiple save files.

Q: How do I enable logging?
A: Set EnableLogging=true in config.ini. The log file (autosave.log) will be created in the mod folder.

──────────────────────────────────────────────
UNINSTALLATION

Via Vortex:
• Remove the mod from the Mods tab.
• Delete the custom launcher from the Dashboard.
• Uninstall Unlimited Saving II if you no longer need it.

Manually:
• Delete the entire "The Not-So-Smart AutoSave" folder from your game's Mods directory.
• Remove any shortcuts or references that you added.

──────────────────────────────────────────────
DISCLAIMER

The Not-So-Smart AutoSave II mod is provided as-is.
We are not responsible for any loss of progress, unexpected save timings, or issues that might arise from its use.
Always keep backup saves!

──────────────────────────────────────────────
CREDITS & SUPPORT

Developed by: ImPJs
Special Thanks: To all the players who hate losing progress as much as we do.

Need help or found a bug?
Post a comment on the mod page or contact support.

Enjoy the game, and happy autosaving!

──────────────────────────────────────────────
END OF README

──────────────────────────────────────────────

