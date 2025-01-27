--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local JobCustoms = {
    ['mecano'] = true
}

local local_date = os.date('%H:%M:%S', os.time())

-- RegisterServerEvent('achat:kitrepa')
-- AddEventHandler('achat:kitrepa', function()
-- 	   local xPlayer = ESX.GetPlayerFromId(source)
--     local job = xPlayer.job.name
--     local item = "reparkit"
--     if xPlayer.canCarryItem(item, 1) then
--         if xPlayer.job.name == 'mecano' or xPlayer.job.name == "mecano2" then
--             ESX.RemoveSocietyMoney("mecano", 50)
--             xPlayer.addInventoryItem("reparkit", 1)
--             xPlayer.showNotification("Votre entreprise a payer un kit de réparation pour 50$")
--         else
--             TriggerEvent("tF:Protect", source, "achat:kitrepa")
--         end
--     else
--         xPlayer.showNotification("Vous n'avez pas assez de place sur vous !")
--     end
-- end)

RegisterServerEvent('achat:kitrepa')
AddEventHandler('achat:kitrepa', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    local jobWLMecano = xPlayer.job.name
    local item = "reparkit"
    local hasKitRepa = xPlayer.getInventoryItem('reparkit')

    if JobCustoms[jobWLMecano] then
        ESX.RemoveSocietyMoney(jobWLMecano, 250)
        xPlayer.addInventoryItem("reparkit", 1)
        xPlayer.showNotification("Votre entreprise a payer un kit de réparation pour 250$")

        if xPlayer.job.name == "mecano" then
            logsBuy("[Achat Cosméthique] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **\n- Kit Reparation\nPrix : 250$", 'https://discord.com/api/webhooks/1230874312924332103/yDioibxAuY6lOL3k8t5qaN4OlzEYKe8ZTjhXzk_zBFkrIGGZGSmZ6N6VGUgYGdnh8eb4')
        end

        if xPlayer.job.name == "mecano2" then
            logsBuy("[Achat Cosméthique] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **\n- Kit Reparation\nPrix : 250$", 'https://discord.com/api/webhooks/1230874312924332103/yDioibxAuY6lOL3k8t5qaN4OlzEYKe8ZTjhXzk_zBFkrIGGZGSmZ6N6VGUgYGdnh8eb4')
        end

    else
        TriggerEvent("tF:Protect", source, "achat:kitrepa")
    end
end)

RegisterServerEvent('achat:chiffon')
AddEventHandler('achat:chiffon', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    local jobWLMecano = xPlayer.job.name
    local item = "chiffon_clean"
    local hasKitRepa = xPlayer.getInventoryItem('chiffon_clean')

    if JobCustoms[jobWLMecano] then
        ESX.RemoveSocietyMoney(jobWLMecano, 50)
        xPlayer.addInventoryItem("chiffon_clean", 1)
        xPlayer.showNotification("Votre entreprise a payer un Chiffon Microfibre pour 50$")

        if xPlayer.job.name == "mecano" then
            logsBuy("[Achat Cosméthique] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **\n- Chiffon Microfibre\nPrix : 50$", 'https://discord.com/api/webhooks/1230874312924332103/yDioibxAuY6lOL3k8t5qaN4OlzEYKe8ZTjhXzk_zBFkrIGGZGSmZ6N6VGUgYGdnh8eb4')
        end

        if xPlayer.job.name == "mecano2" then
            logsBuy("[Achat Cosméthique] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **\n- Chiffon Microfibre\nPrix : 50$", 'https://discord.com/api/webhooks/1230874312924332103/yDioibxAuY6lOL3k8t5qaN4OlzEYKe8ZTjhXzk_zBFkrIGGZGSmZ6N6VGUgYGdnh8eb4')
        end

    else
        TriggerEvent("tF:Protect", source, "achat:chiffon")
    end
end)

