ESX.RegisterServerCallback('cardealer:getCategories', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then 

        if xPlayer.job.name ~= 'cardealer' then
            TriggerEvent("tF:Protect", source, '(cardealer:getCategories)')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
            cb(result)
        end)
    end
end)

RegisterServerEvent('cardealer:changeBucket')
AddEventHandler('cardealer:changeBucket', function(reason)
    local source = source
    if reason == "enter" then
        SetPlayerRoutingBucket(source, source+1)
    else
        SetPlayerRoutingBucket(source, 0)
    end
end)

ESX.RegisterServerCallback('cardealer:getAllVehicles', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then 

        if xPlayer.job.name ~= 'cardealer' then
            TriggerEvent("tF:Protect", source, '(cardealer:getAllVehicles)')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM vehicles', {
        }, function(result)
            cb(result)
        end)
    end
end)

ESX.RegisterServerCallback('cardealer:getSocietyMoney', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source);

    local society = ESX.DoesSocietyExist("cardealer");

    if (society) then

        cb(ESX.GetSocietyMoney("cardealer"));

    else

        cb(0);
        xPlayer.showNotification("Une erreur est survenue, Code erreur ~g~'cardealer_get_money_error'~s~. Veuillez contacter un ~g~administrateur~s~.");

    end

end);


ESX.RegisterServerCallback('cardealer:getSocietyVehicles', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then 

        if xPlayer.job.name ~= 'cardealer' then
            TriggerEvent("tF:Protect", source, '(cardealer:getSocietyVehicles)')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM cardealer_vehicles WHERE society = @a', {
            ['@a'] = 'society_cardealer'
        }, function(result)
            cb(result)
        end)
    end
end)



RegisterServerEvent('cardealer:buyVehicle')
AddEventHandler('cardealer:buyVehicle', function(props, name, price)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= "cardealer" then
        TriggerEvent("tF:Protect", source, '(cardealer:buyVehicle)');
        return
    end

    local society = ESX.DoesSocietyExist("cardealer");

    if (society) then

        MySQL.Async.execute('INSERT INTO cardealer_vehicles (vehicle, name, price, society) VALUES (@a, @b, @c, @d)', {
            ['@a']   = props,
            ['@b']   = name,
            ['@c']   = price,
            ['@d']   = 'society_cardealer'
        }, function()

            ESX.RemoveSocietyMoney("cardealer", tonumber(price));
            
        end);
    else
        xPlayer.showNotification("Une erreur est survenue, Code erreur ~g~'cardealer_buyVehicle_error'~s~. Veuillez contacter un ~g~administrateur~s~.");
    end
end);


-- RegisterServerEvent('cardealer:removesocietycar', function(plyId, vehId, model, plate, price)
--     local src = source;
--     local xPlayer = ESX.GetPlayerFromId(src);
--     if (xPlayer.job.name == "cardealer") then
--         MySQL.Async.execute('DELETE FROM cardealer_vehicles WHERE id = @id', {
--             ['@id'] = id
--         }, function()
--             local vehicleModel = type(model) == 'number' and model or GetHashKey(model);

--             ESX.SpawnVehicle(vehicleModel, vector3(116.5396, -140.0334, 54.80011), 337.29, plate, true, xPlayer, false, function(vehicle)

--                 xPlayer.triggerEvent("cardealer:onSpawnVehicle", menuData, NetworkGetNetworkIdFromEntity(vehicle:GetHandle()), props)

--             end)
--         end);
--     end
-- end)


ESX.RegisterServerCallback('vehicle:verifierplaquedispoboutique', function (source, cb, plate)
    MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function (result)
        cb(result[1] ~= nil)
    end)
end)

