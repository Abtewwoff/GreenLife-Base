local PoundZones = GreenLife.enums.Pound

CreateThread(function()
    while true do
        local PlayerPos = GetEntityCoords(PlayerPedId())
        local Interval = 1000

        local MenuOpen = MOD_GangBuilder.Menus.MainPound:IsOpen()

        for key, zone in pairs(PoundZones.GangZones) do
            local distanceMenu = #(PlayerPos - vector3(zone['Menu'].x, zone['Menu'].y, zone['Menu'].z))

            local MenuConfig = PoundZones.ZonesMarker['MenuVehicle']

            if (distanceMenu <= MenuConfig.drawDistance) then
                Interval = 0
                DrawMarker(25, zone['Menu'].x, zone['Menu'].y, (zone['Menu'].z - 0.97), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, MenuConfig.RadiusInteraction, MenuConfig.RadiusInteraction, MenuConfig.RadiusInteraction, 30, 255, 0, 255, false, true, 2, false, false, false, false)

                if (distanceMenu <= MenuConfig.RadiusInteraction and not MenuOpen) then
                    -- ESX.ShowHelpNotification(PoundZones.PoundMenu)
                    TriggerEvent("ui:showInteraction", "E", PoundZones.PoundMenu)                    
                    if (IsControlJustReleased(0, 46)) then
                        TriggerServerEvent('GreenLife:GangBuilder:PoundRequestVehicles')

                        MOD_GangBuilder.data.pound.Data = zone
                        MOD_GangBuilder.Menus.MainPound:Toggle()
                    end
                end
            end
        end

        Wait(Interval)
    end
end)