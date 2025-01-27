sAdminSrv = {
    Notification = function(id, str)
        TriggerClientEvent('esx:showNotification', id, str)
    end,
    NotifiedAllStaff = function(str)
        for k,v in pairs(sAdminSrv.AdminList) do 
            if v.inService then
                sAdminSrv.Notification(k, str) 
            end  
        end
    end,
    GetDate = function()
        local date = os.date('*t')
        
        if date.day < 10 then date.day = '0' .. tostring(date.day) end
        if date.month < 10 then date.month = '0' .. tostring(date.month) end
        if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
        if date.min < 10 then date.min = '0' .. tostring(date.min) end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    
        return(date.day ..'/'.. date.month ..'/'.. date.year ..' - '.. date.hour ..':'.. date.min ..':'.. date.sec)
    end,
    GetHours = function()
        local date = os.date('*t')

        if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
        if date.min < 10 then date.min = '0' .. tostring(date.min) end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    
        return(date.hour ..':'.. date.min ..':'.. date.sec)
    end,
    Print = function(str) 
        -- print(sAdmin.Config.Print.DefaultPrefix.." "..str)
    end,
    Debug = function(str) 
        -- print(sAdmin.Config.Print.DebugPrefix.." "..str)
    end,
    UpdateReport = function()
        for k,v in pairs(sAdminSrv.AdminList) do 
            TriggerClientEvent("sAdmin:UpdateReportsList", k, sAdminSrv.ReportsList)
        end
    end,
    AdminList = {},
    PlayersList = {},
    ReportsList = {},
    Items = {},
    TriggersForStaff = function(triggerName, args)
        for k,v in pairs(sAdminSrv.AdminList) do 
            TriggerClientEvent(triggerName, k, args)
        end
    end
}

RegisterNetEvent("tAdmin:reviveAll")
AddEventHandler("tAdmin:reviveAll", function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = GetPlayers()

    if xPlayer.getGroup() == "user" then
        DropPlayer(_src, "[nAdmin] - Vous n'avez pas à faire cela !!!")
        return
    end

    for i = 1, #xPlayers, 1 do
        TriggerClientEvent("ambulance:revive", xPlayers[i])
        TriggerClientEvent("esx:showNotification", xPlayers[i], "❤️ ~g~[Administration]~s~\nUn administrateur a revive tout le serveur")

    end

    TriggerClientEvent("tAdmin:serverInteractFinish", _src)
    local w = {{ ["author"] = { ["name"] = "🍧 VanillaHax - AdminMenu", ["icon_url"] = "https://cdn.discordapp.com/attachments/886646425243517028/946471181744222279/logo_nrcShop2.png" }, ["color"] = "10038562", ["title"] = Title, ["description"] = "**Administration :**\n\n**Staff :** ``"..xPlayer.getName().."``\n**Action :** ``REVIVE ALL``", ["footer"] = { ["text"] = "🪐 "..os.date("%d/%m/%Y | %X"), ["icon_url"] = nil}, } }
    PerformHttpRequest(_AdminCfg.nAdminLog.REVIVE, function(err, text, headers) end, 'POST', json.encode({username = "nAdmin", embeds = w, avatar_url = "https://cdn.discordapp.com/attachments/886646425243517028/946471181744222279/logo_nrcShop2.png"}), { ['Content-Type'] = 'application/json'})
end)


RegisterNetEvent("tAdmin:healAll")
AddEventHandler("tAdmin:healAll", function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = GetPlayers()

    if xPlayer.getGroup() == "user" then
        DropPlayer(_src, "Vous n'avez pas à faire cela !!!")
        return
    end

    for i = 1, #xPlayers, 1 do
        TriggerClientEvent("ambulance:heal", xPlayers[i])
        TriggerClientEvent("esx:showNotification", xPlayers[i], "🩹 ~g~[Administration]~s~\nUn administrateur a heal tous le serveur")
    end

    TriggerClientEvent("tAdmin:serverInteractFinish", _src)
end)

RegisterNetEvent("tAdmin:teleportAll")
AddEventHandler("tAdmin:teleportAll", function(coords)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = GetPlayers()

    if xPlayer.getGroup() == "user" then
        DropPlayer(_src, "[nAdmin] - Vous n'avez pas à faire cela !!!")
        return
    end

    for i = 1, #xPlayers, 1 do
        TriggerClientEvent("tAdmin:setCoords", xPlayers[i], coords)
        TriggerClientEvent("esx:showNotification", xPlayers[i], "✨ ~g~[Administration]~s~\nUn administrateur a téléporté tous le serveur")
    end

    TriggerClientEvent("tAdmin:serverInteractFinish", _src)
    local w = {{ ["author"] = { ["name"] = "🍧 VanillaHax - AdminMenu", ["icon_url"] = "https://cdn.discordapp.com/attachments/886646425243517028/946471181744222279/logo_nrcShop2.png" }, ["color"] = "10038562", ["title"] = Title, ["description"] = "**Administration :**\n\n**Staff :** ``"..xPlayer.getName().."``\n**Action :** ``TÉLÉPORTE ALL``", ["footer"] = { ["text"] = "🪐 "..os.date("%d/%m/%Y | %X"), ["icon_url"] = nil}, } }
    PerformHttpRequest(_AdminCfg.nAdminLog.TP, function(err, text, headers) end, 'POST', json.encode({username = "nAdmin", embeds = w, avatar_url = "https://cdn.discordapp.com/attachments/886646425243517028/946471181744222279/logo_nrcShop2.png"}), { ['Content-Type'] = 'application/json'})
end)

exports('GetReportsList', function()
    return sAdminSrv.ReportsList
end)


MySQL.ready(function()
    MySQL.Async.fetchAll("SELECT * FROM items", {}, function(result)
        for k, v in pairs(result) do
            sAdminSrv.Items[k] = { label = v.label, name = v.name }
        end
    end)
end)

