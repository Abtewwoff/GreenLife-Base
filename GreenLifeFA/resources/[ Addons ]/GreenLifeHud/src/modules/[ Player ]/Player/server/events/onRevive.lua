RegisterNetEvent('GreenLife:Player:onRevive')
AddEventHandler('GreenLife:Player:onRevive', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerEvent("GreenLife:Player:playerRevived", xPlayer.source)
end)