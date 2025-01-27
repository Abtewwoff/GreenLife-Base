local TICK = {
    COMMANDS = 0,
    SHARE_ACCOUNTS = 0
}

local ACCOUNTS = {}

Account = {}
Account.__index = Account

setmetatable(Account, {
    __call = function(_, steam, fivem, vip, points)
        local self = setmetatable({}, Account)

        self.steam = steam
        self.fivem = fivem
        self.vip = vip
        self.points = tonumber(points)
        self.source = nil
        self.gameTimer = 0

        if ACCOUNTS[self.steam] ~= nil then
        end
        ACCOUNTS[self.steam] = self

        return self
    end
})

Tebex = {}

Citizen.CreateThread(function()
    MySQL.Async.fetchAll('SELECT * FROM tebex_accounts', {}, function(result)
        if result[1] ~= nil then
            for _, data in pairs(result) do
                Account(data.steam, data.fivem, data.vip, data.points)
            end
        end
    end)
end)

function Switch(condition, args)
    if type(args) == "table" then
        local fn = args[condition] or args["default"]
        if fn and type(fn) == "function" then fn() end
    end
end

function GetAllSourceIdentifiers(src)
    local steam, fivem = "0", "0"
    local ste, fiv = "license:", "fivem:"
    for _, v in pairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len(ste)) == ste then
            steam = string.sub(v, #ste + 1)
        end
        if string.sub(v, 1, string.len(fiv)) == fiv then
            fivem = string.sub(v, #fiv + 1)
        end
    end
    return steam, fivem
end

function Tebex:getAccountBySource(source)
    for _, account in pairs(ACCOUNTS) do
        if account.source == source then
            return account
        end
    end
    return nil
end

function Tebex:getAccountByFivem(fivem)
    for _, account in pairs(ACCOUNTS) do
        if account.fivem == fivem then
            return account
        end
    end
    return nil
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local src = source
    local steam, fivem = GetAllSourceIdentifiers(src)
    if ACCOUNTS[steam] == nil and ACCOUNTS[fivem] == nil then
        local account = Account(steam, fivem, 0, 0)
        account.source = src
        account.gameTimer = GetGameTimer()
        MySQL.Async.execute('INSERT INTO tebex_accounts (steam, fivem) VALUES (@steam, @fivem)', {
            ['@steam'] = steam,
            ['@fivem'] = fivem,
        })
        return
    elseif ACCOUNTS[fivem] == nil then
        MySQL.Async.execute('UPDATE tebex_accounts SET fivem = @fivem WHERE `steam` = @steam', {
            ["@steam"] = steam,
            ['@fivem'] = fivem,
        })
        return
    elseif ACCOUNTS[steam] == nil then 
        MySQL.Async.execute('UPDATE tebex_accounts SET steam = @steam WHERE `fivem` = @fivem', {
            ["@steam"] = steam,
            ['@fivem'] = fivem,
        })
        return
    end
    local account = ACCOUNTS[steam]
    if account.gameTimer + 7500 > GetGameTimer() then return end
    account.gameTimer = GetGameTimer()
    account.source = src
    if (fivem ~= "0" and account.fivem == "0") then
        account.fivem = fivem
        MySQL.Async.execute('UPDATE tebex_accounts SET `fivem` = @fivem WHERE steam = @steam', {
            ['@steam'] = steam,
            ['@fivem'] = fivem,
        })
    end
    if account.vip ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        local labeltext = 'Aucun'
        if account.vip == 1 then
            labeltext = '~g~Gold'
        elseif account.vip == 2 then
            labeltext = '~g~Diamond~s~'
        end
        MySQL.Async.fetchScalar('SELECT expiration FROM tebex_accounts WHERE steam = @steam', {
            ['@steam'] = steam
        }, function(result)
            if tonumber(result) ~= 157 then
                if tonumber(result) <= os.time() then
                    xPlayer.showNotification('Votre VIP ['..labeltext..'] a expirer')
                    MySQL.Async.execute('UPDATE tebex_accounts SET `vip` = @vip, `expiration` = @expiration WHERE steam = @steam', {
                        ['@steam'] = steam,
                        ['@vip'] = 0,
                        ['@expiration'] = 0,
                    },function(result)
                    end)
                    -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', source, 0)
                else
                    local tempsrestant = (((tonumber(result)) - os.time())/60)
                    local day        = (tempsrestant / 60) / 24
                    local hrs        = (day - math.floor(day)) * 24
                    local minutes    = (hrs - math.floor(hrs)) * 60
                    local txtday     = math.floor(day)
                    local txthrs     = math.floor(hrs)
                    local txtminutes = math.ceil(minutes)
                    xPlayer.showNotification('Votre VIP : ['..labeltext..']\nPrendra fin dans ~r~'..math.floor(day).. ' jours, ~r~'..txthrs.." heure(s).")
                    -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', source, account.vip)
                end
            else
                xPlayer.showNotification('Votre VIP est ~r~Permanent')
                -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', source, account.vip)
            end
        end)
    else
        -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', source, 0)
    end
    GreenLifeServerUtils.toClient('GreenLifeVIP:updatePoints', source, account.points)
end)
Citizen.CreateThread(function()
    while true do
        Wait(2500)
        local timer = GetGameTimer()
        if TICK.COMMANDS + 14743 < timer then
            TICK.COMMANDS = timer + 1000000000
            Tebex:tickCommands()
        end
        if TICK.SHARE_ACCOUNTS + 23412 < timer then
            TICK.SHARE_ACCOUNTS = timer + 1000000000
            Tebex:tickShareAccounts()
        end
    end
end)

function Tebex:tickShareAccounts()
    local data = {}
    for _, account in pairs(ACCOUNTS) do
        if account.source ~= nil then
            data[account.source] = {
                vip = account.vip,
                points = account.points
            }
        end
    end
    TriggerEvent('GreenLifeVIP:shareAccounts', data)
    GreenLifeServerUtils.toClient('GreenLifeVIP:updatePlayerGreenLifeVIP', -1, data)
    TICK.SHARE_ACCOUNTS = GetGameTimer()
end

function Tebex:tickCommands()
    MySQL.Async.fetchAll('SELECT * FROM tebex_commands', {}, function(result)
        if result[1] ~= nil then
            for _, data in pairs(result) do
                MySQL.Async.execute('DELETE FROM tebex_commands WHERE id = @id', {
                    ['@id']  = data.id,
                }, function(rowsChanged)
                    self:executeCommand(data)
                end)
            end
        end
    end)
    TICK.COMMANDS = GetGameTimer()
end

function Tebex:executeCommand(data)
    local id, fivem, command, argument, transaction = data.id, data.fivem, data.command, data.argument, data.transaction
    local account = self:getAccountByFivem(fivem)
    local steam, source, points = account.steam, account.source, account.points
    Citizen.CreateThread(function()
        Switch(command, {
            ['addVip'] = function()
                local expiration = (30 * 86400)

                if expiration < os.time() then
                    expiration = os.time() + expiration
                end
                local rank = tonumber(argument)
                MySQL.Async.execute('UPDATE tebex_accounts SET `vip` = @vip, `expiration` = @expiration WHERE steam = @steam', {
                    ['@vip'] = rank,
                    ['@steam'] = steam,
                    ['@expiration'] = expiration,
                }, function()
                    account.vip = rank
                    if source ~= nil then
                        -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', source, rank)
                    end
                end)
            end,
            ['addVipLifetime'] = function()
                local expiration = (999 * 86400)

                if expiration < os.time() then
                    expiration = 157
                end
                local rank = tonumber(argument)
                MySQL.Async.execute('UPDATE tebex_accounts SET `vip` = @vip, `expiration` = @expiration WHERE steam = @steam', {
                    ['@vip'] = rank,
                    ['@steam'] = steam,
                    ['@expiration'] = expiration,
                }, function()
                    account.vip = rank
                    if source ~= nil then
                        -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', source, rank)
                    end
                end)
            end,
            ['addVipPass'] = function()
                local expiration = (86400)

                if expiration < os.time() then
                    expiration = os.time() + expiration
                end
                local rank = tonumber(argument)
                MySQL.Async.execute('UPDATE tebex_accounts SET `vip` = @vip, `expiration` = @expiration WHERE steam = @steam', {
                    ['@vip'] = rank,
                    ['@steam'] = steam,
                    ['@expiration'] = expiration,
                }, function()
                    account.vip = rank
                    if source ~= nil then
                        -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', source, rank)
                    end
                end)
            end,
            ['removeVip'] = function()
                local rank = tonumber(argument)
                MySQL.Async.execute('UPDATE tebex_accounts SET `vip` = @vip WHERE steam = @steam', {
                    ['@vip'] = 0,
                    ['@steam'] = steam,
                }, function()
                    account.vip = 0
                    if source ~= nil then
                        -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', source, 0)
                    end
                end)
            end,
        })
    end)
    
end

function GetVIP(source)
    if source then
        returnVip = nil
        returnInvestisseurs = nil
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
            MySQL.Async.fetchAll('SELECT * FROM tebex_accounts WHERE steam = @steam',{
                ['@steam'] = license
            }, function(result)
                if result[1] then
                    returnVip = result[1].vip
                    returnInvestisseurs = result[1].investisseur
                end
            end)

            while returnVip == nil do
                Wait(150)
            end

            return returnVip, returnInvestisseurs
        end
    end
end

RegisterCommand('addVip', function(source, args)
    if source ~= 0 then return print("Not access !") end
    local online = false
    local fivem = args[1]
    local vipRank = tonumber(args[2])
    if vipRank == 0 then return end
    local transaction = args[3] 
    Citizen.CreateThread(function()
        MySQL.Async.execute('INSERT INTO tebex_commands (fivem, command, argument, transaction) VALUES (@fivem, @command, @argument, @transaction)', {
            ['@fivem'] = fivem,
            ['@command'] = 'addVip',
            ['@argument'] = 3,
            ['@transaction'] = transaction
        },function(result)
           
        end)
        MySQL.Async.execute('INSERT INTO tebex_logs_commands (fivem, command, argument, transaction) VALUES (@fivem, @command, @argument, @transaction)', {
            ['@fivem'] = fivem,
            ['@command'] = 'addVip', 
            ['@argument'] = 3,
            ['@transaction'] = transaction
        })
        local xPlayers   = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local steamplayer, fivemPlayer = GetAllSourceIdentifiers(xPlayers[i])
            if fivem == fivemPlayer then
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                TriggerEvent('tebex:addviplogs', xPlayer.source, fivemPlayer, vipLabel, transaction)
                xPlayer.addAccountMoney('bank', 50000)
                TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous avez reçu le ~g~VIP~s~")
                ACCOUNTS[steamplayer].vip = vipRank
                -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', xPlayer.source, vipRank)
                online = true
            else
                online = false
            end
        end  
        if not online then
            MySQL.Async.fetchAll('SELECT * FROM account_info WHERE fivem = @fivem',{
                ['@fivem'] = "fivem:"..fivem
            }, function(result)
                if result[1] then
                    playerLicense = result[1].license
                    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
                        ['@identifier'] = playerLicense
                    }, function(result)
                        local formattedAccounts = json.decode(result[1].accounts) or {}
                        for k,v in pairs(formattedAccounts) do
                            if v.name == "bank" then
                                v.money = v.money+50000
                            end
                        end
                        MySQL.Async.execute('UPDATE `users` SET `accounts` = @accounts WHERE `identifier` = @identifier',
                        {
                            ['@identifier'] = playerLicense,
                            ["@accounts"] = json.encode(formattedAccounts)
                        })
                    end)
                end
            end)
        end
    end)
