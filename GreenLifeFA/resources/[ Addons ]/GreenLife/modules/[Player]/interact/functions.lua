--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)
		Wait(10)
    end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)

	--AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	--DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	--blockinput = true
--
	--while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
	--	Wait(0)
	--end
--
	--if UpdateOnscreenKeyboard() ~= 2 then
	--	local result = GetOnscreenKeyboardResult()
	--	Wait(500)
	--	blockinput = false
	--	return result
	--else
	--	Wait(500)
	--	blockinput = false
	--	return nil
	--end
    local Input = exports["Abteww"]:KeyboardInput(("Abteww:input:%s"):format(ExampleText), TextEntry);
    if (not Input) then
        return nil
    end
    local MaximumLengt = (((MaxStringLenght ~= nil) and (MaxStringLenght > 0) and MaxStringLenght) or 10000);
    if (string.len(Input) > MaximumLengt) then
        return nil
    end
    return Input;
end


function CustomAmount()
    local montant = nil
    AddTextEntry("BANK_CUSTOM_AMOUNT", "Entrez le montant")
    DisplayOnscreenKeyboard(1, "BANK_CUSTOM_AMOUNT", '', "", '', '', '', 15)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        montant = GetOnscreenKeyboardResult()
        Wait(1)
    else
        Wait(1)
    end
    return tonumber(montant)
end

RegisterNetEvent('requestClothes')
AddEventHandler('requestClothes', function(clothesType)
    if clothesType == "haut" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
            TriggerEvent('skinchanger:getSkin', function(skinb)
                local lib, anim = 'clothingtie', 'try_tie_neutral_a'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                end)
                Wait(1000)
                ClearPedTasks(PlayerPedId())
    
                if skina.torso_1 ~= skinb.torso_1 then
                    vethaut = true
                    TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = skina.torso_1, ['torso_2'] = skina.torso_2, ['tshirt_1'] = skina.tshirt_1, ['tshirt_2'] = skina.tshirt_2, ['arms'] = skina.arms})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = 15, ['torso_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['arms'] = 15})
                    vethaut = false
                end
    
            end)
        end)    
    elseif clothesType == "bas" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
            TriggerEvent('skinchanger:getSkin', function(skinb)
                local lib, anim = 'clothingtrousers', 'try_trousers_neutral_c'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                end)
                Wait(1000)
                ClearPedTasks(PlayerPedId())
    
                if skina.pants_1 ~= skinb.pants_1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = skina.pants_1, ['pants_2'] = skina.pants_2})
                    vetbas = true
                else
                    vetbas = false
                    if skina.sex == 1 then
                        TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = 15, ['pants_2'] = 0})
                    else
                        TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = 14, ['pants_2'] = 0})
                    end
                end
            end)
        end)
    elseif clothesType == "chaussures" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
            TriggerEvent('skinchanger:getSkin', function(skinb)
                local lib, anim = 'clothingshoes', 'try_shoes_positive_a'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                end)
                Wait(1000)
                ClearPedTasks(PlayerPedId())
    
                if skina.shoes_1 ~= skinb.shoes_1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = skina.shoes_1, ['shoes_2'] = skina.shoes_2})
                    vetch = true
                else
                    vetch = false
                    if skina.sex == 1 then
                        TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = 35, ['shoes_2'] = 0})
                    else
                        TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = 34, ['shoes_2'] = 0})
                    end
                end
            end)
        end)
    elseif clothesType == "sac" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
            TriggerEvent('skinchanger:getSkin', function(skinb)
                local lib, anim = 'clothingtie', 'try_tie_neutral_a'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                end)
                Wait(1000)
                ClearPedTasks(PlayerPedId())
    
                if skina.bags_1 ~= skinb.bags_1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = skina.bags_1, ['bags_2'] = skina.bags_2})
                    vetsac = true
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = 0, ['bags_2'] = 0})
                    vetsac = false
                end
            end)
        end)    
    elseif clothesType == "masque" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
            TriggerEvent('skinchanger:getSkin', function(skinb)
                local lib, anim = 'missfbi4', 'takeoff_mask'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                end)
                Wait(1000)
                ClearPedTasks(PlayerPedId())
    
                if skina.mask_1 ~= skinb.mask_1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = skina.mask_1, ['mask_2'] = skina.mask_2})
                    vetmasque = true
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = 0, ['mask_2'] = 0})
                    vetmasque = false
                end
            end)
        end)
    elseif clothesType == "casque" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
            TriggerEvent('skinchanger:getSkin', function(skinb)
                local lib, anim = 'missfbi4', 'takeoff_mask'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                end)
                Wait(1000)
                ClearPedTasks(PlayerPedId())
    
                if skina.helmet_1 ~= skinb.helmet_1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = skina.helmet_1, ['helmet_2'] = skina.helmet_2})
                    vetmasque = true
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = -1, ['helmet_2'] = 0})
                    vetmasque = false
                end
            end)
        end)        
    elseif clothesType == "lunette" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
            TriggerEvent('skinchanger:getSkin', function(skinb)
                local lib, anim = 'missfbi4', 'takeoff_mask'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                end)
                Wait(1000)
                ClearPedTasks(PlayerPedId())
    
                if skina.glasses_1 ~= skinb.glasses_1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = skina.glasses_1, ['glasses_2'] = skina.glasses_2})
                    vetlunette = true
                else
                    vetlunette = false
                    if skina.sex == 1 then
                        TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = -1, ['glasses_2'] = 0})
                    else
                        TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = 0, ['glasses_2'] = 0})
                    end
                end
            end)
        end)  
    elseif clothesType == "gilet" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
            TriggerEvent('skinchanger:getSkin', function(skinb)
                local lib, anim = 'clothingtie', 'try_tie_neutral_a'
                ESX.Streaming.RequestAnimDict(lib, function()
                    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                end)
                Wait(1000)
                ClearPedTasks(PlayerPedId())
    
                if skina.bproof_1 ~= skinb.bproof_1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = skina.bproof_1, ['bproof_2'] = skina.bproof_2})
                    vetgilet = true
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = 0, ['bproof_2'] = 0})
                    vetgilet = false
                end
            end)
        end)    
    end
