--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local desCategories = {}
local desVehicles = {}
local isOpenedActions = false
local theCategoriesname
local theCategorieslabel
local thisIsForPreview = {}
local alwaysPreview = {}
local getsSocietyvehicles = {}
local LastVehicles = {}


Citizen.CreateThread(function()
    x,y,z = -790.34637451172, -214.08460998535, 36.960872650146
    local blipvoiture = AddBlipForCoord(x,y,z)

	SetBlipSprite (blipvoiture, 326)
	SetBlipDisplay(blipvoiture, 4)
	SetBlipScale  (blipvoiture, 0.6)
	SetBlipAsShortRange(blipvoiture, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("[Entreprise] Concessionnaire voiture")
	EndTextCommandSetBlipName(blipvoiture)

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end

    while true do
        local interval = 500
        local coords = GetEntityCoords(PlayerPedId())

        for k,v in pairs(Config.Jobs.Cardealer.Actions) do
            if ESX.PlayerData.job.name == 'cardealer' then
                if #(coords - v.actions) <= 10 then
                    interval = 1
                    DrawMarker(Config.Get.Marker.Type, v.actions, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(coords - v.actions) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        -- TriggerEvent("ui:showInteraction", "E", " pour ouvrir le menu")
                        if IsControlJustReleased(0, 38) then
                            isOpenedActions = true
                            openCardealerActions()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

function openCardealerActions()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")
    local sellVehicle = RageUI.CreateSubMenu(mainMenu, "", "Vendre un vehicule")
    local listeVehicles = RageUI.CreateSubMenu(mainMenu, "", "Liste des catégories")
    local lesVehiclesDeLaCategories = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local preview = RageUI.CreateSubMenu(mainMenu, '', 'Faites vos actions')

    local x,y,z 

    preview.Closed = function()
        SetEntityCoords(PlayerPedId(), x, y, z)
        FreezeEntityPosition(PlayerPedId(), false)
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
        SetEntityLocallyInvisible(PlayerPedId(), false)
        for k,v in pairs(thisIsForPreview) do
            SetModelAsNoLongerNeeded(v.vehicle)
            ESX.Game.DeleteVehicle(v.vehicle)
        end
        RageUI.CloseAll()
    end

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while isOpenedActions do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Acheter un véhicule", nil , {RightLabel = "→→"}, true, {
                onSelected = function()
                    getCategories()
                    getVehicles()
                end
            }, listeVehicles)
            RageUI.Button("Vendre un véhicule", "N'oubliez pas de faire la facture au préalable, avec un X en fonction de la catégorie !", {RightLabel = "→→"}, true, {
                onSelected = function()
                    getPossedVehicles()
                end
            }, sellVehicle)
        end)

        RageUI.IsVisible(sellVehicle, function()
            for k,v in pairs(getsSocietyvehicles) do
                RageUI.Button(v.name, nil , {RightLabel = v.price.."$"}, true, {
                    onSelected = function()
                        local plate = GeneratePlate()

                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification('~r~Personne autour de vous')
                        else
                            TriggerServerEvent('sellthevehicle', GetPlayerServerId(closestPlayer), v.id, v.model, plate, v.price)
                        end

                        RageUI.CloseAll()
                    end
                })
            end
        end)

        RageUI.IsVisible(listeVehicles, function()
        for k, v in pairs(desCategories) do
            if v.name ~= 'avionfdp' and v.name ~= 'superboat' then
                RageUI.Button(v.label, nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        theCategories = v.name
                        theCategorieslabel = v.label
                        ESX.ShowNotification("Catégorie sélectionnée : " .. theCategorieslabel)
                    end
                }, lesVehiclesDeLaCategories)
            end
        end
    end)
    

        RageUI.IsVisible(lesVehiclesDeLaCategories, function()
    if not theCategories or not theCategorieslabel then
        RageUI.Separator("~r~Aucune catégorie sélectionnée !")
    else
        RageUI.Separator("Véhicule de la catégorie: " .. theCategorieslabel)
        for k, v in pairs(desVehicles) do
            if v.category == theCategories then
                RageUI.Button(v.name, nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        -- Code pour afficher les véhicules
                        x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
                        local plyPed = PlayerPedId()
                        SetEntityCoords(plyPed, -775.54132080078, -227.4574432373, 36.997539520264)
                        local vehicle = v.model
                        TriggerServerEvent('cardealer:changeBucket', "enter")
                        ESX.Game.SpawnLocalVehicle(vehicle, {x = -775.54132080078, y = -227.4574432373, z = 36.997539520264}, 205.50875854492188, function(vehicle)
                            TaskWarpPedIntoVehicle(plyPed, vehicle, -1)
                            FreezeEntityPosition(vehicle, true)
                            table.insert(thisIsForPreview, {
                                vehicle = vehicle,
                                price = v.price,
                                name = v.name,
                                model = v.model
                            })
                        end)
                    end
                }, preview)
            end
        end
    end
