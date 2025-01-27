RegisterCommand("wipe", function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source)

    if source == 0 or ConfigWipe.Autorized[xPlayer.getGroup()] then 
        local tPlayer = ESX.GetPlayerFromIdentifier(args[1])
        if tPlayer ~= nil then 
            DropPlayer(tPlayer.source, ConfigWipe.MessageWipe)
        end

        MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier=@identifier", {
            ["@identifier"] = args[1]
        }, function(result)
            
            if result[1] ~= nil then 
                -- Argent
                Accounts = json.decode(result[1].accounts)
                NewAccounts = {}
                for k, v in pairs(Accounts) do 
                    table.insert(NewAccounts, {
                        name = v.name,
                        money = 0
                    })
                end

                MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
                    ['@owner'] = args[1]
                }, function(result)
                    for i=1, #result, 1 do
                        MySQL.Async.execute('DELETE FROM trunk_inventory WHERE vehiclePlate = @vehiclePlate', {
                            ['@vehiclePlate'] = result[i].plate
                        })

                        if not (result[i].boutique ~= nil and not (result[i].boutique == 1 or not result[i].boutique == true)) then
                            MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @vehiclePlate', {
                                ['@vehiclePlate'] = result[i].plate
                            })
                            print("Voiture non boutique delete avec succès")
                        end
                    end
                end)

                for k, v in pairs(ConfigWipe.TableDelete) do 
                    MySQL.Async.execute("DELETE FROM "..v.name.." WHERE "..v.id.." = @"..v.id.."", {
                        ["@"..v.id] = args[1]
                    })
                end
                for k, v in pairs(ConfigWipe.TableUpdate) do
                    print("UPDATE", args[1], v.id, v.var, v.finalvalue)
                    MySQL.Async.execute("UPDATE "..v.tablename.." SET "..v.var.." = @"..v.var.." WHERE "..v.id.." = @"..v.id.."", {
                        ["@"..v.id] = args[1],
                        ["@"..v.var] = v.finalvalue
                    })
                end

                MySQL.Async.execute("UPDATE users SET accounts=@accounts, inventory=@inventory WHERE identifier=@identifier", {
                    ["@identifier"] = args[1],
                    ["@accounts"] = json.encode(NewAccounts),
                    ["@inventory"] = json.encode(NewItems)
                })

                Source = source == 0 and "CONSOLE" or xPlayer.getName()
                SendLogs("Wipe", "GreenLife | Wipe", "La licence **"..args[1].."** vient de se faire wipe par **"..Source.."**", "https://discord.com/api/webhooks/1226436425155612735/sBj-PAK0DfNH0LZTQdiV36mJHutWK1FUiRbxTrrBOHnFNkr05pUrnL_Glw5KRpmT_nFK")    

                if source == 0 then 
                    print("Le joueur ^4"..args[1].."^0 à été wipe !")
                else
                    TriggerClientEvent(ConfigWipe.ESX..'esx:showNotification', source, "Le joueur ~g~"..args[1].."~s~ à été wipe avec succès !")
                end
                
            else
                if source == 0 then 
                    print("Le joueur est introuvable !")
                else
                    TriggerClientEvent(ConfigWipe.ESX..'esx:showNotification', source, "Aucun joueur trouvé !")
                end
            end
        end)

    else
        TriggerClientEvent(ConfigWipe.ESX..'esx:showNotification', source, "Vous ne disposez pas des permissions")
    end
end)
