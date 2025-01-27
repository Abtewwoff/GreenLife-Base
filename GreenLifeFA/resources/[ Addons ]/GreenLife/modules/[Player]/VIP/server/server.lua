--[[
  This file is part of Synalife RolePlay.
  Copyright (c) Synalife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local vips = {
    'steam:11000014d82135f', -- GameCore
}

-- Pas touche
function isVip(player)
    local allowed = false
    for i,id in ipairs(vips) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end


-- CUSTOM ARMES

local Hash = GetHashKey;

local tints = ESX.GetConfig().DefaultWeaponTints

local WEAPON_CUSTOM_PRICE = {
    -- Melee
    {name = 'WEAPON_DAGGER', label = _U('weapon_dagger'), components = {}},
    {name = 'WEAPON_BAT', label = _U('weapon_bat'), components = {}},
    {name = 'WEAPON_BATTLEAXE', label = _U('weapon_battleaxe'), components = {}},
    {
        name = 'WEAPON_KNUCKLE',
        label = _U('weapon_knuckle'),
        components = {
            {name = 'knuckle_base', label = _U('component_knuckle_base'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_BASE"), point = 250},
            {name = 'knuckle_pimp', label = _U('component_knuckle_pimp'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_PIMP"), point = 250},
            {name = 'knuckle_ballas', label = _U('component_knuckle_ballas'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_BALLAS"), point = 250},
            {name = 'knuckle_dollar', label = _U('component_knuckle_dollar'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_DOLLAR"), point = 250},
            {name = 'knuckle_diamond', label = _U('component_knuckle_diamond'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_DIAMOND"), point = 250},
            {name = 'knuckle_hate', label = _U('component_knuckle_hate'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_HATE"), point = 250},
            {name = 'knuckle_love', label = _U('component_knuckle_love'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_LOVE"), point = 250},
            {name = 'knuckle_player', label = _U('component_knuckle_player'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_PLAYER"), point = 250},
            {name = 'knuckle_king', label = _U('component_knuckle_king'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_KING"), point = 250},
            {name = 'knuckle_vagos', label = _U('component_knuckle_vagos'), hash = Hash("COMPONENT_KNUCKLE_VARMOD_VAGOS"), point = 250}
        }
    },
    {name = 'WEAPON_BOTTLE', label = _U('weapon_bottle'), components = {}},
    {name = 'WEAPON_CROWBAR', label = _U('weapon_crowbar'), components = {}},
    {name = 'WEAPON_FLASHLIGHT', label = _U('weapon_flashlight'), components = {}},
    {name = 'WEAPON_GOLFCLUB', label = _U('weapon_golfclub'), components = {}},
    {name = 'WEAPON_HAMMER', label = _U('weapon_hammer'), components = {}},
    {name = 'WEAPON_HATCHET', label = _U('weapon_hatchet'), components = {}},
    {name = 'WEAPON_KNIFE', label = _U('weapon_knife'), components = {}},
    {name = 'WEAPON_MACHETE', label = _U('weapon_machete'), components = {}},
    {name = 'WEAPON_NIGHTSTICK', label = _U('weapon_nightstick'), components = {}},
    {name = 'WEAPON_WRENCH', label = _U('weapon_wrench'), components = {}},
    {name = 'WEAPON_POOLCUE', label = _U('weapon_poolcue'), components = {}},
    {name = 'WEAPON_STONE_HATCHET', label = _U('weapon_stone_hatchet'), components = {}},
    {
        name = 'WEAPON_SWITCHBLADE',
        label = _U('weapon_switchblade'),
        components = {
            {name = 'handle_default', label = _U('component_handle_default'), hash = Hash("COMPONENT_SWITCHBLADE_VARMOD_BASE"), point = 250},
            {name = 'handle_vip', label = _U('component_handle_vip'), hash = Hash("COMPONENT_SWITCHBLADE_VARMOD_VAR1"), point = 250},
            {name = 'handle_bodyguard', label = _U('component_handle_bodyguard'), hash = Hash("COMPONENT_SWITCHBLADE_VARMOD_VAR2"), point = 250}
        }
    },
    -- Handguns
    {
        name = 'WEAPON_APPISTOL',
        label = _U('weapon_appistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_APPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_APPISTOL_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_APPISTOL_VARMOD_LUXE"), point = 250}
        }
    },
    {name = 'WEAPON_CERAMICPISTOL', label = _U('weapon_ceramicpistol'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")}},
    {
        name = 'WEAPON_COMBATPISTOL',
        label = _U('weapon_combatpistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_COMBATPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_COMBATPISTOL_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {name = 'WEAPON_DOUBLEACTION', label = _U('weapon_doubleaction'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")}},
    {name = 'WEAPON_NAVYREVOLVER', label = _U('weapon_navyrevolver'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")}},
    {name = 'WEAPON_FLAREGUN', label = _U('weapon_flaregun'), tints = tints, components = {}, ammo = {label = _U('ammo_flaregun'), hash = Hash("AMMO_FLAREGUN")}},
    {name = 'WEAPON_GADGETPISTOL', label = _U('weapon_gadgetpistol'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")}},
    {
        name = 'WEAPON_HEAVYPISTOL',
        label = _U('weapon_heavypistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_HEAVYPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_HEAVYPISTOL_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_REVOLVER',
        label = _U('weapon_revolver'),
        ammo = {label = _U('ammo_rounds'),hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_REVOLVER_CLIP_01"), point = 250},
            {name = 'vip_finish', label = _U('component_vip_finish'), hash = Hash("COMPONENT_REVOLVER_VARMOD_BOSS"), point = 250},
            {name = 'bodyguard_finish', label = _U('component_bodyguard_finish'), hash = Hash("COMPONENT_REVOLVER_VARMOD_GOON"), point = 250}
        }
    },
    {
        name = 'WEAPON_REVOLVER_MK2',
        label = _U('weapon_revolver_mk2'),
        ammo = {label = _U('ammo_rounds'),hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_REVOLVER_MK2_CLIP_01"), point = 250},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_REVOLVER_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_REVOLVER_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_hollowpoint', label = _U('component_ammo_hollowpoint'), hash = Hash("COMPONENT_REVOLVER_MK2_CLIP_HOLLOWPOINT"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_REVOLVER_MK2_CLIP_FMJ"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_small', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_MK2"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'compensator', label = _U('component_compensator'), hash = Hash("COMPONENT_AT_PI_COMP_03"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_REVOLVER_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {name = 'WEAPON_MARKSMANPISTOL', label = _U('weapon_marksmanpistol'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")}},
    {
        name = 'WEAPON_PISTOL',
        label = _U('weapon_pistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_PISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_PISTOL_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_PISTOL_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_PISTOL_MK2',
        label = _U('weapon_pistol_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_hollowpoint', label = _U('component_ammo_hollowpoint'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_HOLLOWPOINT"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_PISTOL_MK2_CLIP_FMJ"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_PI_RAIL"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH_02"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP_02"), point = 250},
            {name = 'compensator', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_COMP"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_IND_01"), point = 250},
            {name = 'camo_slide_finish', label = _U('component_camo_slide_finish'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_SLIDE"), point = 250},
            {name = 'camo_slide_finish2', label = _U('component_camo_slide_finish2'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_02_SLIDE"), point = 250},
            {name = 'camo_slide_finish3', label = _U('component_camo_slide_finish3'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_03_SLIDE"), point = 250},
            {name = 'camo_slide_finish4', label = _U('component_camo_slide_finish4'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_04_SLIDE"), point = 250},
            {name = 'camo_slide_finish5', label = _U('component_camo_slide_finish5'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_05_SLIDE"), point = 250},
            {name = 'camo_slide_finish6', label = _U('component_camo_slide_finish6'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_06_SLIDE"), point = 250},
            {name = 'camo_slide_finish7', label = _U('component_camo_slide_finish7'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_07_SLIDE"), point = 250},
            {name = 'camo_slide_finish8', label = _U('component_camo_slide_finish8'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_08_SLIDE"), point = 250},
            {name = 'camo_slide_finish9', label = _U('component_camo_slide_finish9'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_09_SLIDE"), point = 250},
            {name = 'camo_slide_finish10', label = _U('component_camo_slide_finish10'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_10_SLIDE"), point = 250},
            {name = 'camo_slide_finish11', label = _U('component_camo_slide_finish11'), hash = Hash("COMPONENT_PISTOL_MK2_CAMO_IND_01_SLIDE"), point = 250}
        }
    },
    {
        name = 'WEAPON_PISTOL50',
        label = _U('weapon_pistol50'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_PISTOL50_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_PISTOL50_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_PISTOL50_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_SNSPISTOL',
        label = _U('weapon_snspistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SNSPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SNSPISTOL_CLIP_02"), point = 500},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_SNSPISTOL_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_SNSPISTOL_MK2',
        label = _U('weapon_snspistol_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_hollowpoint', label = _U('component_ammo_hollowpoint'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_HOLLOWPOINT"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CLIP_FMJ"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_PI_RAIL_02"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH_03"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP_02"), point = 250},
            {name = 'compensator', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_COMP_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_IND_01"), point = 250},
            {name = 'camo_slide_finish', label = _U('component_camo_slide_finish'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_SLIDE"), point = 250},
            {name = 'camo_slide_finish2', label = _U('component_camo_slide_finish2'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_02_SLIDE"), point = 250},
            {name = 'camo_slide_finish3', label = _U('component_camo_slide_finish3'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_03_SLIDE"), point = 250},
            {name = 'camo_slide_finish4', label = _U('component_camo_slide_finish4'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_04_SLIDE"), point = 250},
            {name = 'camo_slide_finish5', label = _U('component_camo_slide_finish5'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_05_SLIDE"), point = 250},
            {name = 'camo_slide_finish6', label = _U('component_camo_slide_finish6'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_06_SLIDE"), point = 250},
            {name = 'camo_slide_finish7', label = _U('component_camo_slide_finish7'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_07_SLIDE"), point = 250},
            {name = 'camo_slide_finish8', label = _U('component_camo_slide_finish8'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_08_SLIDE"), point = 250},
            {name = 'camo_slide_finish9', label = _U('component_camo_slide_finish9'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_09_SLIDE"), point = 250},
            {name = 'camo_slide_finish10', label = _U('component_camo_slide_finish10'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_10_SLIDE"), point = 250},
            {name = 'camo_slide_finish11', label = _U('component_camo_slide_finish11'), hash = Hash("COMPONENT_SNSPISTOL_MK2_CAMO_IND_01_SLIDE"), point = 250}
        }
    },
    {name = 'WEAPON_STUNGUN', label = _U('weapon_stungun'), tints = tints, components = {}},
    {name = 'WEAPON_RAYPISTOL', label = _U('weapon_raypistol'), tints = tints, components = {}},
    {
        name = 'WEAPON_VINTAGEPISTOL',
        label = _U('weapon_vintagepistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_VINTAGEPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_VINTAGEPISTOL_CLIP_02"), point = 500},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250}
        }
    },
    -- Shotguns
    {
        name = 'WEAPON_ASSAULTSHOTGUN',
        label = _U('weapon_assaultshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_ASSAULTSHOTGUN_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_ASSAULTSHOTGUN_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250}
        }
    },
    {name = 'WEAPON_AUTOSHOTGUN', label = _U('weapon_autoshotgun'), tints = tints, components = {}, ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")}},
    {
        name = 'WEAPON_BULLPUPSHOTGUN',
        label = _U('weapon_bullpupshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250}
        }
    },
    {
        name = 'WEAPON_COMBATSHOTGUN',
        label = _U('weapon_combatshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250}
        }
    },
    {name = 'WEAPON_DBSHOTGUN', label = _U('weapon_dbshotgun'), tints = tints, components = {}, ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")}},
    {
        name = 'WEAPON_HEAVYSHOTGUN',
        label = _U('weapon_heavyshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_HEAVYSHOTGUN_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_HEAVYSHOTGUN_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_HEAVYSHOTGUN_CLIP_03"), point = 750},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250}
        }
    },
    {name = 'WEAPON_MUSKET', label = _U('weapon_musket'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SHOTGUN")}},
    {
        name = 'WEAPON_PUMPSHOTGUN',
        label = _U('weapon_pumpshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_SR_SUPP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_PUMPSHOTGUN_MK2',
        label = _U('weapon_pumpshotgun_mk2'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'shells_default', label = _U('component_shells_default'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CLIP_01"), point = 250},
            {name = 'shells_incendiary', label = _U('component_shells_incendiary'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'shells_armor', label = _U('component_shells_armor'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'shells_hollowpoint', label = _U('component_shells_hollowpoint'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CLIP_HOLLOWPOINT"), point = 250},
            {name = 'shells_explosive', label = _U('component_shells_explosive'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CLIP_EXPLOSIVE"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_small', label = _U('component_scope_small'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_MK2"), point = 250},
            {name = 'scope_medium', label = _U('component_scope_medium'), hash = Hash("COMPONENT_AT_SCOPE_SMALL_MK2"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_SR_SUPP_03"), point = 250},
            {name = 'muzzle_squared', label = _U('component_muzzle_squared'), hash = Hash("COMPONENT_AT_MUZZLE_08"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_PUMPSHOTGUN_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_SAWNOFFSHOTGUN',
        label = _U('weapon_sawnoffshotgun'),
        ammo = {label = _U('ammo_shells'), hash = Hash("AMMO_SHOTGUN")},
        tints = tints,
        components = {
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE"), point = 250}
        }
    },
    -- SMG & LMG
    {
        name = 'WEAPON_ASSAULTSMG',
        label = _U('weapon_assaultsmg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_ASSAULTSMG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_ASSAULTSMG_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MACRO"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_COMBATMG',
        label = _U('weapon_combatmg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_COMBATMG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_COMBATMG_CLIP_02"), point = 500},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_COMBATMG_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_COMBATMG_MK2',
        label = _U('weapon_combatmg_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_hollowpoint', label = _U('component_ammo_hollowpoint'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_COMBATMG_MK2_CLIP_FMJ"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_medium', label = _U('component_scope_medium'), hash = Hash("COMPONENT_AT_SCOPE_SMALL_MK2"), point = 250},
            {name = 'scope_large', label = _U('component_scope_large'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM_MK2"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_MG_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_MG_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_COMBATMG_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_COMBATPDW',
        label = _U('weapon_combatpdw'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_COMBATPDW_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_COMBATPDW_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_COMBATPDW_CLIP_03"), point = 750},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_SMALL"), point = 250}
        }
    },
    {
        name = 'WEAPON_GUSENBERG',
        label = _U('weapon_gusenberg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_GUSENBERG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_GUSENBERG_CLIP_02"), point = 750}
        }
    },
    {
        name = 'WEAPON_MACHINEPISTOL',
        label = _U('weapon_machinepistol'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_PISTOL")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MACHINEPISTOL_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MACHINEPISTOL_CLIP_02"), point = 250},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_MACHINEPISTOL_CLIP_03"), point = 750},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250}
        }
    },
    {
        name = 'WEAPON_MG',
        label = _U('weapon_mg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MG_CLIP_02"), point = 500},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_SMALL_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_MG_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_MICROSMG',
        label = _U('weapon_microsmg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MICROSMG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MICROSMG_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_PI_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MACRO"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_MICROSMG_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_MINISMG',
        label = _U('weapon_minismg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MINISMG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MINISMG_CLIP_02"), point = 500}
        }
    },
    {
        name = 'WEAPON_SMG',
        label = _U('weapon_smg'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SMG_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SMG_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_SMG_CLIP_03"), point = 750},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_02"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_SMG_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_SMG_MK2',
        label = _U('weapon_smg_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SMG_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SMG_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_SMG_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_SMG_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_hollowpoint', label = _U('component_ammo_hollowpoint'), hash = Hash("COMPONENT_SMG_MK2_CLIP_HOLLOWPOINT"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_SMG_MK2_CLIP_FMJ"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS_SMG"), point = 250},
            {name = 'scope_small', label = _U('component_scope_small'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2"), point = 250},
            {name = 'scope_medium', label = _U('component_scope_medium'), hash = Hash("COMPONENT_AT_SCOPE_SMALL_SMG_MK2"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_PI_SUPP"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_SB_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_SB_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_SMG_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_SMG_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_SMG_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_SMG_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_SMG_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_SMG_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_SMG_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_SMG_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_SMG_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_SMG_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = ("COMPONENT_SMG_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {name = 'WEAPON_RAYCARBINE', label = _U('weapon_raycarbine'), ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SMG")}, tints = tints, components = {}},
    -- Rifles
    {
        name = 'WEAPON_ADVANCEDRIFLE',
        label = _U('weapon_advancedrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_ADVANCEDRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_ADVANCEDRIFLE_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_SMALL"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_ASSAULTRIFLE',
        label = _U('weapon_assaultrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_ASSAULTRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_ASSAULTRIFLE_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_ASSAULTRIFLE_CLIP_03"), point = 750},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MACRO"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_ASSAULTRIFLE_MK2',
        label = _U('weapon_assaultrifle_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CLIP_FMJ"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_small', label = _U('component_scope_small'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_MK2"), point = 250},
            {name = 'scope_large', label = _U('component_scope_large'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM_MK2"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_AR_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_AR_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_BULLPUPRIFLE',
        label = _U('weapon_bullpuprifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_BULLPUPRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_BULLPUPRIFLE_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_SMALL"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_BULLPUPRIFLE_VARMOD_LOW"), point = 250}
        }
    },
    {
        name = 'WEAPON_BULLPUPRIFLE_MK2',
        label = _U('weapon_bullpuprifle_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CLIP_FMJ"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_small', label = _U('component_scope_small'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_02_MK2"), point = 250},
            {name = 'scope_medium', label = _U('component_scope_medium'), hash = Hash("COMPONENT_AT_SCOPE_SMALL_MK2"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_BP_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_BP_BARREL_02"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_CARBINERIFLE',
        label = _U('weapon_carbinerifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_CARBINERIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_CARBINERIFLE_CLIP_02"), point = 250},
            {name = 'clip_box', label = _U('component_clip_box'), hash = Hash("COMPONENT_CARBINERIFLE_CLIP_03"), point = 1000},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_CARBINERIFLE_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_CARBINERIFLE_MK2',
        label = _U('weapon_carbinerifle_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CLIP_FMJ"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_medium', label = _U('component_scope_medium'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_MK2"), point = 250},
            {name = 'scope_large', label = _U('component_scope_large'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM_MK2"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_CR_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_CR_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_COMPACTRIFLE',
        label = _U('weapon_compactrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_COMPACTRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_COMPACTRIFLE_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_COMPACTRIFLE_CLIP_03"), point = 750}
        }
    },
    {
        name = 'WEAPON_MILITARYRIFLE',
        label = _U('weapon_militaryrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MILITARYRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MILITARYRIFLE_CLIP_02"), point = 500},
            {name = 'ironsights', label = _U('component_ironsights'), hash = Hash("COMPONENT_MILITARYRIFLE_SIGHT_01"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_SMALL"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250}
        }
    },
    {
        name = 'WEAPON_SPECIALCARBINE',
        label = _U('weapon_specialcarbine'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SPECIALCARBINE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SPECIALCARBINE_CLIP_02"), point = 500},
            {name = 'clip_drum', label = _U('component_clip_drum'), hash = Hash("COMPONENT_SPECIALCARBINE_CLIP_03"), point = 750},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER"), point = 250}
        }
    },
    {
        name = 'WEAPON_SPECIALCARBINE_MK2',
        label = _U('weapon_specialcarbine_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CLIP_FMJ"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_small', label = _U('component_scope_small'), hash = Hash("COMPONENT_AT_SCOPE_MACRO_MK2"), point = 250},
            {name = 'scope_large', label = _U('component_scope_large'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM_MK2"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_SC_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_SC_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01"), point = 250}
        }
    },
    -- Sniper
    {
        name = 'WEAPON_HEAVYSNIPER',
        label = _U('weapon_heavysniper'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")},
        tints = tints,
        components = {
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_LARGE"), point = 250},
            {name = 'scope_advanced', label = _U('component_scope_advanced'), hash = Hash("COMPONENT_AT_SCOPE_MAX"), point = 250}
        }
    },
    {
        name = 'WEAPON_HEAVYSNIPER_MK2',
        label = _U('weapon_heavysniper_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_02"), point = 500},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_FMJ"), point = 250},
            {name = 'ammo_explosive', label = _U('component_ammo_explosive'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CLIP_EXPLOSIVE"), point = 250},
            {name = 'scope_zoom', label = _U('component_scope_zoom'), hash = Hash("COMPONENT_AT_SCOPE_LARGE_MK2"), point = 250},
            {name = 'scope_advanced', label = _U('component_scope_advanced'), hash = Hash("COMPONENT_AT_SCOPE_MAX"), point = 250},
            {name = 'scope_nightvision', label = _U('component_scope_nightvision'), hash = Hash("COMPONENT_AT_SCOPE_NV"), point = 250},
            {name = 'scope_thermal', label = _U('component_scope_thermal'), hash = Hash("COMPONENT_AT_SCOPE_THERMAL"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_SR_SUPP_03"), point = 250},
            {name = 'muzzle_squared', label = _U('component_muzzle_squared'), hash = Hash("COMPONENT_AT_MUZZLE_08"), point = 250},
            {name = 'muzzle_bell', label = _U('component_muzzle_bell'), hash = Hash("COMPONENT_AT_MUZZLE_09"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_SR_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_SR_BARREL_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_MARKSMANRIFLE',
        label = _U('weapon_marksmanrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MARKSMANRIFLE_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MARKSMANRIFLE_CLIP_02"), point = 500},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_MARKSMANRIFLE_VARMOD_LUXE"), point = 250}
        }
    },
    {
        name = 'WEAPON_MARKSMANRIFLE_MK2',
        label = _U('weapon_marksmanrifle_mk2'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")},
        tints = tints,
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_01"), point = 250},
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_02"), point = 500},
            {name = 'ammo_tracer', label = _U('component_ammo_tracer'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_TRACER"), point = 250},
            {name = 'ammo_incendiary', label = _U('component_ammo_incendiary'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_INCENDIARY"), point = 250},
            {name = 'ammo_armor', label = _U('component_ammo_armor'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_ARMORPIERCING"), point = 250},
            {name = 'ammo_fmj', label = _U('component_ammo_fmj'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CLIP_FMJ"), point = 250},
            {name = 'scope_holo', label = _U('component_scope_holo'), hash = Hash("COMPONENT_AT_SIGHTS"), point = 250},
            {name = 'scope_large', label = _U('component_scope_large'), hash = Hash("COMPONENT_AT_SCOPE_MEDIUM_MK2"), point = 250},
            {name = 'scope_zoom', label = _U('component_scope_zoom'), hash = Hash("COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2"), point = 250},
            {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP"), point = 250},
            {name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = Hash("COMPONENT_AT_MUZZLE_01"), point = 250},
            {name = 'muzzle_tactical', label = _U('component_muzzle_tactical'), hash = Hash("COMPONENT_AT_MUZZLE_02"), point = 250},
            {name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = Hash("COMPONENT_AT_MUZZLE_03"), point = 250},
            {name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = Hash("COMPONENT_AT_MUZZLE_04"), point = 250},
            {name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = Hash("COMPONENT_AT_MUZZLE_05"), point = 250},
            {name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = Hash("COMPONENT_AT_MUZZLE_06"), point = 250},
            {name = 'muzzle_split', label = _U('component_muzzle_split'), hash = Hash("COMPONENT_AT_MUZZLE_07"), point = 250},
            {name = 'barrel_default', label = _U('component_barrel_default'), hash = Hash("COMPONENT_AT_MRFL_BARREL_01"), point = 250},
            {name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = Hash("COMPONENT_AT_MRFL_BARREL_02"), point = 250},
            {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP_02"), point = 250},
            {name = 'camo_finish', label = _U('component_camo_finish'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO"), point = 250},
            {name = 'camo_finish2', label = _U('component_camo_finish2'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_02"), point = 250},
            {name = 'camo_finish3', label = _U('component_camo_finish3'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_03"), point = 250},
            {name = 'camo_finish4', label = _U('component_camo_finish4'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_04"), point = 250},
            {name = 'camo_finish5', label = _U('component_camo_finish5'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_05"), point = 250},
            {name = 'camo_finish6', label = _U('component_camo_finish6'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_06"), point = 250},
            {name = 'camo_finish7', label = _U('component_camo_finish7'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_07"), point = 250},
            {name = 'camo_finish8', label = _U('component_camo_finish8'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_08"), point = 250},
            {name = 'camo_finish9', label = _U('component_camo_finish9'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_09"), point = 250},
            {name = 'camo_finish10', label = _U('component_camo_finish10'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_10"), point = 250},
            {name = 'camo_finish11', label = _U('component_camo_finish11'), hash = Hash("COMPONENT_MARKSMANRIFLE_MK2_CAMO_IND_01"), point = 250}
        }
    },
    {
        name = 'WEAPON_SNIPERRIFLE',
        label = _U('weapon_sniperrifle'),
        ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")},
        tints = tints,
        components = {
            {name = 'scope', label = _U('component_scope'), hash = Hash("COMPONENT_AT_SCOPE_LARGE"), point = 250},
            {name = 'scope_advanced', label = _U('component_scope_advanced'), hash = Hash("COMPONENT_AT_SCOPE_MAX"), point = 250},
            {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02"), point = 250},
            {name = 'luxary_finish', label = _U('component_luxary_finish'), hash = Hash("COMPONENT_SNIPERRIFLE_VARMOD_LUXE"), point = 250}
        }
    },
    -- Heavy / Launchers
    {name = 'WEAPON_COMPACTLAUNCHER', label = _U('weapon_compactlauncher'), tints = tints, components = {}, ammo = {label = _U('ammo_grenadelauncher'), hash = Hash("AMMO_GRENADELAUNCHER")}},
    {name = 'WEAPON_FIREWORK', label = _U('weapon_firework'), components = {}, ammo = {label = _U('ammo_firework'), hash = Hash("AMMO_FIREWORK")}},
    {name = 'WEAPON_GRENADELAUNCHER', label = _U('weapon_grenadelauncher'), tints = tints, components = {}, ammo = {label = _U('ammo_grenadelauncher'), hash = Hash("AMMO_GRENADELAUNCHER")}},
    {name = 'WEAPON_HOMINGLAUNCHER', label = _U('weapon_hominglauncher'), tints = tints, components = {}, ammo = {label = _U('ammo_rockets'), hash = Hash("AMMO_HOMINGLAUNCHER")}},
    {name = 'WEAPON_MINIGUN', label = _U('weapon_minigun'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MINIGUN")}},
    {name = 'WEAPON_RAILGUN', label = _U('weapon_railgun'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RAILGUN")}},
    {name = 'WEAPON_RPG', label = _U('weapon_rpg'), tints = tints, components = {}, ammo = {label = _U('ammo_rockets'), hash = Hash("AMMO_RPG")}},
    {name = 'WEAPON_RAYMINIGUN', label = _U('weapon_rayminigun'), tints = tints, components = {}, ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_MINIGUN")}},
    -- Thrown
    {name = 'WEAPON_BALL', label = _U('weapon_ball'), components = {}, ammo = {label = _U('ammo_ball'), hash = Hash("AMMO_BALL")}},
    {name = 'WEAPON_BZGAS', label = _U('weapon_bzgas'), components = {}, ammo = {label = _U('ammo_bzgas'), hash = Hash("AMMO_BZGAS")}},
    {name = 'WEAPON_FLARE', label = _U('weapon_flare'), components = {}, ammo = {label = _U('ammo_flare'), hash = Hash("AMMO_FLARE")}},
    {name = 'WEAPON_GRENADE', label = _U('weapon_grenade'), components = {}, ammo = {label = _U('ammo_grenade'), hash = Hash("AMMO_GRENADE")}},
    {name = 'WEAPON_PETROLCAN', label = _U('weapon_petrolcan'), components = {}, ammo = {label = _U('ammo_petrol'), hash = Hash("AMMO_PETROLCAN")}},
    {name = 'WEAPON_HAZARDCAN', label = _U('weapon_hazardcan'), components = {}, ammo = {label = _U('ammo_petrol'), hash = Hash("AMMO_PETROLCAN")}},
    {name = 'WEAPON_MOLOTOV', label = _U('weapon_molotov'), components = {}, ammo = {label = _U('ammo_molotov'), hash = Hash("AMMO_MOLOTOV")}},
    {name = 'WEAPON_PROXMINE', label = _U('weapon_proxmine'), components = {}, ammo = {label = _U('ammo_proxmine'), hash = Hash("AMMO_PROXMINE")}},
    {name = 'WEAPON_PIPEBOMB', label = _U('weapon_pipebomb'), components = {}, ammo = {label = _U('ammo_pipebomb'), hash = Hash("AMMO_PIPEBOMB")}},
    {name = 'WEAPON_SNOWBALL', label = _U('weapon_snowball'), components = {}, ammo = {label = _U('ammo_snowball'), hash = Hash("AMMO_SNOWBALL")}},
    {name = 'WEAPON_STICKYBOMB', label = _U('weapon_stickybomb'), components = {}, ammo = {label = _U('ammo_stickybomb'), hash = Hash("AMMO_STICKYBOMB")}},
    {name = 'WEAPON_SMOKEGRENADE', label = _U('weapon_smokegrenade'), components = {}, ammo = {label = _U('ammo_smokebomb'), hash = Hash("AMMO_SMOKEGRENADE")}},
    -- Tools
    {name = 'WEAPON_FIREEXTINGUISHER', label = _U('weapon_fireextinguisher'), components = {}, ammo = {label = _U('ammo_charge'), hash = Hash("AMMO_FIREEXTINGUISHER")}},
    {name = 'WEAPON_DIGISCANNER', label = _U('weapon_digiscanner'), components = {}},
    {name = 'GADGET_PARACHUTE', label = _U('gadget_parachute'), components = {}},
    {name = 'WEAPON_TACTICALRIFLE',label = _U('weapon_tactilerifle'),ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_RIFLE")},tints = tints,
        components = {
                        {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_TACTICALRIFLE_CLIP_01")},
                        {name = 'clip_extended', label = _U('component_clip_extended'), hash = Hash("COMPONENT_TACTICALRIFLE_CLIP_02")},
                        {name = 'flashlight', label = _U('component_flashlight'), hash = Hash("COMPONENT_AT_AR_FLSH_REH")},
                        {name = 'grip', label = _U('component_grip'), hash = Hash("COMPONENT_AT_AR_AFGRIP")},
                        {name = 'suppressor', label = _U('component_suppressor'), hash = Hash("COMPONENT_AT_AR_SUPP_02")}
                }
    },
    {name = 'WEAPON_PRECISIONRIFLE', label = _U('weapon_precisionrifle'), ammo = {label = _U('ammo_rounds'), hash = Hash("AMMO_SNIPER")}, tints = tints,
                components = {
                        {name = 'clip_default', label = _U('component_clip_default'), hash = Hash("COMPONENT_PRECISIONRIFLE_CLIP_01")},
                }
    },
    {name = 'WEAPON_KATANA', label = _U('weapon_katana'), components = {}},
    {name = 'WEAPON_PENETRATOR', label = _U('weapon_penetrator'), components = {}},
    {name = 'WEAPON_KATANA2', label = _U('weapon_katana2'), components = {}},	
    {name = 'WEAPON_THROWINGCHAIR', label = _U('weapon_throwingchair'), components = {}},
    {name = 'WEAPON_BIGHAMMER', label = _U('weapon_bighammer'), components = {}},
    {name = 'WEAPON_KATANA3', label = _U('weapon_katana3'), components = {}},
    {name = 'WEAPON_KATANA4', label = _U('weapon_katana4'), components = {}},

}

local function CustomPrice(weaponName, customHash)
    for _, v in pairs(WEAPON_CUSTOM_PRICE) do
        if (v.name == weaponName) then
            for _, custom in pairs(v.components) do
                if (GetHashKey(custom.name) == customHash) then
                    return custom
                end
            end
        end
    end
    return false;
end

RegisterNetEvent('Abteww:addAccesoire')
AddEventHandler('Abteww:addAccesoire', function(weaponName, customHash)
    local source = source;
    if (source) then
        local xPlayer = ESX.GetPlayerFromId(source)
        if (xPlayer) then
            local CUSTOM = CustomPrice(weaponName, customHash);
            if CUSTOM then 
                if (CUSTOM.point ~= nil) then
                    -- xPlayer.addWeaponComponent(weaponName, CUSTOM.name)
                    xPlayer.showNotification('Vous avez ajouter '..CUSTOM.label)

                    -- print(source, weaponName, CUSTOM.name)
                    TriggerClientEvent("addWeaponComponentToPed", source, weaponName, CUSTOM.name)

                    -- GiveWeaponComponentToPed(GetPlayerPed(source), GetHashKey(weaponName), GetHashKey(CUSTOM.name))
                end
            end
        end
    end
end)

RegisterNetEvent('Abteww:getLevelVip')
AddEventHandler('Abteww:getLevelVip', function(src)
    local xPlayer = ESX.GetPlayerFromId(source);
    xPlayer.updateVIP(function()
        xPlayer.triggerEvent("Abteww:Getttttt", xPlayer.getVIP(), xPlayer.getVIP() > 0);
    end);
end)
RegisterServerEvent('Weapon:removeAccesoire')
AddEventHandler('Weapon:removeAccesoire', function(weaponName)
    if weaponName == nil then return end
    local source = source;
    if (source) then
        local xPlayer = ESX.GetPlayerFromId(source)
        if (xPlayer) then
            for i = 1 , #xPlayer.getLoadout() do
                if xPlayer.getLoadout()[i].name == weaponName then
                    for k, v in pairs(xPlayer.getLoadout()[i].components) do
                        if xPlayer.hasWeaponComponent(weaponName, v) then
                            xPlayer.removeWeaponComponent(weaponName, v)
                            Wait(100)
                            TriggerClientEvent("RemoveWeaponComponentFromPed", source, weaponName, v)
                        end
                    end
                    xPlayer.showNotification("~b~Vous avez retirer tous les accessoires de votre arme !~s~")
                end
            end
        end
    end
end)
RegisterCommand("vip", function(src)
    local xPlayer = ESX.GetPlayerFromId(src);
    xPlayer.updateVIP(function()
        xPlayer.triggerEvent("Abteww:GetVip", xPlayer.getVIP(), xPlayer.getVIP() > 0);
    end);
end);
