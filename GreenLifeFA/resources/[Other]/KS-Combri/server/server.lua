ESX = nil
local pnjstart = false
---------------------------------
--------- Give item -------------
---------------------------------

 -- Si vous avez le poids sur votre serveur enelver les ( -- ) devant la ligne 17,20,21 et 23.

Config.ESX_GetCoreObject_serveur()

RegisterServerEvent('esx_cambriolage:giveitem')
AddEventHandler('esx_cambriolage:giveitem', function(item)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
	if Config.legacy == "non" then

		xPlayer.addInventoryItem(item, 1)
		TriggerClientEvent('esx:showNotification', src, 'Objet Volé '..item..'')
		
	elseif Config.legacy == "oui" then
	
		if xPlayer.canCarryItem(item, 1) then
			xPlayer.addInventoryItem(item, 1)
			TriggerClientEvent('esx:showNotification', src, 'Objet Volé '..item..'')
		else
			TriggerClientEvent('esx:showNotification', src, 'Vous n\':avez pas assez de place sur vous')

		end 
	end
end)
---------------------------------
--------- Give item -------------
---------------------------------

ESX.RegisterServerCallback('esx_cambriolage:GetGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer ~= nil then
        local playerGroup = xPlayer.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end)
---------------------------------
--------- Alerte lspd -----------
---------------------------------
ESX.RegisterServerCallback('esx_cambriolage:getflicnombre', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xPlayers = ESX.GetPlayers()
    local flic = 0

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'fib' or xPlayer.job.name == 'bcso' then
            flic = flic + 1
            policier = xPlayers[i]
        end
    end
    cb(flic)
end)

RegisterServerEvent('esx_cambriolage:createblip')
AddEventHandler('esx_cambriolage:createblip', function(maison)
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'fib' or xPlayer.job.name == 'bcso' then
            local jobLabel = xPlayer.job.label
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], jobLabel .. ' INFORMATION', 'CENTRAL ' .. jobLabel, 
                'Appel d\'un citoyen concernant un ~r~cambriolage~w~ d\'une maison voisine.', 'CHAR_CHAT_CALL', 8)
            TriggerClientEvent('esx_cambriolage:blip', xPlayers[i], maison)
        end
    end
end)




---------------------------------
--------- Menu revente ----------
---------------------------------
 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--------- revente Tableau ----------

RegisterServerEvent('esx_cambriolage:Tableau')
AddEventHandler('esx_cambriolage:Tableau', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
        local inventoryItem = xPlayer.getInventoryItem('tableau')

        if inventoryItem and inventoryItem.count then
            local Quantity = inventoryItem.count
            local Prixtableau = Config.PrixTableau

            if Quantity >= 1 then  
                xPlayer.addAccountMoney('dirtycash', Prixtableau)
                xPlayer.removeInventoryItem('tableau', 1)
                TriggerClientEvent('esx:showNotification', source, 'Vous avez vendu un ~r~Tableau~s~ pour ' .. Prixtableau .. '$')
            else
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de ~r~tableau~s~ à me vendre')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de ~r~tableau~s~ à me vendre')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Erreur: Impossible de trouver le joueur')
    end
end)

--------- revente Tableau ----------


--------- revente Télé ----------

RegisterServerEvent('esx_cambriolage:Télé')
AddEventHandler('esx_cambriolage:Télé', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
        local inventoryItem = xPlayer.getInventoryItem('tele')

        if inventoryItem and inventoryItem.count then
            local Quantity = inventoryItem.count
            local PrixTV = Config.PrixTV

            if Quantity >= 1 then
                xPlayer.addAccountMoney('dirtycash', PrixTV)   
                xPlayer.removeInventoryItem('tele', 1)
                TriggerClientEvent('esx:showNotification', source, 'Vous avez vendu une ~r~Télé~s~ pour ' .. PrixTV .. '$')
            else
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de ~r~télé~s~ à me vendre')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de ~r~télé~s~ à me vendre')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Erreur: Impossible de trouver le joueur')
    end
end)

--------- revente Télé ----------


--------- revente PC ----------

RegisterServerEvent('esx_cambriolage:Pc')
AddEventHandler('esx_cambriolage:Pc', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
        local inventoryItem = xPlayer.getInventoryItem('pc')

        if inventoryItem and inventoryItem.count then
            local Quantity = inventoryItem.count
            local PrixPc = Config.PrixPc

            if Quantity >= 1 then  
                xPlayer.addAccountMoney('dirtycash', PrixPc)
                xPlayer.removeInventoryItem('pc', 1)
                TriggerClientEvent('esx:showNotification', source, 'Vous avez vendu un ~r~PC~s~ pour ' .. PrixPc .. '$')
            else
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de ~r~Pc~s~ à me vendre')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de ~r~Pc~s~ à me vendre')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Erreur: Impossible de trouver le joueur')
    end
end)


--------- revente PC ----------


--------- revente Vase ----------

RegisterServerEvent('esx_cambriolage:Vase')
AddEventHandler('esx_cambriolage:Vase', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
        local inventoryItem = xPlayer.getInventoryItem('vase')

        if inventoryItem and inventoryItem.count then
            local Quantity = inventoryItem.count
            local PrixVase = Config.PrixVase

            if Quantity >= 1 then  
                xPlayer.addAccountMoney('dirtycash', PrixVase)
                xPlayer.removeInventoryItem('vase', 1)
                TriggerClientEvent('esx:showNotification', source, 'Vous avez vendu un ~r~Vase~s~ pour ' .. PrixVase .. '$')
            else
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de ~r~Vase~s~ à me vendre')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de ~r~Vase~s~ à me vendre')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Erreur: Impossible de trouver le joueur')
    end
end)

--------- revente Vase ----------


--------- revente Enceinte ----------
RegisterServerEvent('esx_cambriolage:Enceinte')
AddEventHandler('esx_cambriolage:Enceinte', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
        local inventoryItem = xPlayer.getInventoryItem('enceinte')

        if inventoryItem and inventoryItem.count then
            local Quantity = inventoryItem.count
            local PrixEnceinte = Config.Prixenceinte

            if Quantity >= 1 then  
                xPlayer.addAccountMoney('dirtycash', PrixEnceinte)
                xPlayer.removeInventoryItem('enceinte', 1)
                TriggerClientEvent('esx:showNotification', source, 'Vous avez vendu une ~r~Enceinte~s~ pour ' .. PrixEnceinte .. '$')
            else
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas d\'~r~Enceinte~s~ à me vendre')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas d\'~r~Enceinte~s~ à me vendre')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Erreur: Impossible de trouver le joueur')
    end
end)

--------- revente Enceinte ----------


--------- revente Bijoux ----------

RegisterServerEvent('esx_cambriolage:Bijoux')
AddEventHandler('esx_cambriolage:Bijoux', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
        local inventoryItem = xPlayer.getInventoryItem('bijoux')

        if inventoryItem and inventoryItem.count then
            local Quantity = inventoryItem.count
            local PrixBijoux = Config.PrixBijoux

            if Quantity >= 1 then  
                xPlayer.addAccountMoney('dirtycash', PrixBijoux)
                xPlayer.removeInventoryItem('bijoux', 1)
                TriggerClientEvent('esx:showNotification', source, 'Vous avez vendu un ~r~Bijoux~s~ pour ' .. PrixBijoux .. '$')
            else
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de ~r~Bijoux~s~ à me vendre')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas de ~r~Bijoux~s~ à me vendre')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Erreur: Impossible de trouver le joueur')
    end
end)

--------- revente Bijoux ----------
