RegisterNetEvent('GreenLife:Society:ReceiveDirtyMoney')
AddEventHandler('GreenLife:Society:ReceiveDirtyMoney', function(number)
    MOD_Society:SetDirtyMoney(number)
end)