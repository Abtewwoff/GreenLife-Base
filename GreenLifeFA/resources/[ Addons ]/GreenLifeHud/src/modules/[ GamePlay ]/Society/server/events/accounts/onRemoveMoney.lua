RegisterNetEvent('GreenLife:Society:RemoveMoney')
AddEventHandler('GreenLife:Society:RemoveMoney', function(societyName, amount, accountType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    local local_date = os.date('%H:%M:%S', os.time())

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            local playerAccount = xPlayer.getAccount(accountType)

            if (playerAccount) then

                local societyMoney = accountType == "cash" and society:GetMoney() or accountType == "dirty_cash" and society:GetDirtyMoney() or 0

                if (societyMoney - amount >= 0) then
                    xPlayer.addAccountMoney(playerAccount.name, amount)

                    if (accountType == "cash") then
                        society:RemoveMoney(amount)
                        society:UpdateBossEvent("GreenLife:Society:ReceiveMoney", society:GetMoney())
                        
                        society:SendLogsDiscord(local_date, GreenLife.enums.Society.Zones[society.name].logs.money, {
                            {
                                ["title"] = "**Retrait Argent :**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Employé :", value = xPlayer.getFirstName().." "..xPlayer.getLastName().." ["..xPlayer.source.."] ["..xPlayer.identifier.."]" },
                                    { name = "- Montant retiré :", value = amount.." $" },
                                    { name = "- Entreprise :", value = society.label },
                                },
                                ["type"]  = "rich",
                                ["color"] = 16711680,
                                ["footer"] =  {
                                ["text"] = "Logs Society | GreenLife",
                                },
                            }
                        })
                    elseif (accountType == "dirty_cash") then
                        society:RemoveDirtyMoney(amount)
                        society:UpdateBossEvent("GreenLife:Society:ReceiveDirtyMoney", society:GetDirtyMoney())
                        
                        society:SendLogsDiscord(local_date, GreenLife.enums.Society.Zones[society.name].logs.linkAddMoney, {
                            {
                                ["title"] = "**Retrait Argent [SALE]:**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Employé :", value = xPlayer.getFirstName().." "..xPlayer.getLastName().." ["..xPlayer.source.."] ["..xPlayer.identifier.."]" },
                                    { name = "- Montant retiré :", value = amount.." $" },
                                    { name = "- Entreprise :", value = society.label },
                                },
                                ["type"]  = "rich",
                                ["color"] = 16711680,
                                ["footer"] =  {
                                ["text"] = "Logs Society | GreenLife",
                                },
                            }
                        })
                    end
                else
                    xPlayer.showNotification("~r~Votre société n'a pas assez d'argent")
                end
            else
                xPlayer.showNotification("~r~Une erreur est survenue~s~, Event du Code erreur: ~g~ 'GreenLife:Society:AddMoney'")
            end
        else
            DropPlayer(xPlayer.source, "[GreenLifeHud] Trying to get money from society storage")
        end
    end

end)