--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local tablearmesachat = {}
havePPA = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)
        Wait(10)
    end  

    if Config.Ammunation.showBlip then
        for k,v in pairs(Config.Ammunation.Positions.interactionZone) do
            local blip = AddBlipForCoord(v.pos)
            SetBlipSprite(blip, Config.Ammunation.Positions.infoBlip.Sprite)
            SetBlipDisplay(blip, Config.Ammunation.Positions.infoBlip.Display)
            SetBlipScale(blip, Config.Ammunation.Positions.infoBlip.Scale)
            SetBlipColour(blip, Config.Ammunation.Positions.infoBlip.Color)
            SetBlipAsShortRange(blip, Config.Ammunation.Positions.infoBlip.Range)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Ammunation.Positions.infoBlip.Name)
            EndTextCommandSetBlipName(blip)                    
        end
    end

    while true do
        local interval = 1000

        for k,v in pairs(Config.Ammunation.Positions.interactionZone) do
            local myCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(myCoords-interactionPos) < 1.0 then
                interval = 0
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à l'armurerie")
                if IsControlJustReleased(0, 51) then
                    Wait(100)
                    AmmunationMenu()
                end
            elseif #(myCoords-interactionPos) < 10.0 then 
                interval = 0
                DrawMarker(Config.Get.Marker.Type, interactionPos, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], 30, 255, 0, 170, 0, 1, 0, 0, nil, nil, 0)
            end
        end
        Wait(interval)
    end
end)

RegisterNetEvent('ammu:addBank')
AddEventHandler('ammu:addBank', function(xPlayer)
    for k,v in pairs(tablearmesachat) do
        table.remove(tablearmesachat, k)
    end
end)

RegisterNetEvent('ammu:removeBank')
AddEventHandler('ammu:removeBank', function(source)
    for k,v in pairs(tablearmesachat) do
        table.remove(tablearmesachat, k)
    end
end)

RegisterNetEvent('useMunitions')
AddEventHandler('useMunitions', function()
	local playerPed = PlayerPedId()
	if IsPedArmed(playerPed, 4) then
		local hash = GetSelectedPedWeapon(playerPed)
        local modelWeapon = 416676503
        local modelGroupe = GetWeapontypeGroup(hash)
        if modelGroupe == modelWeapon then
            if hash then
                TriggerServerEvent('removeMunitions', 1)
                AddAmmoToPed(playerPed, hash, 1)
                ESX.ShowNotification("Vous avez ~g~utilisé~s~ 1x munitions")
            else
                ESX.ShowNotification("~r~Action Impossible~s~ : Vous n'avez pas d'arme en main !")
            end
        else
            ESX.ShowNotification("~r~Action Impossible~s~ : Ce type de munition ne convient pas !")
        end
	else
		ESX.ShowNotification("~r~Action Impossible~s~ : Ce type de munition ne convient pas !")
	end
end)


RegisterNetEvent('useChargeur')
AddEventHandler('useChargeur', function()
	local playerPed = PlayerPedId()
	if IsPedArmed(playerPed, 4) then
		local hash = GetSelectedPedWeapon(playerPed)
        local modelWeapon = 416676503
        local modelGroupe = GetWeapontypeGroup(hash)
        if hash then
            TriggerServerEvent('removeChargeur', 12)
            AddAmmoToPed(playerPed, hash, 12)
            ESX.ShowNotification("Vous avez ~g~utilisé~s~ 1x chargeur (x12)")
        else
            ESX.ShowNotification("~r~Action Impossible~s~ : Vous n'avez pas d'arme en main !")
        end
	else
		ESX.ShowNotification("~r~Action Impossible~s~ : Ce type de munition ne convient pas !")
	end
end)

RegisterCommand("getpos", function(source, args, raw)
	local ped = GetPlayerPed(PlayerId())
	local coords = GetEntityCoords(ped, false)
	local heading = GetEntityHeading(ped)
	Citizen.Trace(tostring("X: " .. coords.x .. " Y: " .. coords.y .. " Z: " .. coords.z .. " HEADING: " .. heading))
end, false)