end)


RegisterCommand('addVipPass', function(source, args)
    if source ~= 0 then return print("Not access !") end
    local fivem = args[1]
    Citizen.CreateThread(function()
        MySQL.Async.execute('INSERT INTO tebex_commands (fivem, command, argument, transaction) VALUES (@fivem, @command, @argument, @transaction)', {
            ['@fivem'] = fivem,
            ['@command'] = 'addVipPass',
            ['@argument'] = 3,
            ['@transaction'] = "Free, VIP BattlePass"
        },function(result)
           
        end)
        MySQL.Async.execute('INSERT INTO tebex_logs_commands (fivem, command, argument, transaction) VALUES (@fivem, @command, @argument, @transaction)', {
            ['@fivem'] = fivem,
            ['@command'] = 'addVipPass', 
            ['@argument'] = 3,
            ['@transaction'] = "Free, VIP BattlePass"
        })
        local xPlayers   = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local steamplayer, fivemPlayer = GetAllSourceIdentifiers(xPlayers[i])
            if fivem == fivemPlayer then
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous avez reçu le ~g~VIP~s~ pendant 24H")
                ACCOUNTS[steamplayer].vip = 3
                -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', xPlayer.source, 3)
            end
        end  
    end)
end)

RegisterCommand('addVipLifetime', function(source, args)
    if source ~= 0 then return print("Not access !") end
    local online = false
    local fivem = args[1]
    local vipRank = tonumber(args[2])
    if vipRank == 0 then return end
    local transaction = args[3] 
    Citizen.CreateThread(function()
        MySQL.Async.execute('INSERT INTO tebex_commands (fivem, command, argument, transaction) VALUES (@fivem, @command, @argument, @transaction)', {
            ['@fivem'] = fivem,
            ['@command'] = 'addVipLifetime',
            ['@argument'] = vipRank,
            ['@transaction'] = transaction
        })
        MySQL.Async.execute('INSERT INTO tebex_logs_commands (fivem, command, argument, transaction) VALUES (@fivem, @command, @argument, @transaction)', {
            ['@fivem'] = fivem,
            ['@command'] = 'addVipLifetime', 
            ['@argument'] = vipRank,
            ['@transaction'] = transaction
        })
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local steamplayer, fivemPlayer = GetAllSourceIdentifiers(xPlayers[i])
            if fivem == fivemPlayer then
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                TriggerEvent('tebex:addviplogs', xPlayer.source, fivemPlayer, vipLabel, transaction)
                TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous avez réçu le ~g~VIP~s~")
                ACCOUNTS[steamplayer].vip = vipRank
                -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', xPlayer.source, vipRank)
                xPlayer.addAccountMoney('bank', 50000)
                online = true
            else
                online = false
            end
        end  
        if not online then
            MySQL.Async.fetchAll('SELECT * FROM account_info WHERE fivem = @fivem',{
                ['@fivem'] = "fivem:"..fivem
            }, function(result)
                if result[1] then
                    playerLicense = result[1].license
                    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
                        ['@identifier'] = playerLicense
                    }, function(result)
                        local formattedAccounts = json.decode(result[1].accounts) or {}
                        for k,v in pairs(formattedAccounts) do
                            if v.name == "bank" then
                                v.money = v.money+money
                            end
                        end
                        MySQL.Async.execute('UPDATE `users` SET `accounts` = @accounts WHERE `identifier` = @identifier',
                        {
                            ['@identifier'] = playerLicense,
                            ["@accounts"] = json.encode(formattedAccounts)
                        })
                    end)
                end
            end)
        end
    end)
