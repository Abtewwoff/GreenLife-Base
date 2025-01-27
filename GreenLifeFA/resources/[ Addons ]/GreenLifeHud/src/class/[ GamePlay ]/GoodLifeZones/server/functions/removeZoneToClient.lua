function _GreenLifeZones:removeZoneToClient(source)
    TriggerClientEvent('GreenLife:Zones:RemoveZone', source, self.id)
end