function _GreenLifeVehicule:SetProperties(properties, xPlayer, callback)
    -- local src = NetworkGetEntityOwner(self.handle);

    -- if (type(src) == 'number' and src > 0) then
    --     TriggerClientEvent('GreenLife:Vehicle:SetVehicleProperties', xPlayer.source, self:GetNetworkId(), properties)
        
    --     if (callback) then callback(self.properties) end
    -- else
    --     if (callback) then callback(self.properties) end
    -- end

    
    TriggerClientEvent('GreenLife:Vehicle:SetVehicleProperties', xPlayer.source, self:GetNetworkId(), properties)

    if (callback) then callback(self.properties) end
end