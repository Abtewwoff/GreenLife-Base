RegisterNetEvent('GreenLife:GangBuilder:UpdateGang')
AddEventHandler('GreenLife:GangBuilder:UpdateGang', function(type, data)
    MOD_GangBuilder.data[type] = data
end)