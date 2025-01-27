--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]


local ServerConfig = {
    webhooks = "https://discord.com/api/webhooks/1226437102426656850/KjeJMU3c7dwjdMBjCsd4ZaWn1CBeUmUWvLAbJtgaPC6YvqkI2iqeT04WuzgydEZ6TzOk",
    webhooksTitle = "GreenLife",
    webhooksColor = 2061822,
}

function CheckLicense(source, type, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(result)
		if tonumber(result[1].count) > 0 then
			cb(true)
		else
			cb(false)
		end
	end)
end

ESX.RegisterServerCallback('checkLicense', function(source, cb, type)
    CheckLicense(source, 'weapon', cb)
end)

local AntiSpamLimit = {}

RegisterServerEvent('addPPA')
AddEventHandler('addPPA', function(weapon)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getAccount('cash').money
    
	if (not AntiSpamLimit[xPlayer.identifier] or GetGameTimer() - AntiSpamLimit[xPlayer.identifier] > 300000) then
		if playerMoney >= Config.Ammunation.PPA.price then
			AntiSpamLimit[xPlayer.identifier] = GetGameTimer()
			MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @identifier AND type = @type', {
				['@identifier'] = xPlayer.identifier,
				['@type'] = 'weapon'
			},function(result)
				Wait(500)
				if result[1] then
					return
				else
					MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
						['@type'] = 'weapon',
						['@owner'] = xPlayer.identifier
					})
					xPlayer.addInventoryItem('weapon', 1, { antiActions = true })
				end
			end)
			xPlayer.removeAccountMoney('cash', Config.Ammunation.PPA.price)
			TriggerClientEvent('esx:showNotification', source, "~g~Achat réussis !")
		else
			TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez !")
		end
	end
end)

RegisterServerEvent("buyWeaponwhiteWeapon")
AddEventHandler("buyWeaponwhiteWeapon", function(item, price)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    for k, v in pairs(Config.Ammunation.Items.whiteWeapon) do
        if item == v.item then
            if price ~= v.price then
				TriggerEvent("tF:Protect", source, '(ammunation:buyWeaponwhiteWeapon)');
                -- Trigger de ban
			else
				if xPlayer.getAccount('cash').money >= tonumber(price) then
					if (xPlayer.canCarryItem(item, 1)) then
						xPlayer.removeAccountMoney('cash', tonumber(price))
						xPlayer.addWeapon(item)
						xPlayer.showNotification("~r~Armurerie\n~s~Vous venez d'acheter une arme (-".. price .." ~g~$~s~)")
						ServerToDiscord(ServerConfig.webhooksTitle, '[ARMURIE] ' ..xPlayer.getName().. ' vient d\'acheter une arme (NOM : ' ..item..' - PRIX : ' ..price.. ')', ServerConfig.webhooksColor)
					else
						xPlayer.showNotification("~r~Vous n'avez pas de place sur vous !")
					end
				else
					xPlayer.showNotification("~r~Il semblerait que vous ne possésez pas l'argent nécessaire")
				end
            end
        end
    end
end)

RegisterServerEvent("buyWeaponwhiteWeaponVip")
AddEventHandler("buyWeaponwhiteWeaponVip", function(item, price)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

	if xPlayer.getVIP() == 3 then
		for k, v in pairs(Config.Ammunation.Items.whiteWeaponVIP) do
			if item == v.item then
				if price ~= v.price then
					TriggerEvent("tF:Protect", source, '(ammunation:buyWeaponwhiteWeaponVip)');
					-- Trigger de ban
				else
					if xPlayer.getAccount('cash').money >= tonumber(price) then
						if (xPlayer.canCarryItem(item, 1)) then
							xPlayer.removeAccountMoney('cash', tonumber(price))
							xPlayer.addWeapon(item)
							xPlayer.showNotification("~r~Armurerie\n~s~Vous venez d'acheter une arme (-".. price .." ~g~$~s~)")
							ServerToDiscord(ServerConfig.webhooksTitle, '[ARMURIE] ' ..xPlayer.getName().. ' vient d\'acheter une arme (NOM : ' ..item..' - PRIX : ' ..price.. ')', ServerConfig.webhooksColor)
						else
							xPlayer.showNotification("~r~Vous n'avez pas de place sur vous !")
						end
					else
						xPlayer.showNotification("~r~Il semblerait que vous ne possésez pas l'argent nécessaire")
					end
				end
			end
		end
	else
		TriggerEvent("tF:Protect", source, '(ammunation:buyWeaponwhiteWeaponVip : No VIP)');
	end
end)

