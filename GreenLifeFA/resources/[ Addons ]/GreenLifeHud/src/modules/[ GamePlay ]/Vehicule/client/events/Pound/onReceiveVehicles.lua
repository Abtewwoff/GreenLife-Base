RegisterNetEvent('GreenLife:Pound:ReceiveVehicles')
AddEventHandler('GreenLife:Pound:ReceiveVehicles', function(vehicles)
    MOD_Vehicle.Pound.vehicles = vehicles
end)