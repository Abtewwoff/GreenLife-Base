function Abteww:GetPlayerLegalManagementMenu()
    RageUI.Separator(("Métier principal ~c~→ ~g~%s~s~ - ~g~%s"):format(ESX.PlayerData.job.label, ESX.PlayerData.job.grade_label));
	RageUI.Separator(("Argent dans la société : ~g~$ ~s~%s"):format(Abteww.SocietyMoney));
	RageUI.Line();
	RageUI.Button("Recruter l'individu", nil, {RightLabel = "→"}, true, {
		onActive = function()
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();
			if (closestPlayer ~= -1 and closestDistance <= 3) then
                Abteww:ShowMarkerOnPlayer(closestPlayer);
			end
		end,
		onSelected = function()
			if (ESX.PlayerData.job.grade_name == "boss") then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();

				if (closestPlayer == -1 or closestDistance > 3.0) then
					ESX.ShowNotification("~r~Aucun joueur autour de vous !");
				else
                    exports["GreenLifeHud"]:RecruitPlayer("job", GetPlayerServerId(closestPlayer));
				end
			else
				ESX.ShowNotification("~r~Vous possédez pas les droits requis !");
			end
		end
	});
	RageUI.Button("Virer l'individu", nil, {RightLabel = "→"}, true, {
		onActive = function()
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();
			if (closestPlayer ~= -1 and closestDistance <= 3) then
                Abteww:ShowMarkerOnPlayer(closestPlayer);
			end
		end,
		onSelected = function()
			if (ESX.PlayerData.job.grade_name == "boss") then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();

				if (closestPlayer == -1 or closestDistance > 3.0) then
					ESX.ShowNotification("~r~Aucun joueur autour de vous !");
				else
                    TriggerServerEvent("Abteww:personalmenu:fire:legal", GetPlayerServerId(closestPlayer));
				end
			else
				ESX.ShowNotification("~r~Vous possédez pas les droits requis !");
			end
		end
	});
	RageUI.Button("Promouvoir l'individu", nil, {RightLabel = "→"}, true, {
		onActive = function()
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();
			if (closestPlayer ~= -1 and closestDistance <= 3) then
                Abteww:ShowMarkerOnPlayer(closestPlayer);
			end
		end,
		onSelected = function()
			if (ESX.PlayerData.job.grade_name == "boss") then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();

				if (closestPlayer == -1 or closestDistance > 3.0) then
					ESX.ShowNotification("~r~Aucun joueur autour de vous !");
				else
                    TriggerServerEvent("Abteww:personalmenu:promote:legal", GetPlayerServerId(closestPlayer));
				end
			else
				ESX.ShowNotification("~r~Vous possédez pas les droits requis !");
			end
		end
	});
	RageUI.Button("Destituer l'individu", nil, {RightLabel = "→"}, true, {
		onActive = function()
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();
			if (closestPlayer ~= -1 and closestDistance <= 3) then
                Abteww:ShowMarkerOnPlayer(closestPlayer);
			end
		end,
		onSelected = function()
			if (ESX.PlayerData.job.grade_name == "boss") then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();

				if (closestPlayer == -1 or closestDistance > 3.0) then
					ESX.ShowNotification("~r~Aucun joueur autour de vous !");
				else
                    TriggerServerEvent("Abteww:personalmenu:demote:legal", GetPlayerServerId(closestPlayer));
				end
			else
				ESX.ShowNotification("~r~Vous possédez pas les droits requis !");
			end
		end
	});
end