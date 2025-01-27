TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
AddEventHandler('playerDropped', function(reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local local_date = os.date('%H:%M:%S', os.time())
    local content = {
        {
            ["title"] = "**__Information :__**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Joueur :", value = xPlayer.name.." "..xPlayer.identifier },
                { name = '- Raison du déco :', value = reason }
            },
            ["type"]  = "rich",
            ["color"] = 2061822,
            ["footer"] =  {
                ["text"] = "vqkz1 | GreenLife",
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1324639125009338418/HXkiyj3ohYVtOyzcL1Vt5XwNhh3jVWE5cSdH9_D5jMENvPGQLHqhJoW_v6Zfug_qPLF1", function(err, text, headers) end, 'POST', json.encode({username = "Logs Déconnexion", embeds = content}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler("playerConnecting", function ()
	local identifier
	local playerId = source
	local PcName = GetPlayerName(playerId)
	
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end
    local local_date = os.date('%H:%M:%S', os.time())
        local content = {
            {
                ["title"] = "**Connexion au serveur :**",
                ["fields"] = {
                    { name = "**- Date & Heure :**", value = local_date },
                    { name = "- Joueur :", value = PcName },
                    { name = "- License  :", value = "license:"..identifier },
                },
                ["type"]  = "rich",
                ["color"] = 2061822,
                ["footer"] =  {
                ["text"] = "vqkz1 | GreenLife",
                },
            }
        }
        PerformHttpRequest("https://discord.com/api/webhooks/1324639239173836912/gjuWBcjbHsmQkkWRh-6lvfVFth6YBqlgScPzkjy6MWWQfVNc3PAv4MPUFfztauoYRfyL", function(err, text, headers) end, 'POST', json.encode({username = "Logs", embeds = content}), { ['Content-Type'] = 'application/json' })
end)