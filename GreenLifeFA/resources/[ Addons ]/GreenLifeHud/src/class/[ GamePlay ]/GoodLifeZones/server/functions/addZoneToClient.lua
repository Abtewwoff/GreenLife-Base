function _GreenLifeZones:addZoneToClient(source)
    TriggerClientEvent('GreenLife:Zones:AddZone', source, self:minify())
end