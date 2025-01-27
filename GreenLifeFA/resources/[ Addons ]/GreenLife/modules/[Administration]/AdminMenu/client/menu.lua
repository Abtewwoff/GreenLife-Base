Menu = {
    GamerTags = {},
    PlayerSelected = nil,
    PlayerInventory = nil,
    PlayerAccounts = nil,
    PlayersWeapons = nil,
    ReportSelected = nil,
    List = {
        ClearZoneIndex = 1,
        ClearZoneItem = {Name = "10", Value = 10},
        TimeZoneIndex = 1,

        AppreciationIndex = 1,
        Item = {Name = "⭐️", Value = 1},
        ZoneClear = 1,
        ZoneReparer = 1,
        Zonemessage = 1,
        Zoneheal = 1,
        ZoneRevive = 1,
        TeleportLocation = 1,
        GiveMoneyIndex = 1,
        GiveVehicle = 1,
        GiveMoneyItem = {Name = "Liquide", Value = "money"},
    },
    ListStaff = {},
    itemList = {},
    SearchItem = {},
    jobsList = {},
    jobGrades = {},

    Type = {
        { Name = "Voiture", Value = "car"},
        { Name = "Avion", Value = "aircraft" },
        { Name = "Bateau", Value = "boat" }
    }
}
local AdminMenu = {
    VehiclesList = {
        "panto",
        "sanchez",
    },
    VehiclesListIndex = 1,
}
local filterArray = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }
local filter = 1
local alphaFilter = false
local zoneFilter = false
PlayerInSpec = false
local selectedColor = 1
local cVarLongC = { "~r~", ""}
local cVar1, cVar2 = "~r~", ""
function cVarLong()
    return cVarLongC[selectedColor]
end

function SizeOfReport()
    local count = 0
    for k,v in pairs(sAdmin.ReportList) do 
        count = count + 1
    end
    return count
end

function ReportEnCours()
    local count = 0
    for k,v in pairs(sAdmin.ReportList) do 
        if v.Taken then 
            count = count + 1
        end
    end
    return count
end


function KeyboardInputAdmin(TextEntry, ExampleText, MaxStringLength)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Wait(500)
		blockinput = false
		return result
	else
		Wait(500)
		blockinput = false
		return nil
	end
end


function defineorNot(str) 
    if str == nil then
        return "~r~Non Défini"
    else
        return "~g~Défini"
    end
end

RegisterNetEvent("dclearw")
AddEventHandler("dclearw", function(id)
   ExecuteCommand("clearloadout "..id)
end)

local string1 = nil
local string2 = nil
local select_type = "car"
local INDEXFDP = 1

local StaffInService = false

AddEventHandler("onNewReport", function()
    if showReports then
        updateReportsUI() 
    end
end)

AddEventHandler("onStaffStatusChange", function(newStaffCount)
    if showReports then
        updateReportsUI()
    end
end)


function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

local teleportLocations = {
    { Name = "Parking central", Coords = vector3(215.5, -810.2, 30.7) },
    { Name = "Fourrière", Coords = vector3(408.6, -1623.2, 29.3) },
    { Name = "Commissariat", Coords = vector3(425.1, -979.5, 30.7) },
}

local availableVehicles = {
    { Name = "Panto", Model = "panto" },
    { Name = "Sultan", Model = "sultan" }
}

local selectedSanction = 1
local sanctionTypes = {"Historique Warn", "Historique Ban" ,"Historique Jail"}
local statuselectricity = false
local statuspurge = false
local itemBuilderData = { label = "", name = "", weight = nil }
local gradeBuilderData = { jobName = "", grade = "", name = "", label = "", salary = "" }



