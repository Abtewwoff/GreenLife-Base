function Abteww:IsPlayerBoss()
    return (ESX.PlayerData.job.grade_name == "boss" and true) or (ESX.PlayerData.job2.grade_name == "boss" and true) or false
end

function Abteww:GetBills()
    ESX.TriggerServerCallback("esx_billing:getBills", function(Bills)
        Abteww.Bills = Bills;
    end)
end

function Abteww:GetPlayerInfosMenu()
    RageUI.Separator(("Métier principal ~c~→ ~g~%s~s~ - ~g~%s"):format(ESX.PlayerData.job.label, ESX.PlayerData.job.grade_label));
    RageUI.Separator(("Métier secondaire ~c~→ ~g~%s~s~ - ~g~%s"):format(ESX.PlayerData.job2.label, ESX.PlayerData.job2.grade_label));
    RageUI.Line();
    RageUI.Button("Documents officiels", nil, {RightLabel = "→→"}, true, {}, Abteww.PlayerIdentitiesMenu);
    RageUI.Button("Factures", nil, {RightLabel = "→→"}, true, {
        onSelected = function()
            Abteww:GetBills();
        end
    }, Abteww.PlayerBillsMenu);
    RageUI.Button("Gestions", nil, {RightLabel = "→→"}, Abteww:IsPlayerBoss(), {}, Abteww.PlayerManagementMenu);
end