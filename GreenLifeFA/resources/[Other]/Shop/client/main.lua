CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(500)
    end
end)
DoScreenFadeIn(500)

local selected = nil;
local lockmenu = true
local quittest = false 
local blabla = true
local VehicleJournalier = {}

Keys.Register("f1", "menuboutique", "Menu Boutique", function()
    PlaySoundFrontend(-1, 'ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 1) 
    OpenMenuMain()
end)

local GoodCoins = 0
local LastVeh = nil
local LastLastVeh = nil
local lastPos = nil
local rot = nil
local index = {
    list = 1
}

local Button = 1

local Action = {
    'Visualiser',
    'Acheter'
 }

local ActionNN = {
   'Visualiser',
   'Essayer',
   'Acheter'
}

local dedenn = {
    'Acheter'
 }
 

CreateThread(function()
    Wait(2500)
    TriggerServerEvent('ewen:getFivemID')
end)

RegisterNetEvent('ewen:ReceiveFivemId', function(ReceiveInfo)
    fivemid = ReceiveInfo
end)

RegisterNetEvent("hello:bro", function()
    ESX.TriggerServerCallback('ewen:getPoints', function(result)
        GoodCoins = result
    end)    
end)

local VehicleSpawned = {}



local function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

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

function OpenMenuMain()
    RageUI.Line()
    local menu = RageUI.CreateMenu("", "Boutique GreenLife")
    -- local vehicles = RageUI.CreateSubMenu(menu, "Boutique GreenLife", "Boutique GreenLife")
    local voitures = RageUI.CreateSubMenu(menu, "Boutique GreenLife", "Boutique GreenLife")
    -- local avionhelico = RageUI.CreateSubMenu(menu, "Boutique GreenLife", "Boutique GreenLife")
    -- local bateaux = RageUI.CreateSubMenu(menu, "Boutique GreenLife", "Boutique GreenLife")
    local PacksMenu = RageUI.CreateSubMenu(menu, "Boutique GreenLife", "Boutique GreenLife")
    local ArmesMenu = RageUI.CreateSubMenu(menu, "Boutique GreenLife", "Boutique GreenLife")
    -- local ArmesShopMenu = RageUI.CreateSubMenu(menu, "Boutique GreenLife", "Boutique GreenLife")
    local CustomArmesShopMenu = RageUI.CreateSubMenu(menu, "Boutique GreenLife", "Boutique GreenLife")
    local CaseMenu = RageUI.CreateSubMenu(menu, "Boutique GreenLife", "Boutique GreenLife")
    local VipMenu = RageUI.CreateSubMenu(menu, "Boutique GreenLife", "Boutique GreenLife")
    local GreenLifePass = RageUI.CreateSubMenu(menu, "Boutique GreenLife", "Boutique GreenLife")
    CustomArmesShopMenu.onIndexChange = function(index)
        if (selected ~= nil) then
            GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(selected.name), selected.components[index].hash)
            if (selected.components[index - 1] ~= nil) and (selected.components[index - 1].hash ~= nil) then
                RemoveWeaponComponentFromPed(PlayerPedId(), GetHashKey(selected.name), selected.components[index - 1].hash)
            end
            if (index == 1) then
                RemoveWeaponComponentFromPed(PlayerPedId(), GetHashKey(selected.name), selected.components[#selected.components].hash)
            end
        end
    end
    CustomArmesShopMenu.Closed = function() 
        TriggerEvent('esx:restoreLoadout')
    end
    voitures.Closed = function() 
        if not blabla then 
            quittest = true
        end 
        DoScreenFadeOut(500)
        Wait(1000)
        lockmenu = true
        DeleteEntity(LastVeh)
        DeleteEntity(LastLastVeh)
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityVisible(PlayerPedId(), true, 0)
        SetEntityCoords(PlayerPedId(), lastPos)
        SetFollowPedCamViewMode(1)
        for k,v in pairs(VehicleSpawned) do 
            if DoesEntityExist(v.model) then
                Wait(150)
                DeleteEntity(v.model)
                table.remove(VehicleSpawned, k)
            end
        end
        TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
        DoScreenFadeIn(500)   
    end
    -- avionhelico.Closed = function() 
    --     DeleteEntity(LastVeh)
    --     DeleteEntity(LastLastVeh)
    --     FreezeEntityPosition(PlayerPedId(), false)
    --     SetEntityVisible(PlayerPedId(), true, 0)
    --     SetEntityCoords(PlayerPedId(), lastPos)
    --     SetFollowPedCamViewMode(1)
    --     for k,v in pairs(VehicleSpawned) do 
    --         if DoesEntityExist(v.model) then
    --             Wait(150)
    --             DeleteEntity(v.model)
    --             table.remove(VehicleSpawned, k)
    --         end
    --     end
    --     TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
    -- end
    -- bateaux.Closed = function() 
    --     DeleteEntity(LastVeh)
    --     DeleteEntity(LastLastVeh)
    --     FreezeEntityPosition(PlayerPedId(), false)
    --     SetEntityVisible(PlayerPedId(), true, 0)
    --     SetEntityCoords(PlayerPedId(), lastPos)
    --     SetFollowPedCamViewMode(1)
    --     for k,v in pairs(VehicleSpawned) do 
    --         if DoesEntityExist(v.model) then
    --             Wait(150)
    --             DeleteEntity(v.model)
    --             table.remove(VehicleSpawned, k)
    --         end
    --     end
    --     TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
    -- end
    ESX.TriggerServerCallback('ewen:getPoints', function(result)
        GoodCoins = result
    end)
    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu ~= nil do
        RageUI.IsVisible(menu, function()
            if fivemid == nil then 
                fivemid = 'Aucun'
            end
            -- RageUI.Separator('Code Boutique : ~g~'..fivemid)
            -- RageUI.Separator('~s~GoodCoins : ~g~'..GoodCoins)
            RageUI.Button('~s~Accéder au discord', nil, {RightLabel = "→"}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
                    end,
                onSelected = function()
                    SendNUIMessage({
                        action = 'openLink',
                        url = 'https://discord.gg/greenlife'
                    })
                    RageUI.CloseAll()
                end
            })
            RageUI.Button('~s~Historique', nil, {RightLabel = "→"}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
                    end,
                onSelected = function()
                    RageUI.CloseAll()
                    OpenHistoryMenu()
                end
            })
            RageUI.Line()
            if exports.GreenLife:IsInSafeZone() and not exports.GreenLife:IsInMenotte() and not exports.GreenLife:IsInPorter() and not exports.GreenLife:IsInOtage() then
                RageUI.Button('~s~Véhicules', nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
                        end,
                        onSelected = function()
                            DoScreenFadeOut(500)
                            Wait(1000)
                            lastPos = GetEntityCoords(PlayerPedId())
                            rot = 1.0
                            SetEntityCoords(PlayerPedId(), vector3(962.3648, 35.35, 123))
                            SetEntityHeading(PlayerPedId(), 331.785)
                            TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', true)             
                            DoScreenFadeIn(500)           
                        end
                    }, voitures)
            else
                RageUI.Button('~s~Véhicules', nil, {RightLabel = "→"}, true, {
                    onActive = function()
                        RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
                        end,
                        onSelected = function()
                            ESX.ShowNotification('Vous devez être en Zone Safe pour acceder à cette catégorie')
                        end
                    })
            end
                -- RageUI.Button("~s~Customisation d'armes", nil, {RightLabel = "→"}, true, {
                --     onActive = function()
                --         RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
                --         end,
                --     onSelected = function()
                        
                --     end
                -- }, CustomArmesShopMenu)

            -- RageUI.Button('~s~Caisse Mystère', nil, {RightLabel = "→"}, true, {
            --     onActive = function()
            --         RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
            --         end,
            --     onSelected = function()
                    
            --     end
            -- }, CaseMenu)
            RageUI.Button('~s~Caisse Mystère', nil, {RightLabel = "→"}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
                    end,
                onSelected = function()
                    ExecuteCommand("caseOpening")
                    RageUI.CloseAll()
                end,     
            })

            RageUI.Button('~s~Armes', nil, {RightLabel = "→"}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
                    end,
                onSelected = function()
                    
                end
            }, ArmesMenu)

            -- RageUI.Button('~s~Chasse au trésor', nil, {RightLabel = "→"}, true, {
            --     onActive = function()
            --         RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
            --         end,
            --     onSelected = function()
            --         ExecuteCommand("treasure")
            --         RageUI.CloseAll()
            --     end,     
            -- })

            RageUI.Button('~s~Packs', nil, {RightLabel = "→"}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
                    end,
                onSelected = function()
                    
                end
            }, PacksMenu)

            -- RageUI.Button("~s~GreenLifePass Premium", nil, {RightLabel = "→"}, true, {
            --     onActive = function()
            --         RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
            --         end,
            --     onSelected = function()
            --     end
            -- }, GreenLifePass)
        end)
        -- RageUI.IsVisible(vehicles, function()
        --     RageUI.Button('Voitures', nil, {RightLabel = "→"}, true, {
        --         onSelected = function()
        --             lastPos = GetEntityCoords(PlayerPedId())
        --             rot = 1.0
        --             SetEntityCoords(PlayerPedId(), vector3(-74.9472, -812.6113, 325.1751))
        --             SetEntityHeading(PlayerPedId(), 331.785)
        --             TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', true)
        --         end
        --     }, voitures)
        --    RageUI.Button('Avion/Hélicoptère', nil, {RightLabel = "→"}, true, {
        --        onSelected = function()
        --            lastPos = GetEntityCoords(PlayerPedId())
        --            rot = 1.0
        --            SetEntityCoords(PlayerPedId(), vector3(-964.772, -2988.266, 13.945))
        --            SetEntityHeading(PlayerPedId(), 150.864)
        --            TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', true)
        --        end
        --    }, avionhelico)
        --     RageUI.Button('Bateaux', nil, {RightLabel = "→"}, true, {
        --         onSelected = function()
        --             lastPos = GetEntityCoords(PlayerPedId())
        --             rot = 1.0
        --             SetEntityCoords(PlayerPedId(), vector3(530.6523, -3371.662, 5.361))
        --             SetEntityHeading(PlayerPedId(), 282.959)
        --             TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', true)
        --         end
        --     },bateaux)
        -- end)

        local GameCoreTmoche = true

        RageUI.IsVisible(voitures, function()
            for k,v in pairs(BoutiqueVehicles) do
                RageUI.List(v.label..' | Prix : ~g~'..v.price, ActionNN, index.list, v.description, {}, lockmenu, {
                        onActive = function()
                            FreezeEntityPosition(PlayerPedId(), true)
                            SetEntityVisible(PlayerPedId(), false, 0)
                            SetWeatherTypeNow('EXTRASUNNY')
                            SetFollowPedCamViewMode(4)
                            if LastVeh ~= nil then
                                rot = rot + 0.10
                                SetEntityHeading(LastVeh, rot)
                            end
                        end,
                        onListChange = function(Index, Item)
                            index.list = Index;
                            Button = Index;
                        end,
                        onSelected = function()
                            if lockmenu then 
                                if Button == 1 then
                                    if not blabla then 
                                        quittest = true
                                    end 
                                    lockmenu = false
                                    SetEntityCoords(PlayerPedId(), vector3(962.3648, 35.35, 123))
                                    if ESX.Game.IsSpawnPointClear(vector3(966.0196, 42.41, 123.1267), 100) then
                                        ESX.Game.SpawnLocalVehicle(v.model, vector3(966.0196, 42.41, 123.1267), 355.858, function(vehicle)
                                            lockmenu = true
                                            LastVeh = vehicle
                                            FreezeEntityPosition(vehicle, true)
                                            SetVehicleDoorsLocked(vehicle, 2)
                                            SetEntityInvincible(vehicle, true)
                                            SetVehicleFixed(vehicle)
                                            SetVehicleDirtLevel(vehicle, 0.0)
                                            SetVehicleEngineOn(vehicle, true, true, true)
                                            SetVehicleLights(vehicle, 2)
                                            SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                            SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                            table.insert(VehicleSpawned, {model = vehicle})
                                        end)
                                    else
                                        lockmenu = false
                                        DeleteEntity(LastVeh)
                                        DeleteEntity(LastLastVeh)
                                        ESX.Game.SpawnLocalVehicle(v.model, vector3(966.0196, 42.41, 123.1267), 355.858, function(vehicle)
                                            lockmenu = true
                                            LastVeh = vehicle
                                            FreezeEntityPosition(vehicle, true)
                                            SetVehicleDoorsLocked(vehicle, 2)
                                            SetEntityInvincible(vehicle, true)
                                            SetVehicleFixed(vehicle)
                                            SetVehicleDirtLevel(vehicle, 0.0)
                                            SetVehicleEngineOn(vehicle, true, true, true)
                                            SetVehicleLights(vehicle, 2)
                                            SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                            SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                            table.insert(VehicleSpawned, {model = vehicle})
                                        end)
                                    end
                                elseif Button == 2 then
                                    if LastLastVeh == nil then
                                        lockmenu = false
                                        blabla = false
                                        if not blabla then 
                                            quittest = false
                                        end 
                                        DoScreenFadeOut(500)
                                        Wait(1000)
                                        ESX.ShowNotification('Vous disposez de 30s pour votre test !')
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        SetEntityVisible(PlayerPedId(), true, 0)
                                        SetFollowPedCamViewMode(1)
                                        SetEntityCoords(PlayerPedId(), -871.19, -3220.34, 13.94)
                                        DeleteEntity(LastVeh)
                                        DeleteEntity(LastLastVeh)
                                        ESX.Game.SpawnLocalVehicle(v.model, vector3(-871.19, -3220.34, 13.94), 355.858, function(vehicle)
                                            lockmenu = true
                                            LastLastVeh = vehicle
                                            SetVehicleDoorsLocked(vehicle, 2)
                                            SetEntityInvincible(vehicle, true)
                                            SetVehicleDirtLevel(vehicle, 0.0)
                                            SetVehicleEngineOn(vehicle, true, true, true)
                                            SetVehicleLights(vehicle, 2)
                                            SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                            SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                            table.insert(VehicleSpawned, {model = vehicle})
                                            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                        end)
                                        SetTimeout(31000, function()
                                            if not quittest then
                                                lockmenu = false
                                                DoScreenFadeOut(500)
                                                Wait(1000)
                                                DeleteEntity(LastLastVeh)
                                                ESX.ShowNotification('Vous venez de finir votre test de 30s !')
                                                SetEntityCoords(PlayerPedId(), vector3(962.3648, 35.35, 123))
                                                ESX.Game.SpawnLocalVehicle(v.model, vector3(966.0196, 42.41, 123.1267), 355.858, function(vehicle)
                                                    lockmenu = true
                                                    LastVeh = vehicle
                                                    FreezeEntityPosition(vehicle, true)
                                                    SetVehicleDoorsLocked(vehicle, 2)
                                                    SetEntityInvincible(vehicle, true)
                                                    SetVehicleFixed(vehicle)
                                                    SetVehicleDirtLevel(vehicle, 0.0)
                                                    SetVehicleEngineOn(vehicle, true, true, true)
                                                    SetVehicleLights(vehicle, 2)
                                                    SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                                    SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                                    table.insert(VehicleSpawned, {model = vehicle})
                                                end)
                                                LastLastVeh = nil
                                                DoScreenFadeIn(500)
                                            end
                                            LastLastVeh = nil
                                            blabla = true
                                            quittest = false
                                        end)
                                        DoScreenFadeIn(500)
                                    else
                                        ESX.ShowNotification('Vous venez de faire un test attendez un peut !')
                                    end
                                elseif Button == 3 then
                                    if not blabla then 
                                        quittest = true
                                    end 
                                    local Confirm = KeyboardInput("Confirmer vous votre achat ?", "Oui / Non", 10)

                                    if Confirm == "Oui" then 
                                        TriggerServerEvent('aBoutique:BuyVehicle', v.model, v.price, v.label)
                                        DeleteEntity(LastVeh)
                                        DeleteEntity(LastLastVeh)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        SetEntityVisible(PlayerPedId(), true, 0)
                                        SetEntityCoords(PlayerPedId(), lastPos)
                                        SetFollowPedCamViewMode(1)
                                        for k,v in pairs(VehicleSpawned) do 
                                            if DoesEntityExist(v.model) then
                                                Wait(150)
                                                DeleteEntity(v.model)
                                                table.remove(VehicleSpawned, k)
                                            end
                                        end
                                        TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
                                        RageUI.CloseAll()     
                                    else
                                        ESX.ShowNotification('Achat non confirmer.')
                                        DeleteEntity(LastVeh)
                                        DeleteEntity(LastLastVeh)
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        SetEntityVisible(PlayerPedId(), true, 0)
                                        SetEntityCoords(PlayerPedId(), lastPos)
                                        SetFollowPedCamViewMode(1)
                                        for k,v in pairs(VehicleSpawned) do 
                                            if DoesEntityExist(v.model) then
                                                Wait(150)
                                                DeleteEntity(v.model)
                                                table.remove(VehicleSpawned, k)
                                            end
                                        end
                                        TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
                                        RageUI.CloseAll()     
                                    end                     
                                end
                        end
                    end
                })
            end
        end)
        -- RageUI.IsVisible(avionhelico, function()
        --     for k,v in pairs(BoutiqueAirPlaines) do 
        --         RageUI.List(GetLabelText(v.model)..' | Prix : ~g~'..v.price, Action, index.list, nil, {RightLabel = "→"}, true, {
        --             onActive = function()
        --                 FreezeEntityPosition(PlayerPedId(), true)
        --                 SetEntityVisible(PlayerPedId(), false, 0)
        --                 SetWeatherTypeNow('EXTRASUNNY')
        --                 SetFollowPedCamViewMode(4)
        --                 if LastVeh ~= nil then
        --                     rot = rot + 0.10
        --                     SetEntityHeading(LastVeh, rot)
        --                 end
        --             end,
        --             onListChange = function(Index, Item)
        --                 index.list = Index;
        --                 Button = Index;
        --             end,
        --             onSelected = function()
        --                 if Button == 1 then
        --                     if ESX.Game.IsSpawnPointClear(vector3(-970.8639, -2999.831, 13.945), 100) then
        --                         ESX.Game.SpawnLocalVehicle(v.model, vector3(-970.8639, -2999.831, 13.945), 337.120, function(vehicle)
        --                             LastVeh = vehicle
        --                             FreezeEntityPosition(vehicle, true)
        --                             SetVehicleDoorsLocked(vehicle, 2)
        --                             SetEntityInvincible(vehicle, true)
        --                             SetVehicleFixed(vehicle)
        --                             SetVehicleDirtLevel(vehicle, 0.0)
        --                             SetVehicleEngineOn(vehicle, true, true, true)
        --                             SetVehicleLights(vehicle, 2)
        --                             SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
        --                             SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
        --                             table.insert(VehicleSpawned, {model = vehicle})
        --                         end)
        --                     else
        --                         DeleteEntity(LastVeh)
        --                         DeleteEntity(LastLastVeh)
        --                         ESX.Game.SpawnLocalVehicle(v.model, vector3(-970.8639, -2999.831, 13.945), 337.120, function(vehicle)
        --                             LastVeh = vehicle
        --                             FreezeEntityPosition(vehicle, true)
        --                             SetVehicleDoorsLocked(vehicle, 2)
        --                             SetEntityInvincible(vehicle, true)
        --                             SetVehicleFixed(vehicle)
        --                             SetVehicleDirtLevel(vehicle, 0.0)
        --                             SetVehicleEngineOn(vehicle, true, true, true)
        --                             SetVehicleLights(vehicle, 2)
        --                             SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
        --                             SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
        --                             table.insert(VehicleSpawned, {model = vehicle})
        --                         end)
        --                     end
        --                 elseif Button == 2 then
        --                     TriggerServerEvent('aBoutique:BuyVehiclePlane', v.model, GetLabelText(v.model))
        --                     DeleteEntity(LastVeh)
        --                     DeleteEntity(LastLastVeh)
        --                     FreezeEntityPosition(PlayerPedId(), false)
        --                     SetEntityVisible(PlayerPedId(), true, 0)
        --                     SetEntityCoords(PlayerPedId(), lastPos)
        --                     SetFollowPedCamViewMode(1)
        --                     for k,v in pairs(VehicleSpawned) do 
        --                         if DoesEntityExist(v.model) then
        --                             Wait(150)
        --                             DeleteEntity(v.model)
        --                             table.remove(VehicleSpawned, k)
        --                         end
        --                     end
        --                     TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
        --                     RageUI.CloseAll()     
        --                 end
        --             end
        --         })
        --     end
		-- end)

        -- RageUI.IsVisible(bateaux, function()
        --     for k,v in pairs(BoutiqueBoat) do 
        --         RageUI.List(GetLabelText(v.model)..' | Prix : ~g~'..v.price, Action, index.list, nil, {RightLabel = "→"}, true, {
        --             onActive = function()
        --                 FreezeEntityPosition(PlayerPedId(), true)
        --                 SetEntityVisible(PlayerPedId(), false, 0)
        --                 SetWeatherTypeNow('EXTRASUNNY')
        --                 SetFollowPedCamViewMode(4)
        --                 if LastVeh ~= nil then
        --                     rot = rot + 0.10
        --                     SetEntityHeading(LastVeh, rot)
        --                 end
        --             end,
        --             onListChange = function(Index, Item)
        --                 index.list = Index;
        --                 Button = Index;
        --             end,
        --             onSelected = function()
        --                 if Button == 1 then
        --                     if ESX.Game.IsSpawnPointClear(vector3(550.243, -3378.061, 5.843), 100) then
        --                         ESX.Game.SpawnLocalVehicle(v.model, vector3(550.243, -3378.061, 5.843), 282.959, function(vehicle)
        --                             LastVeh = vehicle
        --                             FreezeEntityPosition(vehicle, true)
        --                             SetVehicleDoorsLocked(vehicle, 2)
        --                             SetEntityInvincible(vehicle, true)
        --                             SetVehicleFixed(vehicle)
        --                             SetVehicleDirtLevel(vehicle, 0.0)
        --                             SetVehicleEngineOn(vehicle, true, true, true)
        --                             SetVehicleLights(vehicle, 2)
        --                             SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
        --                             SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
        --                             table.insert(VehicleSpawned, {model = vehicle})
        --                         end)
        --                     else
        --                         DeleteEntity(LastVeh)
        --                         DeleteEntity(LastLastVeh)
        --                         ESX.Game.SpawnLocalVehicle(v.model, vector3(550.243, -3378.061, 5.843), 282.959, function(vehicle)
        --                             LastVeh = vehicle
        --                             FreezeEntityPosition(vehicle, true)
        --                             SetVehicleDoorsLocked(vehicle, 2)
        --                             SetEntityInvincible(vehicle, true)
        --                             SetVehicleFixed(vehicle)
        --                             SetVehicleDirtLevel(vehicle, 0.0)
        --                             SetVehicleEngineOn(vehicle, true, true, true)
        --                             SetVehicleLights(vehicle, 2)
        --                             SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
        --                             SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
        --                             table.insert(VehicleSpawned, {model = vehicle})
        --                         end)
        --                     end
        --                 elseif Button == 2 then
        --                     TriggerServerEvent('aBoutique:BuyVehicleBoat', v.model, GetLabelText(v.model))
        --                     DeleteEntity(LastVeh)
        --                     DeleteEntity(LastLastVeh)
        --                     FreezeEntityPosition(PlayerPedId(), false)
        --                     SetEntityVisible(PlayerPedId(), true, 0)
        --                     SetEntityCoords(PlayerPedId(), lastPos)
        --                     SetFollowPedCamViewMode(1)
        --                     for k,v in pairs(VehicleSpawned) do 
        --                         if DoesEntityExist(v.model) then
        --                             Wait(150)
        --                             DeleteEntity(v.model)
        --                             table.remove(VehicleSpawned, k)
        --                         end
        --                     end
        --                     TriggerServerEvent('BoutiqueBucket:SetEntitySourceBucket', false)
        --                     RageUI.CloseAll() 
        --                 end
        --             end
        --         })
        --     end
		-- end)
        RageUI.IsVisible(PacksMenu, function() 
            RageUI.Line()
            RageUI.Button('Crée ton Organisation', nil, {RightLabel = "7000"}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Prix : ~g~7000"}, {})
                end,
                onSelected = function()
                    TriggerServerEvent('aBoutique:IllegalOrga')
                    RageUI.CloseAll()
                end
            })
            RageUI.Button('Crée ton Gang', nil, {RightLabel = "5000"}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Prix : ~g~5000"}, {})
                end,
                onSelected = function()
                    TriggerServerEvent('aBoutique:IllegalGang')
                    RageUI.CloseAll()
                end
            })
            RageUI.Button('Crée ton Entreprise Farm', nil, {RightLabel = 6000}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Prix : ~g~6000"}, {})
                end,
                onSelected = function()
                    TriggerServerEvent('aBoutique:entreprise')
                    RageUI.CloseAll()
                end
            })
            RageUI.Line()
            RageUI.Button('Ajout Véhicule au choix', nil, {RightLabel = 7000}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Prix : ~g~7000"}, {})
                end,
                onSelected = function()
                    TriggerServerEvent('aBoutique:vehunique')
                    RageUI.CloseAll()
                end
            })
            RageUI.Button('Déplacement Gang/Orga', nil, {RightLabel = "2000"}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Prix : ~g~2000"}, {})
                end,
                onSelected = function()
                    TriggerServerEvent('aBoutique:ChangePoint')
                    RageUI.CloseAll()
                end
            })
            RageUI.Line()
            RageUI.Button('Ajout Mapping', nil, {RightLabel = ">"}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Merci de faire un ticket sur le ~g~Discord ",}, {})
                end,
                onSelected = function()
                    ESX.ShowNotification("Merci de faire un ticket sur le Discord ")
                    
                    RageUI.CloseAll()
                end
            })
            RageUI.Button('Ajout Yacht perso', nil, {RightLabel = ">"}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Merci de faire un ticket sur le ~g~Discord ",}, {})
                end,
                onSelected = function()
                    ESX.ShowNotification("Merci de faire un ticket sur le Discord ")
                    
                    RageUI.CloseAll()
                end
            })
        end)

        
        
        RageUI.IsVisible(ArmesMenu, function()
            for k,v in pairs(WeaponBoutique) do
                RageUI.List(v.label..' | Prix : ~g~'..v.price, dedenn, index.list, v.description, {}, lockmenu, {
                        onSelected = function()
                            if lockmenu then 
                                if Button == 1 then
                                    local Confirm = KeyboardInput("Confirmez-vous votre achat ?", "Oui / Non", 10)
                                    if Confirm == "Oui" then
                                        TriggerServerEvent('aBoutique:BuyWeapon', v.name, v.price, v.label)
                                        RageUI.CloseAll()     
                                    else
                                        ESX.ShowNotification('Achat non confirmé.')
                                        RageUI.CloseAll()
                                    end                     
                                end
                        end
                    end
                })
            end
        end)        

        

        RageUI.IsVisible(CustomArmesShopMenu, function()
            local sWeapon = GetSelectedPedWeapon(PlayerPedId())
            local weapon = ESX.GetWeaponFromHash(sWeapon)
            if sWeapon ~= GetHashKey("WEAPON_UNARMED") then
                local isPermanent = ESX.IsWeaponPermanent(weapon.name)
                if isPermanent then
                    RageUI.Separator(weapon.label)
                    RageUI.Line()
                    if (ESX.Table.SizeOf(weapon) > 0) then
                        for _, v in pairs(weapon.components) do
                            if v.name ~= "luxary_finish" and v.name ~= "clip_default" and v.name ~= "ammo_tracer" and v.name ~= "ammo_incendiary" and v.name ~= "ammo_armor" and v.name ~= "ammo_fmj" and v.name ~= "ammo_explosive" and v.name ~= "ammo_hollowpoint" and v.name ~= "shells_explosive" and v.name ~= "shells_hollowpoint" and v.name ~= "shells_armor" and v.name ~= "shells_incendiary" and v.name ~= "shells_incendiary" then
                                RageUI.Button(v.label, nil, {RightLabel = "→"}, not HasPedGotWeaponComponent(PlayerPedId(), sWeapon, v.hash), {
                                    onActive = function()
                                        if v.name == "clip_extended" then
                                            RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Composant : ~g~"..v.label.."", "Prix : ~g~500"}, {})
                                        elseif v.name == "clip_drum" then
                                            RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Composant : ~g~"..v.label.."", "Prix : ~g~750"}, {})
                                        elseif v.name == "clip_box" then
                                            RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Composant : ~g~"..v.label.."", "Prix : ~g~1000"}, {})
                                        else
                                            RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Composant : ~g~"..v.label.."", "Prix : ~g~250"}, {})
                                        end
                                    end,
                                    onSelected = function()
                                        TriggerServerEvent('tebex:on-process-checkout-weapon-custom', weapon.name, GetHashKey(v.name))
                                    end,
                                })
                            end
                        end
                    else
                        RageUI.Separator("Aucune personnalisation disponible")
                    end
                else
                    RageUI.Separator("Aucune personnalisation sur ce type d'arme")
                end
            else
                RageUI.Line()
                RageUI.Separator("~r~Vous n'avez pas d'armes en main~s~")
                RageUI.Line()
            end
        end)

        
        RageUI.IsVisible(CaseMenu, function() 
            for k,v in pairs(BoutiqueMysteryBox) do
                if v.model ~= 'caisse_fidelite' then
                    RageUI.List(v.label..' | Prix : ~g~'..v.price, Action, index.list, v.description, {}, true, {
                        onActive = function()
                            RageUI.RenderCaisse("caisse", v.model)
                            RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
                        end,
                        onListChange = function(Index, Item)
                            index.list = Index;
                            Button = Index;
                        end,
                        onSelected = function()
                            if Button == 1 then
                                OpenMenuPreviewCaisse(v.model, v.label)
                            elseif Button == 2 then
                                RageUI.CloseAll()
                                TriggerServerEvent('GreenLife:process_checkout_case', v.model)
                            end
                        end
                    })
                else
                    RageUI.List(v.label..' | Bonus Fidélité', Action, index.list, nil, {RightLabel = "→"}, true, {
                        onActive = function()
                            RageUI.RenderCaisse("caisse", v.model)
                            RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins..""}, {})
                        end,
                        onListChange = function(Index, Item)
                            index.list = Index;
                            Button = Index;
                        end,
                        onSelected = function()
                            if Button == 1 then
                                OpenMenuPreviewCaisse(v.model, v.label)
                            elseif Button == 2 then
                                ESX.ShowNotification('Vous ne povuez pas acheter cette Caisse')
                            end
                        end
                    })
                end
            end
        end)
        RageUI.IsVisible(VipMenu, function() 
            RageUI.Button('VIP ~g~Gold (1 mois)', nil, { RightLabel = 1000}, true, {
                onActive = function()
                RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Temps : ~g~1 Mois","VIP : ~g~Gold", "Bonus: ~g~500 GoodCoins"}, {})
                end,
                onSelected = function()
                    TriggerServerEvent('eBoutique:BuyVIP', "gold")
                end,
            })
            RageUI.Button('VIP (1 mois)', nil, { RightLabel = 2000}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Prix : ~g~2000"}, {})
                end,
                onSelected = function()
                    TriggerServerEvent('eBoutique:BuyVIP', "diamond")
                end,
            })
        end)

        RageUI.IsVisible(GreenLifePass, function() 
            RageUI.Button('GreenLifePass Premium (1 mois)', nil, { RightLabel = 1000}, true, {
                onActive = function()
                    RageUI.Info('~g~Boutique GreenLife', {'Code Boutique : ~g~'..fivemid..'', "~s~Greenlife : ~g~"..GoodCoins.."", "Prix : ~g~1000"}, {})
                end,
                onSelected = function()
                    TriggerServerEvent('eBoutique:BuyPremium')
                end,
            })
        end)
        if not RageUI.Visible(menu) 
        and not RageUI.Visible(vehicles) 
        and not RageUI.Visible(voitures) 
        and not RageUI.Visible(avionhelico) 
        and not RageUI.Visible(bateaux) 
        and not RageUI.Visible(PacksMenu) 
        and not RageUI.Visible(ArmesMenu) 
        and not RageUI.Visible(ArmesShopMenu) 
        and not RageUI.Visible(CustomArmesShopMenu) 
        and not RageUI.Visible(CaseMenu)
        and not RageUI.Visible(VipMenu)
        and not RageUI.Visible(GreenLifePass)
        then
            menu = RMenu:DeleteType('menu', true)
		end
		Wait(3)
    end