local function OpenMenu(data)
    if ESX.GetPlayerData()['group'] == "user" and ESX.GetPlayerData()['group'] == nil then
        ESX.ShowNotification("🔒 ~r~Vous n'avez pas accès à ce menu.")
        return
    end
    if sAdmin.Config.Debug then 
        sAdmin.Debug("Ouverture du menu")
    end
    local menu = RageUI.CreateMenu("", "Interaction disponible")
    local persoMenu = RageUI.CreateSubMenu(menu, "", "Interaction personnel")
    local vehMenu = RageUI.CreateSubMenu(menu, "", "Interaction véhicule")
    local joueurMenu = RageUI.CreateSubMenu(menu, "", "Interaction joueurs")
    local menuactionsplayer = RageUI.CreateSubMenu(joueurMenu, "", "Actions sur le joueur")
    local teleportationaction = RageUI.CreateSubMenu(menuactionsplayer, "", "Téléportation")
    local sanctionplayer = RageUI.CreateSubMenu(menuactionsplayer, "", "Sanction")
    local sanctionList = RageUI.CreateSubMenu(sanctionplayer, "", "Liste des sanctions")
    local managesanction = RageUI.CreateSubMenu(sanctionList, "", "Gestion des sanctions")
    local joueurActionMenu = RageUI.CreateSubMenu(joueurMenu, "", "Actions sur le joueur")
    local actiondispo = RageUI.CreateSubMenu(menu, "", "Actions disponibles")
    local cardinal = RageUI.CreateSubMenu(menu, "", "Interaction serveur")
    local itembuilder = RageUI.CreateSubMenu(cardinal, "", "Builder d'item")
    local managesalaire = RageUI.CreateSubMenu(cardinal, "", "Gestion des salaires")
    local optionsalaire = RageUI.CreateSubMenu(managesalaire, "", "Options sur le salaire")
    local modification_grade = RageUI.CreateSubMenu(optionsalaire, "", "Modification du grade")
    local addgrade = RageUI.CreateSubMenu(optionsalaire, "", "Ajout d'un grade")
    local optionserveur = RageUI.CreateSubMenu(menu, "", "Options serveur")
    local jobslist = RageUI.CreateSubMenu(optionserveur, "", "Liste des jobs")
    local itemlist = RageUI.CreateSubMenu(optionserveur, "", "Liste des items")
    local optionitem = RageUI.CreateSubMenu(itemlist, "", "Options sur l'item")
    local managestaff = RageUI.CreateSubMenu(optionserveur, "", "Gestion du staff")
    local staffList = RageUI.CreateSubMenu(menu, "", "Liste des staffs")
    local staffinfo = RageUI.CreateSubMenu(staffList, "", "Informations du staff")
    local reportMenu = RageUI.CreateSubMenu(menu, "", "Liste des reports")
    local reportInfoMenu = RageUI.CreateSubMenu(reportMenu, "", "Informations du report")
    local actionsreports = RageUI.CreateSubMenu(reportInfoMenu, "", "Actions sur le report")
    
    RageUI.Visible(menu, not RageUI.Visible(menu))
    
    Citizen.CreateThread(function()
        while menu do
            Wait(800)
            if cVar1 == "" then
                cVar1 = "~r~"
            else
                cVar1 = ""
            end
            if cVar2 == "~r~" then
                cVar2 = ""
            else
                cVar2 = ""
            end
        end
    end)

    Citizen.CreateThread(function()
        while menu do
            Wait(250)
            selectedColor = selectedColor + 1
            if selectedColor > #cVarLongC then
                selectedColor = 1
            end
        end
    end)

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()
            if data.inService then 
                state = "~g~Actif"
            else 
                state = "~r~Inactif"
            end
            RageUI.Checkbox("Mode Staff", nil, data.inService, {}, {
                onChecked = function()
                    data.inService = true
                    sAdmin.inService = true
                    meta.actif_staff = meta.actif_staff + 1
                    TriggerServerEvent("sAdmin:ChangeState", true, data)
                    StaffInService = true
                    TriggerEvent("onStaffStatusChange", meta.actif_staff)
                end,
                onUnChecked = function()
                    data.inService = false
                    sAdmin.inService = false
                    StaffInService = false
                    TriggerEvent('SHOW_NOTIFTOP', false, ('Nombre de Reports (~r~%s~s~) | Report Counter (~y~%s~s~) | Nombre de staff (~g~%s~s~)'):format(nombreDeReports, reportEffectued, nombreDeStaff), "rgba(255, 255, 255, 1)")
                    meta.actif_staff = meta.actif_staff - 1
                    TriggerServerEvent("sAdmin:ChangeState", false, data)
                    TriggerEvent("onStaffStatusChange", meta.actif_staff)
                    if inNoclip then
                        inNoclip = false
                        CreateThread(function()
                            ToogleNoClip()
                        end)
                    end
                    if showName then
                        showName = false
                        showNames(showName)
                    end
                    if showBlips then
                        showBlips = false
                        showBlipsF(showBlips)
                    end
                    if inInvisible then
                        inInvisible = false
                        SetEntityInvincible(PlayerPedId(), false)
                        SetEntityVisible(PlayerPedId(), true, false)
                    end
                    if showReports then
                        showReports = false
                    end
                    if sonReports then
                        sonReports = false
                    end
                    exports['kRadial']:hideInfo()
                end,
            })

            RageUI.Line()

            RageUI.Button("Liste des Reports", nil, {RightLabel = "[~r~" .. SizeOfReport() .. "~s~]"}, data.inService and sAdmin.Config.Perms.AccesCat["report_menu"][data.grade], {}, reportMenu)
            RageUI.Button("Liste des Joueurs", nil, {RightLabel = "[~r~".. SizeOfPlayersList() .."~s~]"}, data.inService and sAdmin.Config.Perms.AccesCat["interaction_players"][data.grade], {}, joueurMenu)
            RageUI.Button("Gestion Véhicules", nil, {RightLabel = "→→"}, data.inService and sAdmin.Config.Perms.AccesCat["interaction_vehicle"][data.grade], {}, vehMenu)
            RageUI.Button("Gestion Préférences", nil, {RightLabel = "→→"}, data.inService and sAdmin.Config.Perms.AccesCat["interaction_perso"][data.grade], {}, persoMenu)
            RageUI.Button("Actions Disponibles", nil, {RightLabel = "→→"}, data.inService and sAdmin.Config.Perms.AccesCat["action_dispo"][data.grade], {}, actiondispo)
            RageUI.Line()
            RageUI.Button("Listes des builders", nil, {RightLabel = "→→"}, data.inService and sAdmin.Config.Perms.AccesCat["interaction_cardinal"][data.grade], {}, cardinal)
            RageUI.Button("Gestions Serveur", nil, {RightLabel = "→→"}, data.inService and sAdmin.Config.Perms.AccesCat["option_serveur"][data.grade], {}, optionserveur)

        end, function()
        end)

        RageUI.IsVisible(reportMenu, function()
            
            RageUI.Separator("Reports : ~g~"..SizeOfReport().."  ~c~|~s~ Dont ~g~"..ReportEnCours().."~s~ prit en charge")
            RageUI.Separator("Vous avez effectué ~g~"..sAdmin.AdminList[GetPlayerServerId(PlayerId())].reportEffectued .." reports.")

            RageUI.Line()

            for k,v in pairs(sAdmin.ReportList) do
                if (v.TakenBy == nil) then v.TakenBy = "Vous" end
                if not v.Taken then
                    RageUI.Button("[~r~EN ATTENTE~s~] → "..v.Name, "~s~Raison : "..v.Raison.."\n~s~Heure : "..v.Date.."\n~s~Auteur : "..v.Name, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            TriggerServerEvent("sAdmin:UpdateReport", k) 
                            Menu.ReportSelected = v
                        end
                    }, reportInfoMenu)
                else 
                    RageUI.Button("[~g~En Cours~s~] → "..v.Name, "~s~Raison : "..v.Raison.."\n~s~Heure : "..v.Date.."\n~s~Auteur : "..v.Name, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            Menu.ReportSelected = v
                        end
                    }, reportInfoMenu)
                end
            end
         
        end, function()
        end)

        RageUI.IsVisible(reportInfoMenu, function()
            
            while Menu.ReportSelected == nil do Wait(1) end

            RageUI.Separator("↓ Infomrations Report ↓")
 
            RageUI.Button("Nom du joueur :", nil, {RightLabel = "~g~"..Menu.ReportSelected.Name}, true, {})
            RageUI.Button("Raison du report :",nil , {RightLabel = "~g~"..Menu.ReportSelected.Raison}, true, {})
            RageUI.Button("Heure du report :", nil, {RightLabel = "~g~"..Menu.ReportSelected.Date}, true, {})
            RageUI.Button("Report pris par :", nil, {RightLabel = "~g~"..Menu.ReportSelected.TakenBy}, true, {})

            RageUI.Line()

            RageUI.Button("Gestion du Joueur", nil, {RightLabel = "→→"}, true, {
                onSelected = function()
                    Menu.PlayerSelected = {ped = GetPlayerPed(Menu.ReportSelected.Source), id = Menu.ReportSelected.Source}
                end
            }, actionsreports)
            RageUI.Button("Cloturer ce report", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, {
                onSelected = function()
                        TriggerServerEvent("sAdmin:ClotureReport", Menu.ReportSelected.Source)
                        RageUI.GoBack()
                end
            })
         
        end, function()
        end)
            

        RageUI.IsVisible(persoMenu, function()
            if sAdmin.Config.Perms.Buttons["cat_persoMenu"]["noclip"][data.grade] then
                RageUI.Checkbox('Mode noclip', nil, inNoclip, {}, {
                    onChecked = function()
                        inNoclip = true
                        ESX.ShowNotification("✈️ ~g~Administration\nMode noclip activé")
                        CreateThread(function()
                            ToogleNoClip()
                        end)
                    end,
                    onUnChecked = function()
                        inNoclip = false
                        ESX.ShowNotification("🚫 ~g~Administration\nMode noclip désactivé")
                        CreateThread(function()
                            ToogleNoClip()
                        end)
                    end,
                })
            end
            if sAdmin.Config.Perms.Buttons["cat_persoMenu"]["invisibleMonde"][data.grade] then 
                RageUI.Checkbox('Mode invisible', nil, inInvisible, {}, {
                    onChecked = function()
                        inInvisible = true
                        SetEntityInvincible(PlayerPedId(), true)
                        SetEntityVisible(PlayerPedId(), false, false)
                        SetEntityNoCollisionEntity(PlayerPedId(), entity2, false)
                        ESX.ShowNotification("🕵️‍♂️ ~g~Administration\nMode invisible activé")
                    end,
                    onUnChecked = function()
                        inInvisible = false
                        SetEntityInvincible(PlayerPedId(), false)
                        SetEntityVisible(PlayerPedId(), true, false)
                        ESX.ShowNotification("👀 ~g~Administration\nMode invisible désactivé")
                    end,
                })
            end
            -- if sAdmin.Config.Perms.Buttons["cat_persoMenu"]["show_gamertags"][data.grade] then
            --     RageUI.Checkbox('Affichez les noms', nil, showName, {}, {
            --         onChecked = function()
            --             showName = true
            --             ESX.ShowNotification("👀 ~g~Administration\nVous avez affiché les noms")
            --             showNames(showName)
            --         end,
            --         onUnChecked = function()
            --             showName = false
            --             ESX.ShowNotification("👀 ~g~Administration\nVous avez masqué les noms")
            --             showNames(showName)
            --         end,
            --     })
            -- end
            if sAdmin.Config.Perms.Buttons["cat_persoMenu"]["show_gamertags"][data.grade] then
                RageUI.Checkbox('Affichez les blips', nil, showBlips, {}, {
                    onChecked = function()
                        showBlips = true
                        ESX.ShowNotification("👀 ~g~Administration\nVous avez affiché les blips")
                        showBlipsF(showBlips)
                    end,
                    onUnChecked = function()
                        showBlips = false
                        ESX.ShowNotification("👀 ~g~Administration\nVous avez masqué les blips")
                        showBlipsF(showBlips)
                    end,
                })
            end
            if sAdmin.Config.Perms.Buttons["cat_persoMenu"]["report_info"][data.grade] then
                RageUI.Checkbox('Affichez les reports', nil, showReports, {}, {
                    onChecked = function()
                        showReports = true
                        updateReportsUI() 
                    end,
                    onUnChecked = function()
                        showReports = false
                        exports['kRadial']:hideInfo()
                    end,
                })
            end
            if sAdmin.Config.Perms.Buttons["cat_persoMenu"]["report_sound"][data.grade] then
                RageUI.Checkbox('Activer le son des reports', nil, sonReports, {}, {
                    onChecked = function()
                        sonReports = true
                    end,
                    onUnChecked = function()
                        sonReports = false
                    end,
                })
            end
            RageUI.Button('Se téléporter sur marqueur', nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_persoMenu"]["teleport_waypoint"][data.grade], {
                onSelected = function() 
                    local pPed = PlayerPedId()
                    local WaypointHandle = GetFirstBlipInfoId(8)
                    if DoesBlipExist(WaypointHandle) then
                        local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
                        SetEntityCoordsNoOffset(pPed, coord.x, coord.y, -199.5, false, false, false, true)
                        ESX.ShowNotification("✅ ~g~Administration\nTéléporté au marqueur avec succés")
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nIl n'y a pas de marqueur sur ta map")
                    end
                end
            })
            RageUI.Button("Enlever le sang sur soi", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_persoMenu"]["tache_sang"][data.grade], {
                onSelected = function()
                    ClearPedBloodDamage(PlayerPedId())
                    ESX.ShowNotification("🩸 ~g~Administration\nVous avez enlevé le sang sur vous")
                end
            })        
        end, function()
        end)

        RageUI.IsVisible(vehMenu, function()

            RageUI.Button("Réparer le véhicule", nil, { RightLabel = "→→" }, sAdmin.Config.Perms.Buttons["cat_vehMenu"]["repairVehicle"][data.grade], {
                onActive = function()
                    sAdmin.ClosetVehWithDisplay()
                end;
                onSelected = function()
                    local veh = GetClosestVehicleAdmin(GetEntityCoords(PlayerPedId()), nil)
                    NetworkRequestControlOfEntity(veh)
                    while not NetworkHasControlOfEntity(veh) do
                        Wait(1)
                    end
                    SetVehicleFixed(veh)
                    SetVehicleDeformationFixed(veh)
                    SetVehicleDirtLevel(veh, 0.0)
                    SetVehicleEngineHealth(veh, 1000.0)
                    ESX.ShowNotification("🔧 ~g~Véhicule réparé")
                end
            })
            RageUI.Button("Supprimer le véhicule", nil, { RightLabel = "→→" }, sAdmin.Config.Perms.Buttons["cat_vehMenu"]["clearVehicle"][data.grade], {
                onActive = function()
                    sAdmin.ClosetVehWithDisplay()
                end;
                onSelected = function()
                    Citizen.CreateThread(function()
                        local veh = GetClosestVehicleAdmin(GetEntityCoords(PlayerPedId()), nil)
                        NetworkRequestControlOfEntity(veh)
                        while not NetworkHasControlOfEntity(veh) do
                            Wait(1)
                        end
                        DeleteEntity(veh)
                        ESX.ShowNotification("🚗 ~g~Véhicule supprimé")
                    end)
                end
            })
            RageUI.Button("Freeze/Unfreeze un véhicule", nil, { RightLabel = "→→" }, sAdmin.Config.Perms.Buttons["cat_vehMenu"]["freezeVehicle"][data.grade], {
                onActive = function()
                    sAdmin.ClosetVehWithDisplay()
                end;
                onSelected = function()
                    local veh = ESX.Game.GetClosestVehicle(PlayerCoords)
                    if not IsFrozen then 
                        FreezeEntityPosition(veh, true)
                        IsFrozen = true 
                        ESX.ShowAdvancedNotification("MiraLife", "Administrateur", "Vous avez Freeze le véhicule", "CHAR_ADMIN", 1)
                    elseif IsFrozen then 
                        FreezeEntityPosition(veh, false)
                        IsFrozen = false
                        ESX.ShowAdvancedNotification("MiraLife", "Administrateur", "Vous avez Unfreeze le véhicule", "CHAR_ADMIN", 1)
                    end
                end
            })
            RageUI.Button("Faire le plein d'essence", nil, { RightLabel = "→→" }, true, {
                onActive = function()
                    sAdmin.ClosetVehWithDisplay()
                end;
                onSelected = function()
                    local player = PlayerPedId()
                    local veh = GetVehiclePedIsIn(player)

                    if veh ~= 0 then
                        exports["GreenLifeHud"]:SetFuel(veh, 100)
                    else
                        ESX.ShowNotification("🚙 Vous devez être dans un véhicule")
                    end   
                end
            })
            RageUI.Button("Retourner le véhicule", nil, { RightLabel = "→→" }, sAdmin.Config.Perms.Buttons["cat_vehMenu"]["returnVehicle"][data.grade], {
                onActive = function()
                    sAdmin.ClosetVehWithDisplay()
                end;
                onSelected = function()
                    local veh = GetClosestVehicleAdmin(GetEntityCoords(PlayerPedId()), nil)
                    NetworkRequestControlOfEntity(veh)
                    while not NetworkHasControlOfEntity(veh) do
                        Wait(1)
                    end
                    SetEntityCoords(veh, GetEntityCoords(PlayerPedId()))
                    ESX.ShowNotification("🚗 ~g~Véhicule retourné")
                end
            })
            RageUI.Line()

            RageUI.List('Réparer véhicule zone', {
                { Name = "5m", Value = 5 },
                { Name = "10m", Value = 10 },
                { Name = "15m", Value = 15 },
                { Name = "20m", Value = 20 },
                { Name = "25m", Value = 25 },
                { Name = "30m", Value = 30 },
                { Name = "35m", Value = 35 },
                { Name = "50m", Value = 50 },
                { Name = "100m", Value = 100 },
            }, Menu.List.ZoneReparer, nil, {}, nil, {
                onListChange = function(Index, Item)
                    Menu.List.ZoneReparer = Index;
                end,
                onSelected = function(Index, Item)
                    local playerPed = PlayerPedId()
                    local radius = Item.Value
                    if radius and tonumber(radius) then
                        radius = tonumber(radius) + 0.01
                        local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed, false), radius)

                        for i = 1, #vehicles, 1 do
                            local attempt = 0

                            while not NetworkHasControlOfEntity(vehicles[i]) and attempt < 100 and DoesEntityExist(vehicles[i]) do
                                Wait(100)
                                NetworkRequestControlOfEntity(vehicles[i])
                                attempt = attempt + 1
                            end

                            if DoesEntityExist(vehicles[i]) and NetworkHasControlOfEntity(vehicles[i]) then
                                SetVehicleFixed(vehicles[i])
                                SetVehicleDeformationFixed(vehicles[i])
                                SetVehicleDirtLevel(vehicles[i], 0.0)
                                SetVehicleEngineHealth(vehicles[i], 1000.0)
                            end
                        end
                    else
                        local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

                        if IsPedInAnyVehicle(playerPed, true) then
                            vehicle = GetVehiclePedIsIn(playerPed, false)
                        end

                        while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
                            Wait(100)
                            NetworkRequestControlOfEntity(vehicle)
                            attempt = attempt + 1
                        end

                        if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
                            SetVehicleFixed(vehicle)
                            SetVehicleDeformationFixed(vehicle)
                            SetVehicleDirtLevel(vehicle, 0.0)
                            SetVehicleEngineHealth(vehicle, 1000.0)
                        end
                    end
                end,
            })

            local pPed = PlayerPedId()
		    local plyCoords = GetEntityCoords(pPed)
            RageUI.List("Spawn un véhicule", AdminMenu.VehiclesList, AdminMenu.VehiclesListIndex, nil, {}, true, {
                onListChange = function(Index)
                    AdminMenu.VehiclesListIndex = Index
                end;
                onSelected = function(Index)
                    if Index == 1 then
                        TriggerServerEvent("sAdmin:spawnVehicle", 'panto', plyCoords)
                    elseif Index == 2 then
                        TriggerServerEvent("sAdmin:spawnVehicle", 'sanchez', plyCoords)
                        
                    end
                end
            })

            RageUI.List('Clear la zone', {
                { Name = "5m", Value = 5 },
                { Name = "10m", Value = 10 },
                { Name = "15m", Value = 15 },
                { Name = "20m", Value = 20 },
                { Name = "25m", Value = 25 },
                { Name = "30m", Value = 30 },
                { Name = "35m", Value = 35 },
                { Name = "50m", Value = 50 },
                { Name = "100m", Value = 100 },
            }, Menu.List.ZoneClear, nil, {}, nil, {
                onListChange = function(Index, Item)
                    Menu.List.ZoneClear = Index;
                end,
                onSelected = function(Index, Item)
                    local playerPed = PlayerPedId()
                    local radius = Item.Value
                    if radius and tonumber(radius) then
                        radius = tonumber(radius) + 0.01
                        local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed, false), radius)

                        for i = 1, #vehicles, 1 do
                            local attempt = 0

                            while not NetworkHasControlOfEntity(vehicles[i]) and attempt < 100 and DoesEntityExist(vehicles[i]) do
                                Wait(100)
                                NetworkRequestControlOfEntity(vehicles[i])
                                attempt = attempt + 1
                            end

                            if DoesEntityExist(vehicles[i]) and NetworkHasControlOfEntity(vehicles[i]) then
                                ESX.Game.DeleteVehicle(vehicles[i])
                                DeleteEntity(vehicles[i])
                            end
                        end
                    else
                        local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

                        if IsPedInAnyVehicle(playerPed, true) then
                            vehicle = GetVehiclePedIsIn(playerPed, false)
                        end

                        while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
                            Wait(100)
                            NetworkRequestControlOfEntity(vehicle)
                            attempt = attempt + 1
                        end

                        if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
                            ESX.Game.DeleteVehicle(vehicle)
                            DeleteEntity(vehicle)
                        end
                    end
                end,
            })
        end)

        RageUI.IsVisible(joueurMenu, function()

            RageUI.Checkbox("Restreindre à ma zone", nil, zoneFilter, {}, {
                onChecked = function()
                    zoneFilter = true
                end;
                onUnChecked = function()
                    zoneFilter = false
                end
            })

            if alphaFilter then
                RageUI.List("Filtre:", filterArray, filter, nil, {}, true, {
                    onListChange = function(Index)
                        filter = Index
                    end
                })
            end

            RageUI.Line()

            RageUI.Separator("↓ Joueurs ↓")

            if not zoneFilter then 
                for k,v in pairs(sAdmin.PlayersList) do 
                    if v.name ~= nil then
                        if alphaFilter then
                            if starts(v.name:lower(), filterArray[filter]:lower()) then
                                local group = ""
                                if v.group ~= "user" then 
                                    group = " ~r~[STAFF]~s~ "
                                else
                                    group = " "
                                end
                                if group ~= nil then
                                    RageUI.Button("["..k.."]".. group .. v.name, "~s~Heure de connexion : "..v.hoursLogin, {RightLabel = "→→"}, true, {
                                        onActive = function()
                                            sAdmin.PlayerMakrer(GetPlayerPed(k))
                                        end,
                                        onSelected = function()
                                            Menu.PlayerSelected = {ped = GetPlayerPed(k), id = k}
                                        end
                                    }, menuactionsplayer)
                                end
                            end
                        else
                            local group = ""
                            if v.group ~= "user" then 
                                group = " ~r~[STAFF]~s~ "
                            else
                                group = " "
                            end
                            RageUI.Button("["..k.."]".. group .. v.name, "~s~Heure de connexion : "..v.hoursLogin, {RightLabel = "→→"}, true, {
                                onActive = function()
                                    sAdmin.PlayerMakrer(GetPlayerPed(k))
                                end,
                                onSelected = function()
                                    Menu.PlayerSelected = {ped = GetPlayerPed(k), id = k}
                                end
                            }, menuactionsplayer)
                        end
                    end
                end
            else
                for _,player in pairs(GetActivePlayers()) do 
                    local sID = GetPlayerServerId(player)
                    local name = GetPlayerName(player)
                    if name ~= nil then
                        if alphaFilter then
                            if starts(name:lower(), filterArray[filter]:lower()) then
                                RageUI.Button("["..sID.."] "..name, nil, {RightLabel = "→→"}, true, {
                                    onActive = function()
                                        sAdmin.PlayerMakrer(GetPlayerPed(sID))
                                    end,
                                    onSelected = function()
                                        Menu.PlayerSelected = {ped = GetPlayerPed(sID), id = sID}
                                    end
                                }, menuactionsplayer)
                            end
                        else
                            RageUI.Button("["..sID.."] "..name, nil, {RightLabel = "→→"}, true, {
                                onActive = function()
                                    sAdmin.PlayerMakrer(GetPlayerPed(sID))
                                end,
                                onSelected = function()
                                    Menu.PlayerSelected = {ped = GetPlayerPed(sID), id = sID}
                                end
                            }, menuactionsplayer)
                        end
                    end
                end
            end
        end, function()
        end)

        RageUI.IsVisible(menuactionsplayer, function()
            RageUI.Button("Actions de téléportations", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["interaction_players"]["action_teleportation"][data.grade], {}, teleportationaction)
            RageUI.Button("Actions sur le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["interaction_players"]["action_player"][data.grade], {}, joueurActionMenu)
            RageUI.Button("Sanctionner le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["interaction_players"]["sanction_player"][data.grade], {}, sanctionplayer)
        end)
        
        RageUI.IsVisible(actionsreports, function()
            RageUI.Button("Actions de téléportations", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["report_menu"]["action_teleportation"][data.grade], {}, teleportationaction)
            RageUI.Button("Actions sur le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["report_menu"]["action_player"][data.grade], {}, joueurActionMenu)
            RageUI.Button("Sanctionner le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["report_menu"]["sanction_player"][data.grade], {}, sanctionplayer)
        end)

        RageUI.IsVisible(teleportationaction, function()
            RageUI.Button("Goto", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["goto"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:Goto", Menu.PlayerSelected.id)
                end
            })
            RageUI.Button("Bring", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["bring"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:Bring", Menu.PlayerSelected.id)
                end
            })            
            RageUI.Button("Bring Back", "Cela va peremettre de remettre la position d'avant au joueur", {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["bring"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:BringBack", Menu.PlayerSelected.id)
                end
            })
            RageUI.List('Lieux de téléportation', teleportLocations, Menu.List.TeleportLocation, nil, {}, nil, {
                onListChange = function(Index, Item)
                    Menu.List.TeleportLocation = Index
                end,
                onSelected = function(Index, Item)
                    local coords = Item.Coords
                    if coords and Menu.PlayerSelected then
                        local targetPlayerPed = GetPlayerPed(GetPlayerFromServerId(Menu.PlayerSelected.id))
                        if targetPlayerPed then
                            SetEntityCoords(targetPlayerPed, coords.x, coords.y, coords.z)
                            ESX.ShowNotification("Le joueur a étais téléporter ~s~ vers ~r~" .. Item.Name)
                        else
                            ESX.ShowNotification("~r~Le joueur sélectionné est introuvable")
                        end
                    else
                        ESX.ShowNotification("~r~Coordonnées invalides ou joueur non sélectionné")
                    end
                end,
            })
        end)
        
        RageUI.IsVisible(sanctionplayer, function()
            RageUI.Button("Ban le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["ban"][data.grade], {
                onSelected = function()
                    local id_player = Menu.PlayerSelected.id  
                    
                    if id_player then
                        local time = exports["cfx-target"]:ShowSync('Durée ban en heure', true, 600, "number")
                        if time then
                            local raison_ban = exports["cfx-target"]:ShowSync('Veuillez indiquer la raison du ban : ', true, 600, "small_text")
                            if raison_ban then
                                ExecuteCommand("ban " .. id_player .. " " .. time .. " " .. raison_ban)
                            else
                                ESX.ShowNotification("❌ ~g~Administration\nRaison invalide.")
                            end
                        else
                            ESX.ShowNotification("❌ ~g~Administration\nDurée invalide.")
                        end
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nID joueur invalide.")
                    end
                end
            })

            RageUI.Button("Kick le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["kick"][data.grade], {
                onSelected = function()
                    local reason = exports["cfx-target"]:ShowSync('Veuillez indiquer votre la raison : ', true, 600, "small_text")
                    if reason then
                        TriggerServerEvent("sAdmin:Kick", Menu.PlayerSelected.id, tostring(reason))
                        RageUI.CloseAll()
                    else 
                        ESX.ShowNotification("❌ ~g~Administration\nMessage invalide")
                    end
                end
            })
            RageUI.Button("Warn le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["warn"][data.grade], {
                onSelected = function()
                    local reason = exports["cfx-target"]:ShowSync('Veuillez indiquer votre la raison : ', true, 600, "small_text")
                    if reason then
                        TriggerServerEvent("sAdmin:Warn", Menu.PlayerSelected.id, tostring(reason))
                    else 
                        ESX.ShowNotification("❌ ~g~Administration\nMessage invalide")
                    end
                end
            })
            RageUI.Button("Jail le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["jail"][data.grade], {
                onSelected = function()
                    ExecuteCommand("jail "..Menu.PlayerSelected.id)
                end
            })
            RageUI.Button("Tuer le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["kill"][data.grade], {
                onSelected = function()
                    local targetPlayerPed = GetPlayerPed(GetPlayerFromServerId(Menu.PlayerSelected.id))
                    if targetPlayerPed then
                        SetEntityHealth(targetPlayerPed, 0)
                    end
                end
            })
            RageUI.Line()
        
            RageUI.Button("Voir les sanctions", nil, {RightLabel = "→→"}, true, {
                onSelected = function()
                end
            }, sanctionList)
        end)
        

        RageUI.IsVisible(sanctionList, function()
            RageUI.List("Sanctions", sanctionTypes, selectedSanction, nil, {}, true, {
                onListChange = function(Index)
                    selectedSanction = Index
                end,
                onSelected = function(Index)
                    local playerId = Menu.PlayerSelected.id 
                    print("Demande de récupération des avertissements pour l'ID:", playerId)
        
                    if Index == 1 then
                        TriggerServerEvent("sAdmin:FetchPlayerWarns", playerId)
                    elseif Index == 2 then 
                        TriggerServerEvent("sAdmin:FetchPlayerBans", playerId)
                    elseif Index == 3 then
                        TriggerServerEvent("sAdmin:FetchPlayerJails", playerId)
                    end
                end
            })
        
            RageUI.Line()
        
            if selectedSanction == 1 then
                if playerWarns and #playerWarns > 0 then
                    for _, warn in ipairs(playerWarns) do
                        RageUI.Button("Warn #".. warn.nombre_avertissement, "Staff : ".. warn.staff_name .."\n~s~Raison : " .. warn.raison .. "\n~s~Date : " .. warn.date .."\n~s~Heure : ".. warn.heure, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                selectedWarnId = warn.id_warn
                            end
                        }, managesanction)
                    end
                else
                    RageUI.Separator(" ~r~Aucun avertissement trouvé pour ce joueur ")
                end
            elseif selectedSanction == 2 then
                if playerBans and #playerBans > 0 then
                    for _, ban in ipairs(playerBans) do
                        RageUI.Button("ID de ban : ".. ban.ban_id, "Staff : ".. ban.sourceplayername .."\n~s~Raison : " .. ban.reason .. "\n~s~Date d'ajout : " .. ban.added .. "\n~s~Permanent : ".. ban.permanent, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                selectedBanId = ban.id
                            end
                        }, managesanction)
                    end
                else
                    RageUI.Separator(" ~r~Aucun ban trouvé pour ce joueur ")
                end
            elseif selectedSanction == 3 then
                if playerJails and #playerJails > 0 then
                    for _, jail in ipairs(playerJails) do
                        RageUI.Button("ID de jail : ".. jail.id_jail, "Staff : ".. jail.staff_name .."\n~s~Raison : ".. jail.raison .."\n~s~Nombres de tâches : ".. jail.nombre_tache .."\n~s~Date d'ajout : ".. jail.date .."\n~s~Heure d'ajout : ".. jail.heure, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                selectedJailId = jail.id
                            end
                        }, managesanction)
                    end
                else
                    RageUI.Separator(" ~r~Aucun jail trouvé pour ce joueur ")
                end
            end
        end)
        
        RageUI.IsVisible(managesanction, function()

            if selectedSanction == 1 then
                RageUI.Button("Supprimer le warn", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        if selectedWarnId then
                            TriggerServerEvent("sAdmin:DeleteWarn", selectedWarnId)
                            RageUI.CloseAll()
                        end
                    end
                })
            elseif selectedSanction == 2 then
                RageUI.Button("Supprimer le ban", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        if selectedBanId then
                            TriggerServerEvent("sAdmin:DeleteBan", selectedBanId)
                            RageUI.CloseAll()
                        end
                    end
                })
            elseif selectedSanction == 3 then
                RageUI.Button("Supprimer le jail", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        if selectedJailId then
                            TriggerServerEvent("sAdmin:DeleteJail", selectedJailId)
                            RageUI.CloseAll()
                        end
                    end
                })
            end
        end)
        

        RageUI.IsVisible(joueurActionMenu, function()
            RageUI.Button("Réanimer le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["revive"][data.grade], {
                onSelected = function()
                    ExecuteCommand("revive "..Menu.PlayerSelected.id)
                end
            })  
            RageUI.Button("Heal le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["heal"][data.grade], {
                onSelected = function()
                    ExecuteCommand("heal "..Menu.PlayerSelected.id)
                end
            })
            RageUI.Button("Enlever le sang sur le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["tache_sang_player"][data.grade], {
                onSelected = function()
                    ClearPedBloodDamage(Menu.PlayerSelected.ped)
                end
            })

            RageUI.Line()

            RageUI.Button("Spectate le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["spec"][data.grade], {
                onSelected = function()
                    if Menu.PlayerSelected.id == PlayerPedId() then 
                        ESX.ShowNotification("⚠️ Tu peux pas te spec toi même !")
                    else
                        Admin:StartSpectate({
                            id = Menu.PlayerSelected.id,
                            ped = GetPlayerPed(GetPlayerFromServerId(Menu.PlayerSelected.id))
                        })
                    end
                end
            })
            RageUI.Button("Faire un screen de son écran", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["screen"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("AdminMenu:screenShot", Menu.PlayerSelected.id)
                end
            })
            RageUI.Button("Envoyer un message en plein écran", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["sendMess"][data.grade], {
                onSelected = function()
                    local message = exports["cfx-target"]:ShowSync('Veuillez indiquer votre message : ', true, 600, "small_text")
                    if message then
                        TriggerServerEvent("sAdmin:SendMessageGros", Menu.PlayerSelected.id, tostring(message))
                    else 
                        ESX.ShowNotification("❌ ~g~Administration\nMessage invalide")
                    end
                end
            })
            RageUI.Button("Envoyer un message", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["sendMess"][data.grade], {
                onSelected = function()
                    local message = exports["cfx-target"]:ShowSync('Veuillez indiquer votre message : ', true, 600, "small_text")
                    if message then
                        TriggerServerEvent("sAdmin:SendMessage", Menu.PlayerSelected.id, tostring(message))
                    else 
                        ESX.ShowNotification("❌ ~g~Administration\nMessage invalide")
                    end
                end
            })

            RageUI.Line()

            RageUI.Button("Voir l'inventaire", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["showInventory"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("GreenLife:Inventory:OpenSecondInventory", "fplayerStaff", Menu.PlayerSelected.id)
                end
            })
            RageUI.Button("Freeze le joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["freeze"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:Freeze", Menu.PlayerSelected.id)
                end
            })
            RageUI.List('Donner un véhicule au joueur', availableVehicles, Menu.List.GiveVehicle, nil, {}, nil, {
                onListChange = function(Index, Item)
                    Menu.List.GiveVehicle = Index
                end,
                onSelected = function(Index, Item)
                    if Item then
                        local vehicleModel = Item.Model
                        local targetPlayerPed = GetPlayerPed(GetPlayerFromServerId(Menu.PlayerSelected.id))
                        
                        if vehicleModel and targetPlayerPed then
                            local hash = GetHashKey(vehicleModel)
                            
                            RequestModel(hash)
                            while not HasModelLoaded(hash) do Wait(100) end
            
                            local coords = GetEntityCoords(targetPlayerPed)
                            local heading = GetEntityHeading(targetPlayerPed)
            
                            local vehicle = CreateVehicle(hash, coords.x, coords.y, coords.z, heading, true, false)
                            SetEntityAsMissionEntity(vehicle, true, true)
                            
                            ESX.ShowNotification("Vous avez fait apparaître un véhicule pour le joueur")
                        end
                    end
                end,
            })
        end)

        RageUI.IsVisible(actiondispo, function()

        RageUI.Button("Faire apparaitre un véhicule sur un joueur", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["action_dispo"]["spawnVehicle"][data.grade], {
            onSelected = function()
                local veh = exports["cfx-target"]:ShowSync('Veuillez indiquer le nom du véhicule : ', true, 600, "small_text")
                local playerId = exports["cfx-target"]:ShowSync('Veuillez indiquer l\'ID du joueur : ', true, 600, "small_text")

                if veh ~= nil and veh ~= " " and playerId ~= nil and playerId ~= " " then
                    local hash = GetHashKey(veh)

                    RequestModel(hash)
                    local ped = GetEntityCoords(PlayerPedId())
                    local heading = GetEntityHeading(PlayerPedId())
                    local player = PlayerPedId()
                    while not HasModelLoaded(hash) do Wait(100) end

                    local vehicle = CreateVehicle(hash, ped.x, ped.y, ped.z, heading, true, false)
                    SetEntityAsMissionEntity(vehicle, true, true)
                    ESX.ShowNotification("Vous avez fait apparaître un ~r~"..veh.."~w~ sur le joueur avec l'ID ~r~"..playerId)
                end
            end,
        })

            RageUI.List('Message de zone', {
                { Name = "5m", Value = 5 },
                { Name = "10m", Value = 10 },
                { Name = "15m", Value = 15 },
                { Name = "20m", Value = 20 },
                { Name = "25m", Value = 25 },
                { Name = "30m", Value = 30 },
                { Name = "35m", Value = 35 },
                { Name = "50m", Value = 50 },
                { Name = "100m", Value = 100 },
            }, Menu.List.Zonemessage, nil, {}, nil, {
                onListChange = function(Index, Item)
                    Menu.List.Zonemessage = Index
                end,
                onSelected = function(Index, Item)
                    local playerPed = PlayerPedId()
                    local radius = Item.Value
                    if radius and tonumber(radius) then
                        radius = tonumber(radius)
                        local textzone = exports["cfx-target"]:ShowSync('Veuillez indiquer le message : ', true, 400, "text")
                        if textzone and textzone ~= "" then
                            TriggerServerEvent("sAdmin:ZoneMessage", GetEntityCoords(playerPed), radius, textzone)
                            ESX.ShowNotification("Vous avez envoyer un message dans une zone de ~r~"..radius.." m")
                        else
                            ESX.ShowNotification("~r~Message invalid")
                        end
                    end
                end,
            })  
            RageUI.List('Heal la zone', {
                { Name = "5m", Value = 5 },
                { Name = "10m", Value = 10 },
                { Name = "15m", Value = 15 },
                { Name = "20m", Value = 20 },
                { Name = "25m", Value = 25 },
                { Name = "30m", Value = 30 },
                { Name = "35m", Value = 35 },
                { Name = "50m", Value = 50 },
                { Name = "100m", Value = 100 },
            }, Menu.List.Zoneheal, nil, {}, nil, {
                onListChange = function(Index, Item)
                    Menu.List.Zoneheal = Index
                end,
                onSelected = function(Index, Item)
                    local playerPed = PlayerPedId()
                    local radius = Item.Value
                    if radius and tonumber(radius) then
                        radius = tonumber(radius)
                        local players = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed, false), radius)
                        for i = 1, #players, 1 do
                            local playerPed = GetPlayerPed(players[i])
                            SetEntityHealth(playerPed, 200)
                            ESX.ShowNotification("Vous avez soigner tous le monde dans une zone de ~r~"..radius.." m")
                        end
                        
                    end
                end,
            })     
            RageUI.List('Revive la zone', {
                { Name = "5m", Value = 5 },
                { Name = "10m", Value = 10 },
                { Name = "15m", Value = 15 },
                { Name = "20m", Value = 20 },
                { Name = "25m", Value = 25 },
                { Name = "30m", Value = 30 },
                { Name = "35m", Value = 35 },
                { Name = "50m", Value = 50 },
                { Name = "100m", Value = 100 },
            }, Menu.List.ZoneRevive, nil, {}, nil, {
                onListChange = function(Index, Item)
                    Menu.List.ZoneRevive = Index
                end,
                onSelected = function(Index, Item)
                    local playerPed = PlayerPedId()
                    local radius = Item.Value
                    if radius and tonumber(radius) then
                        radius = tonumber(radius)
                        local players = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed, false), radius)
                        for i = 1, #players, 1 do
                            local targetPed = GetPlayerPed(players[i])
                            TriggerServerEvent("sAdmin:Revive", GetEntityCoords(targetPed))
                        end
                        ESX.ShowNotification("Vous avez revive tous le monde dans une zone de ~r~" .. radius .. " m")
                    end
                end,
            })
        end)

        RageUI.IsVisible(cardinal, function()
            RageUI.Button("Crée un gang", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   ExecuteCommand("sGangBuilder")
                   ESX.ShowNotification("📩 Merci de prévenir Abteww a la fin de la création !")
                end
            })

            RageUI.Button("Crée un job", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   ExecuteCommand("createjob")
                   ESX.ShowNotification("📩 Merci de prévenir Abteww a la fin de la création !")
                end
            })

            RageUI.Button("Crée un event", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   ExecuteCommand("event")
                end
            })
            RageUI.Button("Crée une drogue", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   ExecuteCommand("drugsbuilder")
                end
            })
            RageUI.Button("Crée un coffre", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   ExecuteCommand("chestbuilder")
                end
            })
            RageUI.Button("Crée un yacht", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   ExecuteCommand("yachtbuilder")
                end
            })
            RageUI.Button("Crée une propritété", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   ExecuteCommand("openProperties")
                end
            })
            RageUI.Button("Crée un item", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                end
            }, itembuilder)
            RageUI.Button("Gestions des salaires", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:GetJobsList")
                end
            }, managesalaire)

        end, function()
        end)

        RageUI.IsVisible(managesalaire, function()
            for _, job in pairs(Menu.jobsList) do
                RageUI.Button(job.label, "Nom du job : " .. job.name .. "\nType de société : " .. job.societyType, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        Menu.selectedJob = job
                        TriggerServerEvent("sAdmin:GetJobGrades", job.name)
                    end
                }, optionsalaire)
            end
        end)
        
        RageUI.IsVisible(optionsalaire, function()
            if Menu.selectedJob and #Menu.jobGrades > 0 then
                for _, grade in pairs(Menu.jobGrades) do
                    RageUI.Button(grade.label, "Grade : " .. grade.name .. "\nSalaire : " .. grade.salary, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            Menu.selectedGrade = grade
                        end
                    }, modification_grade)
                end

                RageUI.Line()

                RageUI.Button("Ajouter un grade", nil, {RightLabel = "→→"}, true, {}, addgrade)
            else
                RageUI.Separator("~r~Aucun grade disponible pour ce job")
            end
        end)

        RageUI.IsVisible(modification_grade, function()
            if Menu.selectedGrade then

                RageUI.Button("Modifier le salaire", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        local newSalary = exports["cfx-target"]:ShowSync('Nouveau salaire : ', true, 600, "number")
                        if newSalary and tonumber(newSalary) then
                            TriggerServerEvent("sAdmin:UpdateJobGrade", Menu.selectedJob.name, Menu.selectedGrade.name, tonumber(newSalary))
                            RageUI.GoBack()
                        else
                            ESX.ShowNotification("❌ ~g~Administration\nSalaire invalide")
                        end
                    end
                })

                RageUI.Button("Supprimer le grade", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent("sAdmin:DeleteJobGrade", Menu.selectedJob.name, Menu.selectedGrade.name)
                        RageUI.GoBack()
                    end
                })
            end
        end)

        RageUI.IsVisible(addgrade, function()
            RageUI.Button("Nom du Job (minuscule) : " .. (gradeBuilderData.jobName ~= "" and gradeBuilderData.jobName or "Aucun"), nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    local jobName = exports["cfx-target"]:ShowSync("Entrez le nom du job :", true, 600, "text")
                    if jobName and jobName ~= "" then
                        gradeBuilderData.jobName = jobName
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nNom de job invalide")
                    end
                end
            })
        
            RageUI.Button("Grade : " .. (gradeBuilderData.grade ~= "" and gradeBuilderData.grade or "Aucun"), nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    local grade = exports["cfx-target"]:ShowSync("Entrez le grade :", true, 600, "number")
                    if grade and tonumber(grade) then
                        gradeBuilderData.grade = tonumber(grade)
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nGrade invalide")
                    end
                end
            })
        
            RageUI.Button("Nom du grade : " .. (gradeBuilderData.name ~= "" and gradeBuilderData.name or "Aucun"), nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    local name = exports["cfx-target"]:ShowSync("(minuscule et sans espace(pour faire une espace c'est : _ ))", true, 600, "text")
                    if name and name ~= "" then
                        gradeBuilderData.name = name
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nNom interne invalide")
                    end
                end
            })
        
            RageUI.Button("Label : " .. (gradeBuilderData.label ~= "" and gradeBuilderData.label or "Aucun"), nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    local label = exports["cfx-target"]:ShowSync("Entrez le label :", true, 600, "text")
                    if label and label ~= "" then
                        gradeBuilderData.label = label
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nLabel invalide")
                    end
                end
            })
        
            RageUI.Button("Salaire : " .. (gradeBuilderData.salary ~= "" and gradeBuilderData.salary or "Aucun"), nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    local salary = exports["cfx-target"]:ShowSync("Entrez le salaire :", true, 600, "number")
                    if salary and tonumber(salary) then
                        gradeBuilderData.salary = tonumber(salary)
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nSalaire invalide")
                    end
                end
            })
        
            RageUI.Button("Créer le grade", "Validez la création du grade", { RightLabel = "✅" }, true, {
                onSelected = function()
                    if gradeBuilderData.jobName ~= "" and gradeBuilderData.grade ~= "" and gradeBuilderData.name ~= "" and gradeBuilderData.label ~= "" and gradeBuilderData.salary ~= "" then
                        TriggerServerEvent("sAdmin:CreateJobGrade", gradeBuilderData)
                        gradeBuilderData = { jobName = "", grade = "", name = "", label = "", salary = "" }
                        RageUI.GoBack()
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nVeuillez remplir tous les champs.")
                    end
                end
            })
        end)

        RageUI.IsVisible(itembuilder, function()
            RageUI.Button("Label : " .. (itemBuilderData.label ~= "" and itemBuilderData.label or "Aucun"), nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    local label = exports["cfx-target"]:ShowSync("Entrez le label de l'item :", true, 600, "text")
                    if label and label ~= "" then
                        itemBuilderData.label = label
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nLabel invalide")
                    end
                end
            })

            RageUI.Button("Nom : " .. (itemBuilderData.name ~= "" and itemBuilderData.name or "Aucun"), nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    local name = exports["cfx-target"]:ShowSync("Entrez le nom de l'item :", true, 600, "text")
                    if name and name ~= "" then
                        itemBuilderData.name = name
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nNom invalide")
                    end
                end
            })

            RageUI.Button("Poids : " .. (itemBuilderData.weight and tostring(itemBuilderData.weight) or "Aucun"), nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    local weight = exports["cfx-target"]:ShowSync("Entrez le poids de l'item :", true, 600, "number")
                    if weight and tonumber(weight) then
                        itemBuilderData.weight = tonumber(weight)
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nPoids invalide")
                    end
                end
            })

            RageUI.Button("Créer l'item", "Validez la création de l'item", { RightLabel = "✅" }, true, {
                onSelected = function()
                    if itemBuilderData.label ~= "" and itemBuilderData.name ~= "" and itemBuilderData.weight then
                        TriggerServerEvent("sAdmin:CreateItem", {
                            label = itemBuilderData.label,
                            name = itemBuilderData.name,
                            weight = itemBuilderData.weight
                        })
                        itemBuilderData = { label = "", name = "", weight = nil }
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nVeuillez remplir tous les champs.")
                    end
                end
            })
        end)

        RageUI.IsVisible(optionserveur, function()

            RageUI.Button("Gestions Staffs", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["option_serveur"]["gestion_staff"][data.grade], {}, managestaff)
            RageUI.Button("Faire une annonce", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["option_serveur"]["annonce"][data.grade], {
                onSelected = function()
                    local message = exports["cfx-target"]:ShowSync('Veuillez indiquer votre annonce : ', true, 600, "small_text")
                    if message then
                        TriggerServerEvent("sAdmin:Annonce", message)
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nMessage invalide")
                    end
                end
            })
            RageUI.Button("Liste des Jobs/Orgas", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["option_serveur"]["jobsinfos"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:GetJobsList")
                end
            }, jobslist)
            RageUI.Button("Liste des Items", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["option_serveur"]["items_list"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:GetItemsList")
                end
            }, itemlist)

            RageUI.Line()

            RageUI.Button("Teleport All", "Permet de téléporter tous le serveur sur vous", {RightLabel = "⚠️"}, sAdmin.Config.Perms.Buttons["option_serveur"]["tp_all"][data.grade], {
                onSelected = function()
                    local message = exports["cfx-target"]:ShowSync('Êtes vous sûr de votre choix (oui/non): ', true, 600, "small_text")
                    if message == "oui" then
                        TriggerServerEvent("tAdmin:teleportAll", GetEntityCoords(PlayerPedId()))
                        ESX.ShowNotification("✨ ~g~Information\n~s~Tout le monde a été téléporté sur vous !")
                    else
                     ESX.ShowNotification("⚠️ ~r~Erreur !\n~s~Format invalide !")

                    end
                end
            })
            RageUI.Button("Revive All", "Permet de revive tous le serveur", {RightLabel = "❤️"}, sAdmin.Config.Perms.Buttons["option_serveur"]["revive_all"][data.grade], {
                onSelected = function()
                    local message = exports["cfx-target"]:ShowSync('Êtes vous sûr de votre choix (oui/non): ', true, 600, "small_text")
                    if message == "oui" then
                        TriggerServerEvent("tAdmin:reviveAll", GetEntityCoords(PlayerPedId()))
                        ESX.ShowNotification("~g~Information\n~s~Tout le monde a etait revive")
                    else
                    ESX.ShowNotification("⚠️ ~r~Erreur !\n~s~Format invalide !")

                    end
                end
            })
            RageUI.Button("Heal All", "Permet de heal tous le serveur", {RightLabel = "❤️"}, sAdmin.Config.Perms.Buttons["option_serveur"]["heal_all"][data.grade], {
                onSelected = function()
                    local message = exports["cfx-target"]:ShowSync('Êtes vous sûr de votre choix (oui/non): ', true, 600, "small_text")
                    if message == "oui" then
                        TriggerServerEvent("tAdmin:healAll", GetEntityCoords(PlayerPedId()))
                        ESX.ShowNotification("~g~Information\n~s~Tout le monde a etait heal")
                    else
                    ESX.ShowNotification("⚠️ ~r~Erreur !\n~s~Format invalide !")

                    end
                end
            })


        end)

        RageUI.IsVisible(jobslist, function()
            for _, job in pairs(Menu.jobsList) do
                RageUI.Button("" .. job.label, "Nom du job : " .. job.name .."\nType de société : "..job.societyType, {RightLabel = "→→"}, true, {
                    onSelected = function()
                    end
                })
            end
        end)

        RageUI.IsVisible(itemlist, function()
            for _, item in pairs(Menu.itemList) do
                RageUI.Button(item.label, "Nom de l'item : " .. item.nom .. "\nPoids : " .. item.weight, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        Menu.ItemSelected = item.nom
                    end
                }, optionitem)
            end
        end)
        
        RageUI.IsVisible(optionitem, function()
            if Menu.ItemSelected then 
                RageUI.Button("Changer le poids de l'item", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["option_serveur"]["change_weight_item"][data.grade], {
                    onSelected = function()
                        local poids = exports["cfx-target"]:ShowSync('Veuillez indiquer le poids de l\'item : ', true, 600, "number")
                        if poids then
                            TriggerServerEvent("sAdmin:ChangeWeightItem", Menu.ItemSelected, poids)
                            RageUI.GoBack()
                        else
                            ESX.ShowNotification("❌ ~g~Administration\nPoids invalide")
                        end
                    end
                })

                RageUI.Button("Supprimer l'item", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["option_serveur"]["delete_item"][data.grade], {
                    onSelected = function()
                        TriggerServerEvent("sAdmin:DeleteItem", Menu.ItemSelected)
                        RageUI.GoBack()
                    end
                })
            else
                ESX.ShowNotification("❌ ~g~Administration\nAucun item sélectionné")
            end
        end)
        

        RageUI.IsVisible(managestaff, function()
            RageUI.Button("Ajouter un staff", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["option_serveur"]["add_staff"][data.grade], {
                onSelected = function()
                    local id = exports["cfx-target"]:ShowSync('Veuillez indiquer l\'ID du joueur : ', true, 600, "small_text")
                    local grade = exports["cfx-target"]:ShowSync('Veuillez indiquer le grade du joueur : ', true, 600, "small_text")
                    if id and grade then
                        TriggerServerEvent("sAdmin:AddStaff", id, grade)
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nID ou grade invalide")
                    end
                end
            })

            RageUI.Button("Modifier le grade d'un staff", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["option_serveur"]["modif_staff_role"][data.grade], {
                onSelected = function()
                    local id = exports["cfx-target"]:ShowSync('Veuillez indiquer l\'ID du joueur : ', true, 600, "small_text")
                    local grade = exports["cfx-target"]:ShowSync('Veuillez indiquer le grade du joueur : ', true, 600, "small_text")

                    if id and grade then
                        TriggerServerEvent("sAdmin:UpdateStaff", id, grade)
                    else
                        ESX.ShowNotification("❌ ~g~Administration\nID ou grade invalide")
                    end
                end
            })

            RageUI.Line()

            RageUI.Button("Liste des staffs", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["option_serveur"]["staff_list"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:GetStaffsList")
                end
            }, staffList)
        end)

        RageUI.IsVisible(staffList, function()
            for _, staff in pairs(Menu.ListStaff) do
                RageUI.Button("" .. staff.name, "\nMoyenne Appréciation : " .. string.format("%.2f", staff.average_evaluation), {RightLabel = "→→"}, true, {
                    onSelected = function()
                        Menu.StaffSelected = staff
                    end
                }, staffinfo)
            end
        end)
        
        
        RageUI.IsVisible(staffinfo, function()
            if Menu.StaffSelected then  
                local selectedStaff = Menu.StaffSelected
                RageUI.Button("Supprimer le staff", nil, {RightLabel = "→→"}, sAdmin.Config.Perms.Buttons["option_serveur"]["delete_staff"][data.grade], {
                    onSelected = function()
                        TriggerServerEvent("sAdmin:DeleteStaff", selectedStaff.license)
                    end
                })
            end
        end)      

        if not RageUI.Visible(menu) and not RageUI.Visible(persoMenu) and not RageUI.Visible(vehMenu) and not RageUI.Visible(joueurMenu) 
        and not RageUI.Visible(joueurActionMenu) and not RageUI.Visible(teleportationaction) and not RageUI.Visible(sanctionplayer) and not RageUI.Visible(menuactionsplayer) and not RageUI.Visible(cardinal) and not RageUI.Visible(reportMenu) 
        and not RageUI.Visible(reportInfoMenu) and not RageUI.Visible(actiondispo) and not RageUI.Visible(sanctionList) and not RageUI.Visible(managesanction) and not RageUI.Visible(actionsreports) and not RageUI.Visible(optionserveur) and not RageUI.Visible(jobslist)
        and not RageUI.Visible(managestaff) and not RageUI.Visible(staffList) and not RageUI.Visible(staffinfo) and not RageUI.Visible(itemlist) and not RageUI.Visible(optionitem) 
        and not RageUI.Visible(itembuilder) and not RageUI.Visible(managesalaire) and not RageUI.Visible(optionsalaire) and not RageUI.Visible(modification_grade) 
        and not RageUI.Visible(addgrade) then
            menu = RMenu:DeleteType('menu', true)
            persoMenu = RMenu:DeleteType('persoMenu', true)
            vehMenu = RMenu:DeleteType('vehMenu', true)
            joueurMenu = RMenu:DeleteType('joueurMenu', true)
            menuactionsplayer = RMenu:DeleteType('menuactionsplayer', true)
            teleportationaction = RMenu:DeleteType('teleportationaction', true)
            sanctionplayer = RMenu:DeleteType('sanctionplayer', true)
            sanctionList = RMenu:DeleteType('sanctionList', true)
            managesanction = RMenu:DeleteType('managesanction', true)
            joueurActionMenu = RMenu:DeleteType('joueurActionMenu', true)
            actiondispo = RMenu:DeleteType('actiondispo', true)
            optionserveur = RMenu:DeleteType('optionserveur', true)
            jobslist = RMenu:DeleteType('jobslist', true)
            itemlist = RMenu:DeleteType('itemlist', true)
            optionitem = RMenu:DeleteType('optionitem', true)
            managestaff = RMenu:DeleteType('managestaff', true)
            staffList = RMenu:DeleteType('staffList', true)
            staffinfo = RMenu:DeleteType('staffinfo', true)
            cardinal = RMenu:DeleteType('cardinal', true)
            managesalaire = RMenu:DeleteType('managesalaire', true)
            optionsalaire = RMenu:DeleteType('optionsalaire', true)
            modification_grade = RMenu:DeleteType('modification_grade', true)
            addgrade = RMenu:DeleteType('addgrade', true)
            itembuilder = RMenu:DeleteType('itembuilder', true)
            reportMenu = RMenu:DeleteType('reportMenu', true)
            reportInfoMenu = RMenu:DeleteType('reportInfoMenu', true)
            actionsreports = RMenu:DeleteType('actionsreports', true)
 
            Menu.PlayerSelected = nil 
            Menu.PlayerInventory = nil
            Menu.PlayerAccounts = nil
        end
    end
