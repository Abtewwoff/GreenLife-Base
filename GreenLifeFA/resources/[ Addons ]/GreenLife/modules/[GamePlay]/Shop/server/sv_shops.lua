local listeItem = {
    ['phone'] = {name = 'phone', label = 'Samsung', price = 1500, category = 'Superette'},
    ['fishingrod'] = {name = 'fishingrod', label = 'Canne à pêche', price = 1000, category = 'Superette'},
    ['bread'] = {name = 'bread', label = 'Pain', price = 15, category = 'Superette'},
    ['water'] = {name = 'water', label = 'Eau de source', price = 15, category = 'Superette'},
    ['radio'] = {name = 'radio', label = 'Radio', price = 1000, category = 'Superette'},
    --
    ['pizzamarguerita'] = {name = 'pizzamarguerita', label = 'Pizza\'s Marguerita', price = 100, category = 'Pizzaria'},
    ['pizzaroyal'] = {name = 'pizzaroyal', label = 'Pizza\'s Royal', price = 100, category = 'Pizzaria'},
    --
    ['pates'] = {name = 'pates', label = 'Pâtes', price = 100, category = 'Italian'},
    ['patespesto'] = {name = 'patespesto', label = 'Pâtes au Pesto', price = 100, category = 'Italian'},
    --
    ['clip'] = {name = 'clip', label = 'Boite de Munitions', price = 5000, category = 'Ammu-Nation1'},
    --
    ['weapon_poolcue'] = {name = 'weapon_poolcue', label = 'Queue de Billard', price = 5000, category = 'Ammu-Nation'},
    ['weapon_knuckle'] = {name = 'weapon_knuckle', label = 'Poing Américain', price = 5000, category = 'Ammu-Nation'},
    ['weapon_pistol'] = {name = 'weapon_pistol', label = 'Pistolet Simple', price = 300000, category = 'Ammu-Nation'},
    --
    
    ['jusleechi'] = {name = 'jusleechi', label = 'Jus de Leechi ( ~g~Premium + )', price = 50, category = 'Superette'},
    ['hotdog'] = {name = 'hotdog', label = 'Hot-dog ( ~g~Premium + )', price = 50, category = 'Superette'},
}

RegisterServerEvent('core:achat')
AddEventHandler('core:achat', function(item, price, type, numberQty)
    print(numberQty)
    local xPlayer = ESX.GetPlayerFromId(source)
    if listeItem[item] == nil then
        DropPlayer(source, 'Utilisation d\'un Trigger ( LTD )'.. item, price, type)
    else
        if listeItem[item].name == item and listeItem[item].price == tonumber(price) then
            if type == 1 then
                if xPlayer.getAccount('cash').money >= listeItem[item].price then
                    local totalPrice = price * numberQty
                    xPlayer.removeAccountMoney('cash', totalPrice)
                        if listeItem[item].name == "phone" or listeItem[item].name == "fishingrod" or listeItem[item].name == "water" or listeItem[item].name == "bread" or listeItem[item].name == "radio" then
                            xPlayer.addInventoryItem(listeItem[item].name, numberQty)
                            xPlayer.showNotification("Vous avez acheté en Liquide "..numberQty.." "..listeItem[item].label.." pour "..totalPrice.." $")
                            local _src = source
                            local pseudo  = GetPlayerName(source)
                            local steamhex = xPlayer.identifier
                            local content = {
                                {
                                    ["title"] = "**Shop :**",
                                    ["fields"] = {
                                        -- { name = "**- Date & Heure :**", value = local_date },
                                        { name = "- Joueur :", value = pseudo.." [".._src.."] ["..steamhex.."]" },
                                        { name = "- Item acheter :", value = listeItem[item].label.." x"..numberQty },
                                        { name = "- Prix payer :", value = price.."$" },
                                    },
                                    ["type"]  = "rich",
                                    ["color"] = 2061822,
                                    ["footer"] =  {
                                    ["text"] = "By Kazuto | GreenLife",
                                    },
                                }
                            }
                            PerformHttpRequest("https://discord.com/api/webhooks/1226437102426656850/KjeJMU3c7dwjdMBjCsd4ZaWn1CBeUmUWvLAbJtgaPC6YvqkI2iqeT04WuzgydEZ6TzOk", function(err, text, headers) end, 'POST', json.encode({username = "Logs SHOP", embeds = content}), { ['Content-Type'] = 'application/json' })
                        end
                else
                    xPlayer.showNotification("~g~".. listeItem[item].category .."\nVous n\'avez pas l\'argent nécéssaire")
                end
                
            elseif type == 2 then
                if tonumber(xPlayer.getAccount('bank').money) >= price then
                    totalPrice = price * numberQty
                    xPlayer.removeAccountMoney('bank', totalPrice)
                    xPlayer.addInventoryItem(listeItem[item].name, numberQty)
                    local _src = source
                    local pseudo  = GetPlayerName(source)
                    local steamhex = xPlayer.identifier
                    local content = {
                        {
                            ["title"] = "**Shop :**",
                            ["fields"] = {
                                -- { name = "**- Date & Heure :**", value = local_date },
                                { name = "- Joueur :", value = pseudo.." [".._src.."] ["..steamhex.."]" },
                                { name = "- Item acheter :", value = listeItem[item].label.." x"..numberQty },
                                { name = "- Prix payer :", value = totalPrice.."$" },
                            },
                            ["type"]  = "rich",
                            ["color"] = 2061822,
                            ["footer"] =  {
                            ["text"] = "By Kazuto | GreenLife",
                            },
                        }
                    }
                    PerformHttpRequest("https://discord.com/api/webhooks/1226437102426656850/KjeJMU3c7dwjdMBjCsd4ZaWn1CBeUmUWvLAbJtgaPC6YvqkI2iqeT04WuzgydEZ6TzOk", function(err, text, headers) end, 'POST', json.encode({username = "Logs SHOP", embeds = content}), { ['Content-Type'] = 'application/json' })
                    xPlayer.showNotification("Vous avez acheté avec votre Carte Bancaire "..numberQty.." "..listeItem[item].label.." pour "..totalPrice.." $")

                else
                    xPlayer.showNotification("~g~".. listeItem[item].category .."\nVous n\'avez pas l\'argent nécéssaire")
                end
            end
        else 
            DropPlayer(source, 'Utilisation d\'un Trigger ( LTD )'.. item, price, type)
        end
    end
end)

MomoLogs = function(name, message, color)
	date_local1 = os.date('%H:%M:%S', os.time())
	local date_local = date_local1
	local webhook = ""

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
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end 