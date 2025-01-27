ESX  = exports['Framework']:getSharedObject()

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

mineurState = false

local MainMineur = RageUI.CreateMenu("", "Travail de mineur", nil, nil, ConfigEmploie.NomFichier, ConfigEmploie.NomBanniere)

RageUI.Closed = function()
    mineurState = false
end


function OpenMenuMineur()
    if mineurState then 
        mineurState = false
        RageUI.Visible(MainMineur, false)
        return 
    else 
        mineurState = true
        RageUI.Visible(MainMineur, true)
    end

    CreateThread(function()
        while mineurState do 
            Wait(1)
            RageUI.IsVisible(MainMineur, function()

                RageUI.Button("Commencer à travailler", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent('Meta_dev:prisedeservice')
                        RageUI.CloseAll()
                        SetNewWaypoint(vector3(2950.514, 2798.447, 41.03659))
                        ServiceMineur()
                    end
                })

                RageUI.Button("Arreter de travailler", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent('Meta_dev:findeservice')
                        RageUI.CloseAll()
                        DeleteEntity(car)
                        DeleteEntity(rock)
                    end
                })
            end)
        end
    end)
end


function ServiceMineur()
    local h = GetHashKey('biff')
    RequestModel(h)
    while not HasModelLoaded(h) do Wait(0) end 
    car = CreateVehicle(h, 2829.2512207031, 2792.6228027344, 57.641174316406, 187.9472808837891, true, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), car, -1)
    SetVehicleFuelLevel(car, 99.9)
    spawnpierre()
end


function spawnpierre()
    local props = "rock_4_cl_2_2"
    local objects = GetHashKey(props)
    RequestModel(objects)
    while not HasModelLoaded(objects) do Wait(0) end
    local posfe = ConfigMineur.PointRecolte[math.random(1, #ConfigMineur.PointRecolte)]  ---- Prend une position aléatoire
    rock = CreateObject(objects, posfe.x, posfe.y, posfe.z - 0.9, true, false, false) ---- Crée l'objet
    PlaceObjectOnGroundProperly(rock) --- Place l'objet au sol

    blip = AddBlipForEntity(rock)
    SetBlipSprite (blip, ConfigJardinier.Jardinier.BlipsAleatoire.model)
    SetBlipDisplay(blip, 4) 
    SetBlipScale(blip, ConfigJardinier.Jardinier.BlipsAleatoire.taille)
    SetBlipColour (blip, ConfigJardinier.Jardinier.BlipsAleatoire.couleur)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Pierre à tailler')
    EndTextCommandSetBlipName(blip)
    recoltepierre(rock)
end


function recoltepierre(rock)
    CreateThread(function()
        while true do 
            local playerCoords = GetEntityCoords(PlayerPedId())
            local rockCoords = GetEntityCoords(rock)
            local distance = #(playerCoords - rockCoords)
            
            if distance <= 5 then
                DrawMarker(22, rockCoords.x, rockCoords.y, rockCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 30, 255, 0, 155)
                wait = 0
                if distance <= 1.5 then
                    ESX.ShowHelpNotification("Appuyez sur E pour tailler la pierre")
                    -- TriggerEvent("ui:showInteraction", "E", " pour tailler la pierre")
                    if IsControlJustPressed(1, 51) then
                        SetBlockingOfNonTemporaryEvents(PlayerPedId(), true)
                        FreezeEntityPosition(PlayerPedId(), true)
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)
                        Wait(4000)
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                        TriggerServerEvent('Meta_dev:paiementmineur')
                        DeleteEntity(rock)
                        spawnpierre()
                        return recoltepierre
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
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mineur' then 
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, ConfigMineur.Position.pos.x, ConfigMineur.Position.pos.y, ConfigMineur.Position.pos.z)
        if dist3 <= 1.0 then
            Timer = 0
            end
            if dist3 <= 5.0 then
                Timer = 0   
                DrawMarker(ConfigEmploie.Position.Emploie.marker, ConfigMineur.Position.pos.x, ConfigMineur.Position.pos.y, ConfigMineur.Position.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfigEmploie.LargeurX, ConfigEmploie.LargeurY, ConfigEmploie.LargeurZ, ConfigEmploie.colorR, ConfigEmploie.colorG, ConfigEmploie.colorB, ConfigEmploie.Opacity, ConfigEmploie.MarkerSaute, true, 2, ConfigEmploie.MarkerTourne, nil, nil, false)
                    ESX.ShowHelpNotification(ConfigMineur.Position.text)
                    -- TriggerEvent("ui:showInteraction", "E", ConfigMineur.Position.text)
                    if IsControlJustPressed(1,51) then
                        OpenMenuMineur()
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
--     local blip1 = AddBlipForCoord(ConfigMineur.Mineur.Blips.pos) -- remplacer les coordonnés
--     SetBlipSprite(blip1, ConfigMineur.Mineur.Blips.model) -- Model du blip
--     SetBlipDisplay(blip1, 4)
--     SetBlipScale(blip1, ConfigMineur.Mineur.Blips.taille) -- Taille du blip
--     SetBlipColour(blip1, ConfigMineur.Mineur.Blips.couleur) -- Couleur du blip
--     SetBlipAsShortRange(blip1, true)
--     BeginTextCommandSetBlipName('STRING')
--     AddTextComponentSubstringPlayerName(ConfigMineur.Mineur.Blips.nom) -- Nom du blips
--     EndTextCommandSetBlipName(blip1)
-- end)

--------------------------------------------------------------------------------------------------------------------------
                                    -- [ PED] --
--------------------------------------------------------------------------------------------------------------------------


CreateThread(function()
    local hash = GetHashKey("ig_floyd")
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "ig_floyd", 2833.386, 2795.333, 56.4951, 100.22673797607422, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)

    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
end)