end

RegisterNetEvent('aBoutique:BuyCustomMaxClient', function()
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    FullCustom(vehicle)
end)

function FullCustom(veh)
	SetVehicleModKit(veh, 0)
	ToggleVehicleMod(veh, 18, true)
	ToggleVehicleMod(veh, 22, true)
	SetVehicleMod(veh, 16, 5, false)
	SetVehicleMod(veh, 12, 2, false)
	SetVehicleMod(veh, 11, 3, false)
	SetVehicleMod(veh, 14, 14, false)
	SetVehicleMod(veh, 15, 3, false)
	SetVehicleMod(veh, 13, 2, false)
	SetVehicleMod(veh, 23, 21, true)
	SetVehicleMod(veh, 0, 1, false)
	SetVehicleMod(veh, 1, 1, false)
	SetVehicleMod(veh, 2, 1, false)
	SetVehicleMod(veh, 3, 1, false)
	SetVehicleMod(veh, 4, 1, false)
	SetVehicleMod(veh, 5, 1, false)
	SetVehicleMod(veh, 6, 1, false)
	SetVehicleMod(veh, 7, 1, false)
	SetVehicleMod(veh, 8, 1, false)
	SetVehicleMod(veh, 9, 1, false)
	SetVehicleMod(veh, 10, 1, false)
	SetVehicleModKit(veh, 0)
	ToggleVehicleMod(veh, 20, true)
	SetVehicleModKit(veh, 0)
	SetVehicleNumberPlateTextIndex(veh, true)
    myCar = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false))
	TriggerServerEvent('esx_lscustom:refreshOwnedVehicle', myCar);
