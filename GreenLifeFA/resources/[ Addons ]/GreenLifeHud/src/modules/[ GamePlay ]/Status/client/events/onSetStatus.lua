RegisterNetEvent('GreenLife:Status:SetStatus')
AddEventHandler('GreenLife:Status:SetStatus', function(status)
    for name, value in pairs(status) do
        MOD_Status:setStatus(name, value)
    end
end)