RegisterNetEvent('GreenLife:Inventory:setSecondInventory')
AddEventHandler('GreenLife:Inventory:setSecondInventory', function(inventoryItems, invName, weight, maxWeight)
    MOD_inventory.class:setSecondInventory(inventoryItems, invName, weight, maxWeight)
end)