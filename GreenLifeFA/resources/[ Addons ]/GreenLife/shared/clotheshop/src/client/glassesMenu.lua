--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local filter = {accessories = {Lunette1 = 1, Lunette2 = 1}}

---@author
---@type function _Client.open:glassesMenu
function _Client.open:glassesMenu()
    local glassesMenu = RageUIClothes.CreateMenu('', 'Voici les articles disponibles')

    glassesMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Rotation Droite"})
    glassesMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Rotation Gauche"})

    FreezeEntityPosition(PlayerPedId(), true)
    Uclothes:CreateHeadCam()

    RageUIClothes.Visible(glassesMenu, (not RageUIClothes.Visible(glassesMenu)))

    while glassesMenu do
        Wait(0)
        RageUIClothes.IsVisible(glassesMenu, function()
            local Lunette1 = {} for i = 0 , GetNumberOfPedPropDrawableVariations(PlayerPedId(), 1)-1, 1 do Lunette1[i] = i end
            local Lunette2 = {} for i = 0 , GetNumberOfPedPropTextureVariations(PlayerPedId(), 1, filter.accessories.Lunette1) - 1, 1 do Lunette2[i] = i end
            local desc = "Appuyez sur la touche ~h~ENTRER~h~ pour choisir un numéro"
            RageUIClothes.Line()
            RageUIClothes.List('Lunette 1', Lunette1, filter.accessories.Lunette1, desc, {}, true, { onActive = function() Uclothes:OnRenderCam() end, onListChange = function(Index, Item) filter.accessories.Lunette1 = Index filter.accessories.Lunette2 = 1 TriggerEvent('skinchanger:change', 'glasses_1', filter.accessories.Lunette1 - 1) end, 
            onSelected = function() 
                local result = exports["cfx-target"]:ShowSync('Veuillez indiquez le numéro que vous souhaitez sélectionner ', true, 600, "small_text") 
                if result ~= "" and tonumber(result) ~= nil then 
                    filter.accessories.Lunette1 = result TriggerEvent('skinchanger:change', 'glasses_1', filter.accessories.Lunette1 - 1) 
                else 
                    ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.') 
                end 
            end})
            RageUIClothes.List('Lunette 2', Lunette2, filter.accessories.Lunette2, desc, {}, true, { onActive = function() Uclothes:OnRenderCam() end, onListChange = function(Index, Item) filter.accessories.Lunette2 = Index TriggerEvent('skinchanger:change', 'glasses_2', filter.accessories.Lunette2 - 1) end, 
            onSelected = function() local result = exports["cfx-target"]:ShowSync('Veuillez indiquez le numéro que vous souhaitez sélectionner ', true, 600, "small_text") 
                if result ~= "" and tonumber(result) ~= nil then 
                    filter.accessories.Lunette2 = result TriggerEvent('skinchanger:change', 'glasses_2', filter.accessories.Lunette2 - 1) 
                else 
                    ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.') 
                end 
            end})
            RageUIClothes.Button(('Valider les changements (%s$)'):format(_Config.clotheshop.accessoriesPrice), nil, { Color = { BackgroundColor = { 0, 140, 0, 160 } } }, true, {
                onActive = function() Uclothes:OnRenderCam() end,
                onSelected = function()
                    -- type: type of clothe (Exemple : 'pants')
                    -- label: label of clothe (Exemple : 'Pants Blue')
                    -- data: data of clothe (Exemple : data = {["pants_1"] = 23, ["pants_2"] = 2})
                    -- exports["lc-inventory"]:addClothes('glasses', 'Lunettes', {["glasses_1"] = filter.accessories.Lunette1 - 1, ["glasses_2"] = filter.accessories.Lunette2 - 1})
                    TriggerServerEvent(_Prefix..':accessories:pay')
                    Wait(180)
                    RageUIClothes.CloseAll()
                    TriggerServerEvent(_Prefix..':animation:pay')

                end
            })
        end)

        if not RageUIClothes.Visible(glassesMenu) then
            glassesMenu = RMenuClothes:DeleteType('glassesMenu', true)
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
            Wait(180)
            FreezeEntityPosition(PlayerPedId(), false)
            Uclothes:KillCam()
        end
    end
end