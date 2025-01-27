local GarageZones = GreenLife.enums.Garage

CreateThread(function()
    while true do
        local PlayerPos = GetEntityCoords(PlayerPedId())
        local Interval = 1000
        
        local MenuOpen = MOD_Vehicle.Menu.MainGarage:IsOpen()

        for key, zone in pairs(GarageZones.Zones) do
            local distanceSpawn = #(PlayerPos - vector3(zone['Spawn'].x, zone['Spawn'].y, zone['Spawn'].z))
            local distanceDelete = #(PlayerPos - vector3(zone['Delete'].x, zone['Delete'].y, zone['Delete'].z))

            local SpawnConfig = GarageZones.ZonesMarker['SpawnVehicle']

            if (distanceSpawn <= SpawnConfig.drawDistance ) then
                Interval = 0
                DrawMarker(25, zone['Spawn'].x, zone['Spawn'].y, (zone['Spawn'].z - 0.97), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, SpawnConfig.RadiusInteraction, SpawnConfig.RadiusInteraction, SpawnConfig.RadiusInteraction, 30, 255, 0, 255, false, true, 2, false, false, false, false)

                if (distanceSpawn <= SpawnConfig.RadiusInteraction and not MenuOpen) then
                    ESX.ShowHelpNotification(GarageZones.GarageSpawn)
                    
                    if (IsControlJustReleased(0, 46)) then
                        TriggerServerEvent('GreenLife:Garage:RequestVehicles')

                        MOD_Vehicle.Garage.Data = zone
                        MOD_Vehicle.Menu.MainGarage:Toggle()
                    end
                end
            end

            local DeleteConfig = GarageZones.ZonesMarker['DeleteVehicle']

            if (distanceDelete <= DeleteConfig.drawDistance) then
                Interval = 0
                DrawMarker(25, zone['Delete'].x, zone['Delete'].y, (zone['Delete'].z - 0.97), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, DeleteConfig.RadiusInteraction, DeleteConfig.RadiusInteraction, DeleteConfig.RadiusInteraction, 30, 255, 0, 255, false, true, 2, false, false, false, false)

                if (distanceDelete <= DeleteConfig.RadiusInteraction and not MenuOpen) then
                    ESX.ShowHelpNotification(GarageZones.GarageDelete)
                    
                    if (IsControlJustReleased(0, 46)) then
                        local playerPed  = PlayerPedId()
                        if IsPedInAnyVehicle(playerPed,  false) then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            local VehiculeProps = API_Vehicles:getProperties(vehicle)
                    
                            TriggerServerEvent('GreenLife:Garage:ParkVehicle', GetVehicleNumberPlateText(vehicle), VehiculeProps)
                        end
                    end
                end
            end
        end

        Wait(Interval)
    end
end)