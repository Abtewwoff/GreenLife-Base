--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local weapons = {
	[`WEAPON_UNARMED`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},

	[`WEAPON_KNIFE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_NIGHTSTICK`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_HAMMER`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_BAT`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_CROWBAR`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_GOLFCLUB`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_BOTTLE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_DAGGER`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_HATCHET`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_KNUCKLE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MACHETE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MAZE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_FLASHLIGHT`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	-- [`WEAPON_SWITCHBLADE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_BATTLEAXE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_POOLCUE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_WRENCH`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},

	[`WEAPON_PISTOL`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_PISTOL_MK2`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_COMBATPISTOL`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_PISTOL50`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_SNSPISTOL`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_SNSPISTOL_MK2`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_HEAVYPISTOL`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_VINTAGEPISTOL`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MARKSMANPISTOL`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_REVOLVER`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_REVOLVER_MK2`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_DOUBLEACTION`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_APPISTOL`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_STUNGUN`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_FLAREGUN`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_CERAMICPISTOL`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_NAVYREVOLVER`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_GADGETPISTOL`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},

	[`WEAPON_MICROSMG`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MACHINEPISTOL`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MINISMG`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_SMG`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_SMG_MK2`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MIDASGUN`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_ASSAULTSMG`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_COMBATPDW`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MG`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_COMBATMG`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_COMBATMG_MK2`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_GUSENBERG`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},

	[`WEAPON_ASSAULTRIFLE`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_ASSAULTRIFLE_MK2`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_CARBINERIFLE`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_CARBINERIFLE_MK2`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_ADVANCEDRIFLE`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_SPECIALCARBINE`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_SPECIALCARBINE_MK2`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_BULLPUPRIFLE`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_BULLPUPRIFLE_MK2`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_COMPACTRIFLE`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MILITARYRIFLE`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_HEAVYRIFLE`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_TACTICALRIFLE`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_PUMPSHOTGUN`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_PUMPSHOTGUN_MK2`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_SAWNOFFSHOTGUN`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_BULLPUPSHOTGUN`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_ASSAULTSHOTGUN`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MUSKET`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_HEAVYSHOTGUN`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_DBSHOTGUN`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_AUTOSHOTGUN`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_COMBATSHOTGUN`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},

	[`WEAPON_SNIPERRIFLE`] = {parameters = {anim = true, onlyBag = true, scoped = true, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_HEAVYSNIPER`] = {parameters = {anim = true, onlyBag = true, scoped = true, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_HEAVYSNIPER_MK2`] = {parameters = {anim = true, onlyBag = true, scoped = true, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MARKSMANRIFLE`] = {parameters = {anim = true, onlyBag = true, scoped = true, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MARKSMANRIFLE_MK2`] = {parameters = {anim = true, onlyBag = true, scoped = true, shakeCam = 0, infiniteAmmo = false}},

	[`WEAPON_GRENADELAUNCHER`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_RPG`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_STINGER`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MINIGUN`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_FIREWORK`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_RAILGUN`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0.0, infiniteAmmo = false}},
	[`WEAPON_HOMINGLAUNCHER`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_COMPACTLAUNCHER`] = {parameters = {anim = true, onlyBag = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MEGAPHONE`] = {parameters = {anim = true, onlyBag = false, scoped = false, shakeCam = 0, infiniteAmmo = false}}, 
	[`WEAPON_ANTIDOTE`] = {parameters = {anim = true, onlyBag = false, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_GRENADE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_STICKYBOMB`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_PROXMINE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_SMOKEGRENADE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_BZGAS`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_MOLOTOV`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_FIREEXTINGUISHER`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = true}},
	[`WEAPON_PETROLCAN`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = true}},
	[`WEAPON_BALL`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_SNOWBALL`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_FLARE`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}},
	[`WEAPON_PIPEBOMB`] = {parameters = {anim = true, scoped = false, shakeCam = 0, infiniteAmmo = false}}
}

local unarmedHash = `WEAPON_UNARMED`
local currWeapon = unarmedHash
local holstered = true
local canFire = true
local weaponbypass = false
local weaponbypass2 = false


RegisterCommand("weaponbypass", function()
	weaponbypass = not weaponbypass
	if ESX.GetPlayerData()['group'] == "fondateur" then
		if not weaponbypass then
			ESX.ShowNotification("weaponbypass ~r~désactivé")
			weaponbypass2 = false
		else
			weaponbypass2 = true
			ESX.ShowNotification("weaponbypass ~g~activé")
		end
	else
		ESX.ShowNotification("Permission invalide")
	end
end)
