RegisterNetEvent('GreenLife:Society:RequestGrades')
AddEventHandler('GreenLife:Society:RequestGrades', function(societyName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            TriggerClientEvent('GreenLife:Society:ReceiveGrades', xPlayer.source, society:GetGrades())
        else
            DropPlayer(xPlayer.source, "[GreenLifeHud] Trying to get money from society storage")
        end
    end
end)