end)

-- local colorb = "~g~"
-- local colore = "~g~"
-- local coloreg = "~g~"
-- local fuelc = "~g~"
-- local rad = 0
-- local rag = 0
-- local rard = 0 
-- local rarg = 0

-- -- CreateThread(function()
-- --     while true do
-- --         SetPedSuffersCriticalHits(PlayerPedId(),false) -- descativer les tete
-- --         local playerPed = PlayerPedId()
-- --         if IsPedInAnyVehicle(playerPed, false) then
-- --             local veh = GetVehiclePedIsIn(playerPed, false)
-- --             if GetVehicleEngineHealth(veh) > 1 and GetVehicleEngineHealth(veh) < 550 then
-- --                 ESX.ShowNotification("~g~[Tableau de bord]~s~ le moteur du véhicule est ~o~fortement endommagé")
-- --                 PlaySoundFrontend(-1,"Timer_10s", "GTAO_FM_Events_Soundset", true)
-- --                 Wait(20000) -------
-- --                 ESX.ShowNotification("~g~[Tableau de bord]~s~ le moteur du véhicule est en ~y~état critique")
-- --                 local soundId2 = GetSoundId()
-- --                 PlaySoundFrontend(soundId2,"Tank_Critical_Damage_Loop", "dlc_vw_am_ip_tank_sounds", true)
-- --                 Wait(20000) -------
-- --                 StopSound(soundId2)
-- --                 ReleaseSoundId(soundId2)
-- --                 ESX.ShowNotification("~g~[Tableau de bord]~s~ Le moteur du véhicule est ~y~hors-service")
-- --                 SetVehicleEngineHealth(veh,-4000.0)
-- --                 Wait(5000)
-- --                 SetVehicleEngineHealth(veh,0.0)
-- --                 local soundId3 = GetSoundId()
-- --                 PlaySoundFrontend(soundId3,"Engine_fail", "DLC_PILOT_ENGINE_FAILURE_SOUNDS", true)
-- --             end
-- --         end
-- --         Wait(300)
-- --     end
-- -- end)



