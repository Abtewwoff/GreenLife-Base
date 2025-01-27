RegisterNetEvent('GreenLife:Society:ReceiveGrades')
AddEventHandler('GreenLife:Society:ReceiveGrades', function(grades)
    MOD_Society:SetGrades(grades)
end)