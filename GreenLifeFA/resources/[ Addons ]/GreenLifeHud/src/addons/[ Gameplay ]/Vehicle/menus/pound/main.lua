MOD_Vehicle.Menu.MainPound = RageUI.CreateMenu("", "Fourrières")


MOD_Vehicle.Menu.PoundVehicle = require 'src.addons.[ Gameplay ].Vehicle.menus.pound.submenus.index'
MOD_Vehicle.Menu.PoundVehicle:LoadMenu(MOD_Vehicle.Menu.MainPound)

local function GetNumberOfPoundVehicle(vehiclesPound, currentPound)
    local vehicles = {}

    for vehiclePlate, vehicle in pairs(vehiclesPound or {}) do
        if (vehicle) then
            if (vehicle.stored == 0 and vehicle.type == currentPound.type) then
                table.insert(vehicles, vehiclePlate)
            end
        end
    end

    return #vehicles
end


MOD_Vehicle.Menu.MainPound:IsVisible(function(Items)

    if (not MOD_Vehicle.Pound.vehicles) then
        Items:Separator("Chargement des véhicules")
    else
        local vehicles = MOD_Vehicle.Pound.vehicles
        local currentPound = MOD_Vehicle.Pound.Data

        if (GetNumberOfPoundVehicle(vehicles, currentPound) > 0) then
            local playerVip = exports.GreenLife:GetVipLevel()

            local vehicles = MOD_Vehicle.Pound.vehicles
            
            for i=1, #vehicles do

                vehicles[i].type = MOD_Vehicle:GetTypeFromModel(vehicles[i].model)

                local VehType = string.lower(vehicles[i].type or "null")
                local CurrPoundType = string.lower(currentPound.type)

                if (vehicles[i] ~= nil and VehType == CurrPoundType) then

                    local vehicleName = GetDisplayNameFromVehicleModel(vehicles[i].model);

                    Items:Button(("%s ~c~[%s%s~c~]~s~"):format(vehicleName, "~g~", vehicles[i].plate ), nil, {}, true, {
                        onSelected = function()
                            MOD_Vehicle.Pound.DataVehicle = vehicles[i]
                        end
                    }, MOD_Vehicle.Menu.PoundVehicle.Menu);
                end
            end
        else
            Items:Separator()
            Items:Separator("~r~Aucun véhicule.")
            Items:Separator()
        end
    end

end, nil, function()
    MOD_Vehicle.Pound.Data = {}
end)