function _GreenLifeInventory:updateInventory()
    self:reloadWeight()

    TriggerClientEvent('GreenLife:Inventory:UpdatePlayerInventory', self.class.source, self.inventoryItems, self.inventoryClothes, self.weight, self.maxweight)

end