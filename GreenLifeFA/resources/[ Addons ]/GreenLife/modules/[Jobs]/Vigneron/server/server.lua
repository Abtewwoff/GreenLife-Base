local TimeoutJob4 = {}

RegisterNetEvent('GreenLife:Vigneron:Annonce', function(announcementType, customMessage)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local message = ""

    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if announcementType == 1 then
            message = "Un vigneron est actuellement disponible !"
        elseif announcementType == 2 then
            message = "Plus de vigneron sont disponibles pour le moment"
        elseif announcementType == 3 then
            if not customMessage or type(customMessage) ~= "string" or #customMessage > 200 then return end
            message = customMessage
        else
            return
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', src, 'Vigneron', 'Annonce', "Vous devez attendre 10 minutes avant de pouvoir refaire une annonce.", 'CHAR_SOCIAL_CLUB', 0)
    end

    TriggerClientEvent('esx:showAdvancedNotification', -1, 'Vigneron', 'Annonce', message, 'CHAR_SOCIAL_CLUB', 0)
end)



RegisterServerEvent('vigneron:recolte')
AddEventHandler('vigneron:recolte', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canCarryItem('raisin', 1) then
        xPlayer.addInventoryItem('raisin', 1)
        xPlayer.showNotification("Vous avez récolté x1 raisin")
    else
        xPlayer.showNotification("~r~Vous n'avez plus de place dans votre inventaire !")
    end
end)
