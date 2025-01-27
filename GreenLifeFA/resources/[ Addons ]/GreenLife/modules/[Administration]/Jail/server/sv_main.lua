--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
JailX = {}
local allowedByServer = false

RegisterServerEvent('jail:onConnecting')
AddEventHandler('jail:onConnecting', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },function(result)
        if result[1] then
            TriggerClientEvent('jail:PutInBack', source, result[1].remainingTasks, result[1].motif)
        end
    end)
end)


ESX.AddGroupCommand('unjail', 'helpeur', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source);
    if not tonumber(args[1]) then return end
    if GetPlayerName(tonumber(args[1])) == nil then 
        if (xPlayer) then
            TriggerClientEvent('esx:showNotification', source, "~r~ID incorrecte") 
        else
            -- print("ID incorrecte.");
        end
        return 
    end
    local id = args[1]
    local tPlayer = ESX.GetPlayerFromId(id)
    allowedByServer = true
    xPlayer.showNotification('Vous avez unjail : ~r~'..tPlayer.name)
    SendLogs("Jail", "GreenLife | UnJail", "**"..tPlayer.name.."** (***"..tPlayer.identifier.."***) a été libéré de prison par **"..xPlayer.name.."** (***"..xPlayer.identifier.."***)", "https://discord.com/api/webhooks/1226436780450906162/CsMbCY8wFoN67aw4AvSY1SFBIV7xnFfRGWZK7uN2SR5Y14MkWzdEtYLgAVC2f9DQq_4E")
    MySQL.Async.fetchAll('SELECT remainingTasks FROM jail WHERE identifier = @identifier', {
        ['@identifier'] = tPlayer.identifier
    },function(result)
        if result[1] then
            TriggerClientEvent('jail:UnPut', id)
            if (xPlayer) then
                TriggerClientEvent('esx:showNotification', source, "~g~Le joueur a été sortit de prison !")
            else
                -- print("Le joueur a été sortit de prison !");
            end
        else
            if (xPlayer) then
                TriggerClientEvent('esx:showNotification', source, "~r~Ce joueur n'est pas en prison !")
            else
                -- print("Ce joueur n'est pas en prison !");
            end
        end
    end)
end, {help = "Unjail un joueur", params = {
    {name = "id", help = "Id du joueur"}
}})

RegisterServerEvent('jail:updateState')
AddEventHandler('jail:updateState', function(time)
    if allowedByServer == true then
        JailX[source] = {
            number = time,
            hasBeenAllowed = true
        }
        allowedByServer = false
        TriggerClientEvent('esx_status:add', source, 'thirst', 1000000)
        TriggerClientEvent('esx_status:add', source, 'hunger', 1000000) 
    else
        TriggerEvent("tF:Protect", source, '(jail:updateState');
        return
    end
end)

RegisterServerEvent('jail:removeTask')
AddEventHandler('jail:removeTask', function(nbr)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT remainingTasks FROM jail WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },function(result)
        if result[1] then
            JailX[source] = {
                number = result[1].remainingTasks-1,
                hasBeenAllowed = false
            }
            MySQL.Async.execute("UPDATE jail SET remainingTasks = @b WHERE identifier = @a", {
                ['a'] = xPlayer.identifier,
                ['b'] = nbr
            }, function()
            end)
        end
    end)
end)

RegisterServerEvent('jail:SetInJail')
AddEventHandler('jail:SetInJail', function(jailStay, reason)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    JailX[source] = {
        number = jailStay,
        hasBeenAllowed = false
    }
    MySQL.Async.execute('INSERT INTO jail VALUES (@identifier, @number, @reason)', {  
        ['@identifier'] = xPlayer.identifier,        
        ['@number'] = jailStay,
        ['@reason'] = reason
    }, function(rowsChanged)       
    end)
end)

RegisterServerEvent('jail:SetInJailBack')
AddEventHandler('jail:SetInJailBack', function(jailStay)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    JailX[source] = {
        number = jailStay,
        hasBeenAllowed = false
    }
end)

RegisterServerEvent('jail:HealPlayer')
AddEventHandler('jail:HealPlayer', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if JailX[source] == nil then
        TriggerEvent("tF:Protect", source, '(jail:HealPlayer)');
        return
    end 
    TriggerClientEvent('esx_status:add', source, 'thirst', 1000000)
    TriggerClientEvent('esx_status:add', source, 'hunger', 1000000)
end)

