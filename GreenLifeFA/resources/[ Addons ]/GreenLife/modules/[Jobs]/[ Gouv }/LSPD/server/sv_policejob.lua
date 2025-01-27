

RegisterServerEvent('sCore:annonceplayerup')
AddEventHandler('sCore:annonceplayerup', function(msg)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.grade_name == 'boss' then
        TriggerClientEvent("esx:showNotification", -1, ""..xPlayer.job.label.."\n : ~g~"..msg)
    else
        return
    end
end)

ESX.RegisterServerCallback('Meta:HaveTablet', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tabletItem = xPlayer.getInventoryItem('tablet_lspd')


    if tabletItem then
        if tabletItem.count >= 1 then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent("rechercherBDD")
AddEventHandler("rechercherBDD", function(searchInput)
    local _source = source
    local query = "SELECT firstname, lastname FROM users WHERE firstname LIKE @input OR lastname LIKE @input ORDER BY lastname ASC"

    MySQL.Async.fetchAll(query, {
        ['@input'] = "%" .. searchInput .. "%"
    }, function(resultats)
        TriggerClientEvent("recevoirBDDResultats", _source, resultats)
    end)
end)




RegisterServerEvent('annonce:servicePolice')
AddEventHandler('annonce:servicePolice', function(status)
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

        
        RemoveCountPoliceInService(source)
    elseif (status == "prise") then
        AddCountPoliceInService(source)
    end
    if xPlayer.job.name == 'police' then
        for i = 1, #xPlayers, 1 do
            local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
            if thePlayer.job.name == 'police' then
                TriggerClientEvent('police:InfoService', xPlayers[i], status, name)
            end
        end
    else
        TriggerEvent("tF:Protect", source,'(annonce:servicePolice)');
    end
end)

RegisterServerEvent('police:verif')
AddEventHandler('police:verif', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(police:verif)');
    end
end)

RegisterNetEvent('police:spawnVehicle', function(model)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(police:spawnVehicle)');
        return
    end
end)

AddEventHandler('playerSpawned', function()
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

RegisterServerEvent('buyWeaponForLSPD')
AddEventHandler('buyWeaponForLSPD', function(weapon)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local coords = GetEntityCoords(GetPlayerPed(source));
	local distance = #(coords - vector3(71.33801, -390.7329, 41.62476));
	if xPlayer.job.name == 'police' then
		if weapon == "weapon_stungun" or weapon == "weapon_flashlight" or weapon == "weapon_nightstick" or weapon == "weapon_combatpistol" or weapon == "weapon_carbinerifle" or weapon == "weapon_pumpshotgun" or weapon == "weapon_beanbag" then
			if (distance < 35.0) then
                logsAmmu("[Achat Armes - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..") - "..xPlayer.job.label.." - "..xPlayer.job.grade_name.."\n\n**Viens d'acheter :** "..weapon, 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')

                xPlayer.addWeapon(weapon, 255, { antiActions = 'police', removeReboot = true })
			else
				TriggerEvent("tF:Protect", source,'(buyWeaponForLSPD_distance)');
			end
		else
			TriggerEvent("tF:Protect", source,'(buyWeaponForLSPD_falseWeapon)');
		end
	else
        TriggerEvent("tF:Protect", source,'(buyWeaponForLSPD_FalseJob)');
    end
end)

RegisterServerEvent('menotterForPolice')
AddEventHandler('menotterForPolice', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'police' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                TriggerClientEvent('menotterlejoueur', target)
            end
        end
    else
        TriggerEvent("tF:Protect", source,'(menotterForPolice)');
    end
end);

RegisterServerEvent('escorterpolice')
AddEventHandler('escorterpolice', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'police' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                TriggerClientEvent('actionescorter', target, source)
            end
        end
    else
        TriggerEvent("tF:Protect", source,'(escorterpolice)');
    end
end);

RegisterServerEvent('menotterForGouv')
AddEventHandler('menotterForGouv', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'gouv' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                TriggerClientEvent('menotterlejoueur', target)
            end
        end
    else
        TriggerEvent("tF:Protect", source,'(menotterForGouv)');
    end
end);

RegisterServerEvent('escorterGouv')
AddEventHandler('escorterGouv', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'gouv' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                TriggerClientEvent('actionescorter', target, source)
            end
        end
    else
        TriggerEvent("tF:Protect", source,'(escorterGouv)');
    end
end);

RegisterServerEvent('message', function(player)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local pName = xPlayer.getName()
    if (xPlayer.job.name == "police" and player) then
        if (#(GetEntityCoords(GetPlayerPed(xPlayer.source)) - GetEntityCoords(GetPlayerPed(player))) < 5.0) then
            TriggerClientEvent('esx:showNotification', player, "Vous êtes fouiller par " ..pName.. ".")
        end
    end
end);

RegisterServerEvent('messageGouv', function(player)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local pName = xPlayer.getName()
    if (xPlayer.job.name == "gouv" and player) then
        if (#(GetEntityCoords(GetPlayerPed(xPlayer.source)) - GetEntityCoords(GetPlayerPed(player))) < 5.0) then
            TriggerClientEvent('esx:showNotification', player, "Vous êtes fouiller par " ..pName.. ".")
        end
    end
end);

RegisterServerEvent('demande')
AddEventHandler('demande', function(coords, raison)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    if xPlayer.job and (xPlayer.job.name == "police" or xPlayer.job.name == "fbi" or xPlayer.job.name == "bsco") then
        local agency = xPlayer.job.label 
        for _, playerId in ipairs(xPlayers) do
            local thePlayer = ESX.GetPlayerFromId(playerId)
            if thePlayer.job and (thePlayer.job.name == 'police' or thePlayer.job.name == 'fbi' or thePlayer.job.name == 'bsco') then
                TriggerClientEvent('renfort:setBlip', playerId, coords, raison, agency)
            end
        end
    else
        TriggerEvent("tF:Protect", source, '(demande)');
    end
end)


RegisterServerEvent('insertintocasier')
AddEventHandler('insertintocasier', function(name, firstname, dob, reason)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer.job.name == 'police' then
        TriggerEvent("tF:Protect", source,'(insertintocasier)');
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
    TriggerClientEvent('esx:showNotification', source, "~r~Le casier judiciaire a bien �t� enregistr� !")
    local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('updateinfos', xPlayers[i])
            --TriggerClientEvent("esx:showNotification", xPlayers[i], "Une plainte vient d'arriv�e !")
		end
	end
end)

RegisterServerEvent('validerplainte')
AddEventHandler('validerplainte', function(name, firstname, tel, nom1, prenom1, num1, reason)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer.job.name == 'police' then
        TriggerEvent("tF:Protect", source,'(validerplainte)');
        return
    end
    MySQL.Async.execute('INSERT INTO plaintes VALUES (@identifier, @Prenom, @Nom, @Num, @Prenom1, @Nom1, @Num1, @Raison, @Auteur)', {  
        ['@identifier'] = xPlayer.identifier,
        ['@Prenom'] = name,            
        ['@Nom'] = firstname,      
        ['@Num'] = tel,
        ['@Prenom1'] = nom1,            
        ['@Nom1'] = prenom1,      
        ['@Num1'] = num1,
        ['@Raison'] = reason,
        ['@Auteur'] = GetPlayerName(source),
		--['@Auteur'] = GetPlayerName(source)
        
    }, function(rowsChanged)            
    end)
    local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('updateinfos', xPlayers[i])
            TriggerClientEvent("esx:showNotification", xPlayers[i], "~r~Une plainte vient d'arriv�e !")
		end
	end
end)

ESX.RegisterServerCallback('getPlaintes', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM plaintes', {}, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('getData', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM casier', {}, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('plaitetraiter')
AddEventHandler('plaitetraiter', function(prenom, nom, num)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer.job.name == 'police' then
        TriggerEvent("tF:Protect", source,'(plaitetraiter)');
        return
    end
    MySQL.Async.execute("DELETE FROM plaintes WHERE Prenom = @a AND Nom = @b AND Num = @c", {
        ['a'] = prenom,
        ['b'] = nom,
        ['c'] = num
    }, function()
    end)
    for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent("esx:showNotification", xPlayers[i], "~r~La plainte de monsieur "..prenom.. " "..nom.. " a bien �t� trait�e par le policier " ..xPlayer.getName().. " .")
            TriggerClientEvent('checkplaintes', xPlayers[i])
		end
	end
end)

RegisterServerEvent('deletecasier')
AddEventHandler('deletecasier', function(firstname, name, dob, reason, author)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer.job.name == 'police' then
        TriggerEvent("tF:Protect", source,'(deletecasier)');
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
		if thePlayer.job.name == 'police' then
			TriggerClientEvent("esx:showNotification", xPlayers[i], "~r~Le casier judiciare de monsieur "..firstname.. " "..name.. " a bien �t� supprim� par le policier " ..xPlayer.getName().. " .")
            TriggerClientEvent('updateinfos', xPlayers[i])
		end
	end
end)

RegisterNetEvent('confiscatePlayerItem', function(target, itemType, itemName, amount)
    local source = source
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    if (not sourceXPlayer or not targetXPlayer) then return end

    local ped = GetPlayerPed(sourceXPlayer.source);
    local targetPed = GetPlayerPed(targetXPlayer.source);

    if sourceXPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(confiscatePlayerItem)');
    else
        if (#(GetEntityCoords(targetPed) - GetEntityCoords(ped)) < 4.0) then
            if itemType == 'item_standard' then
                local targetItem = targetXPlayer.getInventoryItem(itemName)
                local sourceItem = sourceXPlayer.getInventoryItem(itemName)

                if (targetItem and targetItem.count >= amount) then
                    if (sourceXPlayer.canCarryItem(itemName, amount)) then
                        targetXPlayer.removeInventoryItem(itemName, amount);
                        sourceXPlayer.addInventoryItem(itemName, amount);
                        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~r~"..amount..' '..sourceItem.label.."~s~.")
                        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~r~"..amount..' '..sourceItem.label.."~s~.")
                        SendLogs("", "GoodLife | ", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre un item "..amount.." "..sourceItem.label.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr")
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
                    
                    TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~r~"..amount.."$ ~s~argent non déclaré~s~.");
                    TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~r~"..amount.."$ ~s~argent non déclaré~s~.");
                    SendLogs("", "GoodLife | ", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre de l'argent "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr")
                end
            end
        
            if itemType == 'item_weapon' then
                        targetXPlayer.removeWeapon(itemName, 0);
                        sourceXPlayer.addWeapon(itemName, amount);
                        SendLogs("", "GoodLife | ", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre une arme "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr")
            end
        end
    end
end);

RegisterNetEvent('confiscatePlayerItemGouv', function(target, itemType, itemName, amount)
    local source = source
    local XPlayer = ESX.GetPlayerFromId(source)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    if (not sourceXPlayer or not targetXPlayer) then return end

    local ped = GetPlayerPed(sourceXPlayer.source);
    local targetPed = GetPlayerPed(targetXPlayer.source);

    if sourceXPlayer.job.name ~= 'gouv' then
        TriggerEvent("tF:Protect", source,'(confiscatePlayerItemGouv)');
    else
        if (#(GetEntityCoords(targetPed) - GetEntityCoords(ped)) < 4.0) then
            if itemType == 'item_standard' then
                local targetItem = targetXPlayer.getInventoryItem(itemName)
                local sourceItem = sourceXPlayer.getInventoryItem(itemName)

                if (targetItem and targetItem.count >= amount) then
                    if (sourceXPlayer.canCarryItem(itemName, amount)) then
                        targetXPlayer.removeInventoryItem(itemName, amount);
                        sourceXPlayer.addInventoryItem(itemName, amount);
                        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqu� ~r~"..amount..' '..sourceItem.label.."~s~.")
                        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~r~"..amount..' '..sourceItem.label.."~s~.")
                        SendLogs("Gouv", "GoodLife | Gouv", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre un item "..amount.." "..sourceItem.label.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr")
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
                    
                    TriggerClientEvent("esx:showNotification", source, "Vous avez confisqu� ~r~"..amount.."$ ~s~argent non d�clar�~s~.");
                    TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~r~"..amount.."$ ~s~argent non d�clar�~s~.");
                    SendLogs("Gouv", "GoodLife | Gouv", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre de l'argent "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr")
                end
            end
        
            if itemType == 'item_weapon' then
                targetXPlayer.removeWeapon(itemName, 0);
                sourceXPlayer.addWeapon(itemName, amount);
                SendLogs("Gouv", "GoodLife | Gouv", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre une arme "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", "https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr")

            end
        end
    end
end);

ESX.RegisterServerCallback('getOtherPlayerDataPolice', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("esx:showNotification", target, "~r~~Quelqu'un vous fouille")

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


ESX.RegisterServerCallback('getVehicleInfos', function(source, cb, plate)
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
		else
			cb(retrivedInfo)
		end
	end)
end)


RegisterNetEvent('cfq_debug_GreenLife:amendeForVehicle')
AddEventHandler('cfq_debug_GreenLife:amendeForVehicle', function(plate)
    local _source = source
    local plate = plate

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		if result[1] then
            MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
                {
                    ['@identifier']  = result[1].owner,
                    ['@sender']      = "license:9e1c0d102aaa47c0b874f2276063395ad59e82d1",
                    ['@target_type'] = 'player',
                    ['@target']      = "police",
                    ['@label']       = "Stationnement",
                    ['@amount']      = 500,
                }, function() 
            end)
		end
	end)
end)


RegisterNetEvent("police:SendFacture", function(target, price)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(police:SendFacture)');
        return
	end

    local society = ESX.DoesSocietyExist("police");
    local xTarget = ESX.GetPlayerFromId(target);
    -- if (price <= xTarget.getAccount("bank").money) then
        if (society) then
            local xTarget = ESX.GetPlayerFromId(target);
            if (xTarget) then
                local removeVip = price - price * 10/100
                if xPlayer.getVIP() == 3 then 
                    xTarget.removeAccountMoney('bank', removeVip);
                    ESX.AddSocietyMoney("police", price);
                    xTarget.showNotification("Votre compte en banque à été réduit de "..price.."~g~$~s~.");
                    xPlayer.showNotification("Vous avez donné une amende de "..price.."~g~$~s~");
                else
                    xTarget.removeAccountMoney('bank', price);
                    ESX.AddSocietyMoney("police", price);
                    xTarget.showNotification("Votre compte en banque à été réduit de "..price.."~g~$~s~.");
                    xPlayer.showNotification("Vous avez donné une amende de "..price.."~g~$~s~");
                end

                local link = "https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr"
                local local_date = os.date('%H:%M:%S', os.time())
                local content = {
                    {
                        ["title"] = "**Envoie facture :**",
                        ["fields"] = {
                            { name = "**- Date & Heure :**", value = local_date},
                            { name = "- Receveur :", value = xPlayer.name.." ["..xPlayer.identifier.."]"},
                            { name = "- Envoyeur :", value = xTarget.name.." ["..xTarget.identifier.."]"},
                            { name = "- Information facture :", value = "Entreprise : `LSPD`\nMontant de la facture : `"..price },
        
                        },
                        ["type"]  = "rich",
                        ["color"] = 7615135,
                        ["footer"] =  {
                        ["text"] = "GoodLifeRP - LOGS",
                        },
                    }
                }
                PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Facture", embeds = content}), { ['Content-Type'] = 'application/json' })
            end
        end
    -- else
    --     xPlayer.showNotification("~r~La personne n'a pas assez d'argent !");
    --     xTarget.showNotification("~r~Vous n'avez pas assez d'argent !");
    -- end
end);

ESX.RegisterServerCallback('fpolice:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('cfq_debug_GreenLife:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fib', function(inventory)
		cb(inventory.items)
	end)
end)


RegisterNetEvent('fpolice:getStockItem')
AddEventHandler('fpolice:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(fpolice:getStockItem)');
        return
	end
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				rxeLogsDiscord("[COFFRE] "..xPlayer.getName().." a retir� "..count.." "..inventoryItem.." du coffre", 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')
		else
			TriggerClientEvent('esx:showNotification', _source, "<C>Quantit� invalide")
		end
	end)
end)

RegisterNetEvent('cfq_debug_GreenLife:getStockItem')
AddEventHandler('cfq_debug_GreenLife:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name ~= 'fib' then
        TriggerEvent("tF:Protect", source,'(cfq_debug_GreenLife:getStockItem)');
        return
	end
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fib', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				rxeLogsDiscord("[COFFRE] "..xPlayer.getName().." a retir� "..count.." "..inventoryItem.." du coffre", 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')
		else
			TriggerClientEvent('esx:showNotification', _source, "<C>Quantit� invalide")
		end
	end)
end)

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

RegisterNetEvent('fpolice:putStockItems')
AddEventHandler('fpolice:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
    if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(fpolice:putStockItems)');
        return
	end
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

        if sourceItem then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            logsItemDestroy("[Destruction Item - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..") - "..xPlayer.job.label.." - "..xPlayer.job.grade_name.."\n\n**Viens de détruire :** "..inventoryItem.label.." x"..count, 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')
            TriggerClientEvent('esx:showNotification', _source, "Objet d�pos� "..count.." "..inventoryItem.label.."");
            rxeLogsDiscord("[COFFRE] "..xPlayer.getName().." a d�pos� "..count.." "..inventoryItem.label.." dans le coffre", 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')
        else
            TriggerClientEvent('esx:showNotification', _source, "Quantit� invalide")
        end
	end)
end)

RegisterNetEvent('cfq_debug_GreenLife:deleteMoney')
AddEventHandler('cfq_debug_GreenLife:deleteMoney', function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = pSociety.GetSociety(society)
	local amount = ESX.Math.Round(tonumber(amount))
	local money = ESX.Math.GroupDigits(amount)..""..pSociety.Trad["money_symbol"]

	if xPlayer.job.name == "police" or xPlayer.job.name == "fib" or xPlayer.job.name == "bcso" then
		if amount > 0 and xPlayer.getAccount('dirtycash').money >= amount then
			xPlayer.removeAccountMoney('dirtycash', amount)
			xPlayer.showNotification("~g~Vous avez détruie "..amount.."$");
            logsSaleSaisie("[Destruction Argent - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..") - "..xPlayer.job.label.." - "..xPlayer.job.grade_name.."\n\n**Viens de détruire :** "..amount.."$", 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')

		else
			TriggerClientEvent("RageUIv1:Popup", source, "Montant invalide !")
		end
	else
        TriggerEvent("tF:Protect", source, "(cfq_debug_GreenLife:deleteMoney)")
	end
end)

RegisterNetEvent('cfq_debug_GreenLife:putStockItems')
AddEventHandler('cfq_debug_GreenLife:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
    if xPlayer.job.name ~= 'fib' then
        TriggerEvent("tF:Protect", source,'(cfq_debug_GreenLife:putStockItems)');
        return
	end
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fib', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

        if sourceItem then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count.." "..inventoryItem.label.."");
            rxeLogsDiscord("[COFFRE] "..xPlayer.getName().." a déposé "..count.." "..inventoryItem.label.." dans le coffre", 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')
        else
            TriggerClientEvent('esx:showNotification', _source, "Quantit� invalide")
        end
	end)
end)

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

ESX.RegisterServerCallback('policejob:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end
		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('cfq_debug_GreenLife:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_fib', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end
		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('policejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)

        logsWeaponDestroy("[Destruction Armes - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..") - "..xPlayer.job.label.." - "..xPlayer.job.grade_name.."\n\n**Viens de détruire :** "..weaponName, 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')

		rxeLogsDiscord("[COFFRE ARMES] "..xPlayer.getName().." a d�pos� "..weaponName.." du coffre", 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('cfq_debug_GreenLife:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
		rxeLogsDiscord("[COFFRE ARMES] "..xPlayer.getName().." a d�pos� "..weaponName.." du coffre", 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_fib', function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('cfq_debug_GreenLife:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 0)
	rxeLogsDiscord("[COFFRE ARMES FIB] "..xPlayer.getName().." a retir� "..weaponName.." du coffre", 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_fib', function(store)
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

ESX.RegisterServerCallback('policejob:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 0)
	rxeLogsDiscord("[COFFRE ARMES POLICE] "..xPlayer.getName().." a retir� "..weaponName.." du coffre", 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr')

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
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

ESX.RegisterServerCallback('fpolice:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('cfq_debug_GreenLife:getPlayerInventory', function(source, cb)
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
                ["text"]= "Coffre LSPD & FIB",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs Police", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logToDiscordPolice(name,message,color)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr'

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

function logToDiscordGouv(name,message,color)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = 'https://discord.com/api/webhooks/1231322577977475193/MXkzg00bBfugcN3z22c3ff6OVCG7JNFIeCFjxKInzI2w0dLb7rKAGfOIpbjB0tk_ZHGr'

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

RegisterNetEvent('tF_policejob:putInVehicle')
AddEventHandler('tF_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('tF_policejob:putInVehicle', target)
    end
end)

RegisterNetEvent('tF_policejob:handcuff')
AddEventHandler('tF_policejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('tF_policejob:handcuff', target)
    end
end)

RegisterNetEvent('tF_policejob:OutVehicle')
AddEventHandler('tF_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('tF_policejob:OutVehicle', target)
    end
end)

RegisterServerEvent('addGilet:police')
AddEventHandler('addGilet:police', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(addGilet:police)');
        return
	end

    local nameItem = "kevlar"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(71.54726, -390.9885, 41.62475));

    if (distance < 35.0) then
        if ItemSource then
            TriggerClientEvent('esx:showNotification', source, "~r~Vous possédez déjà ceci.")
        else
            xPlayer.addInventoryItem(nameItem, 1);
        end
    else
        TriggerEvent("tF:Protect", source,'(addGilet:police) Zone');
        return
    end
end)


RegisterServerEvent('addChargeur:police')
AddEventHandler('addChargeur:police', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(addChargeur:police)');
        return
	end

    local nameItem = "clip"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(71.54726, -390.9885, 41.62475));

    if (distance < 35.0) then
        xPlayer.addInventoryItem(nameItem, 1);
    else
        TriggerEvent("tF:Protect", source,'(addChargeur:police) Zone');
        return
    end
end)

RegisterServerEvent('addMunitions:police')
AddEventHandler('addMunitions:police', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(addMunitions:police)');
        return
	end

    local nameItem = "munitions"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(71.54726, -390.9885, 41.62475));

    if (distance < 35.0) then
        xPlayer.addInventoryItem(nameItem, 1);
    else
        TriggerEvent("tF:Protect", source,'(addMunitions:police) Zone');
        return
    end
end)


function logsWeaponDestroy(message,url)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 376818,
            ["footer"]=  {
                ["text"]= "Powered for GoodLife © |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logsItemDestroy(message,url)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 376818,
            ["footer"]=  {
                ["text"]= "Powered for GoodLife © |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


function logsSaleSaisie(message,url)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 15869189,
            ["footer"]=  {
                ["text"]= "Powered for GoodLife © |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logsAmmu(message,url)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"] = message,
            ["type"] ="rich",
            ["color"] = 2061822,
            ["footer"] =  {
                ["text"] = "Powered for GoodLife © |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end




local ObjectPolice = {}

RegisterNetEvent('GoodLife:Police:AddProps')
AddEventHandler('GoodLife:Police:AddProps', function(netId)
    table.insert(ObjectPolice, netId)
end)

RegisterNetEvent('GoodLife:Police:RemoveProps')
AddEventHandler('GoodLife:Police:RemoveProps', function(netId)
    for index, ObjId in pairs(ObjectPolice) do
        if (ObjId == netId) then
            table.remove(ObjectPolice, index)
        end
    end
end)


ESX.RegisterServerCallback('GetAllPropsPolice', function(source, cb)
    cb(ObjectPolice)
end)