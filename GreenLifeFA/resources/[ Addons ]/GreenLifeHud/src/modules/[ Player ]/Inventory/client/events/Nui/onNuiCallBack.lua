RegisterNUICallback('nui:GreenLife:Inventory:Settings', function(settings)
    MOD_inventory.class:setSettingsInventory(settings)
end)


RegisterNUICallback('nui:GreenLife:Inventory:InvMoveInside', function(data)
    TriggerServerEvent('GreenLife:Inventory:InvMoveInside', data)
end)


RegisterNUICallback('nui:GreenLife:Inventory:InvMoveToMain', function(data)
    TriggerServerEvent('GreenLife:Inventory:InvMoveToMain', data)
end)
RegisterNUICallback('nui:GreenLife:Inventory:InvMoveToSecond', function(data)
    TriggerServerEvent('GreenLife:Inventory:InvMoveToSecond', data)
end)


RegisterNUICallback('nui:GreenLife:Inventory:InvMoveInstantToMain', function(data)

end)
RegisterNUICallback('nui:GreenLife:Inventory:InvMoveInstantToSecond', function(data)

end)


RegisterNUICallback('nui:GreenLife:Inventory:InvMoveToWeapons', function(data)
    TriggerServerEvent('GreenLife:Inventory:InvMoveToWeapons', data)
end)
RegisterNUICallback('nui:GreenLife:Inventory:MoveWeaponsToInv', function(data)
    TriggerServerEvent('GreenLife:Inventory:MoveWeaponsToInv', data)
end)
RegisterNUICallback('nui:GreenLife:Inventory:MoveWeaponsInside', function(data)
    TriggerServerEvent('GreenLife:Inventory:MoveWeaponsInside', data)
end)


RegisterNUICallback('nui:GreenLife:Inventory:InvUseItem', function(index)
    if (MOD_inventory.class.inventoryItems[index].type == "weapons") then
        if (not exports['GreenLife']:checkIfPlayerIsInSafeZone()) then
            TriggerServerEvent('GreenLife:Inventory:InvUseItem', index, false)
        end
    else
        TriggerServerEvent('GreenLife:Inventory:InvUseItem', index)
    end
end)
RegisterNUICallback('nui:GreenLife:Inventory:InvGiveItem', function(data)
    MOD_inventory.class:closeInventory()
    MOD_inventory.class:loadGiveItem(data)
end)
RegisterNUICallback('nui:GreenLife:Inventory:InvDeleteItem', function(data)
    TriggerServerEvent('GreenLife:Inventory:InvDeleteItem', data)
end)



------ CLOTHES
RegisterNUICallback('nui:GreenLife:Inventory:InvMoveToClothes', function(data)
    if (MOD_inventory.ClohtesOnAnim) then return end

    TriggerServerEvent('GreenLife:Inventory:InvMoveToClothes', data)
end)

RegisterNUICallback('nui:GreenLife:Inventory:InvMoveClothesToMain', function(data)
    if (MOD_inventory.ClohtesOnAnim) then return end

    TriggerServerEvent('GreenLife:Inventory:InvMoveClothesToMain', data)
end)
RegisterNUICallback('nui:GreenLife:Inventory:InvMoveClothesToSecond', function(data)
    TriggerServerEvent('GreenLife:Inventory:InvMoveClothesToSecond', data)
end)