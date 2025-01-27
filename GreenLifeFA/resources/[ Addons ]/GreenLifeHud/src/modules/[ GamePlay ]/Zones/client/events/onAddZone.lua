RegisterNetEvent('GreenLife:Zones:AddZone')
AddEventHandler('GreenLife:Zones:AddZone', function(zone)
    MOD_Zones:add(zone)
end)