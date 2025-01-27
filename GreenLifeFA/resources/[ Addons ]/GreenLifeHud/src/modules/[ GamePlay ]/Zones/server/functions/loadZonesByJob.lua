function MOD_Zones:loadZonesByJob(source, job)
    local payload = {}
    for _, zone in pairs(self:getAllZones()) do
        if (zone.requireJob) then
            if (zone.requireJob.name == job.name) then
                payload[#payload + 1] = zone:minify()
            end
        end
    end

    TriggerClientEvent('GreenLife:Zones:AddZones', source, payload)
end