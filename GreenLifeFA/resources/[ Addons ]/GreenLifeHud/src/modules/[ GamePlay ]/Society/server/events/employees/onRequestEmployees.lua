RegisterNetEvent('GreenLife:Society:RequestEmployees')
AddEventHandler('GreenLife:Society:RequestEmployees', function(societyName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            TriggerClientEvent('GreenLife:Society:ReceiveEmployees', xPlayer.source, society:GetEmployees())
        else
            DropPlayer(xPlayer.source, "[GreenLifeHud] Trying to get money from society storage")
        end
    end
end)