RegisterNetEvent('GreenLife:Society:SetGrade')
AddEventHandler('GreenLife:Society:SetGrade', function(societyName, identifier, actionType, targetId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            
            local target = ESX.GetPlayerFromId(targetId)

            local employee = target and society:GetEmployee(target.getIdentifier()) or society:GetEmployee(identifier)

            if (actionType == "recruit") then

                if (targetId) then
                    if (not employee) then
                        if (target) then
                            local targetJob = target.getJob()

                            if (targetJob and targetJob.name == "unemployed") then
                                if (ESX.DoesJobExist(society.name, 0)) then
                                    target.setJob(society.name, 0)

                                    local job = target.getJob()

                                    xPlayer.showNotification(string.format("Vous avez recruter %s%s %s~s~ en tant que %s%s~s~",
                                            "~g~",
                                            target.getFirstName(),
                                            target.getLastName(),
                                            "~g~",
                                            job.grade_label
                                        )
                                    )
                                    target.showNotification(string.format("Vous avez été recruter dans la société %s%s~s~ par %s%s %s~s~ en tant que %s%s",
                                            "~g~",
                                            society.label,
                                            "~g~",
                                            target.getFirstName(),
                                            target.getLastName(),
                                            "~g~",
                                            job.grade_label
                                        )
                                    )
                                elseif (ESX.DoesJobExist(society.name, 0)) then
                                    target.setJob(society.name, 1)

                                    local job = target.getJob()

                                    xPlayer.showNotification(string.format("Vous avez recruter %s%s %s~s~ en tant que %s%s~s~",
                                            "~g~",
                                            target.getFirstName(),
                                            target.getLastName(),
                                            "~g~",
                                            job.grade_label
                                        )
                                    )
                                    target.showNotification(string.format("Vous avez été recruter dans la société %s%s~s~ par %s%s %s~s~ en tant que %s%s",
                                            "~g~",
                                            society.label,
                                            "~g~",
                                            target.getFirstName(),
                                            target.getLastName(),
                                            "~g~",
                                            job.grade_label
                                        )
                                    )
                                else
                                    xPlayer.showNotification("~r~Une erreur est survenue~s~, Code erreur: ~g~ 'GreenLife:Society:SetGrade'");
                                end
                            else
                                xPlayer.showNotification("~r~La personne possède déjà un métier.")
                                target.showNotification("~r~Impossible d'accepter la proposition d'embauche, vous avez déjà un métier")
                            end
                        else
                            xPlayer.showNotification("La personne n'est plus disponnible")
                        end
                    else
                        xPlayer.showNotification("~r~La personne est déjà dans votre société.")
                    end
                else
                    xPlayer.showNotification("La personne n'est plus disponnible")
                end

            elseif (actionType == "promote") then

                if (employee) then

                    if (not employee.isBoss) then

                        if (ESX.DoesJobExist(society.name, employee.grade_level + 1)) then
                            society:UpdateEmployee(identifier, employee.grade_level + 1);

                            society:UpdateBossEvent('GreenLife:Society:ReceiveEmployees', society:GetEmployees());
                        else
                            xPlayer.showNotification("~r~Une erreur est survenue~s~, Code erreur: ~g~ 'GreenLife:Society:SetGrade'");
                        end

                    else
                        xPlayer.showNotification("~r~Impossible de promouvoir cette personne.")
                    end
                end

            elseif (actionType == "demote") then

                if (employee) then

                    -- if (not employee.isBoss) then

                        if (ESX.DoesJobExist(society.name, employee.grade_level - 1)) then
                            society:UpdateEmployee(identifier, employee.grade_level - 1);

                            society:UpdateBossEvent('GreenLife:Society:ReceiveEmployees', society:GetEmployees());
                        else
                            xPlayer.showNotification("~r~Une erreur est survenue~s~, Code erreur: ~g~ 'GreenLife:Society:SetGrade'");
                        end

                    -- else
                    --     xPlayer.showNotification("~r~Impossible de promouvoir cette personne.")
                    -- end
                end
            elseif (actionType == "fire") then

                if (employee) then

                    -- if (not employee.isBoss) then

                        society:UpdateEmployee(identifier, false);

                        society:UpdateBossEvent('GreenLife:Society:ReceiveEmployees', society:GetEmployees());

                    -- else
                    --     xPlayer.showNotification("~r~Impossible de promouvoir cette personne.")
                    -- end
                end

            end

        else
            DropPlayer(xPlayer.source, "[GreenLifeHud] Trying to get money from society storage")
        end
    end
end)