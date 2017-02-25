/*
blck Mission system by Ghostrider-DBD-
Loosely based on the AI mission system by blckeagls ver 2.0.2
Contributions by Narines: bug fixes, testing, infinite ammo fix.
Ideas or code from that by Vampire and KiloSwiss have been used for certain functions.

2/24/17 Version 6.56 Build 39.
Added a check so that mission completion by players near loot crates was tripped only when players were on foot.
Added a setting that determines whether loot crates are loaded when the mission spawns or once the mission is complete. 
	see blck_loadCratesTiming = "atMissionCompletion"; (line 78) for this configuration setting.
	
1/28/17 Version 6.55 Build 38
bug fixes
Commented out logging that is no longer needed
Removed a weapon from loot tables that could be used for dupping.


1/24/17 Version 6.55 Build 35
Added a new configuration blck_killEmptyStaticWeapons which determines if static weapons shoudl be disabled after the AI is killed.
Added a configuration blck_cleanUpLootChests that determines if loot crates are deleted when other mission objects are deleted.
Fixed an issue that prevented proper deletion of mission objects and live AI.

1/23/17 Version 6.54 Build 33
Fixed typos in GMS_fnc_vehicleMonitor.sqf
Removed a few files that are not used or needed.
Removed some code that had been commented out from blck_functions.sqf.

1/22/17 Version 6.54 build 32
Changed code to test for conditions that trigger to spawn mission objects and AI completely
Rewrote the code for spawning emplaced weapons from scratch.
Fixed an error in how the waitTime till a mission was respawned after being updated to inactive status.
Added additional reporting as to the mission type for which AI, statics and vehicle patrols are being spawned.
Continued switching from blck_debugOn to blck_debugLevel.
Continued work to move much of the code from GMS_fnc_missionSpawner to precompiled functions.
	- tested and working for all but the emplaced weapons module.
Removed old code that had been commented out from GMS_missionSpawner.
deactivated the 'fired' event handler
added an 'reloaded' event handler to units that adds a magazin of the type used to reload the weapon to prevent units running out of ammo. this also provides a break in firing and is more realistic.
Added a check to GMS_fnc_vehicleMonitor that addes ammo to vehicle cargo when stores are low. Removed the infinite ammo script for static and vehicle weapons, again for greater realism.
Increased number of rounds of ammo added to AI units for primary and secondary weapons.
Tweaked code in GMS_fnc_spawnUnit to increase efficiency.
Attempted a fix for occaisional issues with missions not triggering or ending by changing from distance to distance2D.
Tweaked code for deleting dead AI to also delete any weapons containers nearby.
Checked throughout for potential scope issues; ensured all private variables were declared as such.
Changed the method by which mission patrol vehicles and static weapons are deleted at the end of a mission.

1/21/17 Build 29.
Went back to the timerless system for spawning missions.
Improved code for updating the array of pending/active missions
	GMS_fnc_updateMissionQue.sqf re-written to take greater advantage of existing array commands: set and find.
Ensured that the array used to store the location(s) of active or recent missions is properly updated.

1/13/17 Version 6.54 Build 27
Rerverted back to the code that spawned a single instance of each mission until I can debug certain issues.

1/7/17 Version 6.53 Build 24
Added a setting blck_baseSkill = 0.7; // This defines the base skil of AI. Increase it to make AI more challenging.
Tweaked AI difficulty settings to make missions more difficult.
changed - GMS_EH_unitKilled - the event handler now uses precompiled rather than compiled on the fly code.
changed - several other minor performance tweaks were made server side.
changed - small changes were made the the loop in blck_client.sqf 
Tweaked debugging information to reduced unnecessary logging when not in debug-mode.
Disabled the loop sending server fps client-side
fixed - GMS_fnc_updateMissionQue was not correctly updating mission information after mission completion.
fixed - GMS_fnc_mainThread was not deleted old AI and Vehicles from the arrays used to capture them after mission completion.
changed - calls to GMS_fnc_vehicleMonitor were moved inside the main loop.

1/3/17 Version 6.51 Build 23
Moved configuration for the client from debug\blckclient.sqf to debug\blckconfig.sqf.
Added a setting blck_useKillMessages = true/false; (line 60 of the config. when true, kill messages will be send to all players when a player kills an AI. The style of the message is controlled client-side (debug\blck_config.sqf)
Added a setting blck_useKillScoreMessage = true/false; // (line 61 of the config) when true a tile is displayed to the killer with the kill score information
Added a setting 	blck_useIEDMessages = true/false;  // when true players will receive a message that their vehicle was damaged when AI are killed in a forbidden way (Run over Or Killed with vehicle-mounted weapons)
Fixed: Messages that a nearby IED was detonated are now properly displayed when players illegally kill AI.
Added a way to easily include / exclude APEX items. To exclude them comment out the line 
	#define useAPEX 1
	at approximately line 219 in the config.

12/21/16 Version 6.50 Build 21
Added a check for mod type to the routine that deletes empty groups as this is only needed for Epoch.
Added back the code that (a) eliminates the mission timers and (b) allows multiple instances of a mission to be spawned.

12/20/16 Version 6.46 Buid 20
Moved Variables for time acceleration to the config files.
Reworked code for time acceleration to use timeDay and BIS_fnc_sunriseSunsetTime.

11/20/16 Build 6.45 Build 19
Added Option to display mission information in Toasts (Exile Only).
Fixed an issue related to bugs in Arma 1.66

11/16/16 Version 6.44 Build 15
Added parameters
	blck_blacklistTraderCities=true; // the locations of the Epoch/Exile trader cities will be pulled from the config and added to the location blacklist for the mission system.
	blcklistConcreteMixerZones = true; // Locations of the concrete mixers will be pulled from the configs; no missions will be spawned within 1000 m of these locations.
	blck_blacklistSpawns = true; // Locations of Exile spawns will be pulled from the config. No missions will spawn within 1000 m of these locations.
Added: the main thread now runs a function that checks for empty groups. 
Fixed: The mission system would hang on epoch after a while because createGroup returned nullGroup. this appeared to occur because the maximum number of active groups had been reached. Deleting empty groups periodically solved the issue on a test machine.
Teaked: code to check whether a possible mission spawn location is near a flag or plot pole. Still needs work.
Added: Completed adding EDEN weapons, optics, bipods, optics to AI configurations and mission loot crates.
Added APEX headgear and uniforms.  (Note, you would need to add any of these you wished for players to sell to Epoch\<Map Name>\epoch_config\CfgPricing.hpp on Epoch)
Changed: Definitions of blacklist locations such as spawns moved from GMS_findWorld.sqf to the blck_configs_(epoch|exile).
Changed: Divided rifles and optics into subcategories to better enable assigning weapons to AI difficulties in a sort of class-based way, e.g., 556, 6.5, or LMG are separate classes.
Changed: DLS crate loader (not publically available yet) now uses blck_fnc_loadLootItemsFromArray rather than the prior approach for which specific crate loading functions were called depending on the loadout type (weapons, building supplies, foord etc).
Fixed: You can now loot AI bodies in Epoch.

11/12/16 Version 6.43 Build 12 
Added: MapAddons - use this to spawn AI strongholds or other compositions you generate with Eden editor at server startup.
Added: Loot Crate Spawner - Spawn loot crates at prespecified points. This is designed so that you can spawn crates inside buildings or other structures spawned through the map-addons.
Added: APEX weapons, sights and optics to AI and loot crates.

11/12/16 Version 6.42 Build 11
Enhancements to code to equip weapons; pointrs, silencers and bipods are now attached.

11/11/16 Version 6.42 build 10
Redid the code that spawns the objects at missions to work properly with the new formats generated by M3Arma EDEN Editor whilc being backwards compatible with older formats used in the existing missions.
Added code to add scopes and other attachments to AI weapons.
Added new variable blck_blacklistedOptics which you can use to block spawning optics like TMS.
Added new parameter blck_removeNVG which when true will cause NVG to be deleted from AI bodies.
Fixed: launchers and rounds should now be deleted when blck_removeLaunchers = true;
Fixed: All AI should spawn with a uniform.
More bug fixes and correction of typos.

11/2/16 Version 6.41 Build 9
Added a parameter 	blck_useKilledAIName that, when true, changes the kill messages to show player name and AI unit name 
Added message to players for killstreaks and a crypto/Tabs bonus for killstreaks.
Exile: AI spawn with a few tabs.
//Epoch: AI spawn with a few Crypto
Corrected an error that would spawn Epoch NVG on AI in Exile.

10/25/16 Version 6.4 Build 8 
Reworked the code to spawn vehicle patrols and static weapons and clean them up.
Reworked the code that messages players to be sure that calling titleText does not hang the messaging function and delay hints or system chat notifications.

10/22/16 v 6.3 Build 8-14-16
Moved routines that delete dead AI, Alive AI and mission objects from individual loops to a single loop spawned by blck_init.sqf.
Added functions to cache these data with time stamps for later time-based deletion.

10/21/16 Version 6.2 Build 7
Redid system for markers which are now defined in the mission template reducing dependence on client side configurations for each mission or marker type.
Bug-fixes for helicrashes including ensuring that live AI are despawned after a certain time.

10-1-16 Version 6.1.4 Build 6
1) Added back the time acceleration module

9-25-16 Version 6.1.4 Build 6
1) Added metadata for Australia 5.0.1
2) Fixed bugs with the IED notifications used when a player is penalized for illeagal AI Kills. _fnc_processIlegalKills (server side) and blckClient (client side) reworked. _this select 0 etc was replaced with params[] throughout. Many minor errors were corrected.

9/24/16 Version 6.1.3 Build 5 
1) Re-wrote the SLS crate spawning code which now relies on functions for crate spawning and generating a smoke source already used by the mission system. Replaced old functions with newer ones (e.g., params[] and selectRandom). Found a few bugs. Broke the script up into several discrete functions. Tested on Exile and Epoch,
2) Reworked the code for generating a smoke source. Added additional options with defaults set using params[].

9-19-16 Ver 6.1.2/11/16
Minor bug fixes to support Exile.
Corrected errors with scout and hunter missions trying to spawn using Epoch headgear.
Corrected error wherein AI were spawned as Epoch soldiers
Inactivated a call to an exile function that had no value 

9-15-16 vER 6.1.1
1) Reverted to the old spawnUnits routine because the new one was not spawning AI at Scouts and Hunters correctly.

9-13-16 Ver 6.10
1) Added waypoints for spawned AI Vehicles.
2) Reworked the logic for generating the positions of these waypoints
3) Added loiter waypoints in addition to move wayponts.
4) Reworked the param/params for spawnUnits
5) several other minor optimizations.

9-3-16 Ver 6.0
1) Re-did the custom_server folder so the mod automatically starts. Blck_client.sqf no longer calls the mod from the server.
2) Added a variable blck_modType which presently can be either "Epoch" or "Exile" with the aim of having a single mission system for both mods.
3) Added a more intelligent method for loading key components (variables, functions, and map-specific parameters).
4) Re-did all code to automatically select correct parameters to run correctly on either exile or epoch servers.
5) Added the Exile Static Loot Crate Spawner; Re-did this to load either an exile or epoch version as needed since a lot of the variables and also the locations tables are unique.
6) Added the Dynamic Loot system from Exile again with Exile and Epoch specific configurations; here the difference is only in the location tables.
7) Pulled the map addons function from the Exile build and added a functionality to spawn addons appropriately for map and mod type.
8) Helicrashes redone to provide more variability in the types of wrecks, loot and challenge. These are spawned by a new file Crashes2.sqf
9) Added a setting to determine the number of crash sites spawned at any one time: blck_maxCrashSites. Set to -1 to disable altogether.
10) Added settings to enable / disable specific mission classes, e.g., blck_enableOrangeMissions. Set to 1 to enable, -1 to disable.

8-14-16
Added mission timout feature, set blck_missionTimout = -1 to disble;
Changed to use of params for all .sqf which also eliminated calls to BIS_fnc_params
changed to selectRandom for all .sqf

some changes to client side functions to eliminate the public variable event handler (credits to IT07 for showing the way)
Added the armed powerler to the list of default mission vehicles.

2/28/16
1) Bug fixes completed. Cleanup of bodies is now properly separated from cleanup of live AI. Cleanup of vehicles with live AI is now working correctly.
2) Released to servers this morning.
3) Next step will be to add in the heli reinforcements for ver 5.2.

2/20/16
Bugfixes and enhancements.
1) added checks for nearby bases or nearby players when spawning missions.
2) Fixed typos in Medical Camp missions.
3) Added two new modes for completing mission: 1) mission is complete when all AI are killed; 2) mission is complete when player reaches the crate OR when all AI are killed.

In Progress
1) Mission timouts
2) Added optional reinforcments via helicopters which can then patrol the mission area.

2/11/16
Major Update to Build 5.0

1) All missions but heli crashes are spawned using a single mission timer and mission spawner
2) The mission timer now calles a file containing the mission parameters. The mission spawner is included and run from that file.
3) A kill feed was added reporting each AI kill.
4) AI kills are now handled via an event handler run on the server for forward compatability with headless clients.
5) Multiple minor errors and bug fixes related to mission difficulty, AI loadouts, loot and other parameters were included. 
6) The first phase of restructuring of the file structure has been completed. Most code for functions and units has been moved to a compiles directory in Compiles\Units and Compiles\Functions.
7) Some directionality and randomness was added where mission objects are spawned at random locations from an array of objects to give the missions more of a feeling of a perimeter defense where H-barrier and other objects were added.
8) As part of the restructuing, variables were moved from AIFunctions to a separate file.
9) Bugs in routines for cleanup of dead and live AI were fixed. A much simpler system for tracking live AI, dead AI, locations of active and recent missions, was implemented because of the centralization of the mission spawning to a single script