end

function OpenMenuPreviewCaisse(model, label)
    local CaissePreview = RageUI.CreateMenu('Boutique GreenLife', "Boutique GreenLife")
    RageUI.Visible(CaissePreview, not RageUI.Visible(CaissePreview))
    while CaissePreview do
        Wait(3)
        RageUI.IsVisible(CaissePreview, function()
            RageUI.Line()
            RageUI.Separator('Prévisualisation de la caisse : '..label)
            for k,v in pairs(VisualitionCaisse[model]) do
                if v.rarity == 4 then
                    RageUI.Button(v.label, nil, {RightLabel = '~g~Ultime'}, true, {
                        onActive = function()
                            RageUI.RenderCaissePreview('caissemystere', v.model)
                        end,
                        onSelected = function()
        
                        end
                    })
                end
            end
            for k,v in pairs(VisualitionCaisse[model]) do
                if v.rarity == 3 then
                    RageUI.Button(v.label, nil, {RightLabel = '~g~Légendaire'}, true, {
                        onActive = function()
                            RageUI.RenderCaissePreview('caissemystere', v.model)
                        end,
                        onSelected = function()
        
                        end
                    })
                end
            end
            for k,v in pairs(VisualitionCaisse[model]) do
                if v.rarity == 2 then
                    RageUI.Button(v.label, nil, {RightLabel = '~g~Rare'}, true, {
                        onActive = function()
                            RageUI.RenderCaissePreview('caissemystere', v.model)
                        end,
                        onSelected = function()
        
                        end
                    })
                end
            end
            for k,v in pairs(VisualitionCaisse[model]) do
                if v.rarity == 1 then
                    RageUI.Button(v.label, nil, {RightLabel = '~g~Commun'}, true, {
                        onActive = function()
                            RageUI.RenderCaissePreview('caissemystere', v.model)
                        end,
                        onSelected = function()
        
                        end
                    })
                end
            end
        end, function()
        end)

        if not RageUI.Visible(CaissePreview) then
            CaissePreview = RMenu:DeleteType('BoutiqueSub', true)
            Wait(100)
            OpenMenuMain()
        end
    end
end

-- OPENING CASE

local picture;

local mysterybox = RageUI.CreateMenu("Caisse Mystère", "Bonne chance !")

RegisterNetEvent('ewen:caisseopenclientside')
AddEventHandler('ewen:caisseopenclientside', function(animations, name, message)
    RageUI.Visible(mysterybox, not RageUI.Visible(mysterybox))
    CreateThread(function()
        Wait(250)
        for k, v in pairs(animations) do
            picture = v.name
            RageUI.PlaySound("HUD_FREEMODE_SOUNDSET", "NAV_UP_DOWN")
            if v.time == 5000 then
                RageUI.PlaySound("HUD_AWARDS", "FLIGHT_SCHOOL_LESSON_PASSED")
                ESX.ShowAdvancedNotification('Notification', 'Boutique', message, 'CHAR_GreenLife', 6)
                Wait(4000)
            end
            Wait(v.time)
        end
    end)
end)


RegisterNetEvent('aBoutique:SendJournaliereBoutique')
AddEventHandler('aBoutique:SendJournaliereBoutique', function(vehicle)
    VehicleJournalier = vehicle
end)

CreateThread(function()
	Wait(2000)
	TriggerServerEvent('ewen:boutiquecashout')
end)

