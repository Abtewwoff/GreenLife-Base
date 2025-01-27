function _GreenLifeInventory:updateWeaponsSlot(indexInv, InvData, indexWeapons, WeaponsData)
    self:reloadWeight()

    local InvData = { index = indexInv, data = InvData }
    local WeaponsData = { index = indexWeapons, data = WeaponsData }
    
    if (self.type == 'player') then
        TriggerClientEvent('GreenLife:Inventory:UpdateWeaponsSlot', self.class.source, InvData, WeaponsData, self.weight, self.maxweight)
    end
end