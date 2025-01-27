RegisterNetEvent('GreenLife:Society:ReceiveMoney')
AddEventHandler('GreenLife:Society:ReceiveMoney', function(number)
    MOD_Society:SetMoney(number)
end)