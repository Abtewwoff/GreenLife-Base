RegisterNetEvent('GreenLife:Society:SetSalary')
AddEventHandler('GreenLife:Society:SetSalary', function(societyName, gradeLevel, newSalary)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            society:SetSalary(gradeLevel, tonumber(newSalary))

            society:UpdateBossEvent("GreenLife:Society:ReceiveGrades", society:GetGrades())
        else
            DropPlayer(xPlayer.source, "[GreenLifeHud] Trying to get money from society storage")
        end
    end
end)