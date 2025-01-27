RegisterNetEvent('sendLogs:Facture')
AddEventHandler('sendLogs:Facture', function(player, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(player)

    if xPlayer.job.name == "police" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
    if xPlayer.job.name == "avocat" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
    if xPlayer.job.name == "ambulance" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
    if xPlayer.job.name == "burgershot" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
    if xPlayer.job.name == "journalist" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
    if xPlayer.job.name == "label" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
    if xPlayer.job.name == "ltd_sud" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
    if xPlayer.job.name == "mecano" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
    if xPlayer.job.name == "mecano2" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
    if xPlayer.job.name == "taxi" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
    if xPlayer.job.name == "tequilala" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
    if xPlayer.job.name == "unicorn" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", 'https://discord.com/api/webhooks/1226444500717670480/VuXAqLwqEJluT2FnswQbOWeWvOBDFqNLB4Xe58AJrhPlOV-3WYfRj84cgXDNi8ScHYuQ')
    end
end)


RegisterNetEvent('sendLogs:ServiceYes')
AddEventHandler('sendLogs:ServiceYes', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "avocat" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138271547077963808/wRCe3C9MvOA8l1K2yQh36SlZMeUVWlCE8z7MatDQzYHKZSbVieIJ8YL8fa1AwNtk__ZV')
    end
    if xPlayer.job.name == "ambulance" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138271642758418432/7NABxZHxFHxfsnoGqVzYRLVYlin4SMXILStBy2H0yLiyj9sBSzG1Vyla39_GNV6Jdj-c')
    end
    if xPlayer.job.name == "police" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138274338936717423/MxnGnFpjAxqfqGYFAxP_zWTa6Rmb9HeWDFu-_TmsTd7mthxXsRHuHYVrM1RGKOS6sWTx')
    end
    if xPlayer.job.name == "bcso" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138274458549899264/rcDn7ZhPUNLJk68omFrCSWZWmbeG448cX4P9Wv1H_SjzArX0cI-L8XziubsnM3Jzg2DR')
    end
    if xPlayer.job.name == "burgershot" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138272202534424659/y5WZ0zUilKjQi9RzXZWkZGY8SPT_oerMpXDGokRAiPrGgSWwTTTPLf6QTTFR0uYwXtag')
    end
    if xPlayer.job.name == "journalist" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138272295450853477/NFuN_QYY_45PhBq6imf1fMMT27oBTW2cUslt-7BMPUa7-P5bwXmmFW172n1APHw-eY_S')
    end
    if xPlayer.job.name == "realestateagent" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138273287370199060/31ttuWZGP0PQrXRebPWB3CqOAmV0qLIJM5ERdQu6yELQkMYbbiqlUJDkM6-yndXae2V8')
    end
    if xPlayer.job.name == "label" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138272407250010122/ZWW5WIkQN0qV7Yoy-CNofMi8t_GWtsPnN51N3Ccvj30uvgss938Sfjyn1U3zf6kQKMNS')
    end
    if xPlayer.job.name == "ltd_sud" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138272488091045993/GQni-zcVc5ZzogbPW0vY0vWqfXf9WonwuEfAMZtdmPHDo_NxEzWDd9Y52roq_WeF84-d')
    end
    if xPlayer.job.name == "mecano" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138272574468526131/rwgVgn65_53h4rd-ns7DgVBCTHqK12Uo_vheLgBnMughRRYxquPJ5_cF0uakHAsXomyI')
    end
    if xPlayer.job.name == "mecano2" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138272644354035782/gDvJC19JBxQP9YE_pGsLUUI-8KnnegeelnM47kZmUzkQ2GZ7l3xbf8IReEEHOMjdn6M-')
    end
    if xPlayer.job.name == "taxi" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138272715623649310/GddIcWX6lwbFwIRFIYb_dS8_ivsP7vyo08VlOXDzqRIE4YPvHga03BHV5W_I-oDpAgwa')
    end
    if xPlayer.job.name == "tequilala" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138272801871106058/OLrSNo04vBmw9d_BT2kuR8cIJBX6DGDNYjNk1BTfnSSSHQ0exLFKlBnshU8mObkapqv4')
    end
    if xPlayer.job.name == "unicorn" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138272874193502278/Db1XKTJaGuba7Q4f-Ty2Dxn7cL5Ydb8u4WscM4ihN4td1kjgAyG4zdaoVgEeAl28klno')
    end
end)


RegisterNetEvent('sendLogs:ServiceNo')
AddEventHandler('sendLogs:ServiceNo', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "avocat" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138271547077963808/wRCe3C9MvOA8l1K2yQh36SlZMeUVWlCE8z7MatDQzYHKZSbVieIJ8YL8fa1AwNtk__ZV')
    end
    if xPlayer.job.name == "ambulance" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138271642758418432/7NABxZHxFHxfsnoGqVzYRLVYlin4SMXILStBy2H0yLiyj9sBSzG1Vyla39_GNV6Jdj-c')
    end
    if xPlayer.job.name == "burgershot" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138272202534424659/y5WZ0zUilKjQi9RzXZWkZGY8SPT_oerMpXDGokRAiPrGgSWwTTTPLf6QTTFR0uYwXtag')
    end
    if xPlayer.job.name == "journalist" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138272295450853477/NFuN_QYY_45PhBq6imf1fMMT27oBTW2cUslt-7BMPUa7-P5bwXmmFW172n1APHw-eY_S')
    end
    if xPlayer.job.name == "realestateagent" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138273287370199060/31ttuWZGP0PQrXRebPWB3CqOAmV0qLIJM5ERdQu6yELQkMYbbiqlUJDkM6-yndXae2V8')
    end
    if xPlayer.job.name == "label" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138272407250010122/ZWW5WIkQN0qV7Yoy-CNofMi8t_GWtsPnN51N3Ccvj30uvgss938Sfjyn1U3zf6kQKMNS')
    end
    if xPlayer.job.name == "ltd_sud" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138272488091045993/GQni-zcVc5ZzogbPW0vY0vWqfXf9WonwuEfAMZtdmPHDo_NxEzWDd9Y52roq_WeF84-d')
    end
    if xPlayer.job.name == "mecano" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138272574468526131/rwgVgn65_53h4rd-ns7DgVBCTHqK12Uo_vheLgBnMughRRYxquPJ5_cF0uakHAsXomyI')
    end
    if xPlayer.job.name == "mecano2" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138272644354035782/gDvJC19JBxQP9YE_pGsLUUI-8KnnegeelnM47kZmUzkQ2GZ7l3xbf8IReEEHOMjdn6M-')
    end
    if xPlayer.job.name == "taxi" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138272715623649310/GddIcWX6lwbFwIRFIYb_dS8_ivsP7vyo08VlOXDzqRIE4YPvHga03BHV5W_I-oDpAgwa')
    end
    if xPlayer.job.name == "tequilala" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138272801871106058/OLrSNo04vBmw9d_BT2kuR8cIJBX6DGDNYjNk1BTfnSSSHQ0exLFKlBnshU8mObkapqv4')
    end
    if xPlayer.job.name == "unicorn" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", 'https://discord.com/api/webhooks/1138272874193502278/Db1XKTJaGuba7Q4f-Ty2Dxn7cL5Ydb8u4WscM4ihN4td1kjgAyG4zdaoVgEeAl28klno')
    end
    if xPlayer.job.name == "police" then
        logsCloseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138274338936717423/MxnGnFpjAxqfqGYFAxP_zWTa6Rmb9HeWDFu-_TmsTd7mthxXsRHuHYVrM1RGKOS6sWTx')
    end
    if xPlayer.job.name == "bcso" then
        logsCloseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", 'https://discord.com/api/webhooks/1138274458549899264/rcDn7ZhPUNLJk68omFrCSWZWmbeG448cX4P9Wv1H_SjzArX0cI-L8XziubsnM3Jzg2DR')
    end
end)


function logsCloseService(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 16713003,
            ["footer"]=  {
                ["text"]= "vqkz1 | GreenLife",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logsPriseService(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 389692,
            ["footer"]=  {
                ["text"]= "vqkz1 | GreenLife",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logsAllJob(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 2061822,
            ["footer"]=  {
                ["text"]= "vqkz1 | GreenLife",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end