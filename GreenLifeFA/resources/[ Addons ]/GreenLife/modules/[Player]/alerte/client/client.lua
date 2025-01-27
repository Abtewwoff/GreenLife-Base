ESX = exports['Framework']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local timing, isPlayerWhitelisted = math.ceil(500 / 2), false
local streetName

CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

CreateThread(function()
	while true do
		Wait(2500)
		if NetworkIsSessionStarted() then
			DecorRegister('isOutlaw', 3)
			DecorSetInt(PlayerPedId(), 'isOutlaw', 1)
		end
		
		local playerCoords = GetEntityCoords(PlayerPedId())
		local streetHash, _ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetHash)
	end
end)

function refreshPlayerWhitelisted()
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end
	
    jobAcces = {"police", "fbi", "bsco"}
	for _, v in ipairs(jobAcces) do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end


CreateThread(function()
	while true do
		Wait(2000)

		if DecorGetInt(PlayerPedId(), 'isOutlaw') == 2 then
			Wait(timing)
			DecorSetInt(PlayerPedId(), 'isOutlaw', 1)
		end
	end
end)

CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local msec = 600
		isPlayerWhitelisted = refreshPlayerWhitelisted()

		msec = 0
		if IsPedShooting(playerPed) and not IsPedCurrentWeaponSilenced(playerPed) and Config.Police.GunshotAlert then
			Wait(3000)
			if (isPlayerWhitelisted and Config.Police.ShowCopsMisbehave) or not isPlayerWhitelisted then
				DecorSetInt(playerPed, 'isOutlaw', 2)
				local streetHash, _ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
				streetName = GetStreetNameFromHashKey(streetHash)
	
				TriggerServerEvent('Abteww:Alerte:GunShoot', {
					x = ESX.Math.Round(playerCoords.x, 1),
					y = ESX.Math.Round(playerCoords.y, 1),
					z = ESX.Math.Round(playerCoords.z, 1)
				}, streetName)
			end
		end

		Wait(msec)
	end
end)

RegisterNetEvent('Abteww:Alerte:showAlertOptions')
AddEventHandler('Abteww:Alerte:showAlertOptions', function(targetCoords)
    ESX.ShowNotification("~g~Y~s~ : Pour accepeter l'appel<br/>~r~X~s~ : Pour refuser l'appel")

    CreateThread(function()
        local accepted = false
        while not accepted do
            Wait(0)
            if IsControlJustPressed(0, 246) then
                accepted = true
				SetNewWaypoint(targetCoords.x, targetCoords.y)
                ESX.ShowNotification("Vous avez accepté l'appel.")
            elseif IsControlJustPressed(0, 306) then
                accepted = true
				RemoveBlip(alertBlip)
                ESX.ShowNotification("Vous avez refusé l'appel.")
            end
        end
    end)
end)


RegisterNetEvent('Abteww:Alerte:GunAlert')
AddEventHandler('Abteww:Alerte:GunAlert', function(targetCoords)
	local alertBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
	SetBlipSprite(alertBlip, 161)
	SetBlipScale(alertBlip, 1.2)
	SetBlipColour(alertBlip, 1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Lieu de l'incident")
	EndTextCommandSetBlipName(alertBlip)
	SetBlipRoute(alertBlip, true)
	SetBlipRouteColour(alertBlip, 1)

	Wait(4000)

	TriggerEvent('Abteww:Alerte:showAlertOptions', targetCoords)

	Wait(7000)
	RemoveBlip(alertBlip)
end)

RegisterNetEvent('Abteww:Alerte:Notify')
AddEventHandler('Abteww:Alerte:Notify', function(alert, targetCoords)
    if isPlayerWhitelisted then
        ESX.ShowAdvancedNotification('LSPD', 'Alerte', alert, 'CHAR_CALL911', 1)
        TriggerEvent('Abteww:Alerte:GunAlert', targetCoords)
    end
end)
