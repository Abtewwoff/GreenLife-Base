local RecompenceVIP = 10
local jobsData = {};

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    PlayerData = xPlayer

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

RegisterNetEvent('jobbuilder:restarted', function(player)

    ESX.PlayerData = player
    PlayerData = xPlayer

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end);

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

local JobBuilder = {
    Recolte = {},
    Traitement = {},
    Vente = {}
};

-- Récolte

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        for k,v in pairs(jobsData) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Name then
                local plyPos = GetEntityCoords(PlayerPedId())
                local Recolte = vector3(json.decode(v.PosRecolte).x, json.decode(v.PosRecolte).y, json.decode(v.PosRecolte).z)
                local dist = #(plyPos-Recolte)
                if dist <= 20.0 then
                    Timer = 0
                    DrawMarker(2, Recolte, 0, 0, 0, 0.0, nil, nil, 0.2, 0.2, 0.2, 0, 129, 211, 255, 0, 1, 0, 0, nil, nil, 0)
                end
                if dist <= 3.0 then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour récolter ~g~"..v.labelitemR.."")
                    if IsControlJustPressed(1,51) then
                        startHarvest(v.nameitemR)
                    end
                end
            end
        end
        Wait(Timer)
    end
end)

-- Traitement
Citizen.CreateThread(function()
    while true do
        local Timer = 500
        for k,v in pairs(jobsData) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Name then
                local plyPos = GetEntityCoords(PlayerPedId())
                local Traitement = vector3(json.decode(v.PosTraitement).x, json.decode(v.PosTraitement).y, json.decode(v.PosTraitement).z)
                local dist = #(plyPos-Traitement)
                if dist <= 20.0 then
                    Timer = 0
                    DrawMarker(2, Traitement, 0, 0, 0, 0.0, nil, nil, 0.2, 0.2, 0.2, 0, 129, 211, 255, 0, 1, 0, 0, nil, nil, 0)
                end
                if dist <= 3.0 then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour traiter ~g~"..v.labelitemR.."")
                    if IsControlJustPressed(1,51) then
                        startProcessing(v.nameitemR, v.nameitemT)
                    end
                end
            end
        end
        Wait(Timer)
    end
end)

-- Vente

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if (type(jobsData) == 'table') then
            for k,v in pairs(jobsData) do
                if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Name then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    local Vente = vector3(json.decode(v.PosVente).x, json.decode(v.PosVente).y, json.decode(v.PosVente).z)
                    local dist = #(plyPos-Vente)
                    if dist <= 20.0 then
                        Timer = 0
                        DrawMarker(2, Vente, 0, 0, 0, 0.0, nil, nil, 0.2, 0.2, 0.2, 0, 129, 211, 255, 0, 1, 0, 0, nil, nil, 0)
                    end
                    if dist <= 3.0 then
                        Timer = 0
                        ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour vendre ~g~"..v.labelitemT.."")
                        if IsControlJustPressed(1,51) then
                            startSell(v.nameitemT, v.PrixVente)
                        end
                    end
                end
            end
        end
        Wait(Timer)
    end
end)


function startHarvest(item)
    FreezeEntityPosition(PlayerPedId(), true)
    RequestAnimDict("anim@mp_snowball")
    while (not HasAnimDictLoaded("anim@mp_snowball")) do Wait(3) end
    TaskPlayAnim(PlayerPedId(),"anim@mp_snowball","pickup_snowball",1.0,-1.0, 5000, 0, 1, true, true, true)
    ESX.ShowNotification("Récolte en cours")
    Wait(1500)
    -- -- print("ca")
    TriggerServerEvent("JobBuilder:recolte", item)
    FreezeEntityPosition(PlayerPedId(), false)
end

function startProcessing(itemInProcessing, itemReward)
    FreezeEntityPosition(PlayerPedId(), true)
    ESX.ShowNotification("Traitement en cours")
    Wait(3500)
    TriggerServerEvent("JobBuilder:processing", itemInProcessing, itemReward)
    FreezeEntityPosition(PlayerPedId(), false)
end

function startSell(item, itemPriceReward)
    FreezeEntityPosition(PlayerPedId(), true)
    ESX.ShowNotification("Vente en cours")
    Wait(3500)
    TriggerServerEvent("JobBuilder:sell", item, itemPriceReward, ESX.PlayerData.job.name, ESX.PlayerData.job.label)
    FreezeEntityPosition(PlayerPedId(), false)
end