end)

        RageUI.IsVisible(preview, function()
            for k,v in pairs(thisIsForPreview) do
                local plyPed = PlayerPedId()
                NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
                SetEntityLocallyInvisible(PlayerPedId(), true)
                if GetVehiclePedIsIn(plyPed) == 0 then
                    TaskWarpPedIntoVehicle(plyPed, v.vehicle, -1)
                end
                RageUI.Separator("~g~Confirmez l'achat de "..v.name.."")
                RageUI.Button("Acheter le véhicule", nil, {RightLabel = v.price.."$"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('cardealer:getSocietyMoney', function(data)
                            local d = data;
                            if (d >= v.price) then
                                TriggerServerEvent('cardealer:buyVehicle', v.model, v.name, v.price);
                                SetModelAsNoLongerNeeded(v.vehicle)
                                ESX.Game.DeleteVehicle(v.vehicle)
                                RageUI.CloseAll()
                                SetEntityCoords(PlayerPedId(), x, y, z)
                                NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                                SetEntityLocallyInvisible(PlayerPedId(), false)
                                TriggerServerEvent('cardealer:changeBucket', "leave")
                                inCaseOf = {}
                            else
                                ESX.ShowNotification("~r~Il n'y a pas suffisamment d'argent dans la société.")
                                RageUI.CloseAll()
                                SetEntityCoords(PlayerPedId(), x, y, z)
                                NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                                SetEntityLocallyInvisible(PlayerPedId(), false)
                                TriggerServerEvent('cardealer:changeBucket', "leave")
                            end
                        end)
                    end
                })
                RageUI.Button("Non", nil, {RightLabel = ""}, true, {
                    onSelected = function()
                        SetModelAsNoLongerNeeded(v.vehicle)
                        ESX.Game.DeleteVehicle(v.vehicle)
                        RageUI.CloseAll()
                        SetEntityCoords(PlayerPedId(), x, y, z)
                        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                        SetEntityLocallyInvisible(PlayerPedId(), false)
                        TriggerServerEvent('cardealer:changeBucket', "leave")
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(listeVehicles) and not RageUI.Visible(lesVehiclesDeLaCategories) and not RageUI.Visible(preview) and not RageUI.Visible(sellVehicle) then
            isOpenedActions = false
            mainMenu = RMenu:DeleteType('mainMenu', true)
        end
        if not RageUI.Visible(listeVehicles) and not RageUI.Visible(lesVehiclesDeLaCategories) and not RageUI.Visible(preview) then
            desCategories = {}
            desVehicles = {}
            thisIsForPreview = {}
        end
        if not RageUI.Visible(sellVehicle) then
            getsSocietyvehicles = {}
            alwaysPreview = {}
        end

        Wait(0)
    end
end

local NumberCharset = {}
local Charset = {}

for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end
for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. GetRandomNumber(Config.PlateNumbers))

		ESX.TriggerServerCallback('vehicle:verifierplaquedispoboutique', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

function GenerateSocietyPlate(societyPlate)
	local generatedPlate
	local doBreak = false

	while true do
		Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(societyPlate .. GetRandomNumber(Config.PlateNumbers))

		ESX.TriggerServerCallback('vehicle:verifierplaquedispoboutique', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('vehicle:verifierplaquedispoboutique', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Wait(1)
	math.randomseed(GetGameTimer())

	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Wait(1)
	math.randomseed(GetGameTimer())

	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

function getCategories()
    ESX.TriggerServerCallback('cardealer:getCategories', function(cb)
        desCategories = {} -- Réinitialiser la table pour éviter les doublons
        for i = 1, #cb do
            local d = cb[i]
            table.insert(desCategories, {
                name = d.name,
                label = d.label,
                society = d.society
            })
        end
        if #desCategories == 0 then
            ESX.ShowNotification("~r~Aucune catégorie trouvée.")
        else
            print("Catégories chargées :", json.encode(desCategories))
        end
    end)
end


function getVehicles()
    ESX.TriggerServerCallback('cardealer:getAllVehicles', function(result)
        for i=1, #result do
            local d = result[i]
            table.insert(desVehicles, {
                model = d.model,
                name = d.name,
                price = d.price,
                category = d.category
            })
        end
    end)
end

function getPossedVehicles()
    ESX.TriggerServerCallback('cardealer:getSocietyVehicles', function(ladata)
        for i=1, #ladata do
            local d = ladata[i]
            table.insert(getsSocietyvehicles, {
                id = d.id,
                model = d.vehicle,
                name = d.name,
                price = d.price,
                society = d.society
            })
        end
    end)
end

function KeyboardInputCardealer(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
  
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
      Wait(0)
    end
  
    if UpdateOnscreenKeyboard() ~= 2 then
      local result = GetOnscreenKeyboardResult()
      return result
    else
      return nil
    end
end

local open = false 
local carMain2 = RageUI.CreateMenu('', 'Concessionnaire Voiture')
local subMenu8 = RageUI.CreateSubMenu(carMain2, "", "Interaction")
carMain2.Display.Header = true 
carMain2.Closed = function()
  open = false
end

function OpenMenuCarShop()
	if open then 
		open = false
		RageUI.Visible(carMain2, false)
		return
	else
		open = true 
		RageUI.Visible(carMain2, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(carMain2,function() 

            RageUI.Button("Annonces", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                end
            }, subMenu8)

            RageUI.Button("Faire une Facture", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    local montant = KeyboardInputPolice("Montant:", 'Indiquez un montant', '', 7)
                    if tonumber(montant) == nil then
                        ESX.ShowNotification("Montant invalide")
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification('~r~Personne autour de vous')
                        else
                            ESX.ShowNotification("~g~Facture envoyée avec succès !")
                            TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(closestPlayer), amount)
                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'cardealer', 'Concess Voiture', amount)
                        end
                    end
                end
            })
			end)

            RageUI.IsVisible(subMenu8,function() 

                RageUI.Button("Annonce ~g~[Ouvertures]~s~", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerServerEvent('Ouvre:CarShop')
                    end
                })
    
                RageUI.Button("Annonce ~r~[Fermetures]~r~", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerServerEvent('Ferme:CarShop')
                    end
                })
    
                RageUI.Button("Annonce ~g~[Recrutement]", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerServerEvent('Recrutement:CarShop')
                    end
                })

            end)

		 Wait(0)
		end
	 end)
  end
end