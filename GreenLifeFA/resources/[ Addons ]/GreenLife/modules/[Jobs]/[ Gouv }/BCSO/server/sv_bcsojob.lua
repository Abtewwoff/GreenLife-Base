--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

RegisterServerEvent('annonce:serviceBcso')
AddEventHandler('annonce:serviceBcso', function(status)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName(source)
    local xPlayers = ESX.GetPlayers()
    if status == "fin" then
            xPlayer.removeWeaponSystem("weapon_stungun")
            xPlayer.removeWeaponSystem("weapon_nightstick")
            xPlayer.removeWeaponSystem("weapon_combatpistol")
            xPlayer:removeWeaponSystem("weapon_beanbag")
            xPlayer.removeWeaponSystem("weapon_carbinerifle")
            xPlayer.removeWeaponSystem("weapon_pumpshotgun")
            xPlayer.removeWeaponSystem("weapon_pumpshotgun")

        RemoveCountPoliceInService(source)
    elseif (status == "prise") then
        AddCountPoliceInService(source)
    end
    if xPlayer.job.name == 'bcso' then
        for i = 1, #xPlayers, 1 do
            local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
            if thePlayer.job.name == 'bcso' then
                TriggerClientEvent('bcso:InfoService', xPlayers[i], status, name)
            end
        end
    else
        TriggerEvent("tF:Protect", source, '(annonce:serviceBcso)');
    end
end)

RegisterServerEvent('bcso:verif')
AddEventHandler('bcso:verif', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'bcso' then
        TriggerEvent("tF:Protect", source, '(verif)');
    end
end)

RegisterNetEvent('bcso:spawnVehicle', function(model, position, heading)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'bcso' then
        TriggerEvent("tF:Protect", source, '(verif)');
        return
    end
end)

AddEventHandler('playerDropped', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if (not xPlayer) then return; end

    xPlayer.removeWeaponSystem("weapon_stungun")
    xPlayer.removeWeaponSystem("weapon_nightstick")
    xPlayer.removeWeaponSystem("weapon_combatpistol")
    xPlayer.removeWeaponSystem("weapon_beanbag")
    xPlayer.removeWeaponSystem("weapon_carbinerifle")
    xPlayer.removeWeaponSystem("weapon_advancedrifle")
    xPlayer.removeWeaponSystem("weapon_pumpshotgun")
end)

RegisterServerEvent('bcso:buyWeapon')
AddEventHandler('bcso:buyWeapon', function(weapon)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local distance = #(coords - vector3(-443.837, 6013.124, 37.008))
    
    if xPlayer.job.name == 'bcso' then
        if weapon == "weapon_stungun" or weapon == "weapon_flashlight" or weapon == "weapon_nightstick" or weapon == "weapon_combatpistol" or weapon == "weapon_carbinerifle" then
            if distance < 35.0 then
                xPlayer.addWeapon(weapon, 255)
            else
                TriggerClientEvent('esx:showNotification', source, "~r~Vous devez être plus près pour acheter cela.")
            end
        else
            xPlayer.ban(0, '(bcso:buyWeapon)')
        end
    else
        xPlayer.ban(0, '(bcso:buyWeapon)')
    end
end)


RegisterNetEvent('tF_bcsojob:putInVehicle')
AddEventHandler('tF_bcsojob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'bcso' then
		TriggerClientEvent('tF_bcsojob:putInVehicle', target)
    end
end)

RegisterNetEvent('tF_bcsojob:OutVehicle')
AddEventHandler('tF_bcsojob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'bcso' then
		TriggerClientEvent('tF_bcsojob:OutVehicle', target)
    end
end)

ESX.RegisterServerCallback('bcso:getVehicleInfos', function(source, cb, plate)
    local _source = source
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		if result[1] then
            local retrivedInfo = {plate = plate}
            local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)
			local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)
            retrivedInfo.owner = xPlayer.getFirstName().." "..xPlayer.getLastName()
            cb(retrivedInfo)
			TriggerEvent("Logs:playerCheckInfoOfVeh", plate)
		else
			cb(retrivedInfo)
		end
	end)
end)

RegisterServerEvent('bcso:menotter')
AddEventHandler('bcso:menotter', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'bcso' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                --TriggerClientEvent('menotterlejoueurBcso', target)
                TriggerClientEvent('menotterlejoueur', target)
            end
        end
    else
        TriggerEvent("tF:Protect", source, '(menotter)');
    end
end);

