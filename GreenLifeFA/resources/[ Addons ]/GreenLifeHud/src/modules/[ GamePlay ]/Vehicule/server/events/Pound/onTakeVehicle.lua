RegisterNetEvent('GreenLife:Pound:TakeVehicle')
AddEventHandler('GreenLife:Pound:TakeVehicle', function(vehiclePlate, positionOut)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vPlate = vehiclePlate


    if (xPlayer) then
        local PoundSpawnV = GreenLife.enums.Pound.Prices['SpawnVehicle']
        local Notif = "Vous avez payé ".. PoundSpawnV .."~g~$"
    
        xPlayer.updateVIP(function() 
            if xPlayer.getVIP() == 3 then 
                PoundSpawnV = 0
                Notif = "L'assurance à pris en charge les honoraires !"
            end
        end)

        if (MOD_Vehicle.vehiclesOut[vPlate]) then
            if (DoesEntityExist(MOD_Vehicle.vehiclesOut[vPlate])) then
                TriggerClientEvent('GreenLife:Pound:RefreshVehicles', xPlayer.source)
                return xPlayer.showNotification("~r~Vous devez aller chercher votre véhicule là où vous l'avez stationné, s'il vous a été voler merci de contacter les forces de l'ordre.")
            end

            MOD_Vehicle.vehiclesOut[vPlate] = nil
        end

        local Account = xPlayer.getAccount("cash");

        if (Account) then
            local HaveMoney = (Account.money >= PoundSpawnV)

            xPlayer.updateVIP(function() 
                if xPlayer.getVIP() == 3 then
                    HaveMoney = true
                end
            end)

            if (HaveMoney) then

                MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND stored = 0", {
                    ["@owner"] = xPlayer.getIdentifier(),
                    ["@plate"] = vPlate
                }, function(result)
                    if (#result > 0) then
                        local ped = GetPlayerPed(xPlayer.source)
                        local props = json.decode(result[1].vehicle)

                        if (positionOut) then
                            
                            xPlayer.updateVIP(function() 
                                if xPlayer.getVIP() ~= 3 then 
                                    xPlayer.removeAccountMoney("cash", PoundSpawnV)
                                end
                            end)

                            TriggerClientEvent('GreenLife:Pound:RefreshVehicles', xPlayer.source)

                            MOD_Vehicle:CreateVehicle(props.model, positionOut, positionOut["heading"], result[1].plate, xPlayer.getIdentifier(), function(vehicle, defaultProperties)
                                
                                MOD_Vehicle.vehiclesOut[result[1].plate] = vehicle:GetHandle()

                                -- local propsData = props or nil

                                -- if (not propsData) then
                                --     propsData = defaultProperties
                                --     propsData["plate"] = result[1].plate
                                -- end

                                xPlayer.showNotification(Notif)

                                vehicle:SetProperties(props, xPlayer, function()
                                    SetPedIntoVehicle(ped, vehicle:GetHandle(), -1)

                                    vehicle:SetLocked(false)
                                end)
                            end, xPlayer)

                        else
                            TriggerClientEvent('GreenLife:Pound:RefreshVehicles', xPlayer.source)
                            xPlayer.showNotification("~r~Une erreur est survenue")
                        end
                    else
                        TriggerClientEvent('GreenLife:Pound:RefreshVehicles', xPlayer.source)
                        xPlayer.showNotification("~r~Une erreur est survenue")
                    end
                end)
            else
                TriggerClientEvent('GreenLife:Pound:RefreshVehicles', xPlayer.source)
                xPlayer.showNotification("Vous n'avez pas assez d'argent")
            end
        else
            TriggerClientEvent('GreenLife:Pound:RefreshVehicles', xPlayer.source)
            xPlayer.showNotification("~r~Une erreur est survenue")
        end
    end
end)