RegisterServerEvent('sellthevehicle')
AddEventHandler('sellthevehicle', function(plyId, vehId, vehModel, vehPlate, vehPrice)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(plyId)
    
    ESX.SpawnVehicle(vehModel, vector3(-775.1934, -228.4055, 36.99752), 204.73062133789065, vehPlate, true, tPlayer, tPlayer.getIdentifier(), function(vehicle)

        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, state) VALUES (@owner, @plate, @vehicle, @type, @state)', {
            ['@owner']   = tPlayer.getIdentifier(),
            ['@plate']   = vehicle.plate,
            ['@vehicle'] = json.encode({
                model = vehicle.model,
                plate = vehicle.plate
            }),
            ['@type']   = 'car',
            ['@state']   = 0
        }, function()

            -- Donner la clé au joueur avec la plaque associée
            tPlayer.addInventoryItem('car_key', 1)
            TriggerClientEvent('esx:showNotification', tPlayer.source, "Vous avez reçu une clé pour la plaque : " .. vehPlate)

            -- Enregistrer la clé dans une table si besoin
            MySQL.Async.execute('INSERT INTO vehicle_keys (owner, plate) VALUES (@owner, @plate)', {
                ['@owner'] = tPlayer.getIdentifier(),
                ['@plate'] = vehPlate
            })

        end)
        
        MySQL.Async.execute('DELETE FROM cardealer_vehicles WHERE id = @id', { ['@id'] = vehId });

        SendLogs(xPlayer, tPlayer, vehicle.model, vehPrice, vehicle.plate)
    end)
end)


ESX.RegisterServerCallback('inventory:useItem', function(source, cb, itemName)
    local xPlayer = ESX.GetPlayerFromId(source)

    if itemName == 'car_key' then
        -- Vérifier si la clé est associée à un véhicule existant
        MySQL.Async.fetchAll('SELECT plate FROM vehicle_keys WHERE owner = @owner', {
            ['@owner'] = xPlayer.identifier
        }, function(keys)
            if #keys > 0 then
                cb(true) -- La clé est valide
            else
                cb(false) -- Clé invalide
                xPlayer.showNotification("Cette clé n'est pas valide.")
            end
        end)
    else
        cb(true)
    end
end)


function SendLogs(xPlayer, tPlayer, model, theprice, plate)
    local link = "https://discord.com/api/webhooks/1116024605069545473/BLUwXaIspnfS36UNHGxGR6Y9bM4T7dCUjxDDsnFdjXxvN_PKuLv5dzLUYIAnMpNQDm4f"
    local buyerName  = tPlayer.getName()
    local buyerLicense = tPlayer.getIdentifier()

    local sellerName  = xPlayer.getName()
    local sellerLicense = xPlayer.getIdentifier()

    local local_date = os.date('%H:%M:%S', os.time())
    local content = {
        {
            ["title"] = "**Achat Concess :**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Acheteur :", value = buyerName.." ["..buyerLicense.."]" },
                { name = "- Vendeur :", value = sellerName.." ["..sellerLicense.."]" },
                { name = "- Information facture :", value = "Voiture : "..model.."\nMontant payer : "..theprice.."$\nPlaque : "..plate },
            },
            ["type"]  = "rich",
            ["color"] = 16711680,
            ["footer"] =  {
            ["text"] = "By GreenLife | GreenLifeRP",
            },
        }
    }
    PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Vente Voiture", embeds = content}), { ['Content-Type'] = 'application/json' })

end




local TimeoutJob3 = {};

RegisterServerEvent('Ouvre:CarShop')
AddEventHandler('Ouvre:CarShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob3[xPlayer.identifier] or GetGameTimer() - TimeoutJob3[xPlayer.identifier] > 600000) then
		TimeoutJob3[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "cardealer" then
            TriggerEvent("tF:Protect", source, '(Ouvre:CarShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Concessionnaire <br/> Voiture', '', 'Le concessionnaire Voiture est désormais Ouvert~s~ !', 'CHAR_CONSES', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:CarShop')
AddEventHandler('Ferme:CarShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob3[xPlayer.identifier] or GetGameTimer() - TimeoutJob3[xPlayer.identifier] > 600000) then
		TimeoutJob3[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "cardealer" then
            TriggerEvent("tF:Protect", source, '(Ferme:CarShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Concessionnaire Voiture', '', 'Le concessionnaire Voiture est désormais Fermer~s~ !', 'CHAR_CONSES', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:CarShop')
AddEventHandler('Recrutement:CarShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob3[xPlayer.identifier] or GetGameTimer() - TimeoutJob3[xPlayer.identifier] > 600000) then
		TimeoutJob3[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "cardealer" then
            TriggerEvent("tF:Protect", source, '(Recrutement:CarShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Concessionnaire Voiture', '', 'Les Recrutement en cours, rendez-vous au concessionnaire Voiture !', 'CHAR_CONSES', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)