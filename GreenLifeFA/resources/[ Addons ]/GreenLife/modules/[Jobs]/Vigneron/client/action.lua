local isHarvesting = false
local currentBlip = nil

function RecolteVigneron()
    local menu = RageUI.CreateMenu("", "Menu de récolte")
    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()
            RageUI.Button("→ Commencer la récolte de raisin", nil, {RightLabel = "→→→"}, not isHarvesting, {
                onSelected = function()
                    isHarvesting = true
                    StartHarvesting()
                    RageUI.CloseAll()
                end
            })
            RageUI.Button("→ Stopper la récolte de raisin", nil, {RightLabel = "→→→"}, isHarvesting, {
                onSelected = function()
                    StopHarvesting()
                    RageUI.CloseAll()
                end
            })
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType(menu)
            break
        end
    end
end

function StartHarvesting()
    GenerateNewHarvestPoint()
    CreateThread(function()
        while isHarvesting do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local dist = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, currentBlip.x, currentBlip.y, currentBlip.z)
            if dist <= 2.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du raisin")
                if IsControlJustPressed(1, 51) then
                    HarvestAnimation()
                    TriggerServerEvent("vigneron:recolte")
                    GenerateNewHarvestPoint()
                end
            end
            Wait(0)
        end
    end)
end

function StopHarvesting()
    isHarvesting = false
    if currentBlip then
        RemoveBlip(currentBlip.blip)
        currentBlip = nil
    end
    ESX.ShowNotification("Vous avez arrêté de récolter.")
end

function GenerateNewHarvestPoint()
    if currentBlip then
        RemoveBlip(currentBlip.blip)
    end

    local randomIndex = math.random(1, #Vigneron.Pos.PosRecolte)
    local randomPosition = Vigneron.Pos.PosRecolte[randomIndex]

    local blip = AddBlipForCoord(randomPosition.x, randomPosition.y, randomPosition.z)
    SetBlipSprite(blip, 1)
    SetBlipColour(blip, 2)
    SetBlipScale(blip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Point de récolte")
    EndTextCommandSetBlipName(blip)

    currentBlip = {x = randomPosition.x, y = randomPosition.y, z = randomPosition.z, blip = blip}
end

function HarvestAnimation()
    local playerPed = PlayerPedId()
    local animDict = "amb@world_human_gardener_plant@male@base"
    local animName = "base"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end

    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, 5000, 1, 0, false, false, false)
    Wait(5000)
    ClearPedTasks(playerPed)
end

local position = {
    {x = -1902.1374511719, y = 2048.8356933594, z = 140.73854064941}
}

CreateThread(function()
    while true do
        local wait = 1000
        for k in pairs(position) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            if dist <= 4.0 then
                wait = 0
                DrawMarker(6, position[k].x, position[k].y, position[k].z - 0.97, 0, 0, 0, 0, -90.2, -90.2, 0.55, 0.55, 0.60, 30, 255, 0, 255, 0, 0, 0, 0)
                if dist <= 2.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu de récolte")
                    if IsControlJustPressed(1, 51) then
                        RecolteVigneron()
                    end
                end
            end
        end
        Wait(wait)
    end
end)



-------- Traitement du raisin --------------

function TraitementVigneron()
end

------------ Vente du vin ----------------

function VenteVigneron()
end