end

local announcestring = false

RegisterNetEvent('announceForMessage')
AddEventHandler('announceForMessage', function(msg, name)
	announcestring = msg
    thename = name
	PlaySoundFrontend("DELETE","HUD_DEATHMATCH_SOUNDSET", 1)
	Wait(5000)
	announcestring = false
end)

RegisterNetEvent("ElectricityDesactive")
AddEventHandler("ElectricityDesactive", function(input)
    CreateDui('https://www.petit-fichier.fr/2024/10/30/bruitage-sirene-alarme1/bruitage-sirene-alarme1.mp3', 1, 1)
end)

RegisterNetEvent("PlayPurgeSound")
AddEventHandler("PlayPurgeSound", function(input)
    CreateDui('https://www.petit-fichier.fr/2024/10/30/partage-du-script-the-purge1-1/partage-du-script-the-purge1.mp3', 1, 1)
end)

RegisterNetEvent("oasis:reportrecu")
AddEventHandler("oasis:reportrecu", function(input)
    if sonReports == true then
        CreateDui('https://www.petit-fichier.fr/2023/03/19/report-1/report.mp3', 1, 1)
    elseif sonReports == false then
        return
    end
end)

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString("~r~Message Staff ~w~("..thename..")")
    PushScaleformMovieFunctionParameterString(announcestring)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

