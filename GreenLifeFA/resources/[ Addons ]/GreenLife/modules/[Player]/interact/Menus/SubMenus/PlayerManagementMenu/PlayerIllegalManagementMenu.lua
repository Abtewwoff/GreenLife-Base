function Abteww:GetPlayerIllegalManagementMenu()
    RageUI.Separator(("Métier secondaire ~c~→ ~g~%s~s~ - ~g~%s"):format(ESX.PlayerData.job2.label, ESX.PlayerData.job2.grade_label));
	RageUI.Separator(("Argent dans le groupe illégal : ~g~$ ~s~%s"):format(Abteww.SocietyMoney2));
	RageUI.Line();
	RageUI.Button("Recruter l'individu", nil, {RightLabel = "→"}, true, {
		onActive = function()
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();
			if (closestPlayer ~= -1 and closestDistance <= 3) then
                Abteww:ShowMarkerOnPlayer(closestPlayer);
			end
		end,
		onSelected = function()
			if (ESX.PlayerData.job2.grade_name == "boss") then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();

				if (closestPlayer == -1 or closestDistance > 3.0) then
					ESX.ShowNotification("~r~Aucun joueur autour de vous !");
				else
                    exports["GreenLifeHud"]:RecruitPlayer("job2", GetPlayerServerId(closestPlayer));
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
			if (ESX.PlayerData.job2.grade_name == "boss") then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();

				if (closestPlayer == -1 or closestDistance > 3.0) then
					ESX.ShowNotification("~r~Aucun joueur autour de vous !");
				else
                    TriggerServerEvent("Abteww:personalmenu:fire:illegal", GetPlayerServerId(closestPlayer));
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
			if (ESX.PlayerData.job2.grade_name == "boss") then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();

				if (closestPlayer == -1 or closestDistance > 3.0) then
					ESX.ShowNotification("~r~Aucun joueur autour de vous !");
				else
                    TriggerServerEvent("Abteww:personalmenu:promote:illegal", GetPlayerServerId(closestPlayer));
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
			if (ESX.PlayerData.job2.grade_name == "boss") then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();

				if (closestPlayer == -1 or closestDistance > 3.0) then
					ESX.ShowNotification("~r~Aucun joueur autour de vous !");
				else
                    TriggerServerEvent("Abteww:personalmenu:demote:illegal", GetPlayerServerId(closestPlayer));
				end
			else
				ESX.ShowNotification("~r~Vous possédez pas les droits requis !");
			end
		end
	});
end