RegisterServerEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    TriggerClientEvent('GreenLife:Hud:UpdatePlayersCount', source, GetNumPlayerIndices())
end)