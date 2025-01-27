function _GreenLifeCoffreVehicule:logsRetrait(source, xPlayer, itemName, itemCount)
     local link = "https://discord.com/api/webhooks/1324645655532011591/wA6n1mpt10olmENF6jB1CWS-JxYyUgtOSGfY3HPUhmySBbi5ZCInTs1FoFqWytLP4qZN"
     local local_date = os.date('%H:%M:%S', os.time())
     local content = {
          {
               ["title"] = "**Retrait Coffre (Voiture) :**",
               ["fields"] = {
                    { name = "**- Date & Heure :**", value = local_date },
                    { name = "- Auteur :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
                    { name = "- Item retiré :", value = itemName.." x"..itemCount },
                    { name = "- Plaque du véhicule :", value = self.plate },
               },
               ["type"]  = "rich",
               ["color"] = 16711680,
               ["footer"] =  {
                    ["text"] = "vqkz1 | GreenLife",
               },
          }
     }
     PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Coffre", embeds = content}), { ['Content-Type'] = 'application/json' })
end