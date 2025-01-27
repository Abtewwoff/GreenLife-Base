function Abteww:JoinDiscord()
    SendNUIMessage({
        action = "openLink",
        url = "https://discord.gg/EXrK4sNKhu"
    });
end

function Abteww:ShowRules()
    SendNUIMessage({
        action = "openLink",
        url = "https://docs.google.com/document/d/1NyQG5kJ7DtzGlBq7XEZ2-KpgudzrAolhIjPYoACM3Dk/edit?usp=sharing"
    });
end

function Abteww:GetMainMenu()
    RageUI.Separator(("[ Pseudo : ~g~%s ~s~| ID : ~g~%s ~s~]"):format(Abteww.PlayerName, Abteww.PlayerServerId));
    RageUI.Line();
    RageUI.Button("Informations", nil, {RightLabel = "→→"}, true, {}, Abteww.PlayerInfosMenu);
    if (IsPedSittingInAnyVehicle(Abteww.PlayerPed)) then
        RageUI.Button("Gestion Véhicule", nil, {RightLabel = "→→"}, true, {}, Abteww.PlayerVehicleMenu);
    end
    RageUI.Button("Visualisation", nil, {RightLabel = "→→"}, true, {}, Abteww.visualisation);
    RageUI.Button("Commandes du serveur", nil, {RightLabel = "→→"}, true, {}, Abteww.ServerCommandsMenu);
    RageUI.Button("Vos préference", nil, {RightLabel = "→→"}, true, {}, Abteww.PlayerSettingsMenu);
end