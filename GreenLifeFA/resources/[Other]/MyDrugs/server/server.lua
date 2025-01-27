ESX = nil

Config.ESX_GetCoreObject_serveur()
---------------------------------
------------- COKE --------------
---------------------------------


RegisterNetEvent('MD_Drogue:givedrogue')
AddEventHandler('MD_Drogue:givedrogue', function(drogueType)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local drogueConfig = Config.Drogues[drogueType]
    
    if not drogueConfig then
        TriggerClientEvent('esx:showNotification', src, 'Drogue inconnue')
        return
    end
    local item_itemName = drogueConfig.itemName

	if Config.ox_inventory == true then
		local success, response = exports.ox_inventory:AddItem(xPlayer.source, item_itemName, 1)
		if not success then
			print(('Échec de la remise de l\'objet au joueur %s: %s'):format(source, response))
			
			return
		end 
	else

	if Config.legacy == "non" then
		xPlayer.addInventoryItem(item_itemName, 1)
		
		TriggerClientEvent('esx:showNotification', src, 'Tu as recolter '..item_itemName..'')
		
	elseif Config.legacy == "oui" then
		if xPlayer.canCarryItem(item_itemName, 1) then
			xPlayer.addInventoryItem(item_itemName, 1)
			TriggerClientEvent('esx:showNotification', src, 'Tu as recolter '..item_itemName..'')
		else
			TriggerClientEvent('esx:showNotification', src, 'Vous n\':avez pas assez de place sur vous')

		end 
	end
end
end)
ESX.RegisterServerCallback('MD_Drogue:checkItemForRevente', function(source, cb, itemName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = 0

    if xPlayer and xPlayer.inventory then
        for _, item in ipairs(xPlayer.inventory) do
            if item.name == itemName then
                itemCount = item.count
                break
            end
        end
    end

    cb(itemCount)
end)

RegisterNetEvent('MD_Drogue:givesachet')
AddEventHandler('MD_Drogue:givesachet', function(drogueType)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local drogueConfig = Config.Drogues[drogueType]
    
    if not drogueConfig then
        TriggerClientEvent('esx:showNotification', src, 'Drogue inconnue')
        return
    end
	
	local item = drogueConfig.sachetName

    local item2 = drogueType
    local Quantity_drogue = xPlayer.getInventoryItem(item2).count
    local QuantityParTraitement = drogueConfig.quantiteParTraitement

    if Config.ox_inventory then
        if Quantity_drogue >= QuantityParTraitement then
            local success, response = exports.ox_inventory:RemoveItem(xPlayer.source, item2, QuantityParTraitement)
            if not success then
                TriggerClientEvent('esx:showNotification', src, 'Erreur lors du retrait de ' .. item2 .. ' : ' .. response)
                return
            end
            
            success, response = exports.ox_inventory:AddItem(xPlayer.source, item, 1)
            if not success then
                TriggerClientEvent('esx:showNotification', src, 'Erreur lors de l\'ajout du sachet : ' .. response)
                return
            end
            
            TriggerClientEvent('esx:showNotification', src, 'Tu as fabriqué un ' .. item)
        else
            TriggerClientEvent('esx:showNotification', src, ('Vous n\'avez pas assez de ' .. item2 .. '. Il vous faut ' .. QuantityParTraitement .. ' de ' .. item2 .. ' au total.'))
        end
    else
        if Quantity_drogue >= QuantityParTraitement then
            if Config.legacy == "non" then
                xPlayer.removeInventoryItem(item2, QuantityParTraitement)
                xPlayer.addInventoryItem(item, 1)
                TriggerClientEvent('esx:showNotification', src, 'Tu as fabriqué un ' .. item)
            elseif Config.legacy == "oui" then
                if xPlayer.canCarryItem(item, 1) then
                    xPlayer.removeInventoryItem(item2, QuantityParTraitement)
                    xPlayer.addInventoryItem(item, 1)
                    TriggerClientEvent('esx:showNotification', src, 'Tu as fabriqué un ' .. item)
                else
                    TriggerClientEvent('esx:showNotification', src, 'Vous n\'avez pas assez de place sur vous')
                end 
            end
        else
            TriggerClientEvent('esx:showNotification', src, ('Vous n\'avez pas assez de ' .. item2 .. '. Il vous faut ' .. QuantityParTraitement .. ' de ' .. item2 .. ' au total.'))
        end
    end
end)


RegisterServerEvent('MD_Drogue:revente')
AddEventHandler('MD_Drogue:revente', function(drogueType)

    local drogueConfig = Config.Drogues[drogueType]

    if not drogueConfig then
        TriggerClientEvent('esx:showNotification', source, 'Drogue inconnue')
        return
    end

    local src = source
    local item_sachet = drogueConfig.sachetName
    local xPlayer = ESX.GetPlayerFromId(src)
    local prixRevente = drogueConfig.prixRevente
    local QuantityParTraitement = drogueConfig.quantiteParTraitement

    if Config.ox_inventory then
    	exports.ox_inventory:RemoveItem(src, item_sachet, 1)
        xPlayer.addAccountMoney('black_money', prixRevente)
        TriggerClientEvent('esx:showNotification', src, 'Tu as revendu un ' .. item_sachet .. ' pour ' .. prixRevente .. ' $') 
    else
        local Quantity_item_sachet = xPlayer.getInventoryItem(item_sachet).count

        if Quantity_item_sachet >= 1 then
            if Config.legacy == "non" then
                xPlayer.removeInventoryItem(item_sachet, 1)
                xPlayer.addAccountMoney('black_money', prixRevente)
                TriggerClientEvent('esx:showNotification', src, 'Tu as revendu un ' .. item_sachet .. ' pour ' .. prixRevente .. ' $')
            elseif Config.legacy == "oui" then
                if xPlayer.canCarryItem(item_sachet, 1) then
                    xPlayer.removeInventoryItem(item_sachet, 1)
                    xPlayer.addAccountMoney('black_money', prixRevente)
                    TriggerClientEvent('esx:showNotification', src, 'Tu as revendu un ' .. item_sachet .. ' pour ' .. prixRevente .. ' $')
                else
                    TriggerClientEvent('esx:showNotification', src, 'Vous n\'avez pas assez de place sur vous')
                end
            end
        else
            TriggerClientEvent('esx:showNotification', src, 'Vous n\'avez pas de ' .. item_sachet .. ' à revendre')
        end
    end
end)