end)

RegisterCommand('removeVip', function(source, args)
    if source ~= 0 then return print("Not access !") end
    local fivem = args[1]
    local vipRank = tonumber(args[2])
    local transaction = args[3]
    Citizen.CreateThread(function()
        MySQL.Async.execute('INSERT INTO tebex_commands (fivem, command, argument, transaction) VALUES (@fivem, @command, @argument, @transaction)', {
            ['@fivem'] = fivem,
            ['@command'] = 'removeVip',
            ['@argument'] = vipRank,
            ['@transaction'] = transaction
        })
        MySQL.Async.execute('INSERT INTO tebex_logs_commands (fivem, command, argument, transaction) VALUES (@fivem, @command, @argument, @transaction)', {
            ['@fivem'] = fivem,
            ['@command'] = 'removeVip',
            ['@argument'] = vipRank,
            ['@transaction'] = transaction
        })
        local xPlayers   = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local steamplayer, fivemPlayer = GetAllSourceIdentifiers(xPlayers[i])
            if fivem == fivemPlayer then
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Votre VIP a expiré !")
                -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', xPlayer.source, 0)
            end
        end
    end)
end)

RegisterCommand('viptime', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local steam, fivem = GetAllSourceIdentifiers(source)
    local account = ACCOUNTS[steam]
    if account.vip ~= 0 then
        local labeltext = 'Aucun'
        if account.vip == 1 then
            labeltext = '~g~Gold'
        elseif account.vip == 2 then
            labeltext = '~r~Diamond'
        end
        MySQL.Async.fetchScalar('SELECT expiration FROM tebex_accounts WHERE steam = @steam', {
            ['@steam'] = steam
        }, function(result)
            if tonumber(result) ~= 157 then
                if tonumber(result) <= os.time() then
                    xPlayer.showNotification('Votre VIP ['..labeltext..'] Ã  expirer')
                    MySQL.Async.execute('UPDATE tebex_accounts SET `vip` = @vip, `expiration` = @expiration WHERE steam = @steam', {
                        ['@steam'] = steam,
                        ['@vip'] = 0,
                        ['@expiration'] = 0,
                    })
                    -- GreenLifeServerUtils.toClient('GreenLifeVIP:updateVip', source, 0)
                    ACCOUNTS[steam].vip = 0
                else
                    local tempsrestant = (((tonumber(result)) - os.time())/60)
                    local day        = (tempsrestant / 60) / 24
                    local hrs        = (day - math.floor(day)) * 24
                    local minutes    = (hrs - math.floor(hrs)) * 60
                    local txtday     = math.floor(day)
                    local txthrs     = math.floor(hrs)
                    local txtminutes = math.ceil(minutes)
                    xPlayer.showNotification('Votre VIP : ['..labeltext..']\nPrendra fin dans ~r~'..math.floor(day).. ' jours, ~r~'..txthrs.." heure(s).")
                end
            else
                xPlayer.showNotification('Votre VIP : ['..labeltext..']\nPrendra fin ~r~Jamais')
            end
        end)
    else
        xPlayer.showNotification('Vous n\'avez pas de VIP')
    end
end)