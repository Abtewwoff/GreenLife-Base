local incambriolage = false
local player = PlayerPedId()
local coords = GetEntityCoords(PlayerPedId())
local tableau = false
local tele = false
local pc = false
local vase = false
local enceinte = false
local bijoux = false
local stopalerte = false
local maison
local GetBlips = true
local Getpnjventeur = false



---------------------------------
-- Obtient la bibliothèque ESX --
---------------------------------

ESX = nil 
Config.ESX_GetCoreObject_client()

---------------------------------
---------- Entrer  --------------
---------------------------------

Citizen.CreateThread(function()
    while true do
        Wait(3)
        if incambriolage == false then
            for k, v in pairs(Config.marker) do
                local coords = GetEntityCoords(PlayerPedId())
                if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0 then
                    DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 0.0, 0.0, 0, 0, 1, 2, 0, nil, nil, 0)
                    AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour ouvrir le menu de cambriolage")
                    DisplayHelpTextThisFrame("HELP", true)
                    if IsControlJustPressed(1, 51) then
                        MenuCambriolage(k) -- Passer l'ID du marker au menu de cambriolage
                    end
                end
            end
        end
    end
end)

local cooldawn = false
local mainMenu = RageUI.CreateMenu('', 'Cambriolage')

local cooldown = false
local cooldownTime = 3600000  -- 1h

function MenuCambriolage(markerId)
    if open then 
        open = false
        RageUI.Visible(mainMenu, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(mainMenu, function() 
                    RageUI.Separator("↓ Cambrioler ↓")
                    RageUI.Separator("")
                    local rightLabel = "" -- Définir rightLabel ici pour éviter l'erreur de valeur nil
                    if cooldown then
                        rightLabel = rightLabel .. " ~r~🔒"
                    end
                    RageUI.Button("Cambrioler le lieu", nil, {RightLabel = rightLabel}, not cooldown, {
                        onSelected = function()
                            if not cooldown then
                                cooldown = true
                                lastPurchaseTime = GetGameTimer()
                                SetTimeout(cooldownTime, function() cooldown = false end)
                                StartCambriolage(markerId) -- Passer markerId à la fonction StartCambriolage
                            else
                                local remainingTime = math.ceil((cooldownTime - (GetGameTimer() - lastPurchaseTime)) / 1000)
                                ESX.ShowNotification('Vous devez attendre ' .. remainingTime .. ' secondes avant de pouvoir acheter une autre arme.')
                            end
                        end
                    })
                end)
                Wait(3)
            end
        end)
    end
end


function StartCambriolage(markerId)
    local v = Config.marker[markerId]
    if v then
        ESX.TriggerServerCallback('esx_cambriolage:getflicnombre', function(flic)
            if flic >= Config.flic then
                maison = v.id
                incambriolage = true

                -- Joueur effectue l'entrée
                local playerPed = PlayerPedId()
                TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
                exports["rprogress"]:Start(Config.entrer)
                Wait(Config.entrer * 1000)
                exports["rprogress"]:Stop()

                -- Téléportation dans la maison
                if v.type == "luxe" then
                    SetEntityCoords(PlayerPedId(), -682.33, 592.34, 145.39, false, false, false, true)
                elseif v.type == "basic" then
                    SetEntityCoords(PlayerPedId(), 265.59, -1002.84, -99.01, false, false, false, true)
                end

                -- Attente de 5 secondes après l'entrée
                Wait(5000)

                -- Déclenchement de l'alerte après 5 secondes
                TriggerServerEvent('esx_cambriolage:createblip', maison)
                ESX.ShowNotification("Faite vite et attention aux empreintes", "error", 5000)
            else
                ESX.ShowNotification("Il n'y a pas assez de policiers en ville", "error", 5000)
            end
        end)
    else
        print("Marker non trouvé avec l'ID: " .. markerId)
    end
end

---------------------------------
---------- Entrer  --------------
---------------------------------