RegisterServerEvent('bcso:escorter')
AddEventHandler('bcso:escorter', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'bcso' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                --TriggerClientEvent('actionescorter', target, source)
                TriggerClientEvent('actionescorter', target, source)
            end
        end
    else
        TriggerEvent("tF:Protect", source, '(escorter)');
    end
end);

RegisterServerEvent('bcso:message', function(player)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local pName = xPlayer.getName()
    if (xPlayer.job.name == "bcso" and player) then
        if (#(GetEntityCoords(GetPlayerPed(xPlayer.source)) - GetEntityCoords(GetPlayerPed(player))) < 5.0) then
            TriggerClientEvent('esx:showNotification', player, "Vous êtes fouiller par " ..pName.. ".")
        end
    end
end);

RegisterServerEvent('bcso:demande')
AddEventHandler('bcso:demande', function(coords, raison)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    if xPlayer.job.name == 'bcso' then
        for i = 1, #xPlayers, 1 do
            local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
            if thePlayer.job.name == 'bcso' then
                TriggerClientEvent('bcso:renfort:setBlip', xPlayers[i], coords, raison)
            end
        end
    else
        TriggerEvent("tF:Protect", source, '(demande)');
    end
end)

RegisterServerEvent('bcso:insertintocasier')
AddEventHandler('bcso:insertintocasier', function(name, firstname, dob, reason)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer.job.name == 'bcso' then
        TriggerEvent("tF:Protect", source, '(insertintocasier)');
        return
    end
    MySQL.Async.execute('INSERT INTO casier VALUES (@identifier, @Nom, @Prenom, @Naissance, @Raison, @Auteur)', {  
        ['@identifier'] = xPlayer.identifier,        
        ['@Nom'] = firstname,      
        ['@Prenom'] = name,      
        ['@Naissance'] = dob,
        ['@Raison'] = reason,
        ['@Auteur'] = GetPlayerName(source),
		--['@Auteur'] = GetPlayerName(source)
        
    }, function(rowsChanged)            
    end)
    TriggerClientEvent('esx:showNotification', source, "~r~Le casier judiciaire a bien été enregistré !")
    local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'bcso' then
			TriggerClientEvent('updateinfos', xPlayers[i])
            --TriggerClientEvent("esx:showNotification", xPlayers[i], "Une plainte vient d'arrivée !")
		end
	end
end)

RegisterServerEvent('bcso:validerplainte')
AddEventHandler('bcso:validerplainte', function(name, firstname, tel, nom1, prenom1, num1, reason)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer.job.name == 'bcso' then
        TriggerEvent("tF:Protect", source, '(validerplainte)');
        return
    end
    -- MySQL.Async.execute('INSERT INTO plaintes2 VALUES (@identifier, @Prenom, @Nom, @Num, @Prenom1, @Nom1, @Num1, @Raison, @Auteur)', {  
    --     ['@identifier'] = xPlayer.identifier,
    --     ['@Prenom'] = name,            
    --     ['@Nom'] = firstname,      
    --     ['@Num'] = tel,
    --     ['@Prenom1'] = nom1,            
    --     ['@Nom1'] = prenom1,      
    --     ['@Num1'] = num1,
    --     ['@Raison'] = reason,
    --     ['@Auteur'] = GetPlayerName(source),
	-- 	--['@Auteur'] = GetPlayerName(source)
        
    -- }, function(rowsChanged)            
    -- end)
    PlainteLogsDiscord("[PLAINTE-BCSO] "..xPlayer.getName().." a déposer une plainte : \nPrénom : "..name.."\nNom : "..firstname.."\nTéléphone : "..tel.. "\nRaison :"..reason, 'https://canary.discord.com/api/webhooks/1133347328590348288/Masui0rpz9GkzJjDnr4WKRaB02LrGplFIjl0a3KMuEfOsVX9lHqhZsznKAysq7xS7jh0')
    local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'bcso' then
			TriggerClientEvent('updateinfos', xPlayers[i])
            TriggerClientEvent("esx:showNotification", xPlayers[i], "~g~Une plainte vient d'arrivée !")
		end
	end
end)

ESX.RegisterServerCallback('bcso:getPlaintes', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM plaintes2', {}, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('bcso:getData', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM casierBcso', {}, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('bcso:plaitetraiter')
AddEventHandler('bcso:plaitetraiter', function(prenom, nom, num)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

    if not xPlayer.job.name == 'bcso' then
        TriggerEvent("tF:Protect", source, '(plaitetraiter)');
        return
    end

    MySQL.Async.execute("DELETE FROM plaintes2 WHERE Prenom = @a AND Nom = @b AND Num = @c", {
        ['a'] = prenom,
        ['b'] = nom,
        ['c'] = num
    }, function()
    end)
    for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'bcso' then
			TriggerClientEvent("esx:showNotification", xPlayers[i], "~g~La plainte de monsieur "..prenom.. " "..nom.. " a bien été traitée par le policier " ..xPlayer.getName().. " .")
            TriggerClientEvent('checkplaintes', xPlayers[i])
		end
	end
end)

RegisterServerEvent('bcso:deletecasier')
AddEventHandler('bcso:deletecasier', function(firstname, name, dob, reason, author)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer.job.name == 'bcso' then
        TriggerEvent("tF:Protect", source, '(deletecasier)');
        return
    end
    MySQL.Async.execute("DELETE FROM casier WHERE Prenom = @a AND Nom = @b AND naissance = @c AND raison = @d AND auteur = @e", {
        ['a'] = firstname,
        ['b'] = name,
        ['c'] = dob,
        ['d'] = reason,
        ['e'] = author
    }, function()
    end)
    for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'bcso' then
			TriggerClientEvent("esx:showNotification", xPlayers[i], "~g~Le casier judiciare de monsieur "..firstname.. " "..name.. " a bien été supprimé par le policier " ..xPlayer.getName().. " .")
            TriggerClientEvent('updateinfos', xPlayers[i])
		end
	end
end)

RegisterNetEvent('bcso:confiscatePlayerItem', function(target, itemType, itemName, amount)
    -- print(itemType..""..itemName)
    local source = source
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    if (not sourceXPlayer or not targetXPlayer) then return end

    local ped = GetPlayerPed(sourceXPlayer.source);
    local targetPed = GetPlayerPed(targetXPlayer.source);

    if sourceXPlayer.job.name ~= 'bcso' then
        TriggerEvent("tF:Protect", source, 'bcso:confiscatePlayerItem)');
    else
        if (#(GetEntityCoords(targetPed) - GetEntityCoords(ped)) < 4.0) then
            if itemType == 'item_standard' then
                local targetItem = targetXPlayer.getInventoryItem(itemName)
                local sourceItem = sourceXPlayer.getInventoryItem(itemName)

                if (targetItem and targetItem.count >= amount) then
                    if (sourceXPlayer.canCarryItem(itemName, amount)) then
                        targetXPlayer.removeInventoryItem(itemName, amount);
                        sourceXPlayer.addInventoryItem(itemName, amount);
                        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~g~"..amount..' '..sourceItem.label.."~s~.")
                        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~g~"..amount..' '..sourceItem.label.."~s~.")
                        SendLogs("Bcso", "GreenLife | Bcso", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre un item "..amount.." "..sourceItem.label.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://canary.discord.com/api/webhooks/1093166996767637614/z21wadG1nscJj08QY9JAstgbT4TBxjtnlIGVRCBbY7J-8PZwtYMmIvu9mamnxfLvKG30")
                    else
                        TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez de place dans votre inventaire.");
                    end
                end
            end
                
            if itemType == 'item_account' then
                local targetAccount = targetXPlayer.getAccount(itemName)
                if (targetAccount and targetAccount.money >= amount) then
                    targetXPlayer.removeAccountMoney(itemName, amount);
                    sourceXPlayer.addAccountMoney(itemName, amount);
                    
                    TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~g~"..amount.."$ ~s~argent non d�clar�~s~.");
                    TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~g~"..amount.."$ ~s~argent non d�clar�~s~.");
                    SendLogs("Bcso", "GreenLife | Bcso", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre de l'argent "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://canary.discord.com/api/webhooks/1093166996767637614/z21wadG1nscJj08QY9JAstgbT4TBxjtnlIGVRCBbY7J-8PZwtYMmIvu9mamnxfLvKG30")
                end
            end
        
            if itemType == 'item_weapon' then
                targetXPlayer.removeWeapon(itemName, 0);
                sourceXPlayer.addWeapon(itemName, amount);
                SendLogs("Bcso", "GreenLife | Bcso", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre une arme "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://canary.discord.com/api/webhooks/1093166996767637614/z21wadG1nscJj08QY9JAstgbT4TBxjtnlIGVRCBbY7J-8PZwtYMmIvu9mamnxfLvKG30")
            end
        end
    end
end);

ESX.RegisterServerCallback('bcso:getOtherPlayerDataBcso', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)
    TriggerClientEvent("esx:showNotification", xPlayer, "~r~~Quelqu'un vous fouille")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }
        cb(data)
    end
end)


RegisterNetEvent("bcso:SendFacture", function(target, price)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'bcso' then
        TriggerEvent("tF:Protect", source, '(bcso:SendFacture)');
        return
	end

    local society = ESX.DoesSocietyExist("bcso");
    local xTarget = ESX.GetPlayerFromId(target);
    -- if (price <= xTarget.getAccount("bank").money) then
        if (society) then
            local xTarget = ESX.GetPlayerFromId(target);
            if (xTarget) then
                local removeVip = price - price * 10/100
                if xPlayer.getVIP() == 3 then 
                    xTarget.removeAccountMoney('bank', removeVip);
                    ESX.AddSocietyMoney("bcso", price);
                    xTarget.showNotification("Votre compte en banque à été réduit de "..price.."~g~$~s~.");
                    xPlayer.showNotification("Vous avez donné une amende de "..price.."~g~$~s~");
                else
                    xTarget.removeAccountMoney('bank', price);
                    ESX.AddSocietyMoney("bcso", price);
                    xTarget.showNotification("Votre compte en banque à été réduit de "..price.."~g~$~s~.");
                    xPlayer.showNotification("Vous avez donné une amende de "..price.."~g~$~s~");
                end
                SendLogs("Facture", "GreenLife | Facture", "Le joueur **"..xTarget.name.."** (***"..xTarget.identifier.."***) vient d'envoyer une facture de "..price.."$ au joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) pour l'entreprise **B.C.S.O** ", "https://canary.discord.com/api/webhooks/1093166996767637614/z21wadG1nscJj08QY9JAstgbT4TBxjtnlIGVRCBbY7J-8PZwtYMmIvu9mamnxfLvKG30")
            end
        end
    -- else
    --     xPlayer.showNotification("~r~La personne n'a pas assez d'argent !");
    --     xTarget.showNotification("~r~Vous n'avez pas assez d'argent !");
    -- end
end);



ESX.RegisterServerCallback('bcso:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bcso', function(inventory)
		cb(inventory.items)
	end)
end)


RegisterNetEvent('bcso:getStockItem')
AddEventHandler('bcso:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bcso', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				rxeLogsDiscord("[COFFRE] "..xPlayer.getName().." a retiré "..count.." "..itemName.." du coffre", 'https://canary.discord.com/api/webhooks/1093166996767637614/z21wadG1nscJj08QY9JAstgbT4TBxjtnlIGVRCBbY7J-8PZwtYMmIvu9mamnxfLvKG30')
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

RegisterNetEvent('bcso:putStockItems')
AddEventHandler('bcso:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bcso', function(inventory)

		local inventoryItem = inventory.getItem(itemName);

        if (count and tonumber(count) and sourceItem and sourceItem.count and tonumber(sourceItem.count)) then
            -- does the player have enough of the item?
            if sourceItem.count >= count and count > 0 then
                
                xPlayer.removeInventoryItem(itemName, count);
                inventory.addItem(itemName, count);
                logsItemDestroy("[Destruction Item - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..") - "..xPlayer.job.label.." - "..xPlayer.job.grade_name.."\n\n**Viens de détruire :** "..inventoryItem.label.." x"..count, 'https://discord.com/api/webhooks/1138647125668921486/tUw_qNeYUal9M03jKQ_q8vyjjz4F6D7-jS9S00WXwWPByNXyJw2qs45Fl_45btXnXrGz')
                TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count.." "..inventoryItem.label.."");  -- Abteww à touché.
                rxeLogsDiscord("[COFFRE] "..xPlayer.getName().." a déposé "..count.." "..inventoryItem.label.." dans le coffre", 'https://canary.discord.com/api/webhooks/1093166996767637614/z21wadG1nscJj08QY9JAstgbT4TBxjtnlIGVRCBbY7J-8PZwtYMmIvu9mamnxfLvKG30')
           
            else

                TriggerClientEvent('esx:showNotification', _source, "Quantité invalide");

            end
        else

            xPlayer.showNotification("Une erreur est survenue, Code erreur ~g~'_stock_put_items_error'~s~. Veuillez contacter un administrateur.");

        end

	end);
end);

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