RegisterNetEvent('sAdmin:IsAdmin')
AddEventHandler('sAdmin:IsAdmin', function()
    local _source = source
	if not _source then return end
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then return end 
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= sAdmin.Config.DefaultGroup then 
        local dbQuery = false
        if not sAdminSrv.AdminList[_source] then 

            sAdminSrv.AdminList[_source] = {}
            sAdminSrv.AdminList[_source].source = _source
            sAdminSrv.AdminList[_source].name = GetPlayerName(_source)
            sAdminSrv.AdminList[_source].license = xPlayer.identifier
            sAdminSrv.AdminList[_source].inService = false
            sAdminSrv.AdminList[_source].grade = xGroup

            MySQL.Async.fetchAll('SELECT * FROM `staff` WHERE `license`=@license', {
                ['@license'] = xPlayer.identifier
            }, function(result)
                if result[1] then
                    sAdminSrv.AdminList[_source].reportEffectued = tonumber(result[1].report)
                    sAdminSrv.AdminList[_source].appreciation = json.decode(result[1].evaluation)
                else
                    MySQL.Sync.execute('INSERT INTO `staff` (name, license, evaluation, report) VALUES (@name, @license, @evaluation, @report)', {
                        ['@name'] = GetPlayerName(_source),
                        ['@license'] = xPlayer.identifier,
                        ['@evaluation'] = json.encode({}),
                        ['@report'] = 0,
                    }, function() end)

                    sAdminSrv.AdminList[_source].reportEffectued = 0
                    sAdminSrv.AdminList[_source].appreciation = {}

                    AddNewAdmin(xPlayer.identifier, GetPlayerName(_source))
                end
                dbQuery = true
            end)

            while not dbQuery do Wait(1) end

            TriggerClientEvent("sAdmin:NewAdmin", -1, sAdminSrv.AdminList[_source])
            TriggerClientEvent("sAdmin:GetPlayerList", _source, sAdminSrv.PlayersList)
            TriggerClientEvent("sAdmin:GetReports", _source, sAdminSrv.ReportsList)

            return
        else
            sAdminSrv.AdminList[_source].source = _source
            sAdminSrv.AdminList[_source].inService = false
            sAdminSrv.AdminList[_source].grade = xGroup
            TriggerClientEvent("sAdmin:NewAdmin", -1, sAdminSrv.AdminList[_source])

            if sAdmin.Config.Debug then 
                sAdminSrv.Debug("Refresh du staff "..GetPlayerName(_source))
            end
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not sAdminSrv.PlayersList[_source] then 
        sAdminSrv.PlayersList[_source] = {}
        sAdminSrv.PlayersList[_source].source = _source
        sAdminSrv.PlayersList[_source].name = GetPlayerName(_source)
        sAdminSrv.PlayersList[_source].hoursLogin = sAdminSrv.GetHours()
        sAdminSrv.PlayersList[_source].group = xPlayer.getGroup(_source)
        TriggerClientEvent("sAdmin:NewPlayerList", -1, _source, sAdminSrv.PlayersList[_source])
    end
end)


AddEventHandler('playerDropped', function(reason)
    local _source = source

    if sAdminSrv.PlayersList[_source] then 
        sAdminSrv.PlayersList[_source] = nil
        sAdminSrv.TriggersForStaff("sAdmin:RemovePlayerList", _source)
    end

    if sAdminSrv.ReportsList[_source] then 
        sAdminSrv.ReportsList[_source] = nil 
        sAdminSrv.UpdateReport()
    end

    if sAdminSrv.AdminList[_source] then 
        MySQL.Sync.execute('UPDATE staff SET evaluation = @evaluation, report = @report WHERE license = @license', {
            ['@license'] = sAdminSrv.AdminList[_source].license,
            ['@evaluation'] = json.encode(sAdminSrv.AdminList[_source].appreciation),
            ['@report'] = GetReportByLicense(sAdminSrv.AdminList[_source].license)
        })
        sAdminSrv.AdminList[_source] = nil
        TriggerClientEvent("sAdmin:RemoveAdmin", -1, _source) 
    end
end)

