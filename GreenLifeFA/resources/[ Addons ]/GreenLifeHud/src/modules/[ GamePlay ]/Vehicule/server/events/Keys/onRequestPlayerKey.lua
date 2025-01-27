RegisterNetEvent('GreenLife:Keys:RequestPlayerKey')
AddEventHandler('GreenLife:Keys:RequestPlayerKey', function(vehiclePlate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehicle = MOD_Vehicle:GetVehicleByPlate(vehiclePlate)

    if (xPlayer) then
        if (vehicle) then
            if (vehicle:IsPlayerHasKey(xPlayer)) then
                TriggerClientEvent('GreenLife:Keys:VehiclePlayerKey', xPlayer.source)
            end
        end
    end
end)