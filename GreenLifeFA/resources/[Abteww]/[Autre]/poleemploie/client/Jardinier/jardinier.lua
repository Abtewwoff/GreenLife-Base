ESX  = exports['Framework']:getSharedObject()

----- Variables -----

local PlayerData = {}

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



jardinierState = false

local MainJardinier = RageUI.CreateMenu("", "Liste des emploies", nil, nil, ConfigEmploie.NomFichier, ConfigEmploie.NomBanniere)

RageUI.Closed = function()
    jardinierState = false
end

function OpenMenuJardinier()
    if jardinierState then 
        jardinierState = false
        RageUI.Visible(MainJardinier, false)
        return 
    else 
        jardinierState = true
        RageUI.Visible(MainJardinier, true)
    end

    CreateThread(function()
        while jardinierState do
            Wait(1)

            RageUI.IsVisible(MainJardinier, function()
                RageUI.Button("Commencer à travailler", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                        TriggerServerEvent('Meta_dev:prisedeservice')
                        ServiceJardinier()
                    end
                })

                RageUI.Line()

                RageUI.Button("Arreter de travailler", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                        TriggerServerEvent('Meta_dev:findeservice')
                        DeleteEntity(car)
                        DeleteEntity(herbe)
                    end
                })
            end)

        end
    end)
end





function ServiceJardinier()
    local h = GetHashKey('mower')
    RequestModel(h)
    while not HasModelLoaded(h) do Wait(0) end 
    car = CreateVehicle(h, -1340.573, 138.2964, 56.77966, 296.4451, true, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), car, -1)
    SetVehicleFuelLevel(car, 99.9)
    spawnplant()
end


function spawnplant()
    local props = "prop_plant_flower_01"
    local objects = GetHashKey(props)
    RequestModel(objects)
    while not HasModelLoaded(objects) do Wait(0) end
    local posfe = ConfigJardinier.PointRecolte[math.random(1, #ConfigJardinier.PointRecolte)]  ---- Prend une position aléatoire
    herbe = CreateObject(objects, posfe.x, posfe.y, posfe.z - 0.9, true, false, false) ---- Crée l'objet
    PlaceObjectOnGroundProperly(herbe) --- Place l'objet au sol

    blip = AddBlipForEntity(herbe)
    SetBlipSprite (blip, ConfigJardinier.Jardinier.BlipsAleatoire.model)
    SetBlipDisplay(blip, 4) 
    SetBlipScale(blip, ConfigJardinier.Jardinier.BlipsAleatoire.taille)
    SetBlipColour (blip, ConfigJardinier.Jardinier.BlipsAleatoire.couleur)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Tondre la pelouse')
    EndTextCommandSetBlipName(blip)
   recoltejardinerie(herbe)
end


function recoltejardinerie(herbe)
    CreateThread(function()
        while true do 
            if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(herbe)) <= 5 then
                wait = 0 
                ESX.ShowHelpNotification("Appuyez sur E pour ~g~tondre la pelouse~s~")
                -- TriggerEvent("ui:showInteraction", "E", " pour tondre la pelouse")
                if IsControlJustPressed(1,51) then
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        SetBlockingOfNonTemporaryEvents(PlayerPedId(), true)
                        Wait(100)
                        FreezeEntityPosition(car, true)
                        Wait(4000)
                        TriggerServerEvent('Meta_dev:paiementjardinier')
                        FreezeEntityPosition(car, false)
                        DeleteEntity(herbe)
                        spawnplant()
                        return recoltejardinerie
                    else
                        ESX.ShowNotification("Vous devez être dans un véhicule pour pouvoir tondre la pelouse")
                    end
                end
            else
                wait = 1000
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
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'jardinier' then 
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, ConfigJardinier.Jardinier.Position.pos.x, ConfigJardinier.Jardinier.Position.pos.y, ConfigJardinier.Jardinier.Position.pos.z)
        if dist3 <= 1.0 then
            Timer = 0
            end
            if dist3 <= 5.0 then
                Timer = 0   
                DrawMarker(ConfigEmploie.Position.Emploie.marker, ConfigJardinier.Jardinier.Position.pos.x, ConfigJardinier.Jardinier.Position.pos.y, ConfigJardinier.Jardinier.Position.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfigEmploie.LargeurX, ConfigEmploie.LargeurY, ConfigEmploie.LargeurZ, ConfigEmploie.colorR, ConfigEmploie.colorG, ConfigEmploie.colorB, ConfigEmploie.Opacity, ConfigEmploie.MarkerSaute, true, 2, ConfigEmploie.MarkerTourne, nil, nil, false)
                    ESX.ShowHelpNotification(ConfigJardinier.Jardinier.Position.text)
                    -- TriggerEvent("ui:showInteraction", "E", ConfigJardinier.Jardinier.Position.text)
                    if IsControlJustPressed(1,51) then
                        OpenMenuJardinier()
                    end
                end
            end 
        Wait(Timer)
    end
end)



--------------------------------------------------------------------------------------------------------------------------
                                    -- [ PED] --
--------------------------------------------------------------------------------------------------------------------------


CreateThread(function()
    local hash = GetHashKey("s_m_y_xmech_01")
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_y_xmech_01", -1357.418, 124.2668, 55.23864, 3.348044, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)

    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
end)

-----------------------------------------------------------------------------------------------------------------------------
                                    -- [ Blips] --
--------------------------------------------------------------------------------------------------------------------------


-- CreateThread(function()
--     local blip1 = AddBlipForCoord(ConfigJardinier.Jardinier.Blips.pos) -- remplacer les coordonnés
--     SetBlipSprite(blip1, ConfigJardinier.Jardinier.Blips.model) -- Model du blip
--     SetBlipDisplay(blip1, 4)
--     SetBlipScale(blip1, ConfigJardinier.Jardinier.Blips.taille) -- Taille du blip
--     SetBlipColour(blip1, ConfigJardinier.Jardinier.Blips.couleur) -- Couleur du blip
--     SetBlipAsShortRange(blip1, true)
--     BeginTextCommandSetBlipName('STRING')
--     AddTextComponentSubstringPlayerName(ConfigJardinier.Jardinier.Blips.nom) -- Nom du blips
--     EndTextCommandSetBlipName(blip1)
-- end)