RegisterNetEvent("Admin:ReceiveScreenshot")
AddEventHandler("Admin:ReceiveScreenshot", function(files, playerId)
    exports['screenshot-basic']:requestScreenshotUpload(files, 'files[]', function(data)
        local resp = json.decode(data)
        TriggerServerEvent("Admin:ReceiveScreenshot", (resp ~= nil and resp.attachments ~= nil) and resp.attachments[1].proxy_url or nil, playerId)
    end)
end)

Citizen.CreateThread(function()
while true do
	Wait(0)
        if announcestring then
            scaleform = Initialize("mp_big_message_freemode")
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        end
    end
end)

meta = {}
meta.actif_staff = 0
local playerId = GetPlayerServerId(PlayerId())

function updateReportsUI()
    if showReports then
        exports['kRadial']:drawInfo("Mode modération activé", {
            {title = "Report(s) actif : ", subtitle = ("%s"):format(SizeOfReport())},
            {title = "Report(s) pris : ", subtitle = ("%s"):format(sAdmin.AdminList[playerId].reportEffectued)},
            {title = "Staff(s) Online : ", subtitle = ("%s"):format(meta.actif_staff)}
        })
    end
end


Citizen.CreateThread(function()
    while true do
       Wait(5000)
        updateReportsUI()
    end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    ESX.PlayerLoaded = true
end)

