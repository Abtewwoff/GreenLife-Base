RegisterNetEvent('GreenLife:Pound:RefreshVehicles')
AddEventHandler('GreenLife:Pound:RefreshVehicles', function()
    TriggerServerEvent('GreenLife:Pound:RequestVehicles')
end)