RegisterServerEvent('achat:jerican')
AddEventHandler('achat:jerican', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    local jobWLMecano = xPlayer.job.name
    local item = "jerican"
    local hasKitRepa = xPlayer.getInventoryItem('jerican')

    if JobCustoms[jobWLMecano] then
        ESX.RemoveSocietyMoney(jobWLMecano, 50)
        xPlayer.addInventoryItem("jerican", 1)
        xPlayer.showNotification("Votre entreprise a payer un Jerican pour 50$")

        if xPlayer.job.name == "mecano" then
            logsBuy("[Achat Cosméthique] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **\n- Chiffon Microfibre\nPrix : 50$", 'https://discord.com/api/webhooks/1230874312924332103/yDioibxAuY6lOL3k8t5qaN4OlzEYKe8ZTjhXzk_zBFkrIGGZGSmZ6N6VGUgYGdnh8eb4')
        end

        if xPlayer.job.name == "mecano2" then
            logsBuy("[Achat Cosméthique] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **\n- Chiffon Microfibre\nPrix : 50$", 'https://discord.com/api/webhooks/1230874312924332103/yDioibxAuY6lOL3k8t5qaN4OlzEYKe8ZTjhXzk_zBFkrIGGZGSmZ6N6VGUgYGdnh8eb4')
        end
    end
end)

RegisterServerEvent('BuyLsCustoms')
AddEventHandler('BuyLsCustoms', function(newVehProps, amount)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
    local job = xPlayer.job.name
	local societyAccount = nil
    local price = tonumber(amount)

    if JobCustoms[job] then
        local test = xPlayer.job.name
        local PriceFinal = price * 3
        MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name=@mecano", {
            ["@mecano"] = test
        }, function(result)
            if result[1].money > price then
                TriggerClientEvent('Mecano:installMod', _src, price)
                TriggerEvent("RemoveMoneySociety", job, price)
        
                xPlayer.showNotification("Vous avez ~g~installé~s~ toutes ~g~les modifications~s~.")
                xPlayer.showNotification("Vous avez modifier le véhicule ~g~"..price.."$~s~ on été retiré de l\'entreprise.")
                xPlayer.showNotification("Vous avez ~g~reçu~s~ ub paiement de ~g~"..PriceFinal.."$~s~")
            else
                TriggerClientEvent('CancelLsCustoms', _src)
            end
        end)
    end
end)

RegisterNetEvent('mecano:spawnVehicleMecano', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'mecano' then
        TriggerEvent("tF:Protect", source, '(mecano:spawnVehicleMecano)');
        return
    end
end)

RegisterNetEvent('mecano:spawnVehicleBenny', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'mecano2' then
        TriggerEvent("tF:Protect", source, '(mecano:spawnVehicleBenny)');
        return
    end
end)

RegisterNetEvent('Mecano:refreshOwnedVehicle', function(myCar, price)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'mecano' or xPlayer.job.name == "mecano2" then

    else
        TriggerEvent("tF:Protect", source, '(mecano:spawnVehicle)');
        return
    end

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
        ['@plate'] = myCar.plate
    }, function(result)
        if result[1] then
            local props = json.decode(result[1].vehicle);
            if props.model == myCar.model and props.plate == myCar.plate then
                MySQL.Async.execute('UPDATE `owned_vehicles` SET `vehicle` = @vehicle WHERE `plate` = @plate',
                    {
                        ['@plate'] = myCar.plate,
                        ['@vehicle'] = json.encode(myCar)
                    })
                    
                    local licenseThePlayer = result[1].owner
                    local lePrixFacture = price*3
                    local content = {
                        {
                            ["title"] = "**__Buy Custom__**",
                            ["fields"] = {
                                { name = "**- Date & Heure :**", value = local_date },
                                { name = "- Information :", value = "["..licenseThePlayer.."]"},
                                { name = "- Plaque véhicule :", value = "["..myCar.plate.."]" },
                                { name = "- Prix Facture :", value = lePrixFacture.."$" },
                            },
                            ["type"]  = "rich",
                            ["color"] = 16711680,
                            ["footer"] =  {
                                ["text"] = "By Kazuto | GreenLife",
                            },
                        }
                    }
                    PerformHttpRequest("https://discord.com/api/webhooks/1230874312924332103/yDioibxAuY6lOL3k8t5qaN4OlzEYKe8ZTjhXzk_zBFkrIGGZGSmZ6N6VGUgYGdnh8eb4", function(err, text, headers) end, 'POST', json.encode({username = "Buy Custom", embeds = content}), { ['Content-Type'] = 'application/json' })


                    -- For mecano 
                    if xPlayer.job.name == 'mecano' then
                        local licenseThePlayer = result[1].owner
                        local lePrixFacture = price*3
                        local content = {
                            {
                                ["title"] = "**__Buy Custom__**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Employé :", value = xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")"},
                                    { name = "- Plaque véhicule :", value = "["..myCar.plate.."]" },
                                    { name = "- Prix Facture :", value = lePrixFacture.."$" },
                                },
                                ["type"]  = "rich",
                                ["color"] = 16711680,
                                ["footer"] =  {
                                    ["text"] = "By Kazuto | GreenLife",
                                },
                            }
                        }
                        PerformHttpRequest("https://discord.com/api/webhooks/1230874312924332103/yDioibxAuY6lOL3k8t5qaN4OlzEYKe8ZTjhXzk_zBFkrIGGZGSmZ6N6VGUgYGdnh8eb4", function(err, text, headers) end, 'POST', json.encode({username = "Buy Custom", embeds = content}), { ['Content-Type'] = 'application/json' })
                    end

                    if xPlayer.job.name == 'mecano2' then
                        local licenseThePlayer = result[1].owner
                        local lePrixFacture = price*3
                        local content = {
                            {
                                ["title"] = "**__Buy Custom__**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Employé :", value = xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")"},
                                    { name = "- Plaque véhicule :", value = "["..myCar.plate.."]" },
                                    { name = "- Prix Facture :", value = lePrixFacture.."$" },
                                },
                                ["type"]  = "rich",
                                ["color"] = 16711680,
                                ["footer"] =  {
                                    ["text"] = "By Kazuto | GreenLife",
                                },
                            }
                        }
                        PerformHttpRequest("https://discord.com/api/webhooks/1230874312924332103/yDioibxAuY6lOL3k8t5qaN4OlzEYKe8ZTjhXzk_zBFkrIGGZGSmZ6N6VGUgYGdnh8eb4", function(err, text, headers) end, 'POST', json.encode({username = "Buy Custom", embeds = content}), { ['Content-Type'] = 'application/json' })
                    end
            else
				-- print(('sCustom: %s a tenté de mettre à niveau un véhicule dont le modèle ou la plaque n\'était pas assorti !'):format(xPlayer.identifier))
			end
        end
    end)
