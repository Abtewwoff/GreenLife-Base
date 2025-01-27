function _GreenLifeCoffreProperties:logsDepot(source, xPlayer, itemName, itemId, itemCount)
    local IdShow = ""
    if (itemId ~= nil or type(itemId) ~= 'boolean') then
        IdShow = ' ( '..itemId..' )'
    end

    local local_date = os.date('%H:%M:%S', os.time())
    local link = "https://discord.com/api/webhooks/1226442772131745812/ijgxzBBdprb2JJASIN_Br0zXfTiUmHaLlK59kBR9ek3vHYHCuY0wfb2TEsBwrEY4WuhJ"
    local content = {
        {
            ["title"] = "**Dépot Item(s) :**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Joueur :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
                { name = "- Item déposé :", value = itemName.." x"..itemCount..IdShow },
                { name = "- Entreprise / Gang :", value = self.propertiesName },
            },
            ["type"]  = "rich",
            ["color"] = 65280,
            ["footer"] =  {
            ["text"] = "By Kazuto | GreenLife",
            },
        }
    }
    PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Properties", embeds = content}), { ['Content-Type'] = 'application/json' })
end