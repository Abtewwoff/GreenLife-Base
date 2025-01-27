RegisterNetEvent('GreenLife:GangBuilder:GetParkVehicule')
AddEventHandler('GreenLife:GangBuilder:GetParkVehicule', function(gangId)
    local veh = GetVehiclePedIsIn(PlayerPedId())

    if (veh) then
        TriggerServerEvent('GreenLife:GangBuilder:ParkVehicule', GetVehicleNumberPlateText(veh), gangId, API_Vehicles:getProperties(veh))
    end
end)