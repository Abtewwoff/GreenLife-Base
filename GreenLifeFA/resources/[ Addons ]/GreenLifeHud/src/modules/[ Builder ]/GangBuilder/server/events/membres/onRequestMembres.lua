RegisterNetEvent('GreenLife:GangBuilder:RequestMembres')
AddEventHandler('GreenLife:GangBuilder:RequestMembres', function(gangId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gang = MOD_GangBuilder:getGangById(gangId)

    if (Gang) then
        if (Gang:DoesPlayerExist(xPlayer)) then
            TriggerClientEvent('GreenLife:GangBuilder:ReceiveMembres', xPlayer.source, Gang:GetAllMembre())
        end
    end
end)