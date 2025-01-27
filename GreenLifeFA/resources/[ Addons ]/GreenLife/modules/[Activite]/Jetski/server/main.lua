RegisterNetEvent('h4ci:locajetski')
AddEventHandler('h4ci:locajetski', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local argentdujoueurcash = xPlayer.getAccount('cash').money
    local prix = 5000
    if argentdujoueurcash >= prix then
        xPlayer.removeAccountMoney('cash', 5000)
        TriggerClientEvent('GreenLifePass:addtaskcount:standart', source, 11, 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Jetski obtenu ! ~r~-5.000$")
    else
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas asser d\'argent.')
    end
end)