function _GreenLifeCoffreGang:logsRetrait(source, xPlayer, itemName, itemCount)
    local local_date = os.date('%H:%M:%S', os.time())
    local link = "https://discord.com/api/webhooks/1324645053431283774/w_H9MnuGWIn4ApJx5A1KEARR_AwMhq2MltK24Qhhbd4aP4L3JcjfgGtkUbWO8Q8Kd7vo"
    local content = {
        {
            ["title"] = "**Retrait Item(s) :**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Joueur :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
                { name = "- Item retiré :", value = itemName.." x"..itemCount },
                { name = "- Entreprise / Gang :", value = self.jobName },
            },
            ["type"]  = "rich",
            ["color"] = 16711680,
            ["footer"] =  {
            ["text"] = "vqkz1 | GreenLife",
            },
        }
    }
    PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Society", embeds = content}), { ['Content-Type'] = 'application/json' })

end