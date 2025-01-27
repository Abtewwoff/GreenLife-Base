local blip = nil
local _blip2 = nil
local started = false
local EventEnCourds = false


RegisterNetEvent("splayer_staff_event:GetInfo")
AddEventHandler("splayer_staff_event:GetInfo", function(startPos, endPos, desc, NombreJoueurs, veh, prix, ArgentPropre)
    SetAudioFlag("LoadMPData", 1)
    if not EventEnCourds then
        EventEnCourds = true
        PlaySoundFrontend(-1, "10s", "MP_MISSION_COUNTDOWN_SOUNDSET", 1)
        PlaySoundFrontend(-1, "10s", "MP_MISSION_COUNTDOWN_SOUNDSET", 1)
        Wait(10*1000)
        PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
        PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

        started = false
        ESX.ShowNotification("~g~EVENEMENT CITOYEN\n~s~"..desc)
        if ArgentPropre then
            ESX.ShowNotification("~g~INFORMATION\n~s~Participant Max: ~g~"..NombreJoueurs.."\n~s~Type de véhicule: ~g~"..veh.."\n~s~Gain: ~g~"..prix.."~s~$\nType de gain: ~g~Argent propre.")
        else
            ESX.ShowNotification("~g~INFORMATION\n~s~Participant Max: ~g~"..NombreJoueurs.."\n~s~Type de véhicule: ~g~"..veh.."\n~s~Gain: ~g~"..prix.."~s~$\nType de gain: ~g~Argent sale.")
        end
        Wait(3*1000)
        PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
        PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
        PlaySoundFrontend(-1, "Boss_Blipped", "GTAO_Magnate_Hunt_Boss_SoundSet", 1)
        PlaySoundFrontend(-1, "Airhorn", "DLC_TG_Running_Back_Sounds", 1)

        blip = AddBlipForCoord(startPos)
        SetBlipSprite(blip, 586)
        SetBlipScale(blip, 1.0)

        _blip2 = AddBlipForCoord(startPos)
        SetBlipSprite(_blip2, 161)
        SetBlipColour(_blip2, 69)

        BeginTextCommandSetBlipName('STRING')
    	AddTextComponentString("Event Staff")
        EndTextCommandSetBlipName(blip)

        local pPed = PlayerPedId()
        local pressed = false
        while not started do
            Wait(0)
            DrawMarker(6, startPos - 0.98, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 255, 255, 200, false, false, nil, false, false, false, false)
            DrawMarker(1, startPos - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.3,255, 255, 255, 200, false, false, nil, false, false, false, false)
            local pCoords = GetEntityCoords(pPed)
            local dst = GetDistanceBetweenCoords(startPos, pCoords, true)
            if dst <= 3.0 then
                ESX.ShowNotification("Appuyer sur ~g~[E]~s~ pour lancer la mission")
                if IsControlJustReleased(1, 38) and not pressed and not IsPedInAnyVehicle(pPed, false) and ESX.Game.IsSpawnPointClear(startPos, 5.0) then
                    pressed = true
                    TriggerServerEvent("splayer_staff_event:AddPlayer")
                    StartMission(startPos, endPos, veh, prix, ArgentPropre)
                else
                    ESX.ShowNotification("Tu dois être à pied pour lancer la mission, appuie sûr ~g~E~s~ pour lancer la mission\n~g~La zone doit être dégagé pour sortir le véhicule d'event !")
                end
            end
        end
    end
end)



function StartMission(startPos, endPos, veh, prix, ArgentPropre)
    ESX.ShowNotification("MISSION\n~s~Apporte le véhicule rapidement\nSuis le chemin GPS !")
    LoadModel(GetHashKey(veh))
    local _blip = AddBlipForCoord(endPos)
    SetBlipSprite(_blip, 586)
    SetBlipScale(_blip, 1.0)
    SetBlipRoute(_blip, true)
    
    local veh = CreateVehicle(GetHashKey(veh), startPos, GetEntityHeading(PlayerPedId()), 1, 1)
    SetPedIntoVehicle(PlayerPedId(), veh, -1)

    BeginTextCommandSetBlipName('STRING')
	AddTextComponentString("Evenement citoyen fin")
    EndTextCommandSetBlipName(_blip)

    local finish = false
    local pPed = PlayerPedId()
    while not finish do
        Wait(1)
        local pCoords = GetEntityCoords(pPed)
        local dst = GetDistanceBetweenCoords(pCoords, endPos)
        if dst <= 50.0 then
            DrawMarker(6, endPos - 0.98, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 255, 255, 200, false, false, nil, false, false, false, false)
            DrawMarker(1, endPos - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.3,255, 255, 255, 200, false, false, nil, false, false, false, false)
            if dst <= 3.0 then
                local veh = GetVehiclePedIsIn(pPed, true)
                SetEntityAsNoLongerNeeded(veh)
                DeleteEntity(veh)
                local prix = prix + math.random(1,1000)
                ESX.ShowNotification("Event terminé\nTu à gagné: ~g~"..prix.."~s~$ cash")
                TriggerServerEvent("splayer_staff_eventS:Finish", prix, ArgentPropre)
                break
            end
        end
    end
    RemoveBlip(blip)
    RemoveBlip(_blip2)
    RemoveBlip(_blip)
    ClearAllBlipRoutes()
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
        RequestModel(model)
    end
end


RegisterNetEvent("splayer_staff_event:MaxPlayerReach")
AddEventHandler("splayer_staff_event:MaxPlayerReach", function()
    EventEnCourds = false
    RemoveBlip(blip)
    RemoveBlip(_blip2)
    started = true
    ESX.ShowNotification("Event terminé\nNombre de participant max atteinds.")
end)