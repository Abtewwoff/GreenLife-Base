RegisterNetEvent('GreenLife:Society:RequestDirtyMoney')
AddEventHandler('GreenLife:Society:RequestDirtyMoney', function(societyName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            TriggerClientEvent('GreenLife:Society:ReceiveDirtyMoney', xPlayer.source, society:GetDirtyMoney())
        else
            DropPlayer(xPlayer.source, "[GreenLifeHud] Trying to get money from society storage")
        end
    end

end)