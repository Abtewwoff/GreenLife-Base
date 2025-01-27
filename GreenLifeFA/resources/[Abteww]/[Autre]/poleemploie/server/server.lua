ESX  = exports['Framework']:getSharedObject()

---------- Jardinier -------

local jobCooldown = {}

RegisterServerEvent('Meta_dev:setjobjardinier')
AddEventHandler('Meta_dev:setjobjardinier', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if jobCooldown[_source] and os.time() - jobCooldown[_source] < ConfigEmploie.CoolDown then
        TriggerClientEvent('esx:showNotification', _source, 'Vous devez attendre 2 minute avant de pouvoir changer de job à nouveau.')
    else
        xPlayer.setJob('jardinier', 0)
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez pris le job de jardinier')
        TriggerClientEvent('esx:showNotification', _source, 'Rendez-vous au point de travail pour commencer à travailler')
        jobCooldown[_source] = os.time()
    end
end)


RegisterServerEvent('Meta_dev:paiementjardinier')
AddEventHandler('Meta_dev:paiementjardinier', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local argent = math.random(ConfigJardinier.Jardinier.Paiementmin, ConfigJardinier.Jardinier.Paiementmax)
    xPlayer.addAccountMoney(ConfigEmploie.DataMoney, argent)
    TriggerClientEvent('esx:showNotification', source, 'Vous avez été payé ~g~'..argent..'$~s~ pour votre action de jardinier')
end)


---------- Chantier -------

RegisterServerEvent('Meta_dev:setjobchantier')
AddEventHandler('Meta_dev:setjobchantier', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if jobCooldown[_source] and os.time() - jobCooldown[_source] < ConfigEmploie.CoolDown then
        TriggerClientEvent('esx:showNotification', _source, 'Vous devez attendre 2 minute avant de pouvoir changer de job à nouveau.')
    else
        xPlayer.setJob('chantier', 0)
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez pris le job de chantier')
        TriggerClientEvent('esx:showNotification', _source, 'Rendez-vous au point de travail pour commencer à travailler')
        jobCooldown[_source] = os.time()
    end
end)

RegisterServerEvent('Meta_dev:paiementchantier')
AddEventHandler('Meta_dev:paiementchantier', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local argent = math.random(ConfigChantier.Paiementmin, ConfigChantier.Paiementmax)
    xPlayer.addAccountMoney(ConfigEmploie.DataMoney, argent)
    TriggerClientEvent('esx:showNotification', source, 'Vous avez été payé ~g~'..argent..'$~s~ pour votre action de chantier')
end)


---------- Eboueur -------

RegisterServerEvent('Meta_dev:setjomineur')
AddEventHandler('Meta_dev:setjomineur', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if jobCooldown[_source] and os.time() - jobCooldown[_source] < ConfigEmploie.CoolDown then
        TriggerClientEvent('esx:showNotification', _source, 'Vous devez attendre 2 minute avant de pouvoir changer de job à nouveau.')
    else
        xPlayer.setJob('mineur', 0)
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez pris le job de mineur')
        TriggerClientEvent('esx:showNotification', _source, 'Rendez-vous au point de travail pour commencer à travailler')
        jobCooldown[_source] = os.time()
    end
end)

RegisterServerEvent('Meta_dev:paiementmineur')
AddEventHandler('Meta_dev:paiementmineur', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local argent = math.random(ConfigMineur.Paiementmin, ConfigMineur.Paiementmax)
    xPlayer.addAccountMoney(ConfigEmploie.DataMoney, argent)
    TriggerClientEvent('esx:showNotification', source, 'Vous avez été payé ~g~'..argent..'$~s~ pour votre action de mineur')
end)



------- Arreter de travailler -------

RegisterServerEvent('Meta_dev:stopjob')
AddEventHandler('Meta_dev:stopjob', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.setJob('unemployed', 0)
        TriggerClientEvent('esx:showNotification', _source, 'Vous êtes maintenant bien au chômage')
end)


-- ------- Prendre son service -------

RegisterServerEvent('Meta_dev:prisedeservice')
AddEventHandler('Meta_dev:prisedeservice', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx:showNotification', source, 'Vous avez pris votre service')
end)


-- ------- Fin de service -------

RegisterServerEvent('Meta_dev:findeservice')
AddEventHandler('Meta_dev:findeservice', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx:showNotification', source, 'Vous pris votre fin de service')
end)


---- Abteww ----


-- RegisterServerEvent('Abteww:setjobpizza')
-- AddEventHandler('Abteww:setjobpizza', function()
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)

--     xPlayer.setJob("livreur", 0)
-- end)    