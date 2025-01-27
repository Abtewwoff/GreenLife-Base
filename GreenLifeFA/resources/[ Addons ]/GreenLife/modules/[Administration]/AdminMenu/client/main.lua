sAdmin.AdminList = {}
sAdmin.PlayersList = {}
sAdmin.ReportList = {}


sAdmin.inService = false
local IsInStaffMode = false

function Visual.Subtitle(text, time)
    ClearPrints()
    BeginTextCommandprint("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandprint(time and math.ceil(time) or 0, true)
end

sAdmin.Print = function(str) 
    print(sAdmin.Config.Print.DefaultPrefix.." "..str)
end

sAdmin.Debug = function(str) 
    print(sAdmin.Config.Print.DebugPrefix.." "..str)
end


sAdmin.PlayerMakrer = function(player)
    local ped = GetPlayerPed(player)
    local pos = GetEntityCoords(ped)
    DrawMarker(6, pos.x, pos.y, pos.z - 0.98, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 255, 255, 200, false, false, nil, false, false, false, false)
    DrawMarker(1, pos.x, pos.y, pos.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.3,255, 255, 255, 200, false, false, nil, false, false, false, false)

end

sAdmin.ClosetVehWithDisplay = function()
    local veh = GetClosestVehicleAdmin(GetEntityCoords(PlayerPedId()), nil)
    local vCoords = GetEntityCoords(veh)
    DrawMarker(6, vCoords.x, vCoords.y, vCoords.z - 0.98, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 255, 255, 200, false, false, nil, false, false, false, false)
    DrawMarker(1, vCoords.x, vCoords.y, vCoords.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.3,255, 255, 255, 200, false, false, nil, false, false, false, false)

end

Citizen.CreateThread(function()
    Wait(5000)
    TriggerServerEvent("sAdmin:IsAdmin")
end)

RegisterNetEvent('sAdmin:GetReports')
AddEventHandler('sAdmin:GetReports', function(data)
    sAdmin.ReportList = data
end)

RegisterNetEvent('sAdmin:UpdateReportsList')
AddEventHandler('sAdmin:UpdateReportsList', function(newReportList)
    sAdmin.ReportList = newReportList
end)

RegisterNetEvent('sAdmin:UpdateNumberReport')
AddEventHandler('sAdmin:UpdateNumberReport', function(newReportsCount)
    sAdmin.AdminList[GetPlayerServerId(PlayerId())].reportEffectued = newReportsCount
end)

RegisterNetEvent('sAdmin:NewAdmin')
AddEventHandler('sAdmin:NewAdmin', function(data)
    sAdmin.AdminList[data.source] = data
end)

RegisterNetEvent('sAdmin:UpdateAdminGroup')
AddEventHandler('sAdmin:UpdateAdminGroup', function(_source, newGroupe)
    if sAdmin.AdminList[_source] then 
        sAdmin.AdminList[_source].grade = newGroupe
    end
end)

RegisterNetEvent('sAdmin:RemoveAdmin')
AddEventHandler('sAdmin:RemoveAdmin', function(adminId)
    sAdmin.AdminList[adminId] = nil
end)

RegisterNetEvent('sAdmin:UpdateAvis')
AddEventHandler('sAdmin:UpdateAvis', function(staffId, eval)
    sAdmin.AdminList[staffId].appreciation = eval
end)

RegisterNetEvent('sAdmin:GetPlayerList')
AddEventHandler('sAdmin:GetPlayerList', function(playerList)
    sAdmin.PlayersList = playerList
end)

RegisterNetEvent('sAdmin:NewPlayerList')
AddEventHandler('sAdmin:NewPlayerList', function(playerId, data)
    sAdmin.PlayersList[playerId] = data
end)

RegisterNetEvent('sAdmin:RemovePlayerList')
AddEventHandler('sAdmin:RemovePlayerList', function(playerId)
    sAdmin.PlayersList[playerId] = nil
end)



RegisterNetEvent("sAdmin:Tp")
AddEventHandler("sAdmin:Tp", function(coords, noClip)
    if noClip then 
        if not inNoclip then
            inNoclip = true
            ToogleNoClip()
        end
    end
    local pPed = PlayerPedId()
    playerCoordsX, playerCoordsY, playerCoordsZ = table.unpack(GetEntityCoords(pPed))
    SetEntityCoords(pPed, coords, false, false, false, false)
end)

RegisterNetEvent("sAdmin:TpBack")
AddEventHandler("sAdmin:TpBack", function(coords, noClip)
    if noClip then 
        if not inNoclip then
            inNoclip = true
            ToogleNoClip()
        end
    end
    local pPed = PlayerPedId()
    playerCoordsX, playerCoordsY, playerCoordsZ = table.unpack(GetEntityCoords(pPed))
    SetEntityCoords(pPed, coords, false, false, false, false)
end)

RegisterNetEvent("sAdmin:BringBack")
AddEventHandler("sAdmin:BringBack", function()
    local pPed = PlayerPedId()
    SetEntityCoordsNoOffset(PlayerPedId(), playerCoordsX, playerCoordsY, playerCoordsZ, 0.0, 0.0, 0.0, true)
end)


RegisterNetEvent('Console:Tppc')
AddEventHandler('Console:Tppc', function(players)
    local players = PlayerPedId()
    SetEntityCoords(players, vector3(213.65, -809.03, 31.01), false, false, false, false)
end)

RegisterNetEvent("sAdmin:TpParking")
AddEventHandler("sAdmin:TpParking", function()
    local pPed = PlayerPedId()
    SetEntityCoords(pPed, vector3(213.65, -809.03, 31.01), false, false, false, false)
end)

IsFrozen = false
RegisterNetEvent("sAdmin:FreezePlayer")
AddEventHandler("sAdmin:FreezePlayer", function()
    local pPed = PlayerPedId()
    if not IsFrozen then 
        FreezeEntityPosition(pPed, true)
        IsFrozen = true 
    elseif IsFrozen then 
        FreezeEntityPosition(pPed, false)
        IsFrozen = false
    end
end)

RegisterNetEvent("sAdmin:ShowInventory")
AddEventHandler("sAdmin:ShowInventory", function(inventory, account, weapons)
    Menu.PlayerInventory = inventory
    Menu.PlayerAccounts = account
    Menu.PlayersWeapons = weapons
end)


RegisterNetEvent("sAdmin:setCoords")
AddEventHandler("sAdmin:setCoords", function(coords)
    SetEntityCoords(PlayerPedId(), coords, false, false, false, false)
end)
local HereShowBlips = false

function showBlipsF(bool)
    HereShowBlips = bool
end

CreateThread(function()
	while true do
        local blipstimerr = 1000
		if HereShowBlips then
            local blipstimerr = 1
			for _, player in pairs(GetActivePlayers()) do
				local found = false
				if player ~= PlayerId() then
					local ped = GetPlayerPed(player)
					local blip = GetBlipFromEntity( ped )
					if not DoesBlipExist( blip ) then
						blip = AddBlipForEntity(ped)
						SetBlipCategory(blip, 7)
						SetBlipScale( blip,  0.85 )
						ShowHeadingIndicatorOnBlip(blip, true)
						SetBlipSprite(blip, 1)
						SetBlipColour(blip, 0)
					end

					SetBlipNameToPlayerName(blip, player)

					local veh = GetVehiclePedIsIn(ped, false)
					local blipSprite = GetBlipSprite(blip)

					if IsEntityDead(ped) then
						if blipSprite ~= 303 then
							SetBlipSprite( blip, 303 )
							SetBlipColour(blip, 1)
							ShowHeadingIndicatorOnBlip( blip, false )
						end
					elseif veh ~= nil then
						if IsPedInAnyBoat( ped ) then
							if blipSprite ~= 427 then
								SetBlipSprite( blip, 427 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						elseif IsPedInAnyHeli( ped ) then
							if blipSprite ~= 43 then
								SetBlipSprite( blip, 43 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						elseif IsPedInAnyPlane( ped ) then
							if blipSprite ~= 423 then
								SetBlipSprite( blip, 423 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						elseif IsPedInAnyPoliceVehicle( ped ) then
							if blipSprite ~= 137 then
								SetBlipSprite( blip, 137 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						elseif IsPedInAnySub( ped ) then
							if blipSprite ~= 308 then
								SetBlipSprite( blip, 308 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						elseif IsPedInAnyVehicle( ped ) then
							if blipSprite ~= 225 then
								SetBlipSprite( blip, 225 )
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, false )
							end
						else
							if blipSprite ~= 1 then
								SetBlipSprite(blip, 1)
								SetBlipColour(blip, 0)
								ShowHeadingIndicatorOnBlip( blip, true )
							end
						end
					else
						if blipSprite ~= 1 then
							SetBlipSprite( blip, 1 )
							SetBlipColour(blip, 0)
							ShowHeadingIndicatorOnBlip( blip, true )
						end
					end
					if veh then
						SetBlipRotation( blip, math.ceil( GetEntityHeading( veh ) ) )
					else
						SetBlipRotation( blip, math.ceil( GetEntityHeading( ped ) ) )
					end
				end
			end
		else
			for _, player in pairs(GetActivePlayers()) do
				local blip = GetBlipFromEntity( GetPlayerPed(player) )
				if blip ~= nil then
					RemoveBlip(blip)
				end
			end
		end
        Wait(blipstimerr)
	end
end)

function SizeOfPlayersList()
    local count = 0
    for k,v in pairs(sAdmin.PlayersList) do 
        count = count + 1
    end
    return count
end

function SizeOfStaffListe()
    if ESX.GetPlayerData()['group'] ~= "user" then
        local count = 0
        for k,v in pairs(sAdmin.PlayersList) do 
            count = count + 1
        end
        return count
    end
end

entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end

        enum.destructor = nil
        enum.handle = nil
    end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = { handle = iter, destructor = disposeFunc }
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function GetVehicles()
    local vehicles = {}

    for vehicle in EnumerateVehicles() do
        table.insert(vehicles, vehicle)
    end

    return vehicles
end

function GetClosestVehicleAdmin(coords)
    local vehicles = GetVehicles()
    local closestDistance = -1
    local closestVehicle = -1
    local coords = coords

    if coords == nil then
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end

    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end

    return closestVehicle, closestDistance
end

RegisterCommand("+noclip", function()
    local pPed = PlayerId()
    local pId = GetPlayerServerId(pPed)
    
    for k,v in pairs(sAdmin.AdminList) do 
        if k == pId then 
            if v.inService then 
                if inNoclip then
                    inNoclip = false
                    ToogleNoClip()
                    ESX.ShowNotification("🚫 ~g~Administration~s~\nMode noclip désactivé")
                else 
                    inNoclip = true
                    ToogleNoClip()
                    ESX.ShowNotification("✈️ ~g~Administration~s~\nMode noclip activé")
                end
            end
            return
        end
    end 
end, false)

RegisterNetEvent("sAdmin:BringBack")
AddEventHandler("sAdmin:BringBack", function()
    local pPed = PlayerPedId()
    SetEntityCoordsNoOffset(PlayerPedId(), playerCoordsX, playerCoordsY, playerCoordsZ, 0.0, 0.0, 0.0, true)
end)

RegisterKeyMapping("+noclip", "Noclip", 'keyboard', sAdmin.Config.KeyNoclip)

RegisterCommand("reload", function()
    TriggerServerEvent("sAdmin:IsAdmin")
end)

RegisterCommand("ppos", function()
    local pCoords = GetEntityCoords(PlayerPedId());
    local pHeading = GetEntityHeading(PlayerPedId());
end)

local gamerTags = {}
function showNames(bool)
    isNameShown = bool
    if isNameShown then
        CreateThread(function()
            while isNameShown do
                local plyPed = PlayerPedId()
                for k, v in pairs(GetActivePlayers()) do
                    local PlayerServerId, PlayerPed = GetPlayerServerId(v), GetPlayerPed(v)
                    local playerData = ESX.PlayerData
                    local playerJob = (playerData and playerData.job and playerData.job.label) or "Unknown"
                    local playerGrade = (playerData and playerData.job and playerData.job.grade_label) or ""

                    if #(GetEntityCoords(plyPed, false) - GetEntityCoords(PlayerPed, false)) < 5000.0 then
                        gamerTags[PlayerPed] = CreateFakeMpGamerTag(
                            GetPlayerPed(v),
                            ('(%s) - %s | %s - %s'):format(GetPlayerServerId(v), GetPlayerName(v), playerJob, playerGrade),
                            false, false, '', 0
                        )
                        
                        SetMpGamerTagAlpha(gamerTags[PlayerPed], 0, 255)
                        SetMpGamerTagAlpha(gamerTags[PlayerPed], 2, 255)
                        SetMpGamerTagAlpha(gamerTags[PlayerPed], 4, 255)
                        SetMpGamerTagVisibility(gamerTags[PlayerPed], 0, true)  -- Affiche le pseudo
                        SetMpGamerTagVisibility(gamerTags[PlayerPed], 2, true)  -- Affiche le gamertag

                        -- Afficher ou masquer l'icône de voix selon si le joueur parle
                        if NetworkIsPlayerTalking(v) then
                            SetMpGamerTagColour(gamerTags[PlayerPed], 0, 19)  -- Pseudo en violet
                            SetMpGamerTagColour(gamerTags[PlayerPed], 4, 19)  -- Icône de voix en violet
                            SetMpGamerTagVisibility(gamerTags[PlayerPed], 4, true)  -- Affiche l'icône de voix
                        else
                            SetMpGamerTagColour(gamerTags[PlayerPed], 0, 1)  -- Pseudo en blanc
                            SetMpGamerTagVisibility(gamerTags[PlayerPed], 4, false)  -- Masque l'icône de voix
                        end
                    else
                        RemoveMpGamerTag(gamerTags[PlayerPed])
                        gamerTags[PlayerPed] = nil
                    end
                end
                Wait(25)
            end
            
            for k, v in pairs(gamerTags) do
                RemoveMpGamerTag(v)
            end
            gamerTags = {}
        end)
    end
end


-- local gamerTags = {}
-- function showNames(bool)
--     isNameShown = bool
--     if isNameShown then
--         Citizen.CreateThread(function()
--             while isNameShown do
--                 local plyPed = PlayerPedId()
--                 for _, player in pairs(GetActivePlayers()) do
--                     local ped = GetPlayerPed(player)
--                     if ped ~= plyPed then
--                         if #(GetEntityCoords(plyPed, false) - GetEntityCoords(ped, false)) < 5000.0 then
--                             gamerTags[player] = CreateFakeMpGamerTag(ped, ('[%s] %s'):format(GetPlayerServerId(player), GetPlayerName(player)), false, false, '', 0)
--                             SetMpGamerTagAlpha(gamerTags[player], 0, 255)
--                             SetMpGamerTagAlpha(gamerTags[player], 2, 255)
--                             SetMpGamerTagAlpha(gamerTags[player], 4, 255)
--                             SetMpGamerTagAlpha(gamerTags[player], 7, 255)
--                             SetMpGamerTagVisibility(gamerTags[player], 0, true)
--                             SetMpGamerTagVisibility(gamerTags[player], 2, true)
--                             SetMpGamerTagVisibility(gamerTags[player], 4, NetworkIsPlayerTalking(player))
--                             SetMpGamerTagVisibility(gamerTags[player], 7, DecorExistOn(ped, "staffl") and DecorGetInt(ped, "staffl") > 0)
--                             SetMpGamerTagColour(gamerTags[player], 7, 55)
--                             if NetworkIsPlayerTalking(player) then
--                                 SetMpGamerTagHealthBarColour(gamerTags[player], 211)
--                                 SetMpGamerTagColour(gamerTags[player], 4, 211)
--                                 SetMpGamerTagColour(gamerTags[player], 0, 211)
--                             else
--                                 SetMpGamerTagHealthBarColour(gamerTags[player], 0)
--                                 SetMpGamerTagColour(gamerTags[player], 4, 0)
--                                 SetMpGamerTagColour(gamerTags[player], 0, 0)
--                             end
--                             if DecorExistOn(ped, "staffl") then
--                                 SetMpGamerTagWantedLevel(ped, DecorGetInt(ped, "staffl"))
--                             end
--                             if mpDebugMode then
--                                 print(json.encode(DecorExistOn(ped, "staffl")).." - "..json.encode(DecorGetInt(ped, "staffl")))
--                             end
--                         else
--                             RemoveMpGamerTag(gamerTags[player])
--                             gamerTags[player] = nil
--                         end
--                     end
--                 end
--                 Wait(100)
--             end
--             for k,v in pairs(gamerTags) do
--                 RemoveMpGamerTag(v)
--             end
--             gamerTags = {}
--         end)
--     end
-- end

RegisterNetEvent('sAdmin:changeStaffPed')
AddEventHandler('sAdmin:changeStaffPed', function(nVal)
    if nVal == "nValTrue" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            local isMale = skin.sex == 0
            if isMale then
                ESX.Streaming.RequestModel("csb_g", function()
                    SetPlayerModel(PlayerId(), "csb_g")
                    SetModelAsNoLongerNeeded("csb_g")
                    IsInStaffMode = true
                end)
            else
                ESX.Streaming.RequestModel("a_f_y_femaleagent", function()
                    SetPlayerModel(PlayerId(), "a_f_y_femaleagent")
                    SetModelAsNoLongerNeeded("a_f_y_femaleagent")
                    IsInStaffMode = true
                end)
            end
        end)
    elseif nVal == "nValFalse" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            local isMale = skin.sex == 0
            TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                    TriggerEvent('esx:restoreLoadout')
                    IsInStaffMode = false
                end)
            end)
        end)
    end
end)

exports("IsInStaff", function()
	return IsInStaffMode
end)

-- RegisterNetEvent('Abteww:spawnVehicle')
-- AddEventHandler('Abteww:spawnVehicle', function(playerID, model, Boutique, playerName, type, vehicleType)
-- 	local playerPed = GetPlayerPed(-1)
-- 	local coords    = GetEntityCoords(playerPed)
-- 	local carExist  = false
--     ESX.Game.SpawnVehicle(model, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function(vehicle)
--         if DoesEntityExist(vehicle) then
--             carExist = true
--             SetEntityVisible(vehicle, false, false)
--             SetEntityCollision(vehicle, false)
--             local newPlate = exports['GreenLife']:GeneratePlate()
--             local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
--             vehicleProps.plate = newPlate
--             TriggerServerEvent('Abteww:setVehicle', vehicleProps, Boutique, playerID, vehicleType)
--             ESX.Game.DeleteVehicle(vehicle)	
--             if type ~= 'console' then
--                 ESX.ShowNotification(_U('gived_car', model, Boutique, newPlate, playerName))
--             else
--                 local msg = ('addCar: ' ..model.. ', plate: ' ..newPlate.. ', toPlayer: ' ..playerName..", Boutique: "..Boutique)
--                 TriggerServerEvent('Abteww:printToConsole', msg)
--             end		
--         end		
--     end)
-- 	Wait(2000)
-- end)

-- function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
-- 	AddTextEntry(entryTitle, textEntry)
-- 	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
-- 	blockinput = true

-- 	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
-- 		Wait(0)
-- 	end

-- 	if UpdateOnscreenKeyboard() ~= 2 then
-- 		local result = GetOnscreenKeyboardResult()
-- 		Wait(500)
-- 		blockinput = false
-- 		return result
-- 	else
-- 		Wait(500)
-- 		blockinput = false
-- 		return nil
-- 	end
-- end

        -- Variable pour stocker le ped temporaire créé
local currentPlayerPed = nil

-- Fonction pour afficher le skin d'un joueur à un emplacement spécifique
function showPlayerSkin(playerPed)
    -- Si un ped existe déjà, on le supprime
    if currentPlayerPed then
        DeleteEntity(currentPlayerPed)
        currentPlayerPed = nil
    end

    -- Récupérer le hash du modèle du joueur
    local hash = GetEntityModel(playerPed)

    -- Charger le modèle du joueur
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(1)
    end

    -- Créer un ped temporaire pour afficher le skin à des coordonnées spécifiques (par exemple (0,0,0))
    currentPlayerPed = CreatePed(26, hash, 0.0, 0.0, 0.0, 0.0, true, false)

    -- Rendre le ped invincible et invisible au réseau
    SetEntityInvincible(currentPlayerPed, true)
    NetworkSetEntityInvisibleToNetwork(currentPlayerPed, true)
    SetEntityCanBeDamaged(currentPlayerPed, false)

    -- Désactiver les collisions et autres événements non temporaires
    SetEntityCollision(currentPlayerPed, false, true)
    SetBlockingOfNonTemporaryEvents(currentPlayerPed, true)

    -- Positionner le ped temporaire à un endroit fixe pour l'afficher
    SetEntityCoords(currentPlayerPed, 100.0, 100.0, 20.0, false, false, false, true)  -- Ajuste les coordonnées selon tes besoins
end

-- Fonction pour supprimer le ped temporaire lorsque le menu est fermé ou qu'on change de sélection
function deleteCurrentPlayerPed()
    if currentPlayerPed then
        DeleteEntity(currentPlayerPed)
        currentPlayerPed = nil
    end
end