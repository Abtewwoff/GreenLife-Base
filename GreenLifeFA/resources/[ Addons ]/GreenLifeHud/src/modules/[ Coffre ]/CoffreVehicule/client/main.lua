RegisterKeyMapping('opencoffre', 'Ouvrir le coffre véhicule', 'keyboard', 'L')
RegisterCommand("opencoffre", function ()
    openmenuvehicle()
end)

function openmenuvehicle()
    if (MOD_inventory.class:getPlayerInInventory()) then return end

    local playerCoords = GetEntityCoords(PlayerPedId())

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        ESX.ShowNotification("~r~Vous ne pouvez pas ouvrir le coffre ici !")
        return
    end

    local closestVehicle, closestDistance = API_Vehicles:getClosest(vector3(playerCoords.x, playerCoords.y, playerCoords.z))

    if not closestVehicle or closestVehicle == 0 then
        ESX.ShowNotification("~r~Aucun véhicule détecté à proximité.")
        return
    end

    if closestDistance > 5.0 then
        ESX.ShowNotification("~r~Aucun véhicule à proximité.")
        return
    end

    if not IsEntityAVehicle(closestVehicle) then
        ESX.ShowNotification("~r~Aucun véhicule à proximité.")
        return
    end

    if GetVehicleDoorLockStatus(closestVehicle) == 2 then
        ESX.ShowNotification("~r~Ce coffre est fermé.")
        return
    end

    ExecuteCommand("me Ouvre le coffre du véhicule...")
    TriggerServerEvent("GreenLife:Inventory:OpenSecondInventory", "vehicule", NetworkGetNetworkIdFromEntity(closestVehicle))
end
