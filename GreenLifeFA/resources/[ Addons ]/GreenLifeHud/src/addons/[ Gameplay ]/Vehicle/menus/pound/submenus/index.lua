
local menu = {}

local PoundSpawnV = GreenLife.enums.Pound.Prices['SpawnVehicle']

local NoInSpam = true
InCooldown = function()
    NoInSpam = false
    Wait(60000)
    NoInSpam = true
end

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Fourrières")
    menu.Menu:IsVisible(function(Items)
        local vehicle = MOD_Vehicle.Pound.DataVehicle
        local CurrentPound = MOD_Vehicle.Pound.Data
        if (not vehicle) then
            Items:Separator("Chargement du véhicule")
        else
            Items:Button("Sortir le véhicule", nil, { RightLabel = "Prix: ".. PoundSpawnV .." ~g~$" }, true, {
                onSelected = function()
                    local position = CurrentPound['Spawn']
                    if (MOD_Vehicle:IsSpawnPointClear(position, 2)) then
                        if NoInSpam then
                            TriggerServerEvent('GreenLife:Pound:TakeVehicle', vehicle.plate, position)
                            MOD_Vehicle.Pound.vehicles = nil
                            RageUI.CloseAll()
                        else
                            ESX.ShowNotification("~r~L'emplacement est occupé.")
                        end
                    end
                end
            });
        end
    end, nil, function()
        MOD_Vehicle.Garage.DataVehicle = {}
    end)
end

return menu