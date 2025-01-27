eUtils = {}

eUtils.GetDistance = function(source, position, distance, eventName, security, onAccepted, onRefused)
    if #(GetEntityCoords(GetPlayerPed(source)) - position) < distance then
        onAccepted();
    else
        onRefused();
        if security then
            local xPlayer = ESX.GetPlayerFromId(source)
            GreenLifeLogs('https://discord.com/api/webhooks/1226437571584856085/3MWq9WT-RMFD1XDh22sPcLNEZ5UsctK0DXDLHUwalA2edwZPr05a7VcKxGdvT3nqaCiF', "AntiCheat","**"..GetPlayerName(source).."** vient d'etre Kick \n**License** : "..xPlayer.identifier..'\nEvent : '..eventName, 56108)
            DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat [' ..eventName..']')
        end
    end
end
