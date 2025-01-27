local desVehicles = {}
local desCategories= {}
local theCategories
local theCategorieslabel
local isInPreview = false

Citizen.CreateThread(function()
    while true do
        local interval = 1000
        local coords = GetEntityCoords(PlayerPedId())
        if #(coords - Config.Catalogue.Pos) <= 10 then
            interval = 1
            DrawMarker(Config.Get.Marker.Type, Config.Catalogue.Pos, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
            if #(coords - Config.Catalogue.Pos) <= 3 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au catalogue")
                -- TriggerEvent("ui:showInteraction", "E", " pour accéder au catalogue")
                if IsControlJustReleased(0, 38) then
                    openCatalogue()
                end
            end
        end
        Wait(interval)
    end
end)

openCatalogue = function()
    local mainMenu = RageUI.CreateMenu("", "Consultez nos véhicules")
    local categories = RageUI.CreateSubMenu(mainMenu, "", "Choisissez une catégorie")
    local vehicle = RageUI.CreateSubMenu(mainMenu, "", "Choisissez un véhicule")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Liste des véhicules", nil, {RightLabel = "→→"}, true, {
                onSelected = function()
                    getCatalogue()
                end
            }, categories)
        end)

        RageUI.IsVisible(categories, function()
            for k,v in pairs(desCategories) do
                if v.name ~= 'avionfdp' and v.name ~= 'superboat' then
                    RageUI.Button(v.label, nil , {RightLabel = "→→"}, true, {
                        onSelected = function()
                            theCategories = v.name
                            theCategorieslabel = v.label
                            getVehiclesCatalogue()
                        end
                    }, vehicle)
                end
            end
        end)

        RageUI.IsVisible(vehicle, function()
            RageUI.Separator("↓ Voci les véhicules disponibles ↓")
            RageUI.Line()
            for k,v in pairs(desVehicles) do
                local moneyPrice = v.price * 2
                if v.category == theCategories then
                    RageUI.Button(v.name, "Prix : "..moneyPrice.." $", {RightLabel = "→→"}, true, {
                        onSelected = function()
                            local plyPed = PlayerPedId()
                            SetEntityCoords(plyPed, -792.48541259766, -217.89904785156, 36.161239624023)
                            local vehicle = v.model
                            TriggerServerEvent('catalogue:changeBucket', "enter")
                            ESX.Game.SpawnLocalVehicle(vehicle, Config.Catalogue.PosPreview, Config.Catalogue.Heading, function (vehicle)
                                TaskWarpPedIntoVehicle(plyPed, vehicle, -1)
                                FreezeEntityPosition(vehicle, true)
                            end)
                            isInPreview = true
                            RageUI.CloseAll()
                            Wait(100)
                            openPreviewCatalogue()
                        end
                    })
                end
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(categories) and not RageUI.Visible(vehicle) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            table.remove(desVehicles, k)
            table.remove(desCategories, k)
        end
        if not RageUI.Visible(categories) then
            desCategories = {}
        end
        if not RageUI.Visible(vehicle) then
            desVehicles = {}
        end
        Wait(0)
    end
end

openPreviewCatalogue = function()
    local preview = RageUI.CreateMenu("", "Véhicule prévisualisé")
    RageUI.Visible(preview, not RageUI.Visible(preview))
    while preview do
        RageUI.IsVisible(preview, function()
                RageUI.Button("Revenir au catalogue", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.Game.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                        SetEntityCoords(PlayerPedId(), Config.Catalogue.Pos)
                        isInPreview = false
                        TriggerServerEvent('catalogue:changeBucket', "leave")
                        RageUI.CloseAll()
                    end
                })
        end)
        if not RageUI.Visible(preview) and not isInPreview then
            preview = RMenu:DeleteType(preview, true)
        end
        if not RageUI.Visible(preview) and isInPreview then
            RageUI.Visible(preview, not RageUI.Visible(preview))
        end
        Wait(0)
    end
end

getCatalogue = function()
    ESX.TriggerServerCallback('catalogue:getCatalogue', function(cb)
        for i=1, #cb do
            local d = cb[i]
            table.insert(desCategories, {
                name = d.name,
                label = d.label,
            })
        end
    end)
end

getVehiclesCatalogue = function()
    ESX.TriggerServerCallback('catalogue:getAllVehicles', function(result)
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