---------------------------------
------ Prendre l'objet ----------
---------------------------------
Citizen.CreateThread(function()
   while true do
       Wait(3)
       local coords = GetEntityCoords(PlayerPedId())
            if incambriolage == true then
               for k,v in pairs(Config.objet) do
                    if v.item =="tableau" and tableau == true and v.type == "luxe" then
                        if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15.0) then
							DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
                            if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then 
								AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour ~g~prendre le tableau.")
								DisplayHelpTextThisFrame("HELP", true)
                                if IsControlJustPressed(1, 51) then                  
                                     action(v.item)
                                    tableau = false
                                end   
                            end
                        end
                     end
                    if v.item =="tableau" and tableau == true and v.type == "basic" then
                        if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15.0) then
							DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
                            if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then 
								AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour ~g~prendre le tableau.")
								DisplayHelpTextThisFrame("HELP", true)
                                if IsControlJustPressed(1, 51) then                  
                                    action(v.item)
                                    tableau = false
                                end   
                            end
                        end
                    end

					if v.item =="tele" and tele == true and v.type == "luxe" then
						if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15.0) then
							DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then 
								AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour ~g~prendre la télé.")
								DisplayHelpTextThisFrame("HELP", true)
								if IsControlJustPressed(1, 51) then 
									action(v.item)
									tele = false
							   
								end   
							end
						end
					end
					if v.item =="tele" and tele == true and v.type == "basic" then
						if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15.0) then
							DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then 
								AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour ~g~prendre la télé.")
								DisplayHelpTextThisFrame("HELP", true)
								if IsControlJustPressed(1, 51) then 
									action(v.item)
									tele = false
							   
								 end   
							end
						end
				    end
					if v.item =="pc" and pc == true then
						if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15.0) then
							DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then 
								AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour ~g~prendre le pc portable")
								DisplayHelpTextThisFrame("HELP", true)
								if IsControlJustPressed(1, 51) then 
									action(v.item)
									pc = false				
								end   
							end
						end
				    end
					if v.item =="enceinte" and enceinte == true and v.type == "luxe" then
						if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15.0) then
							DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then 
								AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour ~g~prendre l'enceinte")
								DisplayHelpTextThisFrame("HELP", true)
								if IsControlJustPressed(1, 51) then 
									action(v.item)
									enceinte = false                       
								end   
							end
						end
				    end
					if v.item =="enceinte" and enceinte == true and v.type == "basic" then
						if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15.0) then
							DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then 
								AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour ~g~prendre l'enceinte")
								DisplayHelpTextThisFrame("HELP", true)
								if IsControlJustPressed(1, 51) then 
									action(v.item)
									enceinte = false                       
								end   
							 end
						end
				    end
					if v.item =="vase" and vase == true then
						if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15.0) then
							DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then 
								AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour ~g~prendre le vase")
								DisplayHelpTextThisFrame("HELP", true)
								if IsControlJustPressed(1, 51) then 
									action(v.item)
									vase = false                          
								end   
							end
						end
				    end
				   if v.item =="bijoux" and bijoux == true and v.type == "luxe" then
						if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15.0) then
							DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then 
								AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour ~g~prendre les bijoux")
								DisplayHelpTextThisFrame("HELP", true)
								if IsControlJustPressed(1, 51) then 
									action(v.item)
									bijoux = false                        
							
								end   
						    end
					    end
				    end
				   if v.item =="bijoux" and bijoux == true and v.type == "basic" then
						if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 15.0) then
							DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then 
								AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour ~g~prendre les bijoux")
								DisplayHelpTextThisFrame("HELP", true)
								if IsControlJustPressed(1, 51) then 
									action(v.item)
									bijoux = false                        
							
								end   
							end
						end
				   end
            end
        end 
    end
end) 
---------------------------------
------ Prendre l'objet ----------
---------------------------------

---------------------------------
------- Function d'objet --------
---------------------------------
function action(item)
local player = PlayerPedId()
	if item == "tableau" then
		local playerPed = PlayerPedId()
TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
		exports["rprogress"]:Start(Config.tempstableau)
		Wait(Config.tempstableau * 1000)
		exports["rprogress"]:Stop()
		ClearPedTasksImmediately(player)
       
	end
	if item == "tele" then
		local playerPed = PlayerPedId()
TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
		exports["rprogress"]:Start(Config.tempstele)
		Wait(Config.tempstele * 1000)
		exports["rprogress"]:Stop()
		ClearPedTasksImmediately(player)
       
	end
	if item == "pc" then
		local playerPed = PlayerPedId()
TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
		exports["rprogress"]:Start(Config.tempspc)
		Wait(Config.tempspc * 1000)
		exports["rprogress"]:Stop()
		ClearPedTasksImmediately(player)
      
	end
	if item == "enceinte" then
		local playerPed = PlayerPedId()
TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
		exports["rprogress"]:Start(Config.tempsenceinte)
		Wait(Config.tempsenceinte * 1000)
		exports["rprogress"]:Stop()
		ClearPedTasksImmediately(player)
      
	end
	if item == "vase" then
		local playerPed = PlayerPedId()
TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
		exports["rprogress"]:Start(Config.tempsvase)
		Wait(Config.tempsvase * 1000)
		exports["rprogress"]:Stop()
		ClearPedTasksImmediately(player)
      
	end
	if item == "bijoux" then
		local playerPed = PlayerPedId()
TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
		exports["rprogress"]:Start(Config.tempsbijoux)
		Wait(Config.tempsbijoux * 1000)
		exports["rprogress"]:Stop()
		ClearPedTasksImmediately(player)


	end
   TriggerServerEvent('esx_cambriolage:giveitem',item)   
end
---------------------------------
------- Function d'objet --------
---------------------------------


---------------------------------
---------- Sortie ---------------
---------------------------------
Citizen.CreateThread(function()
    while true do
      Wait(3)
      local coords = GetEntityCoords(PlayerPedId())
        if incambriolage == true then
			for k,v in pairs(Config.sortie) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then
					DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
					AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ pour~g~ sortir de la maison")
					DisplayHelpTextThisFrame("HELP", false)
					if IsControlJustPressed(1, 51) then   
						for k,v in pairs(Config.marker) do 
						if maison == v.id then		
						SetEntityCoords(PlayerPedId(),v.Pos.x, v.Pos.y, v.Pos.z, false, false, false, true)
						end
						Wait(3)
						incambriolage = false
						tableau = false
						tele = false
						pc = false
						vase = false
						enceinte = false
						bijoux = false
						stopalerte = false
						end
					end
				end
			end
		end
    end
end)


---------------------------------
---------- Sortie ---------------
---------------------------------


---------------------------------
-------- alerte police ----------
---------------------------------


RegisterNetEvent('esx_cambriolage:blip')
AddEventHandler('esx_cambriolage:blip', function(maison)
    local blip = nil

    for k, v in pairs(Config.marker) do
        if maison == v.id then
            blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite(blip, 161)
            SetBlipScale(blip, 2.0)
            SetBlipColour(blip, 3)
            PulseBlip(blip)

            -- Suppression automatique après `Config.tempsalerte`
            Wait(Config.tempsalerte * 1000)
            RemoveBlip(blip)
        end
    end
end)

---------------------------------
-------- alerte police ----------
---------------------------------


---------------------------------
--------- Option blips ----------
---------------------------------
function addblip()
ESX.TriggerServerCallback('esx_cambriolage:GetGroup', function(groupejoueur)
        if groupejoueur ~= nil and (groupejoueur == 'admin') or (groupejoueur == 'superadmin') then
			for k,v in pairs(Config.blipscarte) do
				v.name = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
				SetBlipSprite(v.name , 186)
				SetBlipScale(v.name , 1.0)
				SetBlipAsShortRange(v.name, true)
				SetBlipColour(v.name, 5)
				PulseBlip(v.name)
				BeginTextCommandSetBlipName("[Illégal] cambriolage")
				AddTextEntry("cambriolage", "Cambriolage")
				EndTextCommandSetBlipName(v.name)
			end
		else
            ESX.ShowNotification('Vous avez pas le droit')
        end
    end)
