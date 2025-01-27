--[[
  This file is part of exelity RolePlay.
  Copyright (c) exelity RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local filter = {dressing = {index = 1}}

---@author Razzway
---@type function Render:myDressingMenu
function Render:myDressingMenu()
    -- RageUIClothes.Line()
    if _Razzway.Data == nil then 
        BLCCCCCCCCCC = false
        RageUIClothes.GoBack()
    elseif _Razzway.Data == {} then 
        RageUIClothes.Separator("Aucune tenue")
    else
        for _,v in pairs(_Razzway.Data) do
            if v.type == "outfit" then
                RageUIClothes.List((''..v.name..''):format(_Arrow), {
                    {Name = "~g~Equiper la tenue~s~", Type = 1},
                    {Name = "~b~Renommer la tenue~s~", Type = 2},
                    {Name = "~r~Supprimer la tenue~s~", Type = 3},
                }, filter.dressing.index, nil, {  }, nil, {
                    onActive = function() Uclothes:OnRenderCam() end,
                    onListChange = function(Index, Item)
                        filter.dressing.index = Index;
                        selectedType = Item.Type;
                    end,
                    onSelected = function(Index, Item)
                        if selectedType == nil then selectedType = 1 end
                        if selectedType == 1 then
                            CreateThread(function()
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    TriggerEvent('skinchanger:loadClothes', skin, json.decode(v.data))
                                    Wait(50)
                                    TriggerEvent('skinchanger:getSkin', function(skin_)
                                        TriggerServerEvent('esx_skin:save', skin_)
                                    end)
                                end)
                            end)
                            ESX.ShowAdvancedNotification('Notification', "Vêtements", "Vous avez enfilé la tenue : "..v.name, 'CHAR_BINCO', 8)
                        end
                        if selectedType == 2 then
                            local newName = exports["cfx-target"]:ShowSync('Veuillez indiquer le nouveau nom a donner ', true, 600, "small_text")
                            if newName == "" or newName == nil then
                                ESX.ShowAdvancedNotification('Notification', "Vêtements", "Vous devez attitré le nouveau nom de votre tenue pour l'enregistrer", 'CHAR_BINCO', 8)
                            else
                                CreateThread(function()
                                    TriggerEvent('skinchanger:getSkin', function(saveAppearance)
                                        Wait(25)
                                        TriggerServerEvent(_Prefix..":modifyData", v.id, newName)
                                        ESX.ShowAdvancedNotification('Notification', "Vêtements", "Vous avez attribué un nouveau nom à votre tenue :~h~\n- Ancien~s~ ~y~→~s~ ("..v.name..")\n- Nouveau~s~ ~y~→~s~ ("..newName..")", 'CHAR_BINCO', 8)
                                    end)
                                    Wait(50)
                                    RageUIClothes.GoBack()
                                end)
                            end
                        end

                        if selectedType == 3 then
                            table.remove(_Razzway.Data, _)
                            TriggerServerEvent(_Prefix..':deleteData', tonumber(v.id))
                        end
                    end,
                })
            end
        end       
    end
end