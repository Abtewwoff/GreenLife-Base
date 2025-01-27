ESX = nil 
Config.ESX_GetCoreObject_client()
local player = GetPlayerPed(-1)
local coords = GetEntityCoords(PlayerPedId())
---------------------------------
-------- Message F8  ------------
---------------------------------
print ("^5Crée par : Hauxu") 
print ("^3Discord  : https://discord.gg/greenlife") 
print ("^3Info     : Partager le 7/01/2025") 
---------------------------------
-- Obtient la bibliothèque ESX --
---------------------------------
local function StartProgressBar(temps)
    exports["rprogress"]:Start(temps)
    Wait(temps * 1000)
    exports["rprogress"]:Stop()
end

local function PlayAnimation(animation)
    local playerPed = PlayerPedId()
    if animation then
        RequestAnimDict(animation.dict)
        while not HasAnimDictLoaded(animation.dict) do
            Wait(0)
        end
        TaskPlayAnim(playerPed, animation.dict, animation.name, 8.0, -8.0, -1, animation.flag or 1, 0, false, false, false)
    end
end

local function StopAnimation()
    ClearPedTasksImmediately(PlayerPedId())
end
local function HandleRecolte(drogue)
    Citizen.CreateThread(function()
        while true do
            local coords = GetEntityCoords(PlayerPedId())  -- Appel une seule fois par boucle
            local inRange = false  -- Variable pour savoir si le joueur est à proximité

            for _, v in pairs(Config.Drogues[drogue].recolte) do
                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2.0) then
                    inRange = true  -- Le joueur est proche d'un point de récolte
                    DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 254, 234, 170, 0, 1, 2, 0, nil, nil, 0)
                    AddTextEntry("recolte" .. drogue, "Appuyez sur ~INPUT_CONTEXT~ pour ~g~récolter " .. drogue)
                    DisplayHelpTextThisFrame("recolte" .. drogue, true)

                    if IsControlJustPressed(1, 51) then
                        ESX.ShowNotification("Récolte de " .. drogue .. " en cours...")
                        PlayAnimation(Config.Drogues[drogue].animations.recolte)
                        StartProgressBar(Config.Drogues[drogue].tempsRecolte)
                        StopAnimation()
                        TriggerServerEvent('MD_Drogue:givedrogue', drogue)
                    end
                end
            end

            -- Si le joueur est proche d'un point de récolte, réduire le délai pour vérifier rapidement à nouveau
            if inRange then
                Wait(0)  -- Attendre un très court instant pour vérifier à nouveau immédiatement
            else
                Wait(500)  -- Si le joueur est loin, augmenter le délai pour économiser des ressources
            end
        end
    end)
end

local function HandleTraitement(drogue)
    Citizen.CreateThread(function()
        while true do
            local coords = GetEntityCoords(PlayerPedId())  -- Appel une seule fois par boucle
            local inRange = false  -- Variable pour savoir si le joueur est à proximité d'un point de traitement

            for _, v in pairs(Config.Drogues[drogue].traitement) do
                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2.0) then
                    inRange = true  -- Le joueur est proche d'un point de traitement
                    DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 254, 234, 170, 0, 1, 2, 0, nil, nil, 0)
                    AddTextEntry("traitement" .. drogue, "Appuyez sur ~INPUT_CONTEXT~ pour ~g~traiter " .. drogue)
                    DisplayHelpTextThisFrame("traitement" .. drogue, true)

                    if IsControlJustPressed(1, 51) then
                        ESX.ShowNotification("Traitement de " .. drogue .. " en cours...")
                        PlayAnimation(Config.Drogues[drogue].animations.traitement)
                        StartProgressBar(Config.Drogues[drogue].tempsTraitement)
                        StopAnimation()
                        TriggerServerEvent('MD_Drogue:givesachet', drogue)
                    end
                end
            end

            -- Si le joueur est proche d'un point de traitement, réduire le délai pour vérifier rapidement à nouveau
            if inRange then
                Wait(0)  -- Attendre un très court instant pour vérifier à nouveau immédiatement
            else
                Wait(500)  -- Si le joueur est loin, augmenter le délai pour économiser des ressources
            end
        end
    end)
end

local function HandleRevente(drogue)
    local isReventeActive = false
    Citizen.CreateThread(function()
        while true do
            Wait(1000)  -- Vérification toutes les 1000ms
            local coords = GetEntityCoords(PlayerPedId())  -- Appel une seule fois par boucle
            local v = Config.Drogues[drogue].revente
            local item_sachet = Config.Drogues[drogue].sachetName

            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2.0) then
                ESX.TriggerServerCallback('MD_Drogue:checkItemForRevente', function(itemCount)
                    if itemCount > 0 and not isReventeActive then
                        isReventeActive = true
                        TriggerServerEvent('MD_Drogue:revente', drogue)
                        Wait(2000)  -- Temps d'attente avant de permettre une nouvelle revente
                        isReventeActive = false
                    end
                end, item_sachet)
            end
        end
    end)
end

local function HandlePortes(drogue)
    Citizen.CreateThread(function()
        while true do
            Wait(2000)  -- Vérification toutes les 2000ms
            local coords = GetEntityCoords(PlayerPedId())  -- Appel une seule fois par boucle

            -- Vérifie si les données de la drogue et des portes existent
            local drogueConfig = Config.Drogues[drogue]
            if not drogueConfig or not drogueConfig.portes then
                print(("Configuration des portes manquante pour la drogue : %s"):format(drogue))
                return
            end

            local interieur = drogueConfig.portes.interieur
            local exterieur = drogueConfig.portes.exterieur

            if interieur and exterieur then
                if (GetDistanceBetweenCoords(coords, interieur.x, interieur.y, interieur.z, true) < 2.0) then
                    SetEntityCoords(GetPlayerPed(-1), exterieur.x, exterieur.y, exterieur.z, false, false, false, true)
                    Wait(4000)
                elseif (GetDistanceBetweenCoords(coords, exterieur.x, exterieur.y, exterieur.z, true) < 2.0) then
                    SetEntityCoords(GetPlayerPed(-1), interieur.x, interieur.y, interieur.z, false, false, false, true)
                    Wait(4000)
                end
            end
        end
    end)
end

Citizen.CreateThread(function()
    for drogue, _ in pairs(Config.Drogues) do
        HandleRecolte(drogue)
        HandleTraitement(drogue)
        HandleRevente(drogue)
        HandlePortes(drogue)
    end
end)
