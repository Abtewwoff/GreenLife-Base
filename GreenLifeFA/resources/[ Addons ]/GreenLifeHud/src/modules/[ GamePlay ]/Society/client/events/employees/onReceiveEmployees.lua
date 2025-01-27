RegisterNetEvent('GreenLife:Society:ReceiveEmployees')
AddEventHandler('GreenLife:Society:ReceiveEmployees', function(employees)
    MOD_Society:SetEmployees(employees)
end)