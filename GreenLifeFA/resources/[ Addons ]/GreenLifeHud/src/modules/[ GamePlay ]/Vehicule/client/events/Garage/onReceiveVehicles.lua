RegisterNetEvent('GreenLife:Garage:ReceiveVehicles')
AddEventHandler('GreenLife:Garage:ReceiveVehicles', function(vehicles)
    MOD_Vehicle.Garage.vehicles = vehicles
end)