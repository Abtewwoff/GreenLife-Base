RegisterNetEvent('GreenLife:GangBuilder:ReceiveMembres')
AddEventHandler('GreenLife:GangBuilder:ReceiveMembres', function(membres)
    MOD_GangBuilder:SetMembres(membres)
end)