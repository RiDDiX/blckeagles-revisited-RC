/*
	Static loot crate spawner
	by Ghostrider [GRG]
	For Arma 3 Exile and Epoch
	Last Updated 11/12/16
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#ifdef blck_debugMode
//diag_log "[blckeagls] SLS System: Initializing Static Loot Crate System!";
#endif
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

if not (isNull( configFile >> "CfgPatches" >> "a3_epoch_server" )) then
{
	[] execVM "\q\addons\custom_server\SLS\SLS_init_epoch.sqf";
};

if not (isNull ( configFile >> "CfgPatches" >> "exile_server" ) ) then
{
	[] execVM "\q\addons\custom_server\SLS\SLS_init_exile.sqf";
};
diag_log "[blckeagls] SLS System: Static loot crates ran successfully!";
blck_SLSComplete = true;