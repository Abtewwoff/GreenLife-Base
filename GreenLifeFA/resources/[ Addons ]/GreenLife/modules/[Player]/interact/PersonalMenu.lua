Abteww = {};

-- [[ Menu Indexes ]]
Abteww.CarteIdIndex = 1;
Abteww.ConduireIdIndex = 1;
Abteww.ArmeIdIndex = 1;
Abteww.PoliceIdIndex = 1;
Abteww.VehicleEngineIndex = 1;
Abteww.SpeedLimiterIndex = 1;
Abteww.DoorActionsIndex = 1;
Abteww.DoorListIndex = 1;

Abteww.IdentitiesIndexes = {
    {Name = "Montrer", Value = 1},
    {Name = "Regarder", Value = 2}
};
Abteww.EngineIndexes = {
	"Allumer",
	"Éteindre",
};
Abteww.SpeedLimitIndexes = {
	"50 km/h",
	"80 km/h",
	"120 km/h",
	"Désactiver",
};
Abteww.DoorActionsIndexes = {
	"Ouvrir",
	"Fermer",
};
Abteww.DoorListIndexes = {
	"Toutes les portes",
	"Porte avant-gauche",
	"Porte avant-droite",
	"Porte arrière-gauche",
	"Porte arrière-droite",
	"Capot",
	"Coffre",
};
Abteww.DoorState = {
	All = false,
    FrontLeft = false,
    FrontRight = false,
    BackLeft = false,
    BackRight = false,
    Hood = false,
    Trunk = false,
};
Abteww.ServerKeyBinds = {
	{Label = "Ouvrir la Boutique du serveur", Keybind = "F1", StaffOnly = false},
	{Label = "Ouvrir le menu des Clés", Keybind = "F2", StaffOnly = false},
	{Label = "Changer le mode de voix", Keybind = "F3", StaffOnly = false},
	{Label = "Activer le NoClip", Keybind = "F4", StaffOnly = true},
	{Label = "Ouvrir le menu Personnel", Keybind = "F5", StaffOnly = false},
	{Label = "Ouvrir le menu Métier", Keybind = "F6", StaffOnly = false},
	{Label = "Ouvrir le menu Organisation/Gang", Keybind = "F7", StaffOnly = false},
	{Label = "Ouvrir le menu Staff", Keybind = "F10", StaffOnly = true},
	{Label = "Ouvrir le menu Radio", Keybind = "F11", StaffOnly = false},
	{Label = "Ouvrir l'Inventaire", Keybind = "TAB", StaffOnly = false},
	{Label = "Cacher la carte d'identité", Keybind = "BACKSPACE", StaffOnly = false},
	{Label = "Montrer du Doigt", Keybind = "B", StaffOnly = false},
	{Label = "Ouvrir le Téléphone", Keybind = "G", StaffOnly = false},
	{Label = "Lever les Mains", Keybind = "H", StaffOnly = false},
	{Label = "Tomber / Se relever", Keybind = "J", StaffOnly = false},
	{Label = "Ouvrir le menu Emotes", Keybind = "K", StaffOnly = false},
	{Label = "Ouvrir le Coffre du véhicule", Keybind = "L", StaffOnly = false},
	{Label = "Verrouiller le véhicule", Keybind = "U", StaffOnly = false},
	{Label = "Annuler l'animation", Keybind = "X", StaffOnly = false},
};
Abteww.ServerCommands = {
	{Label = "Faire appel à un membre du staff", Command = "report", StaffOnly = false},
	{Label = "Éffacer son chat (Annonces, ...)", Command = "clear", StaffOnly = false},
	{Label = "Activer la vente de drogue", Command = "ventedrogue", StaffOnly = false},
	{Label = "Ouvrir le menu Radio", Command = "radio", StaffOnly = false},
	{Label = "Faire une animation", Command = "e [nom]", StaffOnly = false},
	{Label = "Ouvrir l'interface de musique / vidéo", Command = "pmms", StaffOnly = false},
};

Abteww.Bills = {};
Abteww.SocietyMoney = 0;
Abteww.SocietyMoney2 = 0;
Abteww.ShowMinimap = true;
Abteww.ShowUI = true;
Abteww.Cenematique = false;
Abteww.Interface = false;
Abteww.CasqueMoto = false;
Abteww.IdleCam = false;
Abteww.BikeHelmet = false;
Abteww.SellingDrug = false;

-- [[ Main tree ]]
Abteww.MainMenu = RageUI.CreateMenu("", "Menu personnel");
Abteww.PlayerInfosMenu = RageUI.CreateSubMenu(Abteww.MainMenu, "", "Informations");
Abteww.IDproche = RageUI.CreateSubMenu(Abteww.visualisation, "", "ID Proche");
Abteww.PlayerVehicleMenu = RageUI.CreateSubMenu(Abteww.MainMenu, "", "Véhicule");
Abteww.PlayerSettingsMenu = RageUI.CreateSubMenu(Abteww.MainMenu, "", "Préférences");
Abteww.visualisation = RageUI.CreateSubMenu(Abteww.MainMenu, "", "Themes disponibles");
Abteww.ServerCommandsMenu = RageUI.CreateSubMenu(Abteww.MainMenu, "", "Commandes du serveur");
-- [[ Sub PlayerInfosMenu ]]
Abteww.PlayerIdentitiesMenu = RageUI.CreateSubMenu(Abteww.PlayerInfosMenu, "", "Documents officiels");
Abteww.PlayerBillsMenu = RageUI.CreateSubMenu(Abteww.PlayerInfosMenu, "", "Factures");
Abteww.PlayerManagementMenu = RageUI.CreateSubMenu(Abteww.PlayerInfosMenu, "", "Gestions Patron");
-- [[ Sub PlayerManagementMenu ]]
Abteww.PlayerLegalManagementMenu = RageUI.CreateSubMenu(Abteww.PlayerManagementMenu, "", "Gestion d'entreprise");
Abteww.PlayerIllegalManagementMenu = RageUI.CreateSubMenu(Abteww.PlayerManagementMenu, "", "Gestion de groupe illégal");

