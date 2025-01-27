---
--- @author Azagal
--- Create at [23/10/2022] 20:25:41
--- Current project [GreenLife-V1]
--- File name [buyCard]
---

RegisterNetEvent("Bank:buyCard", function()
    local playerSrc = source

    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (not xPlayer) then
        return
    end

    local cardPrice = 1450
    local hasCard = xPlayer.getInventoryItem("cb")
    if (not hasCard) then
        if (cardPrice <= xPlayer.getAccount("cash").money) then
            xPlayer.addInventoryItem("cb", 1)
            xPlayer.removeAccountMoney("cash", cardPrice)
            TriggerClientEvent("esx:showNotification", playerSrc, "Vous avez reçu votre ~g~carte bancaire~s~.")
        else
            TriggerClientEvent("esx:showNotification", playerSrc, "~r~Vous n'avez pas assez d'argent sur vous.")
        end
    else
        TriggerClientEvent("esx:showNotification", playerSrc, "~r~Vous avez déjà une carte bancaire !")
    end
end)