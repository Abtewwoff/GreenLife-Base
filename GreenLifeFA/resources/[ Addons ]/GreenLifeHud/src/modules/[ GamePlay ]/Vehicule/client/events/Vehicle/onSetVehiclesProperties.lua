RegisterNetEvent('GreenLife:Vehicle:SetVehicleProperties')
AddEventHandler('GreenLife:Vehicle:SetVehicleProperties', function(netId, properties)
    local timer = GetGameTimer()
    while not NetworkDoesEntityExistWithNetworkId(tonumber(netId)) do
        Wait(3)
        if GetGameTimer() - timer > 10000 then
            return
        end
    end

    local vehicle = NetToVeh(tonumber(netId))
    local timer = GetGameTimer()
    while NetworkGetEntityOwner(vehicle) ~= PlayerId() do
        Wait(3)
        if GetGameTimer() - timer > 10000 then
            return
        end
    end

    API_Vehicles:setProperties(vehicle, properties)
end)