Abteww.MainMenu.Closed = function()
    IsMenuActive = false;
end

function Abteww:OpenPersonalMenu()
	if (IsMenuActive) then
		IsMenuActive = false;
		RageUI.Visible(Abteww.MainMenu, false);
		RageUI.Visible(Abteww.PlayerInfosMenu, false);
		RageUI.Visible(Abteww.IDproche, false);
		RageUI.Visible(Abteww.PlayerVehicleMenu, false);
		RageUI.Visible(Abteww.PlayerSettingsMenu, false);
		RageUI.Visible(Abteww.visualisation, false);
		RageUI.Visible(Abteww.ServerKeybindsMenu, false);
		RageUI.Visible(Abteww.ServerCommandsMenu, false);
		RageUI.Visible(Abteww.PlayerIdentitiesMenu, false);
		RageUI.Visible(Abteww.PlayerBillsMenu, false);
		RageUI.Visible(Abteww.PlayerManagementMenu, false);
		RageUI.Visible(Abteww.PlayerLegalManagementMenu, false);
		RageUI.Visible(Abteww.PlayerIllegalManagementMenu, false);
	else
		IsMenuActive = true;
		RageUI.Visible(Abteww.MainMenu, true);
		CreateThread(function()
			Abteww.PlayerPed = PlayerPedId();
			Abteww.PlayerId = PlayerId();
			Abteww.PlayerName = GetPlayerName(PlayerId());
			Abteww.PlayerServerId = GetPlayerServerId(Abteww.PlayerId);
			Abteww.PlayerGroup = ESX.GetPlayerData()["group"];
			while (IsMenuActive) do
                RageUI.IsVisible(Abteww.MainMenu, function()
					Abteww:GetMainMenu();
                end)
				
                RageUI.IsVisible(Abteww.PlayerInfosMenu, function()
					Abteww:GetPlayerInfosMenu();
                end)
				
				RageUI.IsVisible(Abteww.IDproche, function()
				Abteww:GetIDproche();
				end)
			

                RageUI.IsVisible(Abteww.PlayerIdentitiesMenu, function()
					Abteww:GetPlayerIdentitiesMenu();
                end)
				RageUI.IsVisible(Abteww.PlayerBillsMenu, function()
					Abteww:GetPlayerBillsMenuMenu();
                end)
				RageUI.IsVisible(Abteww.PlayerManagementMenu, function()
					Abteww:GetPlayerManagementMenu();
                end)

				RageUI.IsVisible(Abteww.PlayerLegalManagementMenu, function()
					Abteww:GetPlayerLegalManagementMenu();
                end)
				RageUI.IsVisible(Abteww.PlayerIllegalManagementMenu, function()
					Abteww:GetPlayerIllegalManagementMenu();
                end)

				RageUI.IsVisible(Abteww.PlayerVehicleMenu, function()
					Abteww:GetPlayerVehicleMenu();
                end)
				RageUI.IsVisible(Abteww.PlayerSettingsMenu, function()
					Abteww:GetPlayerSettingsMenu();
                end)
				RageUI.IsVisible(Abteww.visualisation, function()
				Abteww:visualisationnn();
				end)
				RageUI.IsVisible(Abteww.ServerKeybindsMenu, function()
					Abteww:GetServerKeybindsMenu();
                end)
				RageUI.IsVisible(Abteww.ServerCommandsMenu, function()
					Abteww:GetServerCommandsMenu();
                end)
				Wait(1);
			end
		end)
	end
end

function Abteww:ShowMarkerOnPlayer(Player)
    local Ped = GetPlayerPed(Player);
    local Position = GetEntityCoords(Ped);

    DrawMarker(2, Position.x, Position.y, Position.z + 1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 115, 240, 255, 0, 1, 2, 0, nil, nil, 0);
end

local noir = false
RegisterCommand('noir', function()
    noir = not noir
    if noir then 
		TriggerEvent('GreenLife:Hud:StateHud', false)
        DisplayRadar(false) 
    end
    while noir do
        if not HasStreamedTextureDictLoaded('revolutionbag') then
            RequestStreamedTextureDict('revolutionbag')
            while not HasStreamedTextureDictLoaded('revolutionbag') do
                Wait(50)
            end
        end

        DrawSprite('revolutionbag', 'cinema', 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
        Wait(0)
    end
	TriggerEvent('GreenLife:Hud:StateHud', true)
    DisplayRadar(true)
    SetStreamedTextureDictAsNoLongerNeeded('revolutionbag')
end)