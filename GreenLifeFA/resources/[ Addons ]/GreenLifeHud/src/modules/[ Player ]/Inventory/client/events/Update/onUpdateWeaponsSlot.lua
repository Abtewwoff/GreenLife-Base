RegisterNetEvent('GreenLife:Inventory:UpdateWeaponsSlot')
AddEventHandler('GreenLife:Inventory:UpdateWeaponsSlot', function(InvData, WeaponsData, weight, maxWeight)
    MOD_inventory.class:updateWeaponsSlot(InvData, WeaponsData, weight, maxWeight)
end)