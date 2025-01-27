RegisterNetEvent('GreenLife:Zones:RemoveZone')
AddEventHandler('GreenLife:Zones:RemoveZone', function(zoneId)
    MOD_Zones:delete(zoneId)
end)