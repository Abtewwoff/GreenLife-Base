GreenLife:OnJobChange(function(typeJob, job)
    TriggerServerEvent('GreenLife:Zones:ChangePlayerJob', typeJob, job)
end)