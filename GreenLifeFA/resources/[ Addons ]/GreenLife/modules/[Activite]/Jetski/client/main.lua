function MenuJetski()
    local main = RageUI.CreateMenu("", "Jetski")
    RageUI.Visible(main, not RageUI.Visible(main))
    Citizen.CreateThread(function()
        while main do
            Wait(3)
            RageUI.IsVisible(main, function()
                RageUI.Button("Jetski", "Pour obtenir un jetski", {RightLabel = "~r~5.000$"}, true, {
                    onSelected = function()
                        TriggerServerEvent('h4ci:locajetski')
                        local playerPed = PlayerPedId()
                        local coords = GetEntityCoords(PlayerPedId())
                        ESX.Game.SpawnVehicle("seashark", coords, 200.0, function(vehicle)
                            TaskWarpPedIntoVehicle(playerPed, vehicle, -1) 
                            exports["GreenLifeHud"]:SetFuel(vehicle, 100)
                            SetVehicleNumberPlateText(vehicle, 'LOCATION') 
                            exports["GreenLifeHud"]:SetFuel(vehicle, 100)

                        end)
                        RageUI.CloseAll()
                    end
                })
            end, function()
            end)
            if not RageUI.Visible(main) then
                main = RMenu:DeleteType('main', true)
            end
        end
    end)
end