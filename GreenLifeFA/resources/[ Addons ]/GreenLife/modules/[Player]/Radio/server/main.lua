RegisterNetEvent('tonio:haveRadio')
AddEventHandler('tonio:haveRadio', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local items = xPlayer.getInventoryItem('radio')

    if items then
        TriggerClientEvent("radioGood", source, true)
    else
       TriggerClientEvent("radioGood", source, false)
    end
end)


