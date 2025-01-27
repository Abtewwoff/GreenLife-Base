RegisterNetEvent('GreenLife:GangBuilder:RequestGrades')
AddEventHandler('GreenLife:GangBuilder:RequestGrades', function(gangId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gang = MOD_GangBuilder:getGangById(gangId)

    if (Gang) then
        if (Gang:DoesPlayerExist(xPlayer)) then
            TriggerClientEvent('GreenLife:GangBuilder:ReceiveGrades', xPlayer.source, Gang:GetAllGrades())
        end
    end
end)