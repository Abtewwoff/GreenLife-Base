RegisterNetEvent('GreenLife:Zones:ChangePlayerJob')
AddEventHandler('GreenLife:Zones:ChangePlayerJob', function(type, job)
    TriggerClientEvent('GreenLife:Zones:onRemoveAllZoneJobType', source, type)

    MOD_Zones:loadZonesByJob(source, job)
end)