end
local fois = 0 
function addblip2()

if fois == 0 then
			for k,v in pairs(Config.blipscarte) do
				v.name = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
				SetBlipSprite(v.name , 186)
				SetBlipScale(v.name , 1.0)
				SetBlipAsShortRange(v.name, true)
				SetBlipColour(v.name, 5)
				PulseBlip(v.name)
				BeginTextCommandSetBlipName("cambriolage")
				AddTextEntry("cambriolage", "Cambriolage")
				EndTextCommandSetBlipName(v.name)
			end
			fois = fois + 1
			end
		
end
--[ 186 763 ] Voici deux style de blip qui peut bien allez avec ce script.
function removeblip()
	for k,v in pairs(Config.blipscarte) do
		RemoveBlip(v.name)
	end
end

RegisterCommand(Config.Command, function()
    ESX.TriggerServerCallback('esx_cambriolage:GetGroup', function(groupejoueur)
        if groupejoueur ~= nil and (groupejoueur == 'admin') or (groupejoueur == 'superadmin') then
            if GetBlips == false then
				addblip()
                GetBlips = true
            else
				removeblip()
                GetBlips = false
            end
        else
            ESX.ShowNotification('Vous avez pas le droit')
        end
    end)
end)

---------------------------------
--------- Option blips ----------
---------------------------------

---------------------------------
------- option makers  ----------
---------------------------------

Citizen.CreateThread(function()
while true do
		Wait(3)
	if cartemakers == true then
		
		local coords = GetEntityCoords(PlayerPedId())
			for k,v in pairs(Config.marker) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0) then
					DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.0, 255.0, 0.0, 170, 0, 1, 2, 0, nil, nil, 0)
				end
			end
		
	end
	 if GetBlips == true then
				addblip2()
               
           
            end
			end
end)

---------------------------------
------- option makers  ----------
---------------------------------

---------------------------------
---------- Menu vente -----------
---------------------------------


local Menuvente = {
    Base = { Title = "menu revente", HeaderColor = {93, 194, 39} },
    Data = { currentMenu = "~r~Choisi ton objet que tu veux revendre" },
    Events = {
        onSelected = function(self, _, btn, JMenu, menuData, currentButton, currentSlt, result)
            
            if btn.name == "Tableau" then
				TriggerServerEvent('esx_cambriolage:Tableau', function()
                end)

            elseif btn.name == "Télé" then
                TriggerServerEvent('esx_cambriolage:Télé', function()
                end)

            elseif btn.name == "Pc" then
               TriggerServerEvent('esx_cambriolage:Pc', function()
                end)

            elseif btn.name == "Vase" then
               TriggerServerEvent('esx_cambriolage:Vase', function()
                end)

            elseif btn.name == "Enceinte" then
               TriggerServerEvent('esx_cambriolage:Enceinte', function()
                end)

            elseif btn.name == "Bijoux" then
               TriggerServerEvent('esx_cambriolage:Bijoux', function()
                end)             
            end
        end
      
    },

    Menu = {
        ["~r~Choisi ton objet que tu veux revendre"] = {
            b = {
                {name = "Tableau", ask = "", askX = true},
                {name = "Télé", ask = "", askX = true},
                {name = "Pc", ask = "", askX = true},
                {name = "Vase", ask = "", askX = true},
                {name = "Enceinte", ask = "", askX = true},
                {name = "Bijoux", ask = "", askX = true},           
            }
        },
    }
}
---------------------------------
---------- Menu vente -----------
---------------------------------

---------------------------------
--------- PED VENDEUR -----------
---------------------------------
if Config.default_pnj_revente then

_RequestModel = function(hash)
		if type(hash) == "string" then hash = GetHashKey(hash) end
			RequestModel(hash)
		while not HasModelLoaded(hash) do
			Wait(3)
		end
	end


