--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

open = {} or {};

function checkPPaLicence()
    ESX.TriggerServerCallback('checkLicense', function(cb)            
        if cb then
            return true
        else 
            return false
        end
    end)
end

function AmmunationMenu()
    if checkPPaLicence() then
        havePPA = true
    end
    local mainMenu = RageUI.CreateMenu("", "Achetez vos armes")
    local whiteWeapon = RageUI.CreateSubMenu(mainMenu, "", "Catégorie : Armes Blanches")
    local letalWeapon = RageUI.CreateSubMenu(mainMenu, "", "Catégorie : Armes Létales")
    local accessories = RageUI.CreateSubMenu(mainMenu, "", "Catégorie : Accessoires")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    if havePPA == false then
        ESX.TriggerServerCallback('checkLicense', function(cb)            
            if cb then
                havePPA = true 
            else 
                havePPA = false   
            end
        end)
    end
    
    while mainMenu do
        Wait(1)
        RageUI.IsVisible(mainMenu, function()
            RageUI.Separator("↓ Armes ↓")
            RageUI.Button("Armes Blanches", nil, {RightLabel = "→"}, true, {}, whiteWeapon)
            if havePPA then 
                RageUI.Button("Armes Létales", nil, {RightLabel = "→"}, true, {}, letalWeapon)
            else
                RageUI.Button("Armes Létales", nil, {RightLabel = nil}, false, {})
            end
            RageUI.Separator("↓ Autre ↓")
            RageUI.Button("Accessoires", nil, {RightLabel = "→"}, true, {}, accessories)
            if not havePPA then 
                RageUI.Button("Achetez le PPA", nil, {RightLabel = "150.000~g~$"}, true, {
                    onSelected = function()
                        TriggerServerEvent('addPPA', 'weapon')
                        RageUI.CloseAll()
                    end
                })
            else
                RageUI.Button("Achetez le PPA", nil, {RightLabel = ""..Config.Ammunation.PPA.price.." ~g~$"}, false, {})
            end
        end)
        RageUI.IsVisible(accessories, function()
            for k,v in pairs(Config.Ammunation.Items.accessories) do
                RageUI.Button(v.label, v.description, {RightLabel = ""..v.price.." ~g~$"}, true, {
                    onSelected = function()
                        TriggerServerEvent("buyWeaponaccessories", v.item, v.price) 
                    end
                })
            end
        end)
        RageUI.IsVisible(whiteWeapon, function()
            for k,v in pairs(Config.Ammunation.Items.whiteWeapon) do
                RageUI.Button(v.label, v.description, {RightLabel = ""..v.price.." ~g~$"}, true, {
                    onSelected = function()
                        TriggerServerEvent("buyWeaponwhiteWeapon", v.item, v.price) 
                    end
                })
            end
        end)
        
        RageUI.IsVisible(letalWeapon, function()
            for k,v in pairs(Config.Ammunation.Items.letalWeapon) do
                RageUI.Button(v.label, v.description, {RightLabel = ""..v.price.." ~g~$"}, true, {
                    onSelected = function()
                        TriggerServerEvent("buyWeaponletalWeapon", v.item, v.price) 
                    end
                })
            end
        end)
        if not RageUI.Visible(mainMenu) and not RageUI.Visible(whiteWeapon) and not RageUI.Visible(whiteWeaponVIP) and not RageUI.Visible(letalWeapon) and not RageUI.Visible(accessories) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
        end
    end
end