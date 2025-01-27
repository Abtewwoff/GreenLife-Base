function Abteww:GetServerCommandsMenu()
    if (not Abteww.ServerCommands) then
        RageUI.Separator("");
        RageUI.Separator("~r~Chargement en cours...");
        RageUI.Separator("");
    else
        for k, v in ipairs(Abteww.ServerCommands) do
            if (v.StaffOnly and Abteww.PlayerGroup ~= "user") then
                RageUI.Button(v.Label, nil, {RightLabel = ("/%s"):format(v.Command)}, true, {});
            elseif (not v.StaffOnly) then
                RageUI.Button(v.Label, nil, {RightLabel = ("/%s"):format(v.Command)}, true, {});
            end
        end
    end
end