Citizen.CreateThread(function()
		local defaultHash = 416176080
		for k,v in pairs(Config.vente) do
			v.hash = v.hash or defaultHash
			_RequestModel(v.hash)
			if not DoesEntityExist(v.entity) then
				v.entity = CreatePed(4, v.hash, v.Pos.x, v.Pos.y, v.Pos.z, v.Pos.h)
				SetEntityAsMissionEntity(v.entity)
				SetBlockingOfNonTemporaryEvents(v.entity, true)
				FreezeEntityPosition(v.entity, true)
				SetEntityInvincible(v.entity, true)
			end
			SetModelAsNoLongerNeeded(v.hash)
		end
	end)


   
end
CreateThread(function()
	while true do
		if Config.default_pnj_revente == true then
			timer2 = 0
			for k,v in pairs(Config.vente) do
				if(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Pos.x, v.Pos.y, v.Pos.z, v.Pos.h, true) < 2.0) then
					AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour~g~ ouvrir le menu")
					DisplayHelpTextThisFrame("HELP", true)
					if IsControlJustPressed(1, 51) then
						CreateMenu(Menuvente)
					end   
				end
			end
		else
			timer2 = 500
		end
		Wait(timer2)
	end
end)
function addpnjventeur()
	Citizen.CreateThread(function()
		while true do
		Wait(3)
			for k,v in pairs(Config.vente) do
		
				if(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Pos.x, v.Pos.y, v.Pos.z, v.Pos.h, true) < 2.0) then
					if Getpnjventeur == true then
						AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~ pour~g~ ouvrir le menu")
						DisplayHelpTextThisFrame("HELP", true)
						if IsControlJustPressed(1, 51) then
							CreateMenu(Menuvente)
						end   
					end
				end
			end
		end
	end)  

	--[[ Demande le modèle spécifié ]]--
	_RequestModel = function(hash)
		if type(hash) == "string" then hash = GetHashKey(hash) end
			RequestModel(hash)
		while not HasModelLoaded(hash) do
			Wait(3)
		end
	end

	--[[ Supprime les caissiers ]]--
	Deletepnjventeur = function()
		for k,v in pairs(Config.vente) do
			if DoesEntityExist(v.entity) then
				DeletePed(v.entity)
				SetPedAsNoLongerNeeded(v.entity)
			end
		end
	end

	--[[Ajout du ped ]]--
	Citizen.CreateThread(function()
		local defaultHash = 416176080
		for k,v in pairs(Config.vente) do
			v.hash = v.hash or defaultHash
			_RequestModel(v.hash)
			if not DoesEntityExist(v.entity) then
				v.entity = CreatePed(4, v.hash, v.Pos.x, v.Pos.y, v.Pos.z, v.Pos.h)
				SetEntityAsMissionEntity(v.entity)
				SetBlockingOfNonTemporaryEvents(v.entity, true)
				FreezeEntityPosition(v.entity, true)
				SetEntityInvincible(v.entity, true)
			end
			SetModelAsNoLongerNeeded(v.hash)
		end
	end)

	--[[ Supprime les peds lorsque la ressource s'arrête ]]--
	AddEventHandler('onResourceStop', function(resourceName)
		if resourceName == GetCurrentResourceName() then
			TriggerServerEvent('esx:clientLog', "[esx_cambriolage]: Deleting peds...")
			Deletepnjventeur()
		end
	end)
	
	
end

function removepnjventeur()
	for k,v in pairs(Config.blipscarte) do
		Deletepnjventeur()
	end
end

RegisterCommand(Config.Commandpnjventeur, function()
    ESX.TriggerServerCallback('esx_cambriolage:GetGroup', function(groupejoueur)
        if groupejoueur ~= nil and (groupejoueur == 'admin') or (groupejoueur == 'superadmin') then
            if Getpnjventeur == false then
				addpnjventeur()
                Getpnjventeur = true
            else
				removepnjventeur()
                Getpnjventeur = false
            end
        else
            ESX.ShowNotification('Vous avez pas le droit')
        end
    end)
end)
---------------------------------
--------- PED VENDEUR -----------
---------------------------------