
function GarageVigneron()
    local garage = RageUI.CreateMenu("", "Garage Vigneron")

    RageUI.Visible(garage, not RageUI.Visible(garage))

    while garage do 
        Wait(0)
        RageUI.IsVisible(garage, function()
            for k,v in pairs(Vigneron.Garage) do 
                RageUI.Button(v.label, nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        ESX.Game.SpawnVehicle(v.model, Vigneron.Pos.Spawn, Vigneron.Pos.Heading, function(vehicle)
                            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                            SetVehicleNumberPlateText(vehicle, "VIGNERON")
                            SetEntityAsMissionEntity(vehicle, true, true)
                        end)
                        RageUI.CloseAll()
                    end
                })
            end
        end)

        if not RageUI.Visible(garage) then
            garage = RMenu:DeleteType(garage)
            break
        end
    end
end