RegisterServerEvent('jail:finish')
AddEventHandler('jail:finish', function()
    local source = source
    if not source then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    if JailX[source].number == 0 then
        MySQL.Async.execute("DELETE FROM jail WHERE identifier = @a AND remainingTasks = @b", {
            ['a'] = xPlayer.identifier,
            ['b'] = 0
        }, function()
            TriggerClientEvent('jail:finishAll', source)
            TriggerClientEvent('esx:showNotification', source, "~g~Vous avez été libéré de après avoir réalisé l'entièreté de vos tâches !")
        end)
    else
        TriggerEvent("tF:Protect", source, '(jail:finish)');
        return
    end
end)

RegisterNetEvent('GreenLife:Jail:CheckIsRealyFinish')
AddEventHandler('GreenLife:Jail:CheckIsRealyFinish', function()
    if JailX[source].number > 0 then
        DropPlayer(source, "Chelou chelou l'histoire, coup de pompe chasseur, hoo faaa (Le tcho)")
    end
end)

RegisterServerEvent('jail:remove')
AddEventHandler('jail:remove', function(timeLeft)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not JailX[source].hasBeenAllowed then
        TriggerEvent("tF:Protect", source, '(jail:remove)');
        return
    end
    MySQL.Async.execute("DELETE FROM jail WHERE identifier = @a AND remainingTasks = @b", {
        ['a'] = xPlayer.identifier,
        ['b'] = timeLeft
    }, function()
       -- TriggerClientEvent('esx:showNotification', source, "~g~Vous avez été libéré de prison !")
    end)
end)

ESX.AddGroupCommand("jail" , "helpeur" ,function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = ESX.GetPlayerFromId(args[1] ~= nil and tonumber(args[1]) or nil)
    if not target or args[1] == nil then 
        if (xPlayer) then
            TriggerClientEvent('esx:showNotification', source, "ID incorrecte") 
            return;
        else
            ESX.Logs.Warn("ID incorrecte");
            return;
        end
    else
        if tonumber(args[1]) < 1 then 
            if (xPlayer) then
                xPlayer.showNotification("cSc")
                xPlayer.ban(0, "(Glitch commande jail)");
                return;
            else
                return;
            end
        else
            if (xPlayer) then
                MySQL.Async.fetchAll('SELECT 1 FROM jail WHERE identifier = @identifier', {
                    ['@identifier'] = target.identifier
                },function(result)
                    if result[1] then
                        TriggerClientEvent('esx:showNotification', source, "~r~Le joueur est déjà en prison~s~") 
                    else
                        TriggerClientEvent("JailMenu:OpenMenu", source, args[1])
                    end
                end)
                return;
            else
                return;
            end
        end
    end
end, {help = "Jail un joueur", params = {
	{name = "id", help = "Id du joueur"},
}})

RegisterServerEvent("JailMenu:AntiMassJail")
AddEventHandler("JailMenu:AntiMassJail", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.ban(0, "c'est con ca :( - (JailMenu:AntiMassJail)");
end)


RegisterServerEvent("JailMenu:JailPlayer")
AddEventHandler("JailMenu:JailPlayer", function(targetId, time, raison)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = ESX.GetPlayerFromId(targetId)
    
    if xPlayer.getGroup() ~= "user" then
        MySQL.Async.fetchAll('SELECT 1 FROM jail WHERE identifier = @identifier', {
            ['@identifier'] = target.identifier
        },function(result)
            if result[1] then
                xPlayer.showNotification("~r~Le joueur est déjà en prison~s~")
            else
                TriggerClientEvent("jail:PutIn", targetId, time, raison)
                TriggerClientEvent("JailMenu:AddJailCounter",xPlayer.source)
                SendLogs("Jail", "GreenLife | Jail", "Le joueur **"..target.name.."** (***"..target.identifier.."***) a été envoyé en prison pour **"..raison.."** avec **"..time.."** objet(s) par **"..xPlayer.name.."** (***"..xPlayer.identifier.."***)", "https://discord.com/api/webhooks/1226436780450906162/CsMbCY8wFoN67aw4AvSY1SFBIV7xnFfRGWZK7uN2SR5Y14MkWzdEtYLgAVC2f9DQq_4E")
            end
        end)
    else
        xPlayer.ban(0, "(JailMenu:JailPlayer)");
    end
end)