function Abteww:GetPlayerBillsMenuMenu()
    if (#Abteww.Bills == 0) then
        RageUI.Separator("");
        RageUI.Separator("~r~Vous n'avez aucune facture");
        RageUI.Separator("");
    else
        RageUI.Line();
        for i = 1, #Abteww.Bills, 1 do
            RageUI.Button(Abteww.Bills[i].label, nil, {RightLabel = (("~g~$~s~ %s"):format(ESX.Math.GroupDigits(Abteww.Bills[i].amount)))}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback("esx_billing:payBill", function()
                    end, Abteww.Bills[i].id);
                    ESX.SetTimeout(100, function()
                        Abteww:GetBills();
                    end)
                end
            })
        end
    end
end