ESX.RegisterServerCallback('bcso:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_bcso', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end
		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('bcso:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
        logsWeaponDestroy("[Destruction Armes - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..") - "..xPlayer.job.label.." - "..xPlayer.job.grade_name.."\n\n**Viens de détruire :** "..weaponName, 'https://discord.com/api/webhooks/1138647125668921486/tUw_qNeYUal9M03jKQ_q8vyjjz4F6D7-jS9S00WXwWPByNXyJw2qs45Fl_45btXnXrGz')

		rxeLogsDiscord("[COFFRE ARMES] "..xPlayer.getName().." a déposé "..weaponName.." du coffre", 'https://canary.discord.com/api/webhooks/1093166996767637614/z21wadG1nscJj08QY9JAstgbT4TBxjtnlIGVRCBbY7J-8PZwtYMmIvu9mamnxfLvKG30')
	end
end)

RegisterServerEvent('addChargeur:bcso')
AddEventHandler('addChargeur:bcso', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    -- Check if player has the 'bcso' job
    if xPlayer.job.name == 'bcso' then
        local nameItem = "clip"
        xPlayer.addInventoryItem(nameItem, 1)
    end
end)


RegisterServerEvent('addMunitions:bcso')
AddEventHandler('addMunitions:bcso', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Check if player has the 'bcso' job
    if xPlayer.job.name ~= 'bcso' then
        TriggerEvent("tF:Protect", _source, '(addMunitions:bcso)')
        return
    end

    local nameItem = "munitions"
    local itemCount = xPlayer.getInventoryItem(nameItem).count
    
    -- Optional: Check if the player already has the maximum number of munitions allowed
    -- if itemCount >= MAX_MUNITIONS_COUNT then
    --     TriggerClientEvent('esx:showNotification', _source, 'You already have enough munitions.')
    --     return
    -- end
    
    local playerCoords = GetEntityCoords(GetPlayerPed(_source))
    local targetCoords = vector3(1818.22, 3665.73, 30.31)
    local distance = #(playerCoords - targetCoords)

    -- Check if player is within the designated zone
    if distance < 35.0 then
        xPlayer.addInventoryItem(nameItem, 1)
    else
        TriggerEvent("tF:Protect", _source, '(addMunitions:bcso) Zone')
    end
end)

RegisterServerEvent('addGilet:bcso')
AddEventHandler('addGilet:bcso', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    -- Check if player has the 'bcso' job
    if xPlayer.job.name == 'bcso' then
        local nameItem = "kevlar"
        xPlayer.addInventoryItem(nameItem, 1)
    end
end)

RegisterNetEvent('Abteww:deleteMoneyBCSO')
AddEventHandler('Abteww:deleteMoneyBCSO', function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = pSociety.GetSociety(society)
	local amount = ESX.Math.Round(tonumber(amount))
	local money = ESX.Math.GroupDigits(amount)..""..pSociety.Trad["money_symbol"]

	if xPlayer.job.name == "police" or xPlayer.job.name == "fib" or xPlayer.job.name == "bcso" then
		if amount > 0 and xPlayer.getAccount('dirtycash').money >= amount then
			xPlayer.removeAccountMoney('dirtycash', amount)
			xPlayer.showNotification("~g~Vous avez détruie "..amount.."$");
            logsSaleSaisie("[Destruction Argent - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..") - "..xPlayer.job.label.." - "..xPlayer.job.grade_name.."\n\n**Viens de détruire :** "..amount.."$", 'https://discord.com/api/webhooks/1138647125668921486/tUw_qNeYUal9M03jKQ_q8vyjjz4F6D7-jS9S00WXwWPByNXyJw2qs45Fl_45btXnXrGz')

		else
			TriggerClientEvent("RageUIv1:Popup", source, "Montant invalide !")
		end
	else
        TriggerEvent("tF:Protect", source, "(Abteww:deleteMoney)")
	end
end)

ESX.RegisterServerCallback('bcso:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 0)
	rxeLogsDiscord("[COFFRE ARMES] "..xPlayer.getName().." a retiré "..weaponName.." du coffre", 'https://canary.discord.com/api/webhooks/1093166996767637614/z21wadG1nscJj08QY9JAstgbT4TBxjtnlIGVRCBbY7J-8PZwtYMmIvu9mamnxfLvKG30')

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_bcso', function(store)
		local weapons = store.get('weapons') or {}

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('bcso:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

function rxeLogsDiscord(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 2061822,
            ["footer"]=  {
                ["text"]= "Coffre ",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function PlainteLogsDiscord(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 2061822,
            ["footer"]=  {
                ["text"]= "Plainte ",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logToDiscord(name,message,color)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = 'https://canary.discord.com/api/webhooks/1093166996767637614/z21wadG1nscJj08QY9JAstgbT4TBxjtnlIGVRCBbY7J-8PZwtYMmIvu9mamnxfLvKG30'

    local embeds = {
        {
            ["title"]= message,
            ["type"]= "rich",
            ["color"] = color,
            ["footer"]=  {
                ["text"]= "Heure: " ..local_date,
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end