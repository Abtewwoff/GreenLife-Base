function MOD_inventory:loadSocietyInventory(jobName, data, slots, maxweight, class)
    self.InventoryCache.society[jobName] = _GreenLifeInventory('coffresociety', data, nil, slots, maxweight, class)

    return (self.InventoryCache.society[jobName])
end