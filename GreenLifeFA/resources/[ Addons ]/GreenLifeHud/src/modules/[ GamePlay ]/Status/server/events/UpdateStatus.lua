RegisterServerEvent('GreenLife:Status:UpdateStatus')
AddEventHandler('GreenLife:Status:UpdateStatus', function(status)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.set('status', status)
	end
end)