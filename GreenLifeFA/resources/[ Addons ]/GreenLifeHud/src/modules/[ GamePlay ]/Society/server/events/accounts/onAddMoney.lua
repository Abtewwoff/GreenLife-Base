RegisterNetEvent('GreenLife:Society:AddMoney')
AddEventHandler('GreenLife:Society:AddMoney', function(societyName, amount, accountType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    local local_date = os.date('%H:%M:%S', os.time())

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            local playerAccount = xPlayer.getAccount(accountType)

            if (playerAccount) then
                if (playerAccount.money >= amount) then
                    xPlayer.removeAccountMoney(playerAccount.name, amount)

                    if (accountType == "cash") then
                        society:AddMoney(amount)
                        society:UpdateBossEvent("GreenLife:Society:ReceiveMoney", society:GetMoney())
                        
                        society:SendLogsDiscord(local_date, GreenLife.enums.Society.Zones[society.name].logs.money, {
                            {
                                ["title"] = "**Dépot d'argent :**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Employé :", value = xPlayer.getFirstName().." "..xPlayer.getLastName().." ["..xPlayer.source.."] ["..xPlayer.identifier.."]" },
                                    { name = "- Montant déposé :", value = amount.." $" },
                                    { name = "- Entreprise :", value = society.label },
                                },
                                ["type"]  = "rich",
                                ["color"] = 65280,
                                ["footer"] =  {
                                ["text"] = "Logs Society | GreenLife",
                                },
                            }
                        })
                    elseif (accountType == "dirty_cash") then
                        society:AddDirtyMoney(amount)
                        society:UpdateBossEvent("GreenLife:Society:ReceiveDirtyMoney", society:GetDirtyMoney())
                        
                        society:SendLogsDiscord(local_date, GreenLife.enums.Society.Zones[society.name].logs.money, {
                            {
                                ["title"] = "**Dépot d'argent [SALE]:**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Employé :", value = xPlayer.getFirstName().." "..xPlayer.getLastName().." ["..xPlayer.source.."] ["..xPlayer.identifier.."]" },
                                    { name = "- Montant déposé :", value = amount.." $" },
                                    { name = "- Entreprise :", value = society.label },
                                },
                                ["type"]  = "rich",
                                ["color"] = 65280,
                                ["footer"] =  {
                                ["text"] = "Logs Society | GreenLife",
                                },
                            }
                        })
                    end
                else
                    xPlayer.showNotification("~r~Vous n'avez pas assez d'argent");
                end
            else
                xPlayer.showNotification("~r~Une erreur est survenue~s~, Event du Code erreur: ~g~ 'GreenLife:Society:AddMoney'")
            end
        else
            DropPlayer(xPlayer.source, "[GreenLifeHud] Trying to get money from society storage")
        end
    end

end)