RegisterNetEvent("sAdmin:ReturnPlayerWarns")
AddEventHandler("sAdmin:ReturnPlayerWarns", function(warns)
    playerWarns = warns or {}
end)

RegisterNetEvent("sAdmin:ReturnPlayerBans")
AddEventHandler("sAdmin:ReturnPlayerBans", function(bans)
    playerBans = bans or {}
end)

RegisterNetEvent("sAdmin:ReturnPlayerJails")
AddEventHandler("sAdmin:ReturnPlayerJails", function(jails)
    playerJails = jails or {}
end)


AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Wait(1)
	end
end);

RegisterCommand("+adminMenu", function()
    local pPed = PlayerId()
    local pId = GetPlayerServerId(pPed)
    for k,v in pairs(sAdmin.AdminList) do 
        if k == pId then 
            OpenMenu(v)
            return
        end
    end 
end, false)

RegisterCommand("tpm", function()
    if ESX.GetPlayerData()['group'] ~= "user"then
        local pPed = PlayerPedId()
        local WaypointHandle = GetFirstBlipInfoId(8)
        if DoesBlipExist(WaypointHandle) then
            local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
            SetEntityCoordsNoOffset(pPed, coord.x, coord.y, -199.5, false, false, false, true)
            ESX.ShowNotification("🗺️ ~g~Administration\nTéléporté au marqueur avec succés")
        else
            ESX.ShowNotification("🗺️ ~g~Administration\nIl n'y a pas de marqueur sur ta map")
        end
    end
end)

