RegisterNetEvent('GreenLife:GangBuilder:PoundRequestVehicles')
AddEventHandler('GreenLife:GangBuilder:PoundRequestVehicles', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then

        local playerGang = xPlayer.job2.name

        if (playerGang ~= "unemployed2") then
            local Gang = MOD_GangBuilder:getGangByName(playerGang)

            if (Gang) then
                if (Gang:DoesPlayerExist(xPlayer)) then
                    TriggerClientEvent('GreenLife:GangBuilder:PoundReceiveVehicles', xPlayer.source, Gang:GetVehiclesTemplate())
                end
            end
        end
    end
end)