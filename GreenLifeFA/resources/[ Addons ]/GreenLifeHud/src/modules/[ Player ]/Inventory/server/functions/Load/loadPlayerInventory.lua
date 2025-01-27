function MOD_inventory:loadPlayerInventory(licence, dataInv, dataClothes, slots, maxweight, class)
    MOD_inventory.InventoryCache.player[licence] = _GreenLifeInventory('player', dataInv, dataClothes, slots, maxweight, class)

    return (MOD_inventory.InventoryCache.player[licence])
end