-- CreateThread(function()
--     while true do
--         local playerPed = PlayerPedId()
--         if IsPedInAnyVehicle(playerPed, false) then
--             local veh = GetVehiclePedIsIn(playerPed, false)
--             SetVehicleDamageModifier(veh,2.0)
--             local engin = GetVehicleEngineHealth(veh)
--             local body = GetVehicleBodyHealth(veh)
--             local clasee = GetVehicleClass(veh)
--             local egene = engin + body
--             local Statut = math.round(egene/2 / 10)
--             SetDisableVehicleEngineFires(true)
--             if engin > 1 and engin < 500 then
--                 -- --print("Je check Moteur")
--                 -- ESX.ShowNotification("~g~[Tableau de bord]~s~ le moteur du véhicule est ~o~fortement endommagé")
--                 -- PlaySoundFrontend(-1,"Timer_10s", "GTAO_FM_Events_Soundset", true)
--                 -- Wait(20000) -------
--                 -- ESX.ShowNotification("~g~[Tableau de bord]~s~ le moteur du véhicule est en ~y~état critique")
--                 -- local soundId2 = GetSoundId()
--                 -- PlaySoundFrontend(soundId2,"Tank_Critical_Damage_Loop", "dlc_vw_am_ip_tank_sounds", true)
--                 -- Wait(20000) -------
--                 -- StopSound(soundId2)
--                 -- ReleaseSoundId(soundId2)
--                 -- ESX.ShowNotification("~g~[Tableau de bord]~s~ Le moteur du véhicule est ~y~hors-service")
--                 -- local soundId3 = GetSoundId()
--                 -- PlaySoundFrontend(soundId3,"Engine_fail", "DLC_PILOT_ENGINE_FAILURE_SOUNDS", true)
--                 -- moteurdead = true 
--                 ESX.ShowNotification("Le moteur du véhicule est ~o~hors-service")
--                 local soundId3 = GetSoundId()
--                 PlaySoundFrontend(soundId3,"Engine_fail", "DLC_PILOT_ENGINE_FAILURE_SOUNDS", true)
--                 SetVehicleEngineHealth(veh,-4000.0)
--                 Wait(5000)
--                 SetVehicleEngineHealth(veh,0.0)
--             end
--             -- elseif Statut <= 55 and moteurdead == false then
--             --     print("Je check Satut")
--             --     ESX.ShowNotification("~g~[Tableau de bord]~s~ l'etat du véhicule est ~o~fortement endommagé")
--             --     PlaySoundFrontend(-1,"Timer_10s", "GTAO_FM_Events_Soundset", true)
--             --     Wait(20000) -------
--             --     ESX.ShowNotification("~g~[Tableau de bord]~s~ l'etat du véhicule est ~y~critique")
--             --     local soundId2 = GetSoundId()
--             --     PlaySoundFrontend(soundId2,"Tank_Critical_Damage_Loop", "dlc_vw_am_ip_tank_sounds", true)
--             --     Wait(20000) -------
--             --     StopSound(soundId2)
--             --     ReleaseSoundId(soundId2)
--             --     ESX.ShowNotification("~g~[Tableau de bord]~s~ le véhicule ~y~hors-service")
--             --     SetVehicleEngineHealth(veh,-4000.0)
--             --     Wait(5000)
--             --     SetVehicleEngineHealth(veh,0.0)
--             --     local soundId3 = GetSoundId()
--             --     PlaySoundFrontend(soundId3,"Engine_fail", "DLC_PILOT_ENGINE_FAILURE_SOUNDS", true)
--             --     genedead = true
--             -- end


--             if clasee == 15 or clasee == 16 then
--                 if IsVehicleTyreBurst(veh, 4) then
--                     SetEntityMaxSpeed(veh,6.94444)
--                 end
--             elseif clasee == 8 then
               
--                 if IsVehicleTyreBurst(veh, 0) and IsVehicleTyreBurst(veh, 4) then
--                     --print("2roue")
--                     SetEntityMaxSpeed(veh,0)
--                     --ESX.ShowNotification("~r~Vos 2 roues sont crevées vous ne pouvez plus avancer",nil,nil,nil,"Wise | Tableau de bord",nil,nil,0.0000001)
--                 elseif  IsVehicleTyreBurst(veh, 0)  or IsVehicleTyreBurst(veh, 4)   then
--                    -- print("1roue")
--                     SetEntityMaxSpeed(veh,6.94444)
--                 end

--             else
--                 -- if IsVehicleTyreBurst(veh, 0)  and IsVehicleTyreBurst(veh, 1) and IsVehicleTyreBurst(veh, 2) and IsVehicleTyreBurst(veh, 3) then
--                 --     SetEntityMaxSpeed(veh,0)
--                 -- end
--                 if IsVehicleTyreBurst(veh, 0) then
--                     rag = 25
--                 else
--                     rag = 0
--                 end
--                 if IsVehicleTyreBurst(veh, 1) then
--                     rad = 25 
--                 else
--                     rad = 0
--                 end
--                 if IsVehicleTyreBurst(veh, 4) then
--                     rarg = 25 
--                 else
--                     rarg = 0
--                 end
--                 if IsVehicleTyreBurst(veh, 5) then
--                     rard = 25
--                 else
--                     rard = 0
--                 end
--                 -- if rag + rad + rard + rarg == 100 then
--                 --     SetEntityMaxSpeed(veh,0)
--                 -- elseif rag + rad + rard + rarg == 75 then 
--                 --     SetEntityMaxSpeed(veh,6.00012)
--                 -- elseif rag + rad + rard + rarg == 50 then 
--                 --     SetEntityMaxSpeed(veh,11.1)
--                 -- elseif rag + rad + rard + rarg == 25 then 
--                 --     SetEntityMaxSpeed(veh,16.9)
--                 -- end
                
--                 if  rag + rad + rard + rarg >= 50 then
--                     SetVehicleEngineOn(veh,false,false,false)
--                 end

--                 --print(rag + rad +  rarg + rard)

--             end


--         end
--         Wait(300)
--     end
-- end)

