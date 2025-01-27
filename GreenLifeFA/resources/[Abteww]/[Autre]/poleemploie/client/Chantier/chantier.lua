ESX  = exports['Framework']:getSharedObject()

----- Variables -----
local PlayerData = {}
local harvestDuration = 6000

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Wait(10)
    end
    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
    end
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



chantierState = false

local MainChantier = RageUI.CreateMenu("", "Liste des emploies", nil, nil, ConfigEmploie.NomFichier, ConfigEmploie.NomBanniere)

RageUI.Closed = function()
    chantierState = false
end

local ServiceChantier = false

function OpenMenuChantier()
    if chantierState then 
        chantierState = false
        RageUI.Visible(MainChantier, false)
        return 
    else 
        chantierState = true
        RageUI.Visible(MainChantier, true)
    end

    CreateThread(function()
        while chantierState do 
            Wait(1)
            RageUI.IsVisible(MainChantier, function()
                if not ServiceChantier then
                    RageUI.Button("Prendre son service", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                            TriggerServerEvent('Meta_dev:prisedeservice')
                            ServiceChantier = true
                            Chantier()
                        end
                    })
                end

                if ServiceChantier then
                    RageUI.Button("Quitter son service", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                            TriggerServerEvent('Meta_dev:findeservice')
                            ServiceChantier = false
                            Chantier()
                        end
                    })
                end
            end)
        end
    end)
end

local blip = nil

function Chantier()
    if ServiceChantier then
        if blip ~= nil then
            RemoveBlip(blip)
        end

        local posfe = ConfigChantier.PointRecolte[math.random(1, #ConfigChantier.PointRecolte)]  ---- Prend une position aléatoire  ; ) 

        blip = AddBlipForCoord(posfe.x, posfe.y, posfe.z)
        SetBlipSprite(blip, ConfigJardinier.Jardinier.BlipsAleatoire.model)
        SetBlipDisplay(blip, 4) 
        SetBlipScale(blip, ConfigJardinier.Jardinier.BlipsAleatoire.taille)
        SetBlipColour(blip, ConfigJardinier.Jardinier.BlipsAleatoire.couleur)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Point de réparation')
        EndTextCommandSetBlipName(blip)

        recoltechantier(posfe)
    end
    if not ServiceChantier then
        RemoveBlip(blip)
    end
end

function recoltechantier(posfe)
    CreateThread(function()
        while true do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - vector3(posfe.x, posfe.y, posfe.z))
            if distance <= 5 then
                DrawMarker(22, posfe.x, posfe.y, posfe.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 30, 255, 0, 155)
                local wait = 0
                if distance <= 1.0 then
                    -- TriggerEvent("ui:showInteraction", "E", " pour travailler")
                    if IsControlJustPressed(1, 51) then
                        FreezeEntityPosition(PlayerPedId(), true)
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_HAMMERING", 0, true)
                        exports.rprogress:Start('', harvestDuration)  -- Utilise la variable de durée ici
                        Wait(harvestDuration)  -- Attendre la même durée que harvestDuration
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                        Chantier()
                        TriggerServerEvent('Meta_dev:paiementchantier')
                        return recoltechantier
                    end
                end
            else
                local wait = 1000
            end
            Wait(wait)
        end
    end)
end


--------------------------------------------------------------------------------------------------------------------------
                                    -- [ DrawMarker] --
--------------------------------------------------------------------------------------------------------------------------


CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'chantier' then 
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, ConfigChantier.Position.pos.x, ConfigChantier.Position.pos.y, ConfigChantier.Position.pos.z)
        if dist3 <= 1.0 then
            Timer = 0
            end
            if dist3 <= 5.0 then
                Timer = 0   
                DrawMarker(ConfigEmploie.Position.Emploie.marker, ConfigChantier.Position.pos.x, ConfigChantier.Position.pos.y, ConfigChantier.Position.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfigEmploie.LargeurX, ConfigEmploie.LargeurY, ConfigEmploie.LargeurZ, ConfigEmploie.colorR, ConfigEmploie.colorG, ConfigEmploie.colorB, ConfigEmploie.Opacity, ConfigEmploie.MarkerSaute, true, 2, ConfigEmploie.MarkerTourne, nil, nil, false)
                    ESX.ShowHelpNotification(ConfigChantier.Position.text)
                    -- TriggerEvent("ui:showInteraction", "E", ConfigChantier.Position.text)
                    if IsControlJustPressed(1,51) then
                        OpenMenuChantier()
                    end
                end
            end 
        Wait(Timer)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------
                                    -- [ Blips] --
--------------------------------------------------------------------------------------------------------------------------


-- CreateThread(function()
--     local blip1 = AddBlipForCoord(ConfigChantier.Chantier.Blips.pos) -- remplacer les coordonnés
--     SetBlipSprite(blip1, ConfigChantier.Chantier.Blips.model) -- Model du blip
--     SetBlipDisplay(blip1, 4)
--     SetBlipScale(blip1, ConfigChantier.Chantier.Blips.taille) -- Taille du blip
--     SetBlipColour(blip1, ConfigChantier.Chantier.Blips.couleur) -- Couleur du blip
--     SetBlipAsShortRange(blip1, true)
--     BeginTextCommandSetBlipName('STRING')
--     AddTextComponentSubstringPlayerName(ConfigChantier.Chantier.Blips.nom) -- Nom du blips
--     EndTextCommandSetBlipName(blip1)
-- end)

--------------------------------------------------------------------------------------------------------------------------
                                    -- [ PED] --
--------------------------------------------------------------------------------------------------------------------------


CreateThread(function()
    local hash = GetHashKey("s_m_y_dockwork_01")
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_y_dockwork_01", -509.52679443359, -1001.6748657227, 22.5505027771, 90.6405792236328, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)

    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
end)
