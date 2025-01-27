local FirstUpdate = true
RegisterNetEvent('GreenLife:Inventory:UpdatePlayerInventory')
AddEventHandler('GreenLife:Inventory:UpdatePlayerInventory', function(data, clothes, weight, maxWeight)
    MOD_inventory.class:setPlayerInventory(data, clothes, weight, maxWeight)
    
    if (FirstUpdate) then
        TriggerEvent('GreenLife:PlayerHasBeenLoadedSkin')
        FirstUpdate = false
    end
end)