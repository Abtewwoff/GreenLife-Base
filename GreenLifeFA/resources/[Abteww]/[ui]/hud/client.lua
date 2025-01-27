local uiFaded = false
local ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end

	while ESX.GetPlayerData().job2 == nil do
		Wait(10)
	end

	local xPlayer = ESX.GetPlayerData()

	while not FirstActivate do 
		Wait(2000)
		SendNUIMessage({
			SendNUIMessage({
				action = 'setInfos',
				job_name = 'job',
				job_value = ('%s - %s'):format(xPlayer.job.label, xPlayer.job.grade_label),
				job2_name = 'job2',
				job2_value = ('%s - %s'):format(xPlayer.job2.label, xPlayer.job2.grade_label)
			}),
			SendNUIMessage({
				action = 'setId',
				value = GetPlayerServerId(PlayerId())
			})
		})
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	SendNUIMessage({
		action = 'setInfos',
		job_name = 'job',
		job_value = ('%s - %s'):format(xPlayer.job.label, xPlayer.job.grade_label),
		job2_name = 'job2',
		job2_value = ('%s - %s'):format(xPlayer.job2.label, xPlayer.job2.grade_label)
	})
	SendNUIMessage({
		action = 'setId',
		value = GetPlayerServerId(PlayerId())
	})
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    SendNUIMessage({
        action = 'setInfos',
        job_name = 'job',
        job_value = ('%s - %s'):format(job.label, job.grade_label),
    })
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    SendNUIMessage({
        action = 'setInfos',
        job2_name = 'job2',
        job2_value = ('%s - %s'):format(job2.label, job2.grade_label)
    })
end)


nbPlayerTotal = 0
RegisterNetEvent("ui:update")
AddEventHandler("ui:update", function(nbPlayerTotal)
	SendNUIMessage({
		type = "online-count",
		onlineCount = nbPlayerTotal
	})
end)

AddEventHandler('tempui:toggleUi', function(value)
	uiFaded = value

	if uiFaded then
		SendNUIMessage({action = 'fadeUi', value = true})
	else
		SendNUIMessage({action = 'fadeUi', value = false})
	end
end)

RegisterNUICallback('firstactivate', function()
	FirstActivate = true
end)

Citizen.CreateThread(function()
	local uiComponents = {'infos', 'statuts'}
	local inFrontend = false

	SendNUIMessage({action = 'hideUi', value = false})

	for i = 1, #uiComponents, 1 do
		SendNUIMessage({action = 'hideComponent', component = uiComponents[i], value = false})
	end

	while true do
		Wait(250)

		HideHudComponentThisFrame(1) -- Wanted Stars
		HideHudComponentThisFrame(2) -- Weapon Icon
		HideHudComponentThisFrame(3) -- Cash
		HideHudComponentThisFrame(4) -- MP Cash
		HideHudComponentThisFrame(6) -- Vehicle Name
		HideHudComponentThisFrame(7) -- Area Name
		HideHudComponentThisFrame(8) -- Vehicle Class
		HideHudComponentThisFrame(9) -- Street Name
		HideHudComponentThisFrame(13) -- Cash Change
		HideHudComponentThisFrame(17) -- Save Game
		HideHudComponentThisFrame(20) -- Weapon Stats

		if not uiFaded then
			if IsPauseMenuActive() or IsPlayerSwitchInProgress() then
				if not inFrontend then
					inFrontend = true
					SendNUIMessage({action = 'hideUi', value = true})
				end
			else
				if inFrontend then
					inFrontend = false
					SendNUIMessage({action = 'hideUi', value = false})
				end
			end
		end
	end
end)