exports("RecruitPlayer", function(jobType, targetId)
    if (jobType == "job") then
        TriggerServerEvent('GreenLife:Society:SetGrade', ESX.PlayerData.job.name, nil, "recruit", targetId)
    elseif (jobType == "job2") then
        TriggerServerEvent('GreenLife:GangBuilder:RecruitPlayer', targetId, nil, ESX.PlayerData.job2.name)
    end
end)