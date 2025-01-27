RegisterNetEvent('GreenLife:GangBuilder:ReceiveGrades')
AddEventHandler('GreenLife:GangBuilder:ReceiveGrades', function(grades)
    MOD_GangBuilder:SetGrades(grades)
end)