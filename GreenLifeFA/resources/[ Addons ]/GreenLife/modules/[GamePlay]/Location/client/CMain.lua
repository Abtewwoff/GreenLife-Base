CreateThread(function()
    while ESX == nil do
        Wait(10)
    end
end)

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local coords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.Location.allpos) do
            if #(coords - v.pos) <= 3 then
                interval = 0
                thepos = v.sortie
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder a la location")
                if IsControlJustPressed(0, 51) then
                    openLocation()
                end
            end
        end
        Wait(interval)
    end
end)

Citizen.CreateThread(function()

    local hash = GetHashKey("csb_reporter")
    while not HasModelLoaded(   hash) do
        RequestModel(hash)
        Wait(20)
    end

    ped = CreatePed("PED_TYPE_APPLE", "csb_reporter", -1034.19, -2732.12, 19.16 , 144.70, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end)

local NoInSpam = true
InCooldown = function()
    NoInSpam = false
    Wait(60000)
    NoInSpam = true
end
openLocation = function()
    local mainMenu = RageUI.CreateMenu("", "Choisissez un véhicule")
    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
    
    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Separator("↓ Pack du départ ↓")
            RageUI.Button("Récupérez ses GreenCoins.", nil, {RightLabel = ""}, true, {
                onSelected = function()
                    ESX.ShowNotification("Vous avez recu vos GreenCoins !")
                    ESX.TriggerServerCallback('location:triplee', function(source)
                    end)
                end
            })
        

            RageUI.Separator("↓ Location ↓")
            RageUI.Button("Blista", nil, {RightLabel = "300$"}, NoInSpam , {
                onSelected = function()
                    ESX.TriggerServerCallback('location:checkmoneyyyy', function(cb)
                        if cb then
                            if NoInSpam then
                                ESX.Game.SpawnVehicle('blista', thepos, 238.38, function (vehicle)
                                    local newPlate = exports['GreenLife']:GeneratePlate()
                                    SetVehicleNumberPlateText(vehicle, newPlate)
                                    exports["GreenLifeHud"]:SetFuel(vehicle, 100)
                                    TriggerServerEvent('tonio:GiveDoubleKeys', 'no', newPlate)
                                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                    ESX.ShowNotification("Vous avez payer 300~g~$")
                                end)
                                RageUI.CloseAll()
                                InCooldown()
                            else
                                ESX.ShowNotification("Vous pouvez pas louer un véhicule maintenant !")
                            end
                        else
                            ESX.ShowNotification("~r~Vous n'avez pas assez d'argent")
                        end
                    end)
                end
            })
            RageUI.Button("Panto", nil, {RightLabel = "200$"}, NoInSpam , {
                onSelected = function()
                    ESX.TriggerServerCallback('location:checkmoney', function(cb)
                        if cb then
                            if NoInSpam then
                                ESX.Game.SpawnVehicle('panto', thepos, 238.38, function (vehicle)
                                    local newPlate = exports['GreenLife']:GeneratePlate()
                                    SetVehicleNumberPlateText(vehicle, newPlate)
                                    exports["GreenLifeHud"]:SetFuel(vehicle, 100)
                                    TriggerServerEvent('tonio:GiveDoubleKeys', 'no', newPlate)
                                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                    ESX.ShowNotification("Vous avez payer 200~g~$")
                                end)
                                RageUI.CloseAll()
                                InCooldown()
                            else
                                ESX.ShowNotification("Vous pouvez pas louer un véhicule maintenant !")
                            end
                        else
                            ESX.ShowNotification("~r~Vous n'avez pas assez d'argent")
                        end
                    end)
                end
            })
            RageUI.Line()
            RageUI.Button("Faggio", nil, {RightLabel = "100$"}, NoInSpam , {
                onSelected = function()
                    ESX.TriggerServerCallback('location:checkmoneyyy', function(cb)
                        if cb then
                            if NoInSpam then
                                ESX.Game.SpawnVehicle('faggio', thepos, 238.38, function (vehicle)
                                    local newPlate = exports['GreenLife']:GeneratePlate()
                                    SetVehicleNumberPlateText(vehicle, newPlate)
                                    exports["GreenLifeHud"]:SetFuel(vehicle, 100)
                                    TriggerServerEvent('tonio:GiveDoubleKeys', 'no', newPlate)
                                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                    ESX.ShowNotification("Vous avez payer 100~g~$ pour la location")
                                end)
                                RageUI.CloseAll()
                                InCooldown()
                            else
                                ESX.ShowNotification("Vous pouvez pas louer un véhicule maintenant !")
                            end
                        else
                            ESX.ShowNotification("~r~Vous n'avez pas assez d'argent")
                        end
                    end)
                end
            })
            RageUI.Button("BMX", nil, {RightLabel = "50$"}, NoInSpam , {
                onSelected = function()
                    ESX.TriggerServerCallback('location:checkmoneyy', function(cb)
                        if cb then
                            if NoInSpam then
                                ESX.Game.SpawnVehicle('bimx', thepos, 238.38, function (vehicle)
                                    local newPlate = exports['GreenLife']:GeneratePlate()
                                    SetVehicleNumberPlateText(vehicle, newPlate)
                                    exports["GreenLifeHud"]:SetFuel(vehicle, 100)
                                    TriggerServerEvent('tonio:GiveDoubleKeys', 'no', newPlate)
                                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                    ESX.ShowNotification("Vous avez payer 50~g~$")
                                end)
                                RageUI.CloseAll()
                                InCooldown()
                            else
                                ESX.ShowNotification("Vous pouvez pas louer un véhicule maintenant !")
                            end
                        else
                            ESX.ShowNotification("~r~Vous n'avez pas assez d'argent")
                        end
                    end)
                end
            })
        end)
        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
        end
        Wait(3)
    end
end
