RegisterNetEvent('GreenLife:Zones:onRemoveAllZoneJobType')
AddEventHandler('GreenLife:Zones:onRemoveAllZoneJobType', function(jobType)
    MOD_Zones:deleteAllByJobType(jobType)
end)