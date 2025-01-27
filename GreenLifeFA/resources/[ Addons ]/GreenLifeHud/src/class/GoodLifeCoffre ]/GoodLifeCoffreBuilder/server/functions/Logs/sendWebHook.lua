function _GreenLifeCoffreBuilder:sendWebHook(title, message, WeebHook, color)
    local local_date = os.date('%H:%M:%S', os.time())

    local content = {
         {
              ["title"] = title,
              ["description"] = message,
              ["type"]  = "rich",
              ["color"] = color,
              ["footer"] =  {
              ["text"]= "Powered for GreenLife ©   |  "..local_date.."",
              },
         }
    }
    PerformHttpRequest(WeebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs Coffre Builder", embeds = content}), { ['Content-Type'] = 'application/json' })
    
end