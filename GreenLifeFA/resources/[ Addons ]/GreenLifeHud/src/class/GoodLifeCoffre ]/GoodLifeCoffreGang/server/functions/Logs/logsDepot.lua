function _GreenLifeCoffreGang:logsDepot(source, xPlayer, itemName, itemId, itemCount)
    local IdShow = ""
    if (itemId ~= nil or type(itemId) ~= 'boolean') then
        IdShow = ' ( '..itemId..' )'
    end

    local local_date = os.date('%H:%M:%S', os.time())
    local link = "https://discord.com/api/webhooks/1324645325616447508/qaVzoqNCbgMOL40YCyv6-FViCrpBjuYe1xucl6pd1JAnj4b8SflBvewc-ciRypKDTLoo"
    local content = {
        {
            ["title"] = "**Dépot Item(s) :**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Joueur :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
                { name = "- Item déposé :", value = itemName.." x"..itemCount..IdShow },
                { name = "- Entreprise / Gang :", value = self.jobName },
            },
            ["type"]  = "rich",
            ["color"] = 65280,
            ["footer"] =  {
            ["text"] = "vqkz1 | GreenLife",
            },
        }
    }
    PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Society", embeds = content}), { ['Content-Type'] = 'application/json' })
end