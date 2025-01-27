
local menu = {}

function menu:SetData(data)
    menu.DataMenu = data
end

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Garage")

    menu.Menu:IsVisible(function(Items)

        local plate = menu.DataMenu
        local vehicle = MOD_GangBuilder.data.vehicles[plate]

        if (vehicle) then
            Items:Button("Sortir le véhicule", nil, {
    
                RightBadge = RageUI.BadgeStyle.Car
    
            }, true, {
    
                onSelected = function()
    
                    if (vehicle) then
    
                        local coords = MOD_GangBuilder.data.infos.spawnPos;

                        if (MOD_Vehicle:IsSpawnPointClear(coords, 2)) then
                            TriggerServerEvent('GreenLife:GangBuilder:TakeVehicle', MOD_GangBuilder.data.infos.id, plate)

                            RageUI.CloseAll()
                        else
                            ESX.ShowNotification("~r~L'emplacement est occupé.");
                        end
    
                    else
                        ESX.ShowNotification("~r~Une erreur est survenue~s~, Code erreur: ~b~'Society_Take_Vehicle'");
                    end
                end
            });
    
            Items:Button("Récupérer mon véhicule", nil, {
    
                RightBadge = RageUI.BadgeStyle.Car
    
            }, MOD_GangBuilder:IsVehicleOwner(plate), {
    
                onSelected = function()
    
                    if (plate) then
                        TriggerServerEvent('GreenLife:GangBuilder:RetrievePlayerVehicle', MOD_GangBuilder.data.infos.id, plate)

                        RageUI.CloseAll()
                    else
                        ESX.ShowNotification("~r~Une erreur est survenue~s~, Code erreur: ~b~'Society_Retrieve_Vehicle'");
                    end
                end
            });
        else
            Items:Separator("Chargement du véhicule...")
        end

    end)
end

return menu