-- RegisterCommand("carinfo", function()
--     dcartable()
-- end)
-- ---- tableau de bord ----

-- local dmcartable = RageUI.CreateMenu("", "Tableau de bord")
-- dmcartable.Closed = function()
--     open = false
-- end
-- function dcartable()
-- 	if open then
-- 		open = false
-- 		RageUI.Visible(dmcartable,false)
-- 		return 
-- 	else
-- 		open = true
-- 		RageUI.Visible(dmcartable,true)
-- 		CreateThread(function()
-- 			while open do 
--                 local ped = PlayerPedId()
--                 local veh = GetVehiclePedIsIn(ped, false)
--                 local clasee = GetVehicleClass(veh)
--                 local engin = GetVehicleEngineHealth(veh)
--                 local body = GetVehicleBodyHealth(veh)
--                 local egene = engin + body
--                 local showengin = math.floor(engin/10)
--                 local showbody = math.floor(body/10)
--                 local Statut = math.round(egene/2 / 10)
--                 local fuel = math.round(GetVehicleFuelLevel(veh))
--                 local km = math.ceil(GetEntitySpeed(veh) * 3.6)
--                 if veh ~= 0 then 
--                     if engin <= 700 and engin > 500 then 
--                         colore = "~y~"
--                     elseif engin <= 500 then
--                         colore = "~r~"
--                     else
--                         colore = "~g~"
--                     end
                    
--                     if body <= 700 and  body > 500 then 
--                         colorb = "~y~"
--                     elseif body <= 500 then
--                         colorb = "~r~"
--                     else
--                         colorb = "~g~"
--                     end

--                     if Statut < 70 and egene > 55 then
--                         coloreg = "~y~"
--                     elseif Statut <= 55 then
--                         coloreg = "~r~"
--                     end
--                     if fuel <= 30 then
--                         fuelc = "~y~"
--                     elseif fuel <= 15 then 
--                         fuelc ="~r~"
--                     end
--                     RageUI.IsVisible(dmcartable,function() 
--                         RageUI.Separator("Vitesse actuel du véhicule : "..km.."KM/H")
--                         RageUI.Separator("État du réservoir d'essence : "..fuelc..fuel.."L")
--                         RageUI.Separator("État du moteur : "..colore..showengin.."%")
--                         RageUI.Separator("État de la carrosserie : "..colorb..showbody.."%")
--                         RageUI.Separator("État général du véhicule : "..colorb..Statut.."%") 
--                         if clasee == 15 or clasee == 16 then
--                             if IsVehicleTyreBurst(veh, 4) then
--                                 RageUI.Separator("Roue Principale : ~r~ Non Fonctionnelle")
--                             else
--                                 RageUI.Separator("Roue Principale : ~g~ Fonctionnelle")
--                             end
--                         elseif clasee == 8 then
--                             if IsVehicleTyreBurst(veh, 0) then
--                                 RageUI.Separator("Roue avant : ~r~ Non Fonctionnelle")
--                             else
--                                 RageUI.Separator("Roue avant : ~g~ Fonctionnelle")
--                             end
--                             if IsVehicleTyreBurst(veh, 4) then
--                                 RageUI.Separator("Roue arrière : ~r~ Non Fonctionnelle")
--                             else
--                                 RageUI.Separator("Roue arrière : ~g~ Fonctionnelle")
--                             end
--                         else
--                             if IsVehicleTyreBurst(veh, 0) then
--                                 RageUI.Separator("Roue avant gauche : ~r~ Non Fonctionnelle")
--                             else
--                                 RageUI.Separator("Roue avant gauche : ~g~ Fonctionnelle")
--                             end
--                             if IsVehicleTyreBurst(veh, 1) then
--                                 RageUI.Separator("Roue avant droite : ~r~ Non Fonctionnelle")
--                             else
--                                 RageUI.Separator("Roue avant droite : ~g~ Fonctionnelle")
--                             end
--                             if IsVehicleTyreBurst(veh, 4) then
--                                 RageUI.Separator("Roue arrière gauche : ~r~ Non Fonctionnelle")
--                             else
--                                 RageUI.Separator("Roue arrière gauche : ~g~ Fonctionnelle")
--                             end
--                             if IsVehicleTyreBurst(veh, 5) then
--                                 RageUI.Separator("Roue arrière droite : ~r~ Non Fonctionnelle")
--                             else
--                                 RageUI.Separator("Roue arrière droite : ~g~ Fonctionnelle")
--                             end
--                         end

--                     end)
--                 else
--                     ESX.ShowNotification("~r~Vous n'êtes pas dans un véhicule.")
--                     return
--                 end
-- 				Wait(1)
-- 			end
-- 		end)
-- 	end
-- end