local local_date = os.date('%H:%M:%S', os.time())

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'journalist', 'alerte Weazel News', true, true)
TriggerEvent('esx_society:registerSociety', 'journalist', 'journalist', 'society_journalist', 'society_journalist', 'society_journalist', {type = 'public'})

local TimeoutJob7 = {};

RegisterServerEvent('Ouvre:journalist')
AddEventHandler('Ouvre:journalist', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "journalist" then
            TriggerEvent("tF:Protect", source, '(Ouvre:journalist)');
            return
        end
        logsAllJob("[Annonce (Ouverture) - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Annonce :** Viens d'annonce l'ouverture", 'https://discord.com/api/webhooks/1138281940307427450/D8rjps2ysm8t0MzAJN41KjEZBsfbhUlSwKudn9SmdNfvd5WHvZeFBWarZbjTxQj5xS7o')
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Weazel News', '', 'Le Weazel News est actuellement ~g~ouvert ~s~ !', 'CHAR_WEAZEL', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:journalist')
AddEventHandler('Ferme:journalist', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "journalist" then
            TriggerEvent("tF:Protect", source, '(Ferme:journalist)');
            return
        end
        logsAllJob("[Annonce (Fermeture) - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Annonce :** Viens d'annonce la fermeture", 'https://discord.com/api/webhooks/1138281940307427450/D8rjps2ysm8t0MzAJN41KjEZBsfbhUlSwKudn9SmdNfvd5WHvZeFBWarZbjTxQj5xS7o')
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Weazel News', '', 'Le Weazel News est désormais  ~r~fermer~s~', 'CHAR_WEAZEL', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:journalist')
AddEventHandler('Recrutement:journalist', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "journalist" then
            TriggerEvent("tF:Protect", source, '(Recrutement:journalist)');
            return
        end
        logsAllJob("[Annonce (Recrutement) - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Annonce :** Viens d'annonce un recrutement", 'https://discord.com/api/webhooks/1138281940307427450/D8rjps2ysm8t0MzAJN41KjEZBsfbhUlSwKudn9SmdNfvd5WHvZeFBWarZbjTxQj5xS7o')
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Weazel News', '', 'Recrutement en cours, rendez-vous au Weazel News', 'CHAR_WEAZEL', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Custom:journalist')
AddEventHandler('Custom:journalist', function(AnnonceCustom)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "journalist" then
            TriggerEvent("tF:Protect", source, '(Custom:journalist)');
            return
        end
        logsAllJob("[Annonce (Custom) - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Annonce (Custom) :** "..AnnonceCustom, 'https://discord.com/api/webhooks/1138281940307427450/D8rjps2ysm8t0MzAJN41KjEZBsfbhUlSwKudn9SmdNfvd5WHvZeFBWarZbjTxQj5xS7o')
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Weazel News', '', AnnonceCustom, 'CHAR_WEAZEL', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterNetEvent('journaliste:spawnVehicleJournalist', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'journalist' then
        TriggerEvent("tF:Protect", source, '(journaliste:spawnVehicleJournalist)');
        return
    end
end)