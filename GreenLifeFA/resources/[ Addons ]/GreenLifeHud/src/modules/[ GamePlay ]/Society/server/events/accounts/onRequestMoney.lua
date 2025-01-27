RegisterNetEvent('GreenLife:Society:RequestMoney')
AddEventHandler('GreenLife:Society:RequestMoney', function(societyName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            TriggerClientEvent('GreenLife:Society:ReceiveMoney', xPlayer.source, society:GetMoney())
        else
            DropPlayer(xPlayer.source, "[GreenLifeHud] Trying to get money from society storage")
        end
    end

end)