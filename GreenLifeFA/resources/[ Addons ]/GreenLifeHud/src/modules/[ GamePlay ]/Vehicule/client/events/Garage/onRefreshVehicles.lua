RegisterNetEvent('GreenLife:Garage:RefreshVehicles')
AddEventHandler('GreenLife:Garage:RefreshVehicles', function()
    TriggerServerEvent('GreenLife:Garage:RequestVehicles')
end)