RegisterServerEvent('gouv:payWeapon')
AddEventHandler('gouv:payWeapon', function(name)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "gouv" then
        TriggerEvent("tF:Protect", source, '(gouv:payWeapon)');
        return
    end

    name = string.lower(name)

    if (xPlayer.canCarryItem(name, 1)) then
        xPlayer.addWeapon(name, 255, { antiActions = 'police', removeReboot = true })
    else
        xPlayer.showNotification("~r~Vous n'avez pas de place sur vous !")
    end
end)

RegisterServerEvent('gouv:payItem')
AddEventHandler('gouv:payItem', function(name)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "gouv" then
        TriggerEvent("tF:Protect", source, '(gouv:payWeapon)');
        return
    end

    name = string.lower(name)

    if (xPlayer.canCarryItem(name, 1)) then
        xPlayer.addInventoryItem(name, 1)
        -- xPlayer.addWeapon(name, 255, { antiActions = 'police', removeReboot = true })
    else
        xPlayer.showNotification("~r~Vous n'avez pas de place sur vous !")
    end
end)

RegisterServerEvent('addChargeur:gouv')
AddEventHandler('addChargeur:gouv', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'gouv' then
        TriggerEvent("tF:Protect", source,'(addChargeur:gouv)');
        return
	end

    local nameItem = "clip"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(-401.72, 1088.16, 334.90));

    if (distance < 35.0) then
        xPlayer.addInventoryItem(nameItem, 1);
    else
        TriggerEvent("tF:Protect", source,'(addChargeur:gouv) Zone');
        return
    end
end)


RegisterServerEvent('addMunitions:gouv')
AddEventHandler('addMunitions:gouv', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'gouv' then
        TriggerEvent("tF:Protect", source,'(addMunitions:gouv)');
        return
	end

    local nameItem = "munitions"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(-401.72, 1088.16, 334.90));

    if (distance < 35.0) then
        xPlayer.addInventoryItem(nameItem, 1);
    else
        TriggerEvent("tF:Protect", source,'(addMunitions:gouv) Zone');
        return
    end
end)



RegisterServerEvent('addGilet:gouv')
AddEventHandler('addGilet:gouv', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'gouv' then
        TriggerEvent("tF:Protect", source, '(addGilet:gouv)');
        return
	end

    local nameItem = "kevlar"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(-401.72, 1088.16, 334.90));

    if (distance < 35.0) then
        if ItemSource then
            TriggerClientEvent('esx:showNotification', source, "~r~Vous possédez déjà ceci.")
        else
            xPlayer.addInventoryItem(nameItem, 1);
        end
    else        
        TriggerEvent("tF:Protect", source, '(addGilet:gouv) Zone');
        return
    end
end)

----- annonce 

RegisterServerEvent('Gouv:open')
AddEventHandler('Gouv:open', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "gouv" then
            TriggerEvent("tF:Protect", source, '(Gouv:open)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Gouvernement', '', 'Le gouvernement est désormais ~g~accessible~s~ à tout public', 'CHAR_WEAZEL', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Gouv:close')
AddEventHandler('Gouv:close', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "gouv" then
            TriggerEvent("tF:Protect", source, '(Gouv:close)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Gouvernement', '', 'Le gouvernement est désormais ~r~plus accessible~s~', 'CHAR_WEAZEL', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Gouv:recru')
AddEventHandler('Gouv:recru', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "gouv" then
            TriggerEvent("tF:Protect", source, '(Gouv:recru)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Gouvernement', '', 'Recrutement en cours, rendez-vous au gouvernement !', 'CHAR_WEAZEL', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)