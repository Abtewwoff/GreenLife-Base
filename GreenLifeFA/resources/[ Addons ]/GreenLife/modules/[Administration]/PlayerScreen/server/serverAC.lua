local webhook = 'https://discord.com/api/webhooks/1328013551574716438/0TmssoEjj1Caz7MH7qSN883PCbAsS9wmU3h1mzYLPxrKbE91_jxw9yxNtwdgHF0PpbL0'

ESX.RegisterServerCallback('screenshot:getwebhook', function(source, cb)
    cb('https://discord.com/api/webhooks/1328013551574716438/0TmssoEjj1Caz7MH7qSN883PCbAsS9wmU3h1mzYLPxrKbE91_jxw9yxNtwdgHF0PpbL0')
end)

RegisterNetEvent("GameCore:TakeScreen")
AddEventHandler("GameCore:TakeScreen", function(source)
    TriggerClientEvent('GameCore:GetScreen', source)
end)

ESX.AddGroupCommand('screen', 'admin', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(args[1])
    local sourcePlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Screen Joueurs", content = "----Début des screen du joueur "..xPlayer.name.." demander par "..sourcePlayer.name.."----"}), { ['Content-Type'] = 'application/json' })
        Wait(2000)
	    TriggerEvent('GameCore:TakeScreen', args[1])
        Wait(4000)
        TriggerEvent('GameCore:TakeScreen', args[1])
        Wait(4000)
        TriggerEvent('GameCore:TakeScreen', args[1])
        Wait(4000)
        TriggerEvent('GameCore:TakeScreen', args[1])
        Wait(4000)
        TriggerEvent('GameCore:TakeScreen', args[1])
        Wait(4000)
        TriggerEvent('GameCore:TakeScreen', args[1])
        Wait(2000)
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Screen Joueurs", content = "----Fin des screen du joueur "..xPlayer.name.." demander par "..sourcePlayer.name.."----"}), { ['Content-Type'] = 'application/json' })
    else
        ESX.ChatMessage(source, "Le joueur n'est pas en ligne.")
    end
end, {help = "screen", params = {
    {name = "screen", help = "ID du joueurs"}
}})