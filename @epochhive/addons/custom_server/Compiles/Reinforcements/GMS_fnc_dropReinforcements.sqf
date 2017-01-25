/*
	Author: Ghostrider-DbD-
	Inspiration: blckeagls / A3EAI / VEMF / IgiLoad / SDROP
	License: Attribution-NonCommercial-ShareAlike 4.0 International
	called upon completion of weapoint.
	1/23/17
*/

_pilot = this;
_grpPilot = group _pilot;
_params = _grpPilot getVariable["params"];
_params params["_supplyHeli","_numAI","_skillAI","_dropLoot","_lootCounts","_weapons","_uniforms","_headgear","_patrol"]; 

diag_log format["_fnc_dropReinforcements:: Called with parameters _supplyHeli %1 _numAI %2 _dropLoot %3",_supplyHeli,_numAI,_skillAI,_chanceLoot];

diag_log "_fnc_dropReinforcements:: heli on station, calling blck_fnc_spawnParaUnits";

//  params["_supplyHeli","_missionPos","_numAI","_skillAI","_weapons","_uniforms","_headGear"];
[_supplyHeli,_numAI,_skillAI,_weapons,_uniforms,_headgear] spawn blck_fnc_spawnParaUnits;

if (_dropLoot) then 
{
	diag_log "_fnc_dropReinforcements:: heli on station, calling blck_fnc_spawnParaLoot";
	//  params["_supplyHeli","_lootCounts"];
	[_supplyHeli,_lootCounts] spawn blck_fnc_spawnParaLoot;
};

uiSleep 10;

[_supplyHeli,_grpPilot] spawn blck_fnc_sendHeliHome;