RegisterKeyMapping("+adminMenu", "Menu Admin", 'keyboard', sAdmin.Config.KeyOpenMenu)

function OpenAvisMenu(data)
    if sAdmin.Config.Debug then 
        sAdmin.Debug("Ouverture du menu")
    end

    if type(data) ~= "table" then
        print("Erreur: 'data' n'est pas une table. Valeur reçue:", data)
        return
    end

    if not data.id or not data.name or not data.reasonReport then
        print("Erreur: Données manquantes dans 'data'.", data)
        return
    end

    local menu = RageUI.CreateMenu("", "Interaction disponible")
    menu.Closable = false
  
    RageUI.Visible(menu, not RageUI.Visible(menu))
    
    while menu do
        Wait(0)
        
        RageUI.IsVisible(menu, function()
            RageUI.Line()
            RageUI.Separator("Vous allez évaluer le service d'un staff")
            RageUI.Separator("Vous allez évaluer : " .. data.name)
            RageUI.Separator("Ce staff vous a aidé pour : " .. data.reasonReport)
            RageUI.Line()

            RageUI.List('Appréciation', {
                { Name = "⭐️", Value = 1 }, 
                { Name = "⭐️⭐️", Value = 2 },
                { Name = "⭐️⭐️⭐️", Value = 3 }, 
                { Name = "⭐️⭐️⭐️⭐️", Value = 4 }, 
                { Name = "⭐️⭐️⭐️⭐️⭐️", Value = 5 }
            }, Menu.List.AppreciationIndex or 1, nil, {}, true, { 
                onListChange = function(Index, Item)
                    Menu.List.AppreciationIndex = Index
                    Menu.List.AppreciationItem = Item
                end
            })

            RageUI.Button("Envoyer l'appréciation", nil, {RightLabel = "→→"}, true, {
                onSelected = function()
                    if data.id and Menu.List.AppreciationItem and Menu.List.AppreciationItem.Value then
                        TriggerServerEvent("sAdmin:AddEvaluation", data.id, Menu.List.AppreciationItem.Value)
                    else
                        print("Erreur: Les données pour l'envoi de l'appréciation ne sont pas valides.", data)
                    end
                    RageUI.CloseAll()
                end 
            })
        end, function() end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end


RegisterNetEvent("sAdmin:OpenAvisMenu")
AddEventHandler("sAdmin:OpenAvisMenu", function(data)
    if data and data.id and data.name and data.reasonReport then
        OpenAvisMenu(data)
    else
        print("Données invalides pour OpenAvisMenu", data)
    end
end)



RegisterNetEvent("sAdmin:GetStaffsList")
AddEventHandler("sAdmin:GetStaffsList", function(ListStaff)
    Menu.ListStaff = ListStaff
end)


RegisterNetEvent("sAdmin:ReturnItemsList")
AddEventHandler("sAdmin:ReturnItemsList", function(itemList)
    Menu.itemList = itemList
end)

RegisterNetEvent("sAdmin:ReturnJobsList")
AddEventHandler("sAdmin:ReturnJobsList", function(jobsList)
    Menu.jobsList = jobsList
end)

RegisterNetEvent("sAdmin:ReturnJobGrades")
AddEventHandler("sAdmin:ReturnJobGrades", function(grades)
    Menu.jobGrades = grades
end)


Citizen.CreateThread(function()
    while true do 
        if PlayerInSpec then 
            -- RageUI.Text({message = "Appuyez sur ~r~[E]~s~ pour quitter le mode spectate"})
            ESX.ShowNotification("Appuyez sur ~r~[E]~s~ pour quitter le mode spectate")

            if IsControlJustPressed(1, 51) then
                Admin:ExitSpectate()
            end
            Wait(1)
        else 
            Wait(1000)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        if StaffInService then
            local nombreDeReports = #sAdmin.ReportList
            local reportEffectued = sAdmin.AdminList[GetPlayerServerId(PlayerId())].reportEffectued or 0
            local nombreDeStaff = #sAdmin.AdminList
            TriggerEvent('SHOW_NOTIFTOP', true, ('Nombre de Reports (~r~%s~s~) | Report Counter (~y~%s~s~) | Nombre de staff (~g~%s~s~)'):format(nombreDeReports, reportEffectued, nombreDeStaff), "rgba(255, 255, 255, 1)")
        else
            Wait(100)
        end
        Wait(0)
    end
end)

    