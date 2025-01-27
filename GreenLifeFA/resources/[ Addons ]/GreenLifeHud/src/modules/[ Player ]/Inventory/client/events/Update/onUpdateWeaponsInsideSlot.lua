RegisterNetEvent('GreenLife:Inventory:UpdateWeaponsInsideSlot')
AddEventHandler('GreenLife:Inventory:UpdateWeaponsInsideSlot', function(FromData, ToData, weight, maxWeight)
    MOD_inventory.class:updateWeaponsInsideSlot(FromData, ToData, weight, maxWeight)
end)