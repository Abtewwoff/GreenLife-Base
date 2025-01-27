RegisterNetEvent('GreenLife:GangBuilder:ReceiveVehicles')
AddEventHandler('GreenLife:GangBuilder:ReceiveVehicles', function(vehicles)
    MOD_GangBuilder:SetVehicles(vehicles)
end)