end)

RegisterServerEvent("Abteww:mechanic:requestPlayerBillsState", function(txplayer, montant)

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local tPlayer = ESX.GetPlayerFromId(txplayer)

    if (tPlayer) then
        MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @a', {
        ['@a'] = tPlayer.Identifier
        }, function(r)

            if (montant <= tPlayer.getAccount("bank").money) then
                if (#r > 0) then
                    xPlayer.showNotification("La personne sélectionner a déjà une ou plusieurs factures impayées.")
                    tPlayer.showNotification("Vous avez déjà une ou plusieurs factures impayées.");
                    TriggerClientEvent("Abteww:mechanic:receivePlayerBillsState", src, false);
                    return;
                end
                TriggerClientEvent("Abteww:mechanic:receivePlayerBillsState", src, true);
            else
                TriggerClientEvent("Abteww:mechanic:receivePlayerBillsState", src, false);
                xPlayer.showNotification("~r~La personne n'a pas assez d'argent !");
                tPlayer.showNotification("~r~Vous n'avez pas assez d'argent !");
            end
        end);
    end
end);

ESX.RegisterUsableItem('chiffon_clean', function (source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('use:Chiffon', source)
end)

ESX.RegisterUsableItem('reparkit', function (source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('use:reparkit', source)
end)

ESX.RegisterUsableItem('jerican', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('use:jerican', source)
end)


RegisterServerEvent('useReparkit')
AddEventHandler('useReparkit', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('reparkit', 1)
end)

RegisterServerEvent('useJerican')
AddEventHandler('useJerican', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('jerican', 1)
end)

RegisterServerEvent('useChiffon')
AddEventHandler('useChiffon', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('chiffon_clean', 1)
end)

RegisterServerEvent('tonio:sendBilling')
AddEventHandler('tonio:sendBilling', function(target, nameJob, price)
    local xTarget = ESX.GetPlayerFromId(target)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'mecano' or xPlayer.job.name == "mecano2" then
        xTarget.removeAccountMoney('bank', price)
        xTarget.showNotification("Vous avez payer ~g~"..price.."$~s~");
        ESX.AddSocietyMoney(xPlayer.job.name, price)
    else
        TriggerEvent("tF:Protect", source, "(tonio:sendBilling)")
    end
end)


function logsBuy(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 9026761,
            ["footer"]=  {
                ["text"]= "Powered for GreenLife © |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end