RegisterNetEvent('sAdmin:ChangeState')
AddEventHandler('sAdmin:ChangeState', function(state, data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= sAdmin.Config.DefaultGroup then 
        if state == true then
            if xPlayer.getGroup() ~= "fondateur" then
                TriggerClientEvent('sAdmin:changeStaffPed', source, "nValTrue")
                SendLogsOther("Staff", "GreenLife | Service", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre son service", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
            end
        else
            TriggerClientEvent('sAdmin:changeStaffPed', source, "nValFalse")
            SendLogsOther("Staff", "GreenLife | Service", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de quitter son service", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
        end
        if sAdminSrv.AdminList[_source] then 
            sAdminSrv.AdminList[_source].inService = state
            return
        end
    else 
        TriggerEvent("tF:Protect", source, '(Admin ChangeState)')
    end
end)

RegisterNetEvent("sAdmin:Goto")
AddEventHandler("sAdmin:Goto", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= "user" then 
        local targetCoords = GetEntityCoords(GetPlayerPed(id))
        TriggerClientEvent("sAdmin:Tp", _source, targetCoords)
        SendLogsOther("Staff", "GreenLife | Teleport", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) s'est téléporter sur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
    else 
        TriggerEvent("tF:Protect", source, '(Admin Goto)')
    end
end)

RegisterNetEvent("sAdmin:Bring")
AddEventHandler("sAdmin:Bring", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()

    if id == -1 then
        DropPlayer("Une erreur est servenue !")
        return
    end
    if xGroup ~= "user" then 
        local pCoords = GetEntityCoords(GetPlayerPed(_source))
        TriggerClientEvent("sAdmin:Tp", id, pCoords)
        SendLogsOther("Staff", "GreenLife | Teleport", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) à téléporter sur lui **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
    else 
        TriggerEvent("tF:Protect", source, '(Admin Bring)')
    end
end)

RegisterNetEvent("sAdmin:Freeze")
AddEventHandler("sAdmin:Freeze", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= "user" then 
        TriggerClientEvent("sAdmin:FreezePlayer", id)
        SendLogsOther("Staff", "GreenLife | Freeze", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de freeze le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
    else 
        TriggerEvent("tF:Protect", source, '(Admin Freeze)')
    end
end)


RegisterNetEvent("sAdmin:SendMessageGros")
AddEventHandler("sAdmin:SendMessageGros", function(id, message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    local name = xPlayer.name

    if xGroup ~= "user" then 
        TriggerClientEvent("announceForMessage", id, message, name)
        SendLogsOther("Staff", "GreenLife | Message", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de d'envoyer un message au joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) [**"..message.."**]", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
    else 
        TriggerEvent("tF:Protect", source, '(Admin SendMessage)')
    end
end)

RegisterNetEvent("sAdmin:SendMessage")
AddEventHandler("sAdmin:SendMessage", function(id, message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        sAdminSrv.Notification(id, "~r~Message de "..xPlayer.name.."~s~\n"..message)
        SendLogsOther("Staff", "GreenLife | Message", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de d'envoyer un message au joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) [**"..message.."**]", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
    else 
        TriggerEvent("tF:Protect", source, '(Admin SendMessage)')
    end
end)


RegisterNetEvent("sAdmin:TpParking")
AddEventHandler("sAdmin:TpParking", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        TriggerClientEvent("sAdmin:TpParking", id)
        SendLogsOther("Staff", "GreenLife | Teleport", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de téléporter le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) au parking centrale", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
    else 
        TriggerEvent("tF:Protect", source, '(Admin TpParking)')
    end
end)

RegisterNetEvent("sAdmin:Kick")
AddEventHandler("sAdmin:Kick", function(id, reason)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        DropPlayer(id, "Vous avez été kick.\nRaison : "..reason)
        SendLogsOther("Staff", "GreenLife | Kick", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de kick le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) pour la raison [**"..reason.."**]", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
    else 
        TriggerEvent("tF:Protect", source, '(Admin Kick)')
    end
end)

RegisterNetEvent("sAdmin:ShowInventory")
AddEventHandler("sAdmin:ShowInventory", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        local xTarget = ESX.GetPlayerFromId(id)
        local targetInventory = xTarget.getInventory(false)
        local targetAccount = xTarget.getAccounts()
        local targetWeapons = {}

        local list = ESX.GetWeaponList()

        for i=1, #list, 1 do
            if xTarget.hasWeapon(list[i].name) then 
                table.insert(targetWeapons, list[i].label)
            end
        end
        TriggerClientEvent("sAdmin:ShowInventory", _source, targetInventory, targetAccount, targetWeapons)
    else 
        TriggerEvent("tF:Protect", source, '(Admin ShowInventory)')
    end
end)

local reportCooldown = 300000

function son()
    local players = ESX.GetPlayers()
    for k, player in pairs(players) do
        TriggerClientEvent("oasis:reportrecu", k)
    end
end

local playerCooldowns = {}

RegisterCommand("report", function(source, args)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local xPlayers = GetPlayers()

    if not xPlayer then return end
    if not sAdminSrv.ReportsList[_source] then 
        if playerCooldowns[_source] and playerCooldowns[_source] > GetGameTimer() then
            local timeRemaining = math.ceil((playerCooldowns[_source] - GetGameTimer()) / 60000)
            TriggerClientEvent("esx:showAdvancedNotification", _source, "Report", "", "Vous devez attendre " .. timeRemaining .. " minute(s) avant de pouvoir faire un autre report.", "CHAR_ADMIN", 8)
            return
        end
        if not args[1] or not args[2] then 
            TriggerClientEvent("esx:showAdvancedNotification", _source, "Report", "", "⚠️ Il faut minimum 2 mots pour faire la raison d'un report.", "CHAR_ADMIN", 8)
            return
        else
            if #(coords - vector3(1751.59, 2481.67, 45.81)) > 50 then
                TriggerClientEvent("esx:showAdvancedNotification", _source, "Report", "", "✅ Votre report a bien été envoyé !", "CHAR_ADMIN", 8)
                local xName = GetPlayerName(_source)
                sAdminSrv.ReportsList[_source] = {
                    Name = xName,
                    Source = _source,
                    Date = sAdminSrv.GetDate(),
                    Raison = table.concat(args, " "),
                    Taken = false,
                    TakenBy = nil
                }
                sAdminSrv.NotifiedAllStaff("Nouveau report de " .. xName)
                sAdminSrv.UpdateReport()
                playerCooldowns[_source] = GetGameTimer() + reportCooldown
                for i = 1, #xPlayers, 1 do
                    local xStaff = ESX.GetPlayerFromId(xPlayers[i])
                    if xStaff.getGroup() ~= "user" then
                        son()
                    end
                end
            else
                TriggerClientEvent("esx:showAdvancedNotification", _source, "Report", "", "🚫 Vous ne pouvez pas faire de report en ~g~prison~s~.", "CHAR_ADMIN", 8)
            end
        end
    else 
        TriggerClientEvent("esx:showAdvancedNotification", _source, "Report", "", "⏳ Vous avez déjà un report en cours.", "CHAR_ADMIN", 8)
    end
end, false)


RegisterNetEvent('sAdmin:UpdateReport')
AddEventHandler('sAdmin:UpdateReport', function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    local theName = xPlayer.name

    if xGroup ~= sAdmin.Config.DefaultGroup then 
        if sAdminSrv.ReportsList[id] then 
            sAdminSrv.ReportsList[id].Taken = true 
            sAdminSrv.ReportsList[id].TakenBy = theName
            sAdminSrv.UpdateReport()
            local targetCoords = GetEntityCoords(GetPlayerPed(id))
            TriggerClientEvent("sAdmin:Tp", _source, targetCoords, true)
            SendLogsOther("Staff", "GreenLife | Report", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre le report de **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
        end
    end
end)

local PlayersPossibleEval = {}

RegisterNetEvent('sAdmin:ClotureReport')
AddEventHandler('sAdmin:ClotureReport', function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= sAdmin.Config.DefaultGroup then 
        sAdminSrv.AdminList[_source].reportEffectued = sAdminSrv.AdminList[_source].reportEffectued + 1
        TriggerClientEvent("sAdmin:UpdateNumberReport", _source, sAdminSrv.AdminList[_source].reportEffectued)

        if sAdminSrv.ReportsList[id] then 
            local tPlayer = ESX.GetPlayerFromId(id)
            TriggerClientEvent("esx:showAdvancedNotification", _source, "Admin", "", "📝 Vous avez clôturé le report de " .. sAdminSrv.ReportsList[id].Name .. " Avec comme ID : (A Faire)", "CHAR_ADMIN", 8)
            SendLogsOther("Staff", "GreenLife | Report", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de clôturer le report de **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")

            MySQL.Async.execute('UPDATE staff SET total_report = total_report + 1 WHERE license = @license', {
                ['@license'] = xPlayer.identifier
            })

            local reportData = {
                id = _source,
                name = tPlayer.name,
                reasonReport = sAdminSrv.ReportsList[id].Raison
            }
            TriggerClientEvent("sAdmin:OpenAvisMenu", tPlayer.source, reportData)

            sAdminSrv.ReportsList[id] = nil
            PlayersPossibleEval[id] = true
            sAdminSrv.UpdateReport()
        end
    end
end)



RegisterServerEvent('tF:resetReport')
AddEventHandler('tF:resetReport', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "fondateur" then
        MySQL.Async.execute("UPDATE staff SET report = 0;", {}, function() end)
    else
        TriggerEvent("tF:Protect", source, '(tF:resetReport)');
    end
end)

RegisterNetEvent('sAdmin:AddEvaluation')
AddEventHandler('sAdmin:AddEvaluation', function(staffId, evaluation)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(staffId)
    
    if PlayersPossibleEval[_source] then
        PlayersPossibleEval[_source] = nil
        if evaluation ~= nil and sAdminSrv.AdminList[_source].appreciation ~= nil and staffId ~= nil then
            if sAdminSrv.AdminList[_source] then 
                table.insert(sAdminSrv.AdminList[_source].appreciation, evaluation)
            end
            TriggerClientEvent("sAdmin:UpdateAvis", staffId, staffId, sAdminSrv.AdminList[_source].appreciation)
            TriggerClientEvent("esx:showAdvancedNotification", _source, "Évaluation", "", "🎉 Votre évaluation a été envoyée avec succès.", "CHAR_ADMIN", 8)
            SendLogsOther("Staff", "GreenLife | Avis", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de donner un avis au staff **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) ["..evaluation.."/5]", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
        end
    end
end)


RegisterNetEvent('sAdmin:GetStaffsList')
AddEventHandler('sAdmin:GetStaffsList', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= sAdmin.Config.DefaultGroup then 
        MySQL.Async.fetchAll('SELECT * FROM `staff`', {}, function(result)
            for _, staff in ipairs(result) do
                local evaluationStr = staff.evaluation or ""
                local evaluations = {}

                for value in string.gmatch(evaluationStr:gsub("[%[%]]", ""), "([^,]+)") do
                    local numValue = tonumber(value)
                    if numValue and numValue >= 1 and numValue <= 5 then
                        table.insert(evaluations, numValue)
                    end
                end

                local total = 0
                local evalCount = #evaluations
                for _, value in ipairs(evaluations) do
                    total = total + value
                end

                staff.average_evaluation = evalCount > 0 and (total / evalCount) or 0
            end

            TriggerClientEvent("sAdmin:GetStaffsList", _source, result)
        end)   
    end
end)

local function GetStaffWithLicense(license)
    for k,v in pairs(sAdminSrv.AdminList) do 
        if v.license == license then 
            return k
        end
    end
    return nil
end

RegisterCommand("clearreport", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= sAdmin.Config.DefaultGroup then 
        if args[1] then
            local staffId = GetStaffWithLicense(args[1])
            if staffId then
                sAdminSrv.AdminList[staffId].reportEffectued = 0
                TriggerClientEvent("esx:showAdvancedNotification", _source, "Admin", "", "✖️ Vous avez clear les reports de " .. sAdminSrv.AdminList[staffId].name .. ".", "CHAR_ADMIN", 8)
                TriggerClientEvent("sAdmin:UpdateNumberReport", staffId, sAdminSrv.AdminList[_source].reportEffectued)
            else 
                MySQL.Sync.execute('UPDATE staff SET report = @report WHERE license = @license', {
                    ['@license'] = args[1],
                    ['@report'] = 0
                })
                TriggerClientEvent("esx:showAdvancedNotification", _source, "Admin", "", "Vous avez clear les reports.", "CHAR_ADMIN", 8)
            end
        else 
            TriggerClientEvent("esx:showAdvancedNotification", _source, "Admin", "", "📄 Vous devez spécifier une license.", "CHAR_ADMIN", 8)
        end
    end
end, false)


RegisterCommand("clearavis", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= sAdmin.Config.DefaultGroup then 
        if args[1] then
            local staffId = GetStaffWithLicense(args[1])
            if staffId then
                sAdminSrv.AdminList[staffId].appreciation = {}
                TriggerClientEvent("esx:showAdvancedNotification", _source, "Admin", "", "Vous avez clear les avis de " .. sAdminSrv.AdminList[staffId].name .. ".", "CHAR_ADMIN", 8)
                TriggerClientEvent("sAdmin:UpdateAvis", staffId, staffId, sAdminSrv.AdminList[staffId].appreciation)
            else 
                MySQL.Sync.execute('UPDATE staff SET evaluation = @evaluation WHERE license = @license', {
                    ['@license'] = args[1],
                    ['@evaluation'] = json.encode({})
                })
                TriggerClientEvent("esx:showAdvancedNotification", _source, "Admin", "", "Vous avez clear les avis.", "CHAR_ADMIN", 8)
            end
        else 
            TriggerClientEvent("esx:showAdvancedNotification", _source, "Admin", "", "Vous devez spécifier une license.", "CHAR_ADMIN", 8)
        end
    end
end, false)

RegisterCommand("deletstaff", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= sAdmin.Config.DefaultGroup then 
        if args[1] then
            local staffId = GetStaffWithLicense(args[1])
            if staffId then
                sAdminSrv.AdminList[staffId].appreciation = {}
                TriggerClientEvent("esx:showAdvancedNotification", _source, "Admin", "", "Vous avez supprimé le staff " .. sAdminSrv.AdminList[staffId].name .. ".", "CHAR_ADMIN", 8)
            else 
                MySQL.Sync.execute('DELETE FROM staff WHERE license=@license', {
                    ['@license'] = args[1]
                })
                TriggerClientEvent("esx:showAdvancedNotification", _source, "Admin", "", "Vous avez supprimé le staff.", "CHAR_ADMIN", 8)
            end
        else 
            TriggerClientEvent("esx:showAdvancedNotification", _source, "Admin", "", "Vous devez spécifier une license.", "CHAR_ADMIN", 8)
        end
    end
end, false)


RegisterCommand("goto", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(args[1])
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        if args[1] ~= nil then
            if GetPlayerName(tonumber(args[1])) ~= nil then
                local coords = GetEntityCoords(GetPlayerPed(tonumber(args[1])))
                TriggerClientEvent("sAdmin:Tp", source, coords)
                SendLogsOther("Staff", "GreenLife | Teleport", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) s'est téléporter sur le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
            end
        end
    end
end, false)

RegisterCommand("bring", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(args[1])
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        if args[1] ~= nil then
            if GetPlayerName(tonumber(args[1])) ~= nil then
                local target = tonumber(args[1])
                local coords = GetEntityCoords(GetPlayerPed(source))
                TriggerClientEvent("sAdmin:setCoords", target, coords)
                SendLogsOther("Staff", "GreenLife | Teleport", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) à téléporter sur lui le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
            end
        end
    end
end, false)

RegisterServerEvent('sAdmin:giveVehicle')
AddEventHandler('sAdmin:giveVehicle', function(id, model, type, boutique)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(id)

    if xPlayer.getGroup() ~= 'fondateur' and xPlayer.getGroup() ~= 'admin' and xPlayer.getGroup() ~= "gerant" then        
        TriggerEvent("tF:Protect", source, '(sAdmin:giveVehicle)')
        return
    end

    if tPlayer then
        ESX.SpawnVehicle(model, GetEntityCoords(GetPlayerPed(tPlayer.source)), 0.0, nil, false, tPlayer, tPlayer.getIdentifier(), function(vehicle)
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, state, boutique, stored) VALUES (@owner, @plate, @vehicle, @type, @state, @boutique, @stored)', {
                ['@owner']      = tPlayer.identifier,
                ['@plate']      = vehicle.plate,
                ['@vehicle']    = json.encode({
                    model = vehicle.model,
                    plate = vehicle.plate
                }),
                ['@state']      = 1,
                ['@boutique']   = boutique,
                ["@stored"]     = 1,
                ['@type']       = type
            }, function(rowsChange)
                SendLogsOther("Staff", "GreenLife | Give Car", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient d'ajouter un véhicule dans le garage du joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) ["..vehicle.plate.."]", "https://discord.com/api/webhooks/1093171998747799632/5jgZ_1vexX6rv53JBmrtp9mc6-QLCSGQmYqtAw447GlQog94rwRy5kmor-5jLaZPSeX6")
            end)
            TriggerClientEvent('esx:showAdvancedNotification', tPlayer.source, "Garagiste", "", "Vous avez reçu un véhicule avec la plaque [" .. vehicle.plate .. "]", "CHAR_CARSITE", 1)
            TriggerClientEvent('esx:showAdvancedNotification', source, "Admin", "", "Vous avez donné un véhicule à "..tPlayer.name.." avec la plaque [" .. vehicle.plate .. "]", "CHAR_CARSITE", 1)
        end)
    else
        TriggerClientEvent('esx:showAdvancedNotification', source, "Admin", "", "Le joueur spécifié est introuvable.", "CHAR_CARSITE", 1)
    end
end)


RegisterNetEvent("sAdmin:spawnVehicle")
AddEventHandler("sAdmin:spawnVehicle", function(model, position)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", source, '(sAdmin:spawnVehicle)');
        return
    end
    ESX.SpawnVehicle(GetHashKey(model), position, 90.0, nil, false, nil, false, false, function(vehicle)
        TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
    end)
end)

RegisterServerEvent("dclearloadout")
AddEventHandler("dclearloadout", function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local tPlayer = ESX.GetPlayerFromId(id)
    for k,v in ipairs(tPlayer.getLoadout()) do
        local vweaponperms = ESX.IsWeaponPermanent(v.name)
        if xPlayer.getGroup() ~= 'fondateur' and xPlayer.getGroup() ~= 'admin' and xPlayer.getGroup() ~= 'moderateur' and xPlayer.getGroup() ~= 'gerant' then
            TriggerEvent("tF:Protect", source, '(dclearloadout)');
            break
        end
        
        if vweaponperms then
            xPlayer.showNotification("Vous ne pouvez pas clear les armes de car ce joueur il possede une ou plusieurs armes perms")
            break
        else
            xPlayer.showNotification("Les armes de  ~g~"..tPlayer.name.."~s~ on bien etait supprimer !")
            TriggerClientEvent("dclearw", src, id)
        end
    end
end)

function CreateRandomPlateTextForXP()
    local plate = ""
    math.randomseed(GetGameTimer())
    for i = 1, 4 do
        plate = plate .. characters[math.random(1, #characters)]
    end
    plate = plate .. ""
    for i = 1, 4 do
        plate = plate .. math.random(1, 9)
    end
    return plate
end

RegisterCommand('giveItemConsole', function(source, args, item, count)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.addInventoryItem(args[2], tonumber(args[3]), nil, true)
        TriggerClientEvent('esx:showNotification', source, "🎁 Vous avez donné : " .. tonumber(args[3]) .. " " .. args[2] .. " à " .. xPlayer.name)

    end
end)

RegisterCommand('giveWeaponConsole', function(source, args, weapon)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.addWeapon(args[2], nil, nil, true)
        TriggerClientEvent('esx:showNotification', source, "🎁 Vous avez donné : " .. tonumber(args[3]) .. " " .. args[2] .. " à " .. xPlayer.name)
    end
end)

RegisterCommand('clearInventoryConsole', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.clearInventoryItem()
        TriggerClientEvent('esx:showNotification', source, "🗑️ Vous avez vidé l'inventaire de : " .. xPlayer.name)
    end
end)

RegisterCommand('clearLoadoutConsole', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.clearAllInventoryWeapons(false)
        TriggerClientEvent('esx:showNotification', source, "🔫 Vous avez retiré les armes (Non perm) de : " .. xPlayer.name)
    end
end)

RegisterCommand('clearAllLoadoutConsole', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.clearAllInventoryWeapons(true)
        TriggerClientEvent('esx:showNotification', source, "🔫 Vous avez retiré toutes les armes de : " .. xPlayer.name)
    end
end)

RegisterCommand('reviveConsole', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        TriggerClientEvent('ambulance:revive', args[1])
        TriggerClientEvent('esx:showNotification', source, "💉 Vous avez réanimé : " .. xPlayer.name)
    end
end)

RegisterCommand("debugPlayerConsole", function(source, args)
    if source == 0 then
        if (args[1]) then
            local player;
            if (args[1]:find("license:")) then
                player = ESX.GetPlayerFromIdentifier(args[1]);
            else
                player = ESX.GetPlayerFromId(tonumber(args[1]));
            end
            if (player) then
                TriggerEvent('esx:playerDropped', player.source, xPlayer, reason)
                ESX.Players[player.source] = nil;
            end
        else
            if (source > 0) then
                ESX.GetPlayerFromId(source).showNotification("~g~Vous devez entrer une license ou un id valide.");
            else
                ESX.Logs.Warn("^1Vous devez entrer une license ou un id valide.");
            end
        end
    end
end)

RegisterCommand('jobConsole', function(source, args, job, grade)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.setJob(args[2], args[3])
        TriggerClientEvent('esx:showNotification', source, "🧑‍💼 Vous avez défini le métier de : " .. xPlayer.name .. " en " .. args[2] .. " " .. args[3])
    end
end)

RegisterCommand('job2Console', function(source, args, job, grade)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.setJob2(args[2], args[3])
        TriggerClientEvent('esx:showNotification', source, "🛠️ Vous avez défini le métier secondaire de : " .. xPlayer.name .. " en " .. args[2] .. " " .. args[3])
    end
end)

RegisterCommand("ConsoleTppc", function(source, args)
    if source == 0 then
        local players = args[1]
        TriggerClientEvent('Console:Tppc', players)
    end
end)

RegisterCommand('healConsole', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        TriggerClientEvent('ambulance:heal', args[1])
        TriggerClientEvent('esx:showNotification', source, "⚕️ Vous avez soigné : " .. xPlayer.name)
    end
end)

RegisterCommand("updateLicense", function(source, args)
    if source == 0 then
        MySQL.Async.fetchAll('SELECT * FROM `users` WHERE `identifier`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE users SET identifier = @report WHERE identifier = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        MySQL.Async.fetchAll('SELECT * FROM `account_info` WHERE `license`=@license', {
            ['@license'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE account_info SET license = @report WHERE license = @doze', {
                    ['@doze'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        MySQL.Async.fetchAll('SELECT * FROM `clothes_data` WHERE `identifier`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE clothes_data SET identifier = @report WHERE identifier = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        MySQL.Async.fetchAll('SELECT * FROM `kq_extra` WHERE `player`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE kq_extra SET player = @report WHERE player = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        MySQL.Async.fetchAll('SELECT * FROM `properties_list` WHERE `owner`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE properties_list SET owner = @report WHERE owner = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        MySQL.Async.fetchAll('SELECT * FROM `user_licenses` WHERE `owner`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE user_licenses SET owner = @report WHERE owner = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        MySQL.Async.fetchAll('SELECT * FROM `billing` WHERE `identifier`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE billing SET identifier = @report WHERE identifier = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        MySQL.Async.fetchAll('SELECT * FROM `clothes_data` WHERE `identifier`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE clothes_data SET identifier = @report WHERE identifier = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        MySQL.Async.fetchAll('SELECT * FROM `playerstattoos` WHERE `identifier`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE playerstattoos SET identifier = @report WHERE identifier = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        MySQL.Async.fetchAll('SELECT * FROM `phone_phones` WHERE `id`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE phone_phones SET id = @report WHERE id = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        -- owned_vehicles
        MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `owner`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE owned_vehicles SET owner = @report WHERE owner = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
    
        TriggerClientEvent('esx:showNotification', source, "📈 Vous avez mis à jour " .. args[1] .. " -> " .. args[2] .. " avec succès !")
    end
end)

RegisterCommand("deleteCar", function(source, args)
    if source == 0 then
        MySQL.Sync.execute('DELETE FROM owned_vehicles WHERE plate=@plate', {
            ['@plate'] = args[1]
        })
        TriggerClientEvent('esx:showNotification', source, "🚗 Vous avez supprimé le véhicule : " .. args[1])

    end
end)


RegisterCommand('giveCar', function(source, args)
	if source == 0 then
		givevoiture(source, args, 'car', Boutique)
	end
end)

function givevoiture(_source, args, vehicleType, Boutique)
	if _source == 0 then
		local sourceID = args[1]
        local playerName = GetPlayerName(args[1])
        TriggerClientEvent('Abteww:spawnVehicle', sourceID, args[1], args[2], args[3], playerName, 'console', vehicleType)
	end
end

RegisterServerEvent('Abteww:setVehicle')
AddEventHandler('Abteww:setVehicle', function (vehicleProps, Boutique, playerID, vehicleType)
	local _source = playerID
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", source, '(Abteww:setVehicle)');
        return
    end

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, state, boutique, stored, type) VALUES (@owner, @plate, @vehicle, @state, @boutique, @stored, @type)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
        ['@state']   = 1,
        ['@boutique'] = Boutique,
		['@stored']  = 1,
		['type'] = vehicleType
	}, function ()
        ESX.GiveCarKey(xPlayer, vehicleProps.plate);
	end)
end)


RegisterNetEvent("sAdmin:BringBack")
AddEventHandler("sAdmin:BringBack", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()

    if id == -1 then
        DropPlayer("Une erreur est servenue !")
        return
    end
    if xGroup ~= "user" then 
        TriggerClientEvent("sAdmin:BringBack", id)
        SendLogsOther("Staff", "GreenLife | Bring Back", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) à bring back **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", "https://canary.discord.com/api/webhooks/1139229896112091277/lXC5ahxtyqvi6Ov53vGehCneWuiV-jen6wZXceKCZX3WSH6Zp5Peeehb1uuFVj2UQHrg")
    else 
        TriggerEvent("tF:Protect", source, '(Admin BringBack)')
    end
end)

RegisterCommand("bringback", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(args[1])
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        if args[1] ~= nil then
            if GetPlayerName(tonumber(args[1])) ~= nil then
                local id = tonumber(args[1])
                TriggerClientEvent("sAdmin:BringBack", id)
                SendLogsOther("Staff", "GreenLife | BringBack", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) à bring back le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", "https://canary.discord.com/api/webhooks/1139229896112091277/lXC5ahxtyqvi6Ov53vGehCneWuiV-jen6wZXceKCZX3WSH6Zp5Peeehb1uuFVj2UQHrg")
            end
        end
    end
end, false)


RegisterServerEvent("sAdmin:ZoneMessage")
AddEventHandler("sAdmin:ZoneMessage", function(coords, radius, message)
    local src = source
    local players = GetPlayers()
    
    for _, playerId in ipairs(players) do
        local playerCoords = GetEntityCoords(GetPlayerPed(playerId))
        local distance = #(coords - playerCoords)
        
        if distance <= radius then
            TriggerClientEvent("esx:showAdvancedNotification", playerId, "Administration", "Message Administration", message, "CHAR_ADMIN", 1)
        end
    end
end)

RegisterServerEvent("sAdmin:Revive")
AddEventHandler("sAdmin:Revive", function(coords)
    local src = source
    local playerPed = GetPlayerPed(src)

    if IsPedDead(playerPed) then
        TriggerClientEvent("ambulance:revive", src)
    end
end)

RegisterServerEvent("sAdmin:Warn")
AddEventHandler("sAdmin:Warn", function(targetId, reason)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local targetPlayer = ESX.GetPlayerFromId(targetId)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:Warn)')
        return
    end

    if not xPlayer or not targetPlayer then
        TriggerClientEvent('esx:showNotification', _source, "❌ ~r~Joueur non trouvé.")
        return
    end

    MySQL.Async.fetchScalar(
        'SELECT COUNT(*) FROM warn WHERE target_id = @target_id',
        {
            ['@target_id'] = targetPlayer.identifier
        },
        function(existingWarningCount)
            existingWarningCount = tonumber(existingWarningCount) or 0
            local newWarningCount = existingWarningCount + 1

            if newWarningCount > 3 then
                TriggerClientEvent('esx:showNotification', _source, "❌ ~r~Le joueur a déjà 3 avertissements.")
                return
            end

            local newWarnId = targetPlayer.identifier .. "_" .. newWarningCount  

            MySQL.Async.execute(
                'INSERT INTO warn (id_warn, target_id, staff_name, target_name, nombre_avertissement, raison, date, heure) ' ..
                'VALUES (@id_warn, @target_id, @staff_name, @target_name, @nombre_avertissement, @raison, @date, @heure)',
                {
                    ['@id_warn'] = newWarnId,
                    ['@target_id'] = targetPlayer.identifier,
                    ['@staff_name'] = xPlayer.getName(),
                    ['@target_name'] = targetPlayer.getName(),
                    ['@nombre_avertissement'] = newWarningCount,
                    ['@raison'] = reason,
                    ['@date'] = os.date("%Y-%m-%d"),
                    ['@heure'] = os.date("%H:%M:%S")
                },
                function(rowsChanged)
                    if rowsChanged > 0 then
                        TriggerClientEvent('esx:showNotification', _source, "✅ ~g~Warn envoyé à " .. targetPlayer.getName())
                        TriggerClientEvent('esx:showNotification', targetId, "⚠️ ~r~Vous avez été warn pour : " .. reason)
                    else
                        TriggerClientEvent('esx:showNotification', _source, "❌ ~r~Erreur lors de l'enregistrement.")
                    end
                end
            )
        end
    )
end)
RegisterServerEvent("sAdmin:FetchPlayerWarns")
AddEventHandler("sAdmin:FetchPlayerWarns", function(playerId)
    local src = source
    local targetLicense = GetPlayerIdentifier(playerId, 0)
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", src, '(sAdmin:FetchPlayerWarns)')
        return
    end

    if not targetLicense then
        TriggerClientEvent("sAdmin:ReturnPlayerWarns", src, {})
        return
    end

    MySQL.Async.fetchAll(
        "SELECT id_warn, target_id, staff_name, target_name, nombre_avertissement, raison, date, heure FROM warn WHERE target_id = @target_id",
        { ['@target_id'] = targetLicense },
        function(result)
            if result and #result > 0 then
                TriggerClientEvent("sAdmin:ReturnPlayerWarns", src, result)
            else
                TriggerClientEvent("sAdmin:ReturnPlayerWarns", src, {})
            end
        end
    )
end)



RegisterServerEvent("sAdmin:DeleteWarn")
AddEventHandler("sAdmin:DeleteWarn", function(warnId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", src, '(sAdmin:DeleteWarn)')
        return
    end

    MySQL.Async.execute(
        "DELETE FROM warn WHERE id_warn = @id_warn",
        { ['@id_warn'] = warnId },
        function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent("esx:showNotification", src, "Vous avez supprimé un avertissement")
            else
                TriggerClientEvent("esx:showNotification", src, "~r~Erreur lors de la suppression.")
            end
        end
    )
end)



RegisterServerEvent("sAdmin:FetchPlayerBans")
AddEventHandler("sAdmin:FetchPlayerBans", function(playerId)
    local src = source
    local targetLicense = GetPlayerIdentifier(playerId, 0)
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", src, '(sAdmin:FetchPlayerBans)')
        return
    end

    if not targetLicense then
        TriggerClientEvent("sAdmin:ReturnPlayerBans", src, {})
        return
    end

    MySQL.Async.fetchAll(
        "SELECT id, ban_id, license, sourceplayername, targetplayername, reason, added, expiration, permanent FROM banlisthistory WHERE license = @license",
        { ['@license'] = targetLicense },
        function(result)
            if result and #result > 0 then
                TriggerClientEvent("sAdmin:ReturnPlayerBans", src, result)
            else
                TriggerClientEvent("sAdmin:ReturnPlayerBans", src, {})
            end
        end
    )
end)


RegisterServerEvent("sAdmin:FetchPlayerJails")
AddEventHandler("sAdmin:FetchPlayerJails", function(playerId)
    local src = source
    local targetLicense = GetPlayerIdentifier(playerId, 0)
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", src, '(sAdmin:FetchPlayerJails)')
        return
    end

    if not targetLicense then
        TriggerClientEvent("sAdmin:ReturnPlayerJails", src, {})
        return
    end

    MySQL.Async.fetchAll(
        "SELECT id_jail, target_id, staff_name, target_name, nombre_tache, raison, date, heure FROM jail_histo WHERE target_id = @target_id",
        { ['@target_id'] = targetLicense },
        function(result)
            if result and #result > 0 then
                TriggerClientEvent("sAdmin:ReturnPlayerJails", src, result)
            else
                TriggerClientEvent("sAdmin:ReturnPlayerJails", src, {})
            end
        end
    )
end)

RegisterServerEvent("sAdmin:DeleteBan")
AddEventHandler("sAdmin:DeleteBan", function(banId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", src, '(sAdmin:DeleteBan)')
        return
    end

    MySQL.Async.execute(
        "DELETE FROM banlisthistory WHERE id = @id",
        { ['@id'] = banId },
        function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent("esx:showNotification", src, "Vous avez supprimé un ban")
            else
                TriggerClientEvent("esx:showNotification", src, "~r~Erreur lors de la suppression.")
            end
        end
    )
end)


RegisterServerEvent("sAdmin:Screen")
AddEventHandler("sAdmin:Screen", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xTarget = ESX.GetPlayerFromId(args[1])

    TriggerClientEvent("Admin:ReceiveScreenshot", xTarget.source, source)
end)

RegisterServerEvent("Admin:ReceiveScreenshot")
AddEventHandler("Admin:ReceiveScreenshot", function(screenshotUrl, playerId)
    local playerSrc = source

    if (playerSrc == nil) then return end

    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (xPlayer == nil) then return end

    local xTarget = ESX.GetPlayerFromId(playerId)
    if (xTarget == nil) then return end

    if (screenshotUrl == nil) then return end
end)


RegisterServerEvent("sAdmin:Info:Electricity")
AddEventHandler("sAdmin:Info:Electricity", function(statuselectricity)
    local message = statuselectricity and "L'électricité de la ville est maintenant ~r~désactivée !!!!!" or "L'électricité de la ville est maintenant ~g~activée !!!!!"
    TriggerClientEvent("ElectricityDesactive", -1)
    TriggerClientEvent("esx:showNotification", -1, message)
end)

RegisterNetEvent("sAdmin:StartPurgeSound")
AddEventHandler("sAdmin:StartPurgeSound", function()
    TriggerClientEvent("PlayPurgeSound", -1)
end)

RegisterServerEvent("sAdmin:AddStaff")
AddEventHandler("sAdmin:AddStaff", function(id, grade)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:AddStaff)')
        return
    end

    if not id or not grade then
        return TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nID ou grade invalide")
    end

    local targetPlayer = ESX.GetPlayerFromId(id)
    if not targetPlayer then
        return TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nJoueur ID invalide")
    end

    local validGroups = { user = true, mod = true, admin = true, superadmin = true, fondateur = true}
    if not validGroups[grade] then
        return TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nLe groupe spécifié n'existe pas")
    end

    targetPlayer.setGroup(grade)
    TriggerClientEvent('esx:showNotification', _source, "Le joueur ID ~r~" .. id .. "~w~ a été promu au grade : ~r~" .. grade)
    DropPlayer(targetPlayer.source, "Vous avez été déconnécé car vous avez été promu au grade : " .. grade)
end)

RegisterServerEvent("sAdmin:UpdateStaff")
AddEventHandler("sAdmin:UpdateStaff", function(id, grade)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:UpdateStaff)')
        return
    end

    if not id or not grade then
        return TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nID ou grade invalide")
    end

    local targetPlayer = ESX.GetPlayerFromId(id)
    if not targetPlayer then
        return TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nJoueur ID invalide")
    end

    local validGroups = { user = true, mod = true, admin = true, superadmin = true, fondateur = true}
    if not validGroups[grade] then
        return TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nLe groupe spécifié n'existe pas")
    end

    targetPlayer.setGroup(grade)
    TriggerClientEvent('esx:showNotification', _source, "Le joueur ID ~r~" .. id .. "~w~ a été promu au grade : ~r~" .. grade)
    DropPlayer(targetPlayer.source, "Vous avez été déconnécé car vous avez été promu au grade : " .. grade)
end)

RegisterServerEvent("sAdmin:DeleteStaff")
AddEventHandler("sAdmin:DeleteStaff", function(license)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:DeleteStaff)')
        return
    end

    if not license or license == "" then
        return TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nLicense invalide")
    end

    local targetPlayer = ESX.GetPlayerFromIdentifier(license)

    if not targetPlayer then
        return TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nJoueur ID invalide")
    end

    targetPlayer.setGroup("user")

    MySQL.Async.execute('DELETE FROM staff WHERE license = @license', {
        ['@license'] = license
    }, function(affectedRows)
        if affectedRows > 0 then
            TriggerClientEvent('esx:showNotification', _source, "Le joueur avec license ~r~" .. license .. "~w~ a été rétrogradé au grade : ~r~user")
            DropPlayer(targetPlayer.source, "Vous avez été déconnecté car vous avez été rétrogradé au grade : user")
        else
            TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nErreur lors de la suppression du joueur avec license : " .. license)
        end
    end)
end)


RegisterServerEvent("sAdmin:Annonce")
AddEventHandler("sAdmin:Annonce", function(message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local name = xPlayer.getName()

    if not message or message == "" then
        return TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nMessage invalide")
    end

    TriggerClientEvent("announceForMessage", -1, message, name)
end)

RegisterServerEvent("sAdmin:GetItemsList")
AddEventHandler("sAdmin:GetItemsList", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:GetItemsList)')
        return
    end

    MySQL.Async.fetchAll('SELECT name, label, weight, can_remove, type, `unique` FROM items', {}, function(result)
        local items = {}
        for _, v in ipairs(result) do
            table.insert(items, {
                nom = v.name,
                label = v.label,
                weight = v.weight,
                can_remove = v.can_remove,
                type = v.type,
                unique = v.unique
            })
        end
        TriggerClientEvent("sAdmin:ReturnItemsList", _source, items)
    end)
end)

RegisterServerEvent("sAdmin:ChangeWeightItem")
AddEventHandler("sAdmin:ChangeWeightItem", function(item, weight)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:ChangeWeightItem)')
        return
    end

    if item and weight then  
        MySQL.Async.execute('UPDATE items SET weight = @weight WHERE name = @item', {
            ['@item'] = item,
            ['@weight'] = weight
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('esx:showNotification', _source, "Vous avez changé le poids de l'item : " .. item .. " à " .. weight)
            else
                TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nErreur lors de la modification du poids de l'item : " .. item)
            end
        end)
    else
        TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nErreur: données de l'item manquantes")
    end
end)

RegisterServerEvent("sAdmin:DeleteItem")
AddEventHandler("sAdmin:DeleteItem", function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:DeleteItem)')
        return
    end

    if item then
        MySQL.Async.execute('DELETE FROM items WHERE name = @item', {
            ['@item'] = item
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('esx:showNotification', _source, "Vous avez supprimé l'item : " .. item)
            else
                TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nErreur lors de la suppression de l'item : " .. item)
            end
        end)
    else
        TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nErreur: données de l'item manquantes")
    end
end)


RegisterServerEvent("sAdmin:GetJobsList")
AddEventHandler("sAdmin:GetJobsList", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:GetJobsList)')
        return
    end

    MySQL.Async.fetchAll("SELECT name, label, societyType, canWashMoney, canUseOffshore FROM jobs", {}, function(jobs)
        if jobs and #jobs > 0 then
            TriggerClientEvent("sAdmin:ReturnJobsList", _source, jobs)
        end
    end)
end)

RegisterServerEvent("sAdmin:CreateItem")
AddEventHandler("sAdmin:CreateItem", function(itemData)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:CreateItem)')
        return
    end

    local item, label, weight = itemData.name, itemData.label, itemData.weight

    if item and label and weight then
        MySQL.Async.execute('INSERT INTO items (name, label, weight, can_remove, type, `unique`) VALUES (@item, @label, @weight, @can_remove, @type, @unique)', {
            ['@item'] = item,
            ['@label'] = label,
            ['@weight'] = weight,
            ['@can_remove'] = 1,
            ['@type'] = "item",
            ['@unique'] = 0
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('esx:showNotification', _source, "Vous avez créé l'item : " .. item)
            else
                TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nErreur lors de la création de l'item : " .. item)
            end
        end)
    else
        TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nErreur: données de l'item manquantes")
    end
end)


RegisterServerEvent("sAdmin:GetJobGrades")
AddEventHandler("sAdmin:GetJobGrades", function(jobName)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:GetJobGrades)')
        return
    end

    MySQL.Async.fetchAll('SELECT grade, name, label, salary FROM job_grades WHERE job_name = @job_name', {
        ['@job_name'] = jobName
    }, function(grades)
        TriggerClientEvent("sAdmin:ReturnJobGrades", _source, grades)
    end)
end)

RegisterServerEvent("sAdmin:UpdateJobGrade")
AddEventHandler("sAdmin:UpdateJobGrade", function(jobName, gradeName, newSalary)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:UpdateJobGrade)')
        return
    end

    if jobName and gradeName and newSalary then
        MySQL.Async.execute('UPDATE job_grades SET salary = @newSalary WHERE job_name = @jobName AND name = @gradeName', {
            ['@jobName'] = jobName,
            ['@gradeName'] = gradeName,
            ['@newSalary'] = newSalary
        }, function(rowsChanged)
            local notification = rowsChanged > 0 
                and ("Salaire mis à jour pour le grade : ~r~" .. gradeName .. "~w~ du job ~r~" .. jobName .. "~w~ à ~r~" .. newSalary .. "~w~ $")
                or "❌ ~g~Administration\nErreur lors de la mise à jour du salaire."
            TriggerClientEvent('esx:showNotification', _source, notification)
        end)
    else
        TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nErreur : données manquantes pour la mise à jour.")
    end
end)

RegisterServerEvent("sAdmin:DeleteJobGrade")
AddEventHandler("sAdmin:DeleteJobGrade", function(jobName, gradeName)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:DeleteJobGrade)')
        return
    end

    if jobName and gradeName then
        MySQL.Async.execute('DELETE FROM job_grades WHERE job_name = @jobName AND name = @gradeName', {
            ['@jobName'] = jobName,
            ['@gradeName'] = gradeName
        }, function(rowsChanged)
            local notification = rowsChanged > 0 
                and ("Grade ~r~" .. gradeName .. "~w~ du job ~r~" .. jobName .. "~w~ supprimé.")
                or "❌ ~g~Administration\nErreur lors de la suppression du grade."
            TriggerClientEvent('esx:showNotification', _source, notification)
        end)
    else
        TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nErreur : données manquantes pour la suppression.")
    end
end)

RegisterServerEvent("sAdmin:CreateJobGrade")
AddEventHandler("sAdmin:CreateJobGrade", function(gradeData)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", _source, '(sAdmin:CreateJobGrade)')
        return
    end

    local jobName, grade, name, label, salary = gradeData.jobName, gradeData.grade, gradeData.name, gradeData.label, gradeData.salary

    if jobName and grade and name and label and salary then
        MySQL.Async.execute('INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@jobName, @grade, @name, @label, @salary, @skin_male, @skin_female)', {
            ['@jobName'] = jobName,
            ['@grade'] = grade,
            ['@name'] = name,
            ['@label'] = label,
            ['@salary'] = salary, 
            ['@skin_male'] = "{}",
            ['@skin_female'] = "{}"
        }, function(rowsChanged)
            local message = rowsChanged > 0 
                and ("Grade ajouté : " .. name .. " avec le label " .. label .. " pour le job " .. jobName)
                or "❌ ~g~Administration\nErreur lors de la création du grade."
            TriggerClientEvent('esx:showNotification', _source, message)
        end)
    else
        TriggerClientEvent('esx:showNotification', _source, "❌ ~g~Administration\nErreur : données manquantes pour la création du grade.")
    end
end)



