function _GreenLifeCoffreSociety:logsRetrait(source, xPlayer, itemName, itemCount)
     local local_date = os.date('%H:%M:%S', os.time())
     local link = "https://discord.com/api/webhooks/1226442772131745812/ijgxzBBdprb2JJASIN_Br0zXfTiUmHaLlK59kBR9ek3vHYHCuY0wfb2TEsBwrEY4WuhJ"
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
             ["text"] = "By Kazuto | GreenLife",
             },
         }
     }
     PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Society", embeds = content}), { ['Content-Type'] = 'application/json' })

end