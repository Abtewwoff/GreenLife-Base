RegisterNetEvent('GreenLife:GangBuilder:PoundReceiveVehicles')
AddEventHandler('GreenLife:GangBuilder:PoundReceiveVehicles', function(vehicles)
    MOD_GangBuilder.data.pound.vehicles = vehicles
end)