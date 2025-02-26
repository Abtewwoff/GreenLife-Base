local modEdit = false
local allJobs = {}



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    PlayerData = xPlayer
end)

RegisterNetEvent('jobbuilder:restarted', function(player)
    ESX.PlayerData = player
    PlayerData = player
end);

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local function JobBuilderKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(3)
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

local JobBuilder = {
    Name = nil,
    Label = nil,
    PosVeh = nil,
    PosBoss = nil,
    PosCoffre = nil,
    PosSpawnVeh = nil,
    nameItemR = nil,
    labelItemR = nil,
    PosRecolte = nil,
    nameItemT = nil,
    labelItemT = nil,
    PosTraitement = nil,
    PosVente = nil,
    vehInGarage = {},
    PrixVente = nil,
    Confirm = nil,
    Confirm1 = nil,
    Confirm2 = nil,
    Confirm3 = nil,
    Confirm4 = nil,
    Confirm5 = nil,
    Confirm6 = nil,
    Confirm7 = nil,
    Confirm8 = nil,
    Choisimec = false,
}




local function menuJobBuilder()
    local MenuP = RageUIPolice.CreateMenu('', 'Créer un job')
    MenuP.Closed = function()
        resetInfo()
    end
    RageUIPolice.Visible(MenuP, not RageUIPolice.Visible(MenuP))

    while MenuP do
        Wait(3)

        RageUIPolice.IsVisible(MenuP, true, true, true, function()

            RageUIPolice.Button("Nom du setjob", nil, {RightLabel = JobBuilder.Name}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.Name = JobBuilderKeyboardInput("Nom du job", "", 30)
                    RageUIPolice.Text({ message = "~g~Nom ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Button("Label du job",nil, {RightLabel = JobBuilder.Label}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.Label = JobBuilderKeyboardInput("Label du job", "", 30)
                    RageUIPolice.Text({ message = "~g~Label ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Button("Placer le point coffre",nil, {RightLabel = JobBuilder.Confirm}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PosCoffre = GetEntityCoords(PlayerPedId())
                    JobBuilder.Confirm = "✅"
                    RageUIPolice.Text({ message = "~g~Point coffre ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Button("Placer le point patron",nil, {RightLabel = JobBuilder.Confirm1}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PosBoss = GetEntityCoords(PlayerPedId())
                    JobBuilder.Confirm1 = "✅"
                    RageUIPolice.Text({ message = "~g~Point menu boss ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Button("Placer le point du garage",nil, {RightLabel = JobBuilder.Confirm2}, function(Hovered, Active, Selected)
                if Selected then

                    local coords = GetEntityCoords(PlayerPedId());

                    JobBuilder.PosVeh = coords;
                    JobBuilder.Confirm2 = "✅"
                    JobBuilder.Choisimec = true
                    RageUIPolice.Text({ message = "~g~Point garage ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Button("Placer le point de spawn véhicule",nil, {RightLabel = JobBuilder.Confirm3}, function(Hovered, Active, Selected)
                if Selected then

                    local coords = GetEntityCoords(PlayerPedId());
                    local heading = GetEntityHeading(PlayerPedId());

                    JobBuilder.PosSpawnVeh = vector4(coords.x, coords.y, coords.z, heading)
                    JobBuilder.Confirm3 = "✅"
                    RageUIPolice.Text({ message = "~g~Position spawn véhicule ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Button("Placer le point de rangement véhicule",nil, {RightLabel = JobBuilder.ConfirmDelete}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.vehInGarage = GetEntityCoords(PlayerPedId())
                    JobBuilder.ConfirmDelete = "✅"
                    RageUIPolice.Text({ message = "~g~Position delete véhicule ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Separator("↓ ~g~Farm  ~s~↓")

            RageUIPolice.Button("Nom de l'item récolte",nil, {RightLabel = JobBuilder.nameItemR}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.nameItemR = JobBuilderKeyboardInput("Nom de l'item récolte", "", 30)
                    RageUIPolice.Text({ message = "~g~Item récolte ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Button("Label de l'item récolte",nil, {RightLabel = JobBuilder.labelItemR}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.labelItemR = JobBuilderKeyboardInput("Label de l'item récolte", "", 30)
                    RageUIPolice.Text({ message = "~g~Label de l'item récolte ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Button("Position de la récolte",nil, {RightLabel = JobBuilder.Confirm6}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PosRecolte = GetEntityCoords(PlayerPedId())
                    JobBuilder.Confirm6 = "✅"
                    RageUIPolice.Text({ message = "~g~Position de la récolte ajouté", time_display = 2500 })
                end
            end)


            RageUIPolice.Button("Nom de l'item traitement",nil, {RightLabel = JobBuilder.nameItemT}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.nameItemT = JobBuilderKeyboardInput("Nom de l'item traitement", "", 30)
                    RageUIPolice.Text({ message = "~g~Nom de l'item traitement ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Button("Label de l'item traitement",nil, {RightLabel = JobBuilder.labelItemT}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.labelItemT = JobBuilderKeyboardInput("Label de l'item traitement", "", 30)
                    RageUIPolice.Text({ message = "~g~Label de l'item traitement ajouté", time_display = 2500 })

                end
            end)

            RageUIPolice.Button("Position du traitement",nil, {RightLabel = JobBuilder.Confirm4}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PosTraitement = GetEntityCoords(PlayerPedId())
                    JobBuilder.Confirm4 = "✅"
                    RageUIPolice.Text({ message = "~g~Position du traitement ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Button("Position de la vente",nil, {RightLabel = JobBuilder.Confirm5}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PosVente = GetEntityCoords(PlayerPedId())
                    JobBuilder.Confirm5 = "✅"
                    RageUIPolice.Text({ message = "~g~Position de vente ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Button("Prix de la vente",nil, {RightLabel = JobBuilder.PrixVente}, function(Hovered, Active, Selected)
                if Selected then
                    JobBuilder.PrixVente = tonumber(JobBuilderKeyboardInput("Prix vente ?", "", 30))
                    RageUIPolice.Text({ message = "~g~Prix de vente ajouté", time_display = 2500 })
                end
            end)

            RageUIPolice.Separator('~g~↓ Actions ↓')

            RageUIPolice.Button("~g~Valider",nil, {RightLabel = "→→"}, function(Hovered, Active, Selected)
                if Selected then
                    if JobBuilder.vehInGarage == nil or JobBuilder.Name == nil or JobBuilder.Label == nil or JobBuilder.PosVeh == nil or JobBuilder.PosCoffre == nil or JobBuilder.PosBoss == nil or JobBuilder.PosSpawnVeh == nil or JobBuilder.nameItemR == nil or JobBuilder.labelItemR == nil or JobBuilder.PosRecolte == nil or JobBuilder.nameItemT == nil or JobBuilder.labelItemT == nil or JobBuilder.PosTraitement == nil then
                        RageUIPolice.Text({ message = "~r~Un ou plusieurs champs n\'ont pas été défini !", time_display = 2500 })
                    else
                        TriggerServerEvent('JobBuilder:addJob', JobBuilder)
                        RageUIPolice.Text({ message = "~g~Job ajoute avec succès !", time_display = 2500 })
                        resetInfo()
                        RageUIPolice.CloseAll()
                    end
                end
            end)

            RageUIPolice.Button('~r~Annuler' , nil, {RightLabel = "→→"}, function(Hovered, Active, Selected)
                if (Selected) then
                    resetInfo()
                    RageUIPolice.CloseAll()
                    RageUIPolice.Text({ message = "~r~Annulé !", time_display = 2500 })
                end
            end)

        end, function()
        end)

        if not RageUIPolice.Visible(MenuP) then
            MenuP = RMenu:DeleteType("MenuP", true)
        end
    end
end


RegisterCommand('createjob', function()
	ESX.TriggerServerCallback('JobBuilder:getUsergroup', function(plyGroup)
		if plyGroup ~= nil and (plyGroup == 'fondateur') then
            menuJobBuilder()

            -- MenuP:toggle()
        else
            --print("Vous n'avez pas les permissions d'ouvrir le ~g~JobsBuilder.")
        end
	end)
end, false)


function resetInfo()
    JobBuilder.Name = nil
    JobBuilder.Label = nil
    JobBuilder.PosVeh = nil
    JobBuilder.PosBoss = nil
    JobBuilder.PosCoffre = nil
    JobBuilder.PosSpawnVeh = nil
    JobBuilder.nameItemR = nil
    JobBuilder.labelItemR = nil
    JobBuilder.PosRecolte = nil
    JobBuilder.nameItemT = nil
    JobBuilder.labelItemT = nil
    JobBuilder.PosTraitement = nil
    JobBuilder.PosVente = nil
    JobBuilder.vehInGarage = {}
    JobBuilder.Confirm = nil
    JobBuilder.Confirm1 = nil
    JobBuilder.Confirm2 = nil
    JobBuilder.Confirm3 = nil
    JobBuilder.Confirm4 = nil
    JobBuilder.Confirm5 = nil
    JobBuilder.Confirm6 = nil
    JobBuilder.Confirm7 = nil
    JobBuilder.Confirm8 = nil
    JobBuilder.Choisimec = false
    JobBuilder.PrixVente = nil
end

local function menuGestJobs()
    local MenuGestion = RageUIPolice.CreateMenu("", ' ')
    local MenuGestionSub = RageUIPolice.CreateSubMenu(MenuGestion, "", ' ')
    RageUIPolice.Visible(MenuGestion, not RageUIPolice.Visible(MenuGestion))
    while MenuGestion do
        Wait(3)

        RageUIPolice.IsVisible(MenuGestion, true, true, true, function()

            RageUIPolice.Checkbox("Activer/Désactiver le mode modification",nil, modEdit,{},function(Hovered,Ative,Selected,Checked)
                if Selected then
                    modEdit = Checked
                    if Checked then
                        RageUIPolice.Text({message = "Vous avez ~g~Activer~s~ le mode modification !", time_display = 2500})
                    else
                        RageUIPolice.Text({message = "Vous avez ~r~Désactiver~s~ le mode modification !", time_display = 2500})
                    end
                end
            end)

            if modEdit then

                for k,v in pairs(allJobs) do

                    RageUIPolice.Button("Entreprise : "..v.Label,nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            jobSelect = v
                        end
                    end, MenuGestionSub)

                end
            end

        end, function()
        end)

        RageUIPolice.IsVisible(MenuGestionSub, true, true, true, function()

            RageUIPolice.Button("Position du garage",nil, {RightLabel = "→"}, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'Posgarage', plyPos, jobSelect.Name)
                end
            end)

            RageUIPolice.Button("Position spawn véhicule",nil, {RightLabel = "→"}, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'Posspawn', plyPos, jobSelect.Name)
                end
            end)

            RageUIPolice.Button("Position du menu boss",nil, {RightLabel = "→"}, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'PosBoss', plyPos, jobSelect.Name)
                end
            end)

            RageUIPolice.Button("Position du coffre",nil, {RightLabel = "→"}, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'PosCoffre', plyPos, jobSelect.Name)
                end
            end)

            RageUIPolice.Button("Position de la récolte",nil, {RightLabel = "→"}, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'PosRecolte', plyPos, jobSelect.Name)
                end
            end)

            RageUIPolice.Button("Position du traitement",nil, {RightLabel = "→"}, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'PosTraitement', plyPos, jobSelect.Name)
                end
            end)

            RageUIPolice.Button("Position de la vente",nil, {RightLabel = "→"}, function(Hovered, Active, Selected)
                if Selected then
                    local plyPos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('JobBuilder:editJob', 'PosVente', plyPos, jobSelect.Name)
                end
            end)

            RageUIPolice.Button("Prix de la vente",nil, {RightLabel = "→"}, function(Hovered, Active, Selected)
                if Selected then
                    local priceVenteNew = JobBuilderKeyboardInput("Prix de la vente ?", "", 30)
                    TriggerServerEvent('JobBuilder:editJob', 'PrixVente', tonumber(priceVenteNew), jobSelect.Name)
                end
            end)

        end, function()
        end)

        if not RageUIPolice.Visible(MenuGestion) and not RageUIPolice.Visible(MenuGestionSub) then
            MenuGestion = RMenu:DeleteType("MenuGestion", true)
        end
    end
end


RegisterCommand('gestionjob', function()
	ESX.TriggerServerCallback('JobBuilder:getUsergroup', function(plyGroup)
		if plyGroup ~= nil and (plyGroup == 'fondateur') then
            ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
                allJobs = result
            end)
            menuGestJobs()
        else
            -- print("Vous n'avez pas les permissions de ouvrir le ~g~Gestion d'entreprise.")
        end
	end)
end, false)







-- local MenuP = RageUI.CreateMenu("", "Créer un job", nil, nil, "commonmenu", "interaction_bgd")
-- MenuP.Closed = function()
--     resetInfo()
-- end

-- MenuP:IsVisible(function(Items)

--     Items:AddButton("Nom du setjob", nil, {RightLabel = JobBuilder.Name}, function(onSelected)
--         if (onSelected) then
--             JobBuilder.Name = JobBuilderKeyboardInput("Nom du job", "", 30)
--             RageUIPolice.Text({ message = "~g~Nom ajouté", time_display = 2500 })
--         end
--     end)

--     Items:AddButton("Label du job",nil, {RightLabel = JobBuilder.Label}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.Label = JobBuilderKeyboardInput("Label du job", "", 30)
--             RageUIPolice.Text({ message = "~g~Label ajouté", time_display = 2500 })
--         end
--     end)

--     Items:AddButton("Placer le point coffre",nil, {RightLabel = JobBuilder.Confirm}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.PosCoffre = GetEntityCoords(PlayerPedId())
--             JobBuilder.Confirm = "✅"
--             RageUIPolice.Text({ message = "~g~Point coffre ajouté", time_display = 2500 })
--         end
--     end)

--     Items:AddButton("Placer le point patron",nil, {RightLabel = JobBuilder.Confirm1}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.PosBoss = GetEntityCoords(PlayerPedId())
--             JobBuilder.Confirm1 = "✅"
--             RageUIPolice.Text({ message = "~g~Point menu boss ajouté", time_display = 2500 })
--         end
--     end)

--     Items:AddButton("Placer le point du garage",nil, {RightLabel = JobBuilder.Confirm2}, function(Hovered, Active, Selected)
--         if Selected then

--             local coords = GetEntityCoords(PlayerPedId());

--             JobBuilder.PosVeh = coords;
--             JobBuilder.Confirm2 = "✅"
--             JobBuilder.Choisimec = true
--             RageUIPolice.Text({ message = "~g~Point garage ajouté", time_display = 2500 })
--         end
--     end)

--     Items:AddButton("Placer le point de spawn véhicule",nil, {RightLabel = JobBuilder.Confirm3}, function(Hovered, Active, Selected)
--         if Selected then

--             local coords = GetEntityCoords(PlayerPedId());
--             local heading = GetEntityHeading(PlayerPedId());

--             JobBuilder.PosSpawnVeh = vector4(coords.x, coords.y, coords.z, heading)
--             JobBuilder.Confirm3 = "✅"
--             RageUIPolice.Text({ message = "~g~Position spawn véhicule ajouté", time_display = 2500 })
--         end
--     end)

--     Items:AddButton("Placer le point de rangement véhicule",nil, {RightLabel = JobBuilder.ConfirmDelete}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.vehInGarage = GetEntityCoords(PlayerPedId())
--             JobBuilder.ConfirmDelete = "✅"
--             RageUIPolice.Text({ message = "~g~Position delete véhicule ajouté", time_display = 2500 })
--         end
--     end)

--     -- RageUIPolice.Separator("↓ ~g~Farm  ~s~↓")
--     Items:AddSeparator("↓ ~g~Farm  ~s~↓")

--     Items:AddButton("Nom de l'item récolte",nil, {RightLabel = JobBuilder.nameItemR}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.nameItemR = JobBuilderKeyboardInput("Nom de l'item récolte", "", 30)
--             RageUIPolice.Text({ message = "~g~Item récolte ajouté", time_display = 2500 })
--         end
--     end)

--     Items:AddButton("Label de l'item récolte",nil, {RightLabel = JobBuilder.labelItemR}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.labelItemR = JobBuilderKeyboardInput("Label de l'item récolte", "", 30)
--             RageUIPolice.Text({ message = "~g~Label de l'item récolte ajouté", time_display = 2500 })
--         end
--     end)

--     Items:AddButton("Position de la récolte",nil, {RightLabel = JobBuilder.Confirm6}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.PosRecolte = GetEntityCoords(PlayerPedId())
--             JobBuilder.Confirm6 = "✅"
--             RageUIPolice.Text({ message = "~g~Position de la récolte ajouté", time_display = 2500 })
--         end
--     end)


--     Items:AddButton("Nom de l'item traitement",nil, {RightLabel = JobBuilder.nameItemT}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.nameItemT = JobBuilderKeyboardInput("Nom de l'item traitement", "", 30)
--             RageUIPolice.Text({ message = "~g~Nom de l'item traitement ajouté", time_display = 2500 })
--         end
--     end)

--     Items:AddButton("Label de l'item traitement",nil, {RightLabel = JobBuilder.labelItemT}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.labelItemT = JobBuilderKeyboardInput("Label de l'item traitement", "", 30)
--             RageUIPolice.Text({ message = "~g~Label de l'item traitement ajouté", time_display = 2500 })

--         end
--     end)

--     Items:AddButton("Position du traitement",nil, {RightLabel = JobBuilder.Confirm4}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.PosTraitement = GetEntityCoords(PlayerPedId())
--             JobBuilder.Confirm4 = "✅"
--             RageUIPolice.Text({ message = "~g~Position du traitement ajouté", time_display = 2500 })
--         end
--     end)

--     Items:AddButton("Position de la vente",nil, {RightLabel = JobBuilder.Confirm5}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.PosVente = GetEntityCoords(PlayerPedId())
--             JobBuilder.Confirm5 = "✅"
--             RageUIPolice.Text({ message = "~g~Position de vente ajouté", time_display = 2500 })
--         end
--     end)

--     Items:AddButton("Prix de la vente",nil, {RightLabel = JobBuilder.PrixVente}, function(Hovered, Active, Selected)
--         if Selected then
--             JobBuilder.PrixVente = tonumber(JobBuilderKeyboardInput("Prix vente ?", "", 30))
--             RageUIPolice.Text({ message = "~g~Prix de vente ajouté", time_display = 2500 })
--         end
--     end)

--     -- RageUIPolice.Separator('~g~↓ Actions ↓')

--     Items:AddButton("~g~Valider",nil, {RightLabel = "→→"}, function(Hovered, Active, Selected)
--         if Selected then
--             if JobBuilder.vehInGarage == nil or JobBuilder.Name == nil or JobBuilder.Label == nil or JobBuilder.PosVeh == nil or JobBuilder.PosCoffre == nil or JobBuilder.PosBoss == nil or JobBuilder.PosSpawnVeh == nil or JobBuilder.nameItemR == nil or JobBuilder.labelItemR == nil or JobBuilder.PosRecolte == nil or JobBuilder.nameItemT == nil or JobBuilder.labelItemT == nil or JobBuilder.PosTraitement == nil then
--                 RageUIPolice.Text({ message = "~r~Un ou plusieurs champs n\'ont pas été défini !", time_display = 2500 })
--             else
--                 TriggerServerEvent('JobBuilder:addJob', JobBuilder)
--                 RageUIPolice.Text({ message = "~g~Job ajoute avec succès !", time_display = 2500 })
--                 resetInfo()
--                 RageUIPolice.CloseAll()
--             end
--         end
--     end)

--     Items:AddButton('~r~Annuler' , nil, {RightLabel = "→→"}, function(Hovered, Active, Selected)
--         if (Selected) then
--             resetInfo()
--             RageUIPolice.CloseAll()
--             RageUIPolice.Text({ message = "~r~Annulé !", time_display = 2500 })
--         end
--     end)
-- end)