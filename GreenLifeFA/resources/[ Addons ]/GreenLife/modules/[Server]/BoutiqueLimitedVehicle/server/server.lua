ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local vehLimited = {}


MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM LimitedVehicleBoutique', {
    },function(result)
        for i = 1 , #result do
            table.insert(vehLimited,{
                carName = result[i].carName,
                carLabel = result[i].carLabel,
                description = result[i].description,
                limite = result[i].limite,
                price = result[i].price,
            })
        end
        Wait(#result*50)
        TriggerClientEvent("Boutique:GetVehicle", -1, vehLimited)
        TriggerEvent("Boutique:UpdateLimitedVeh",vehLimited)
    end)
end)
AddEventHandler('esx:playerLoaded', function(source)
	TriggerClientEvent("Boutique:GetVehicle", source, vehLimited)
end)

RegisterServerEvent("WithdrawVehicle")
AddEventHandler("WithdrawVehicle", function(source,carName)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if (xPlayer) then
        MySQL.Async.fetchAll('SELECT * FROM LimitedVehicleBoutique WHERE carName = @carName', {
            ['@carName'] = carName,
        },function(result)
            if result[1].limite > 1 then
                MySQL.Async.execute('UPDATE LimitedVehicleBoutique SET limite = @limite WHERE carName = @carName', {
                    ['@carName'] = carName,
                    ['@limite'] = result[1].limite - 1,
                }, function(result2)
                    for k,v in pairs(vehLimited) do
                        if v.carName == carName then
                            v.limite = result[1].limite - 1
                            TriggerClientEvent("Boutique:GetVehicle",-1,vehLimited)
                            TriggerEvent("Boutique:UpdateLimitedVeh",vehLimited)
                        end
                    end
                end)
            else
                MySQL.Async.execute('DELETE FROM LimitedVehicleBoutique WHERE carName = @carName', {
                    ['@carName'] = carName,
                }, function(result3)
                    for k,v in pairs (vehLimited) do
                        if v.carName == carName then
                            table.remove(vehLimited,k)
                            TriggerClientEvent("Boutique:GetVehicle",-1,vehLimited)
                            TriggerEvent("Boutique:UpdateLimitedVeh",vehLimited)
                        end
                    end
                
                end)
            end
        end)
    end
end)

RegisterServerEvent("Boutique:BuyVehicle")
AddEventHandler("Boutique:BuyVehicle", function(carName,price,carLabel)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if (xPlayer) then 
        for k,v in pairs(vehLimited) do
            if v.carName == carName then
                if tonumber(price) == tonumber(v.price) then
                    TriggerEvent("aBoutique:BuyVehicle",carName,price,carLabel,"lbv",xPlayer.source)
                else
                    xPlayer.ban(0, "(Boutique:BuyVehicle)")
                end
            end
        end
    end
end)


RegisterCommand("addBoutiqueVehicleLimited", function(source, args, rawCommand)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if (xPlayer) then
        if xPlayer.getGroup() == "fondateur" then
            local carName = args[1]
            local carLabel = args[2]
            local description = args[3]
            local limite = args[4]
            local price = args[5]
            if args[1] ~= nil and args[2] ~= nil and args[3] then
                if tonumber(args[4]) ~= nil and tonumber(args[5]) ~= nil then
                    MySQL.Async.fetchAll( 'SELECT * FROM LimitedVehicleBoutique WHERE carName = @carName', {
                        ['@carName'] = carName,
                    }, function(result)
                        if result[1] then
                            xPlayer.showNotification("~r~Ce véhicule est déjà dans la boutique")
                            
                        else
                            MySQL.Async.execute('INSERT INTO LimitedVehicleBoutique (carName,carLabel,description,limite,price) VALUES (@carName,@carLabel,@description,@limite,@price)', {
                                ['@carName'] = carName,
                                ['@carLabel'] = carLabel,
                                ['@description'] = description,
                                ['@limite'] = limite,
                                ['@price'] = price,
                            }, function(rowsChanged)
                                if rowsChanged > 0 then
                                    table.insert(vehLimited,{
                                        carName = carName,
                                        carLabel = carLabel,
                                        description = description,
                                        limite = limite,
                                        price = price,
                                    })
                                    TriggerClientEvent("Boutique:GetVehicle",-1,vehLimited)
                                    TriggerEvent("Boutique:UpdateLimitedVeh",vehLimited)
                                end
                                xPlayer.showNotification("~g~Vous avez ajouté un véhicule à la boutique")
                            end)
                        end
                    end)
                else
                    xPlayer.showNotification("~r~Vous devez spécifier un nombre pour la limite et le prix")
                end
            else
                xPlayer.showNotification("~r~Vous devez spécifier un nom, un label et une description")
            end
        else
           xPlayer.showNotification("~r~Vous n'avez pas la permission")
        end
    else
        local carName = args[1]
        local carLabel = args[2]
        local description = args[3]
        local limite = args[4]
        local price = args[5]
        if args[1] ~= nil and args[2] ~= nil and args[3] then
            if tonumber(args[4]) ~= nil and tonumber(args[5]) ~= nil then
                MySQL.Async.fetchAll( 'SELECT * FROM LimitedVehicleBoutique WHERE carName = @carName', {
                    ['@carName'] = carName,
                }, function(result)
                    if result[1] then
                        return
                    else
                        MySQL.Async.execute('INSERT INTO LimitedVehicleBoutique (carName,carLabel,description,limite,price) VALUES (@carName,@carLabel,@description,@limite,@price)', {
                            ['@carName'] = carName,
                            ['@carLabel'] = carLabel,
                            ['@description'] = description,
                            ['@limite'] = limite,
                            ['@price'] = price,
                        }, function(rowsChanged)
                            if rowsChanged > 0 then
                                table.insert(vehLimited,{
                                    carName = carName,
                                    carLabel = carLabel,
                                    description = description,
                                    limite = limite,
                                    price = price,
                                })
                                Wait(300)
                                TriggerClientEvent("Boutique:GetVehicle",-1,vehLimited)
                                TriggerEvent("Boutique:UpdateLimitedVeh",vehLimited)
                            end
                            -- print("^2[GreenLife] ^0Vous avez ajouté un véhicule à la boutique")
                        end)
                    end
                end)
            else
                -- print("^1[GreenLife] ^0Vous devez spécifier un nombre pour la limite et le prix")
            end
        else
            -- print("^1[GreenLife] ^0Vous devez spécifier un nom, un label et une description")
        end
        
    end

end)