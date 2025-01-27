RegisterNetEvent('GreenLife:Garage:TakeVehicle')
AddEventHandler('GreenLife:Garage:TakeVehicle', function(vehiclePlate, positionOut)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vPlate = vehiclePlate

    if (xPlayer) then

        if (MOD_Vehicle:GetVehicleByPlate(vPlate)) then
            MySQL.Async.execute("UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate", {
                ["@stored"] = 0,
                ["@plate"] = vPlate
            })

            TriggerClientEvent('GreenLife:Garage:RefreshVehicles', xPlayer.source)

            return xPlayer.showNotification("~r~Vous devez aller chercher votre véhicule là où vous l'avez stationné, s'il vous a été voler merci de contacter les forces de l'ordre.")
        end

        MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND stored = 1", {
            ["owner"] = xPlayer.getIdentifier(),
            ["plate"] = vPlate
        }, function(result)
            if (#result > 0) then
                local ped = GetPlayerPed(xPlayer.source)
                local props = json.decode(result[1].vehicle)
                
                if (positionOut) then
                    TriggerClientEvent('GreenLife:Garage:RefreshVehicles', xPlayer.source)

                    MOD_Vehicle:CreateVehicle(props.model, positionOut, positionOut["heading"], result[1].plate, xPlayer.getIdentifier(), function(vehicle, defaultProperties)

                        MOD_Vehicle.vehiclesOut[result[1].plate] = vehicle:GetHandle()

                        -- local propsData = props or nil

                        -- if (not propsData) then
                        --     propsData = defaultProperties
                        --     propsData["plate"] = result[1].plate
                        -- end

                        vehicle:SetProperties(props, xPlayer, function()
                            SetPedIntoVehicle(ped, vehicle:GetHandle(), -1)

                            vehicle:SetLocked(false)
                        end)
                        
                        MySQL.Async.execute("UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate", {
                            ["@stored"] = 0,
                            ["@plate"] = result[1].plate
                        })
                    end, xPlayer)

                else
                    TriggerClientEvent('GreenLife:Garage:RefreshVehicles', xPlayer.source)
                    xPlayer.showNotification("~r~Une erreur est survenue.")
                end

            else
                TriggerClientEvent('GreenLife:Garage:RefreshVehicles', xPlayer.source)
                xPlayer.showNotification("~r~Une erreur est survenue.")
            end
        end)
    end
end)