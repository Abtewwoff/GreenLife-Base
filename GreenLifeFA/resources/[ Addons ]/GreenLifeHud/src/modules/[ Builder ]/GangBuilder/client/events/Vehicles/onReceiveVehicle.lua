RegisterNetEvent('GreenLife:GangBuilder:ReceiveVehicle')
AddEventHandler('GreenLife:GangBuilder:ReceiveVehicle', function(plate, vehicle)
    MOD_GangBuilder:SetVehicle(plate, vehicle)
end)