RegisterServerEvent("buyWeaponletalWeapon")
AddEventHandler("buyWeaponletalWeapon", function(item, price)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    for k, v in pairs(Config.Ammunation.Items.letalWeapon) do
        if item == v.item then
            if price ~= v.price then
				TriggerEvent("tF:Protect", source, '(ammunation:buyWeaponletalWeapon)');
                -- Trigger de ban
			else
				if xPlayer.getAccount('cash').money >= tonumber(price) then
					if (xPlayer.canCarryItem(item, 1)) then
						xPlayer.removeAccountMoney('cash', tonumber(price))
						xPlayer.addWeapon(item)
						xPlayer.showNotification("~r~Armurerie\n~s~Vous venez d'acheter une arme (-".. price .." ~g~$~s~)")
						ServerToDiscord(ServerConfig.webhooksTitle, '[ARMURIE] ' ..xPlayer.getName().. ' vient d\'acheter une arme (NOM : ' ..item..' - PRIX : ' ..price.. ')', ServerConfig.webhooksColor)
					else
						xPlayer.showNotification("~r~Vous n'avez pas de place sur vous !")
					end
				else
					xPlayer.showNotification("~r~Il semblerait que vous ne possésez pas l'argent nécessaire")
				end
            end
        end
    end
end)

RegisterServerEvent("buyWeaponaccessories")
AddEventHandler("buyWeaponaccessories", function(item, price)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    for k, v in pairs(Config.Ammunation.Items.accessories) do
        if item == v.item then
            if price ~= v.price then
				TriggerEvent("tF:Protect", source, '(ammunation:buyWeaponaccessories)');
                -- Trigger de ban
			else
				if xPlayer.getAccount('cash').money >= tonumber(price) then
					if (xPlayer.canCarryItem(item, 1)) then
						xPlayer.removeAccountMoney('cash', tonumber(price))
						xPlayer.addInventoryItem(item, 1)
						xPlayer.showNotification("~r~Armurerie\n~s~Vous venez d'acheter un item (-".. price .." ~g~$~s~)")
						ServerToDiscord(ServerConfig.webhooksTitle, '[ARMURIE] ' ..xPlayer.getName().. ' vient d\'acheter un accessoire (NOM : ' ..item..' - PRIX : ' ..price.. ')', ServerConfig.webhooksColor)
					else
						xPlayer.showNotification("~r~Vous n'avez pas de place sur vous !")
					end
				else
					xPlayer.showNotification("~r~Il semblerait que vous ne possésez pas l'argent nécessaire")
				end
            end
        end
    end
end)


RegisterServerEvent('removeChargeur')
AddEventHandler('removeChargeur', function(ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('clip', 1)

	TriggerEvent('GreenLife:Inventory:AddWeaponAmmo', false, ammo, source)
end)

RegisterServerEvent('removeMunitions')
AddEventHandler('removeMunitions', function(ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('munitions', 1)
end)

ESX.RegisterUsableItem('clip', function(source)
	TriggerClientEvent('useChargeur', source)
end)

ESX.RegisterUsableItem('munitions', function(source)
	TriggerClientEvent('useMunitions', source)
end)

ServerToDiscord = function(name, message, color)
	date_local1 = os.date('%H:%M:%S', os.time())
	local date_local = date_local1
	local DiscordWebHook = ServerConfig.webhooks

    local embeds = {
	    {
		    ["title"]= message,
		    ["type"]="rich",
		    ["color"] =color,
		    ["footer"]=  {
			    ["text"]= "Heure : " ..date_local.. "",
		    },
	    }
    }

	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end 