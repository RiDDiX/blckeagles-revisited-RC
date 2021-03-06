



/*
	This is a simple mission using precisely placed loot crates and infantry, static weapons and vehicle patrols.
	See the accompanying example mission in the exampleMission folder to get an idea how I laid this out.
	Note that I exported the mission using the exportAll function of M3EDEN editor.
*/

#include "privateVars.sqf";

_mission = "static mission garrison example";  //  Included for additional documentation. Not intended to be spawned as a mission per se.

_difficulty = "red";  // Skill level of AI (blue, red, green etc)

_crateLoot = blck_BoxLoot_Orange;  // You can use a customized _crateLoot configuration by defining an array here. It must follow the following format shown for a hypothetical loot array called _customLootArray
	/*
	_customLootArray = 
		// Loot is grouped as [weapons],[magazines],[items] in order to be able to use the correct function to load the item into the crate later on.
		// Each item consist of the following information ["ItemName",minNum, maxNum] where min is the smallest number added and min+max is the largest number added.
		
		[  
			[// Weapons	

				["srifle_DMR_06_olive_F","20Rnd_762x51_Mag"]				
			],
			[//Magazines
				["10Rnd_93x64_DMR_05_Mag" ,1,5]				
			],			
			[  // Optics
				["optic_KHS_tan",1,3]
			],
			[// Materials and supplies				
				["Exile_Item_MetalScrews",3,10]
				//
			],
			[//Items
				["Exile_Item_MountainDupe",1,3]				
			],
			[ // Backpacks
				["B_OutdoorPack_tan",1,2]
			]
	];	
	*/

_lootCounts = blck_lootCountsRed; // You can use a customized set of loot counts or one that is predefined but it must follow the following format:
								  // values are: number of things from the weapons, magazines, optics, materials(cinder etc), items (food etc) and backpacks arrays to add, respectively.
								  //  blck_lootCountsOrange = [[6,8],[24,32],[5,10],[25,35],16,1];   // Orange

_markerMissionName = "Bad People Live Here";
_missionLandscapeMode = "precise"; 
_markerLabel = "";
//_markerType = ["ellipse",[200,200],"GRID"];
// An alternative would be:
_markerType = ["mil_triangle",[0,0]];
_markerColor = "Default";

_missionCenter = [23714.1,18313.4,0];


_garrisonedBuildings_BuildingPosnSystem = [
    ["Land_u_Shop_01_V1_F",[23733.9,18341.2,3.19],[[0,1,0],[0,0,1]],[true,true],"Red",0.67,3,[],10,600]
];

_garrisonedBuilding_ASLsystem = [
     ["Land_i_House_Big_02_V2_F",[23650.3,18331.9,3.19],[[0,1,0],[0,0,1]],[true,true],"Red",[["B_HMG_01_high_F",[1.43359,3.21875,0.259256],0],["B_GMG_01_high_F",[-2.79102,-5.32813,3.66659],0]],[[[-0.601563,-2.48633,0.260694],0]],600]
];

_missionLandscape = [
    // ["Land_i_House_Small_02_V3_F",[23641.6,18274,3.19],[[0,1,0],[0,0,1]],[true,true]],
    // ["Sign_Arrow_Yellow_F",[23681.8,18302.1,3.19],[[0,1,0],[0,0,1]],[true,true]],
    // ["Land_Slum_House03_F",[23736.2,18265.6,3.19],[[0,1,0],[0,0,1]],[true,true]],
   //  ["Sign_Sphere100cm_F",[23734.7,18341,3.49308],[[0,1,0],[0,0,1]],[true,true]]
];

_aiGroupParameters = [
    // [[23667,18267.7,3.19144],"Red",[3,6],45,600],
   //  [[23736.5,18302.4,3.19144],"Red",[3,6],45,600]
];

_aiScubaGroupParameters = [
];

_vehiclePatrolParameters = [
   //  ["B_CTRG_LSV_01_light_F",[23634.3,18302.3,3.19],"Red",75,600],
   //  ["B_G_Van_02_transport_F",[23659.5,18299.2,3.19],"Red",75,600],
   //  ["O_G_Van_01_transport_F",[23681.9,18303,3.18987],"Red",75,600],
     ["B_LSV_01_armed_F",[23798.9,18344.5,3.19],"Red",75,600]
];

_airPatrols = [
    // ["B_Heli_Light_01_dynamicLoadout_F",[23699.9,18290.7,3.19],"Red",1700,600]
];

_missionEmplacedWeapons = [
    // ["B_HMG_01_F",[23686.1,18338.7,3.19],"Red",0,600]
];

_submarinePatrolParameters = [
];

_missionLootBoxes = [
	// [selectRandom blck_crateTypes,[22893,16766.8,6.31652],[[0,1,0],[0,0,1]],[true,false], _crateLoot, _lootCounts],
     //["Box_FIA_Ammo_F",[23653.6,18333.1,3.44926],[[0,1,0],[0,0,1]],[true,false],_crateLoot,_lootCounts],
     ["Box_FIA_Ammo_F",[23729.4,18298.2,3.19],[[0,1,0],[0,0,1]],[true,false],_crateLoot,_lootCounts]
];

_minNoAI = blck_MinAI_Red;  //  Modify as needed
_maxNoAI = blck_MaxAI_Red;	// Modify as needed.
_noAIGroups = blck_AIGrps_Red;  // Modify as needed; note that these values are ignored of you specify AI patrols in the array below.
_noVehiclePatrols = blck_SpawnVeh_Red; // Modified as needed; can be a numberic value (e.g. 3) or range presented as [2,4]; 
_aircraftTypes = blck_patrolHelisRed;  //  You can use one of the pre-defined lists in blck_configs or your own custom array.
_noAirPatrols =	blck_noPatrolHelisRed; // You can use one of the pre-defined values or a custom one. acceptable values are integers (1,2,3) or a range such as [2,4]; 
//  Change _useMines to true/false below to enable mission-specific settings.
_useMines  = blck_useMines;  // Set to false if you have vehicles patrolling nearby.
_uniforms  = blck_SkinList;  // You can replace this list with a custom list of uniforms if you like.
_headgear  = blck_headgear;  // You can replace this list with a custom list of headgear.
_vests     = blck_vests;     // You can replace this list with a custom list of vests.
_backpacks = blck_backpacks; // You can replace this list with a custom list of backpacks.
_weapons   = blck_WeaponList_Orange; // You can replace this list with a customized list of weapons, or another predifined list from blck_configs_epoch or blck_configs_exile as appropriate.
_sideArms  = blck_pistols;    // You can replace this list with a custom list of sidearms.

#include "\q\addons\custom_server\Compiles\Missions\GMS_fnc_sm_initializeMission.sqf"; 

diag_log format["[blckeagls static missions] COMPLETED initializing middions %1 position at %2 difficulty %3",_mission,_missionCenter,_difficulty];