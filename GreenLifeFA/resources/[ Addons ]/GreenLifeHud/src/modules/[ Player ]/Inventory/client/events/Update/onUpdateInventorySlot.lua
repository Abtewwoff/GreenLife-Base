RegisterNetEvent('GreenLife:Inventory:UpdatePlayerSlot')
AddEventHandler('GreenLife:Inventory:UpdatePlayerSlot', function(fromData, toData, weight, maxWeight)
    MOD_inventory.class:updateInventorySlot(fromData, toData, weight, maxWeight)
end)