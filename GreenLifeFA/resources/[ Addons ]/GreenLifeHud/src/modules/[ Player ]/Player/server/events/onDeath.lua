RegisterNetEvent("GreenLife:Player:onDeath")
AddEventHandler("GreenLife:Player:onDeath", function(deathData)
    local xPlayer = ESX.GetPlayerFromId(source)

    --LOGS A METRE

    TriggerEvent("GreenLife:Player:playerDied", xPlayer.source)
end)