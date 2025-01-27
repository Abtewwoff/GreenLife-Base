CreateThread(function()
    while true do
        TriggerClientEvent('ui:update', -1, GetNumPlayerIndices())
        Wait(10500)
    end
end)