function Abteww:GetServerKeybindsMenu()
    if (not Abteww.ServerKeyBinds) then
        RageUI.Separator("");
        RageUI.Separator("~r~Chargement en cours...");
        RageUI.Separator("");
    else
        for k, v in ipairs(Abteww.ServerKeyBinds) do
            if (v.StaffOnly and Abteww.PlayerGroup ~= "user") then
                RageUI.Button(v.Label, nil, {RightLabel = v.Keybind}, true, {});
            elseif (not v.StaffOnly) then
                RageUI.Button(v.Label, nil, {RightLabel = v.Keybind}, true, {});
            end
        end
    end
end