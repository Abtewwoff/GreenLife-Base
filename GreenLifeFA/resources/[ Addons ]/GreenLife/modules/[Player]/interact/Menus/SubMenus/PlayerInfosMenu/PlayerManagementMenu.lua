function Abteww:IsPlayerBoss1()
    return (ESX.PlayerData.job.grade_name == "boss" and true) or false
end

function Abteww:IsPlayerBoss2()
    return (ESX.PlayerData.job2.grade_name == "boss" and true) or false
end

function Abteww:GetSocietyMoney()
    if (ESX.PlayerData.job.grade_name == "boss") then
        ESX.TriggerServerCallback("pSociety:getSocietyMoney", function(money)
            Abteww.SocietyMoney = ESX.Math.GroupDigits(money)
        end, ESX.PlayerData.job.name)
    end
end

function Abteww:GetSociety2Money()
    if (ESX.PlayerData.job2.grade_name == "boss") then
        ESX.TriggerServerCallback("pSociety:getSocietyMoney", function(money)
            Abteww.SocietyMoney2 = ESX.Math.GroupDigits(money)
        end, ESX.PlayerData.job2.name)
    end
end


function Abteww:GetPlayerManagementMenu()
    RageUI.Separator(("Métier principal ~c~→ ~g~%s~s~ - ~g~%s"):format(ESX.PlayerData.job.label, ESX.PlayerData.job.grade_label));
    RageUI.Separator(("Métier secondaire ~c~→ ~g~%s~s~ - ~g~%s"):format(ESX.PlayerData.job2.label, ESX.PlayerData.job2.grade_label));
    RageUI.Line();
	RageUI.Button("Gestion d'entreprise", nil, {RightLabel = "→→"}, Abteww:IsPlayerBoss1(), {
		onSelected = function()
			Abteww:GetSocietyMoney();
		end
	}, Abteww.PlayerLegalManagementMenu);
	RageUI.Button("Gestion de groupe illégal", nil, {RightLabel = "→→"}, Abteww:IsPlayerBoss2(), {
		onSelected = function()
			Abteww:GetSociety2Money();
		end
	}, Abteww.PlayerIllegalManagementMenu);
end