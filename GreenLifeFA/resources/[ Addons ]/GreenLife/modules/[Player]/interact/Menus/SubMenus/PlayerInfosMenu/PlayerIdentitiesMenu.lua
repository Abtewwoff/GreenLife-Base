function Abteww:GetPlayerIdentitiesMenu()
    RageUI.List("Carte d'identité", Abteww.IdentitiesIndexes, Abteww.CarteIdIndex, nil, {}, true, {
        onListChange = function(Index, Item)
            Abteww.CarteIdIndex = Index;
        end,
        onSelected = function(Index, Item)
            if (Item.Value == 1) then
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();
                if (closestDistance ~= -1 and closestDistance <= 3) then
                    TriggerServerEvent("jsfour-idcard:open", Abteww.PlayerServerId, GetPlayerServerId(closestPlayer));
                    ESX.ShowNotification(("Vous avez montré votre carte d'identité à : ~g~%s"):format(GetPlayerName(closestPlayer)));
                    ExecuteCommand("e idcard");
                else
                    ESX.ShowNotification("~r~Aucun joueur proche !");
                end
            elseif (Item.Value == 2) then
                TriggerServerEvent("jsfour-idcard:open", Abteww.PlayerServerId, Abteww.PlayerServerId);
            end
        end,
    });
    RageUI.List("Permis de conduire", Abteww.IdentitiesIndexes, Abteww.ConduireIdIndex, nil, {}, true, {
        onListChange = function(Index, Item)
            Abteww.ConduireIdIndex = Index;
        end,
        onSelected = function(Index, Item)
            if (Item.Value == 1) then
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();
                if (closestDistance ~= -1 and closestDistance <= 3) then
                    TriggerServerEvent("jsfour-idcard:open", Abteww.PlayerServerId, GetPlayerServerId(closestPlayer), "driver");
                    ESX.ShowNotification(("Vous avez montré votre permis de conduire à : ~g~%s"):format(GetPlayerName(closestPlayer)));
                    ExecuteCommand("e idcardi");
                else
                    ESX.ShowNotification("~r~Aucun joueur proche !");
                end
            elseif (Item.Value == 2) then
                TriggerServerEvent("jsfour-idcard:open", Abteww.PlayerServerId, Abteww.PlayerServerId, "driver");
            end
        end,
    });
    RageUI.List("Permis de port d'armes", Abteww.IdentitiesIndexes, Abteww.ArmeIdIndex, nil, {}, true, {
        onListChange = function(Index, Item)
            Abteww.ArmeIdIndex = Index;
        end,
        onSelected = function(Index, Item)
            if (Item.Value == 1) then
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();
                if (closestDistance ~= -1 and closestDistance <= 3) then
                    TriggerServerEvent("jsfour-idcard:open", Abteww.PlayerServerId, GetPlayerServerId(closestPlayer), "weapon");
                    ESX.ShowNotification(("Vous avez montré votre permis de port d'armes à : ~g~%s"):format(GetPlayerName(closestPlayer)));
                    ExecuteCommand("e idcardi");
                else
                    ESX.ShowNotification("~r~Aucun joueur proche !");
                end
            elseif (Item.Value == 2)then
                TriggerServerEvent("jsfour-idcard:open", Abteww.PlayerServerId, Abteww.PlayerServerId, "weapon");
            end
        end,
    });
    if (ESX.PlayerData.job.name == "police") then
        RageUI.List("Carte de police", Abteww.IdentitiesIndexes, Abteww.PoliceIdIndex, nil, {}, true, {
            onListChange = function(Index, Item)
                Abteww.PoliceIdIndex = Index;
            end,
            onSelected = function(Index, Item)
                if (Item.Value == 1) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();
                    if (closestDistance ~= -1 and closestDistance <= 3) then
                        TriggerServerEvent("jsfour-idcard:open", Abteww.PlayerServerId, GetPlayerServerId(closestPlayer), "police");
                        ESX.ShowNotification(("Vous avez montré votre carte de police à : ~g~%s"):format(GetPlayerName(closestPlayer)));
                        ExecuteCommand("e idcardh");
                    else
                        ESX.ShowNotification("~r~Aucun joueur proche !");
                    end
                elseif (Item.Value == 2) then
                    TriggerServerEvent("jsfour-idcard:open", Abteww.PlayerServerId, Abteww.PlayerServerId, "police");
                end
            end,
        })
    end
end