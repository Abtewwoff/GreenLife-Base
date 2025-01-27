CreateThread(function()
    while (true) do
        TriggerClientEvent('GreenLife:Hud:UpdatePlayersCount', -1, GetNumPlayerIndices())

        Wait(10000)
    end
end)