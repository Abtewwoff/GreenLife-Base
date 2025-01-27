---
--- @author Azagal
--- Create at [31/10/2022] 12:18:11
--- Current project [GreenLife-V1]
--- File name [vehicleMenu]
---

function Taxi:vehicleMenu()
    local menuPosition = Taxi.Config.vehicle.menuPosition
    local mainMenu = RageUI.CreateMenu("", "Garage")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while (mainMenu) do
        local playerCoords = GetEntityCoords(PlayerPedId())

        RageUI.IsVisible(mainMenu, function()
            -- if ServiceTaxi then
                RageUI.Separator("Liste des véhicules")

                for k,v in pairs(Taxi.Config.vehicle.model) do
                    RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(k)), nil, {
                        RightLabel = "Prendre →"
                    }, true, {
                        onSelected = function()
                            ESX.Game.SpawnVehicle(v.name, vector3(-1603.0594482422, -817.96423339844, 9.9909610748291), 314.66, function (vehicle)
                                local newPlate = exports['GreenLife']:GeneratePlate()
                                SetVehicleNumberPlateText(vehicle, newPlate)
                                exports["GreenLifeHud"]:SetFuel(vehicle, 100)
                                TriggerServerEvent('tonio:GiveDoubleKeys', 'no', newPlate)
                                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                            end)
                            TriggerServerEvent("Taxi:Spawn:Vehicle")
                        end
                    })
                end
            -- else
            --     RageUI.Separator("Vous devez etre en service !")
            -- end
        end)

        Wait(3)
    end
end