Config = {}
Config.ESX_GetCoreObject_client = function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100) -- Patiente jusqu'à ce que ESX soit initialisé
    end
end


Config.ESX_GetCoreObject_serveur = function()
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    if not ESX then
        print("[ERREUR] Impossible de charger ESX sur le serveur. Vérifiez votre configuration.")
    else
        print("[INFO] ESX chargé avec succès côté serveur.")
    end
end

------------------------------------[[ CONFIGURATION GÉNÉRALE ]]------------------------------------
Config.legacy = "non" 
Config.ox_inventory = false




Config.DispenseDict = {"mini@sprunk", "plyr_buy_drink_pt1"}
Config.PocketAnims = {"mp_common_miss", "put_away_coke"}

------------------------------------[[ DROGUES CONFIGURATION ]]------------------------------------

Config.Drogues = {
    coke = {
        itemName = "coke",  -- Nom de l'item
        sachetName = "coke_pooch",  -- Nom du sachet
        tempsRecolte = 10,
        tempsTraitement = 15,
        quantiteParTraitement = 5,
        prixRevente = 999,
        recolte = {
            {x = 2220.46, y = 5576.72, z = 53.69},
            {x = 2225.32, y = 5576.31, z = 53.69},
        },
        traitement = {
            {x = 1093.13, y = -3194.90, z = -39.00},
            {x = 1090.36, y = -3194.87, z = -39.00},
        },
        revente = {x = -1096.05, y = 850.67, x = 26.83},
        portes = {
            interieur = {x = 1088.63, y = -3187.49, z = -39.95, h = 258.00},
            exterieur = {x = 854.70, y = -2112.87, z = 30.53, h = 180.00}
        },
        animations = {
            recolte = {dict = "amb@world_human_gardener_plant@male@base", name = "base", flag = 1},
            traitement = {dict = "amb@prop_human_parking_meter@male@idle_a", name = "idle_a", flag = 1},
            revente = {dict = "amb@world_human_hang_out_street@female_hold_arm@base", name = "base", flag = 1}
        }
    },
    weed = {
        itemName = "weed",  -- Nom de l'item
        sachetName = "weed_pooch",  -- Nom du sachet
        tempsRecolte = 5,
        tempsTraitement = 7,
        quantiteParTraitement = 2,
        prixRevente = 1500,
        recolte = {
            {x = 1061.34, y = -3205.75, z = -39.04},
            {x = 1061.41, y = -3202.30, z = -39.04},
        },
        traitement = {
            {x = 1033.76, y = -3203.72, z = -38.18},
            {x = 1037.37, y = -3205.27, z = -38.18},
        },
        revente = {x = -1096.05, y = 850.67, x = 26.83},
        portes = {
            interieur = {x = 1066.36, y = -3183.43, z = -39.16},
            exterieur = {x = 2890.55, y = 4503.87, z = 48.09}
        },
        animations = {
            recolte = {dict = "amb@world_human_gardener_plant@male@base", name = "base", flag = 1},
            traitement = {dict = "amb@prop_human_parking_meter@male@idle_a", name = "idle_a", flag = 1},
            revente = {dict = "amb@world_human_hang_out_street@female_hold_arm@base", name = "base", flag = 1}
        }
    },
    meth = {
        itemName = "meth",  -- Nom de l'item
        sachetName = "meth_pooch",  -- Nom du sachet
        tempsRecolte = 5,
        tempsTraitement = 7,
        quantiteParTraitement = 3,
        prixRevente = 2000,
        recolte = {
            {x = 1012.26, y = -3195.01, z = -38.99},
            {x = 1014.87, y = -3194.92, z = -38.99},
        },
        traitement = {
            {x = 1005.69, y = -3200.4, z = -38.52}
        },
        revente = {x = -1096.05, y = 850.67, x = 26.83},
        portes = {
            interieur = {x = 997.84, y = -3200.66, z = -36.39},
            exterieur = {x = 8.15, y = 6469.15, z = 31.43}
        },
        animations = {
            recolte = {dict = "amb@world_human_gardener_plant@male@base", name = "base", flag = 1},
            traitement = {dict = "amb@prop_human_parking_meter@male@idle_a", name = "idle_a", flag = 1},
            revente = {dict = "amb@world_human_hang_out_street@female_hold_arm@base", name = "base", flag = 1}
        }
    },
    opium = {
        itemName = "opium",  -- Nom de l'item
        sachetName = "opium_pooch",  -- Nom du sachet
        tempsRecolte = 5,
        tempsTraitement = 7,
        quantiteParTraitement = 3,
        prixRevente = 2000,
        recolte = {
            {x = -1096.39, y = 4948.17, z = 218.35}
        },
        traitement = {
            {x = 1389.32, y = 3605.00, z = 38.99}
        },
        revente = {x = -1096.05, y = 850.67, x = 26.83},
        animations = {
            recolte = {dict = "amb@world_human_gardener_plant@male@base", name = "base", flag = 1},
            traitement = {dict = "amb@prop_human_parking_meter@male@idle_a", name = "idle_a", flag = 1},
            revente = {dict = "amb@world_human_hang_out_street@female_hold_arm@base", name = "base", flag = 1}
        }
    },
}
