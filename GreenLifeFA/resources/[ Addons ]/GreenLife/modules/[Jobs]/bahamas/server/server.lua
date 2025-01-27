local TimeoutJob4 = {};

RegisterServerEvent('GreenLife:bahamas:open')
AddEventHandler('GreenLife:bahamas:open', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "bahamas" then
            TriggerEvent("tF:Protect", source,'(Ouvre:unicorn)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Unicorn', 'Annonce Unicorn', 'Le bahamas est désormais ~g~Ouvert~s~ !', 'CHAR_UNICORN', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('GreenLife:bahamas:close')
AddEventHandler('GreenLife:bahamas:close', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "bahamas" then
            TriggerEvent("tF:Protect", source,'(Ouvre:unicorn)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Unicorn', 'Annonce Unicorn', 'Le bahamas est désormais ~r~fermer~s~ !', 'CHAR_UNICORN', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('GreenLife:bahamas:perso')
AddEventHandler('GreenLife:bahamas:perso', function(message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if xPlayer.job.name ~= "bahamas" then
        TriggerEvent("tF:Protect", _source, '(Accès refusé : annonce non autorisée).')
        return
    end
    if TimeoutJob4[identifier] and os.time() - TimeoutJob4[identifier] < 600 then
        local timeLeft = 600 - (os.time() - TimeoutJob4[identifier])
        TriggerClientEvent('esx:showNotification', _source, ('Veuillez patienter %s secondes avant de refaire une annonce.'):format(timeLeft))
        return
    end

    TimeoutJob4[identifier] = os.time()

    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Bahamas', 'Annonce Bahamas', message, 'CHAR_BAHAMAS', 8)
    end
end)