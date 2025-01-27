AddEventHandler('GreenLife:Status:RegisterStatus', function(name, default, remove)
	local StatusClass = _GreenLifeStatus(name, default, function(status)
		status:remove(remove)
	end)

    MOD_Status:add(name, StatusClass)
end)

CreateThread(function()
	TriggerEvent('GreenLife:Status:RegisterStatus', 'hunger', 1000000, 100)

	TriggerEvent('GreenLife:Status:RegisterStatus', 'thirst', 1000000, 75)
	
    MOD_Status:loadStatus()
    MOD_Status:loadUpdateServer()
end)