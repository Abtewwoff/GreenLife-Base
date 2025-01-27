RegisterNetEvent('GreenLife:Inventory:ClosePlayerInventory')
AddEventHandler('GreenLife:Inventory:ClosePlayerInventory', function()
    MOD_inventory.class:closeInventory()
end)

exports("CloseInventory", function()
    MOD_inventory.class:closeInventory()
end)