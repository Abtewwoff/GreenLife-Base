ESX  = exports['Framework']:getSharedObject()

emploieState = false

local MainEmploie = RageUI.CreateMenu("", "Liste des emploies", nil, nil, ConfigEmploie.NomFichier, ConfigEmploie.NomBanniere)

RageUI.Closed = function()
    emploieState = false
end

function PoleEmploie()
    Citizen.CreateThread(function()
        if emploieState then 
            emploieState = false
            RageUI.Visible(MainEmploie, false)
            return 
        else 
            emploieState = true
            RageUI.Visible(MainEmploie, true)
        end

        local initialPosition = GetEntityCoords(PlayerPedId())

        while emploieState do 
            Wait(1)

            local currentPosition = GetEntityCoords(PlayerPedId())
            local distance = #(currentPosition - initialPosition)

            if distance > 5.0 then
                emploieState = false
                RageUI.Visible(MainEmploie, false)
                break
            end

            RageUI.IsVisible(MainEmploie, function()
                RageUI.Button("Jardinier", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent('Meta_dev:setjobjardinier')
                        SetNewWaypoint(ConfigEmploie.PointJardinier)
                    end
                })
                RageUI.Button("Chantier", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent('Meta_dev:setjobchantier')
                        SetNewWaypoint(ConfigEmploie.PointChantier)
                    end
                })
                RageUI.Button("Mineur", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent('Meta_dev:setjomineur')
                        SetNewWaypoint(ConfigEmploie.PointMineur)
                    end
                })

                -- RageUI.Button("Livreur de pizza", nil, {RightLabel = "→→"}, true, {
                --     onSelected = function()
                --         TriggerServerEvent('Abteww:setjobpizza')
                --         SetNewWaypoint(ConfigEmploie.PointPizza)
                --     end
                -- })

                RageUI.Line()

                RageUI.Button("Arreter de travailler", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent('Meta_dev:stopjob')
                    end
                })
            end)
        end
    end)
end

--------------------------------------------------------------------------------------------------------------------------
                                    -- [ DrawMarker] --
--------------------------------------------------------------------------------------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, ConfigEmploie.Position.Emploie.pos.x, ConfigEmploie.Position.Emploie.pos.y, ConfigEmploie.Position.Emploie.pos.z)
        if dist3 <= 1.0 then
            Timer = 0
        end
        if dist3 <= 5.0 then
            Timer = 0   
            DrawMarker(6,ConfigEmploie.Position.Emploie.pos.x, ConfigEmploie.Position.Emploie.pos.y, ConfigEmploie.Position.Emploie.pos.z - 1.0, 1.0, 1.0, 90.0, 0, 0, 0, 0.9, 0.9, 0.9, 30, 255, 0,255, 0, 0, 0, 0)
            DrawMarker(1, ConfigEmploie.Position.Emploie.pos.x, ConfigEmploie.Position.Emploie.pos.y, ConfigEmploie.Position.Emploie.pos.z - 1.3, 0, 0, 0, 0, 0, 0, 0.9, 0.9, 0.9, 30, 255, 0, 200, 0, 0, 0, 0)
            -- TriggerEvent("ui:showInteraction", "E", ConfigEmploie.Position.Emploie.text)
            if IsControlJustPressed(1,51) then
                PoleEmploie()
            end
        end 
        Wait(Timer)
    end
end)

CreateThread(function()
    local blip = AddBlipForCoord(ConfigEmploie.Position.Blips.pos) -- remplacer les coordonnés
    SetBlipSprite(blip, ConfigEmploie.Position.Blips.model) -- Model du blip
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, ConfigEmploie.Position.Blips.taille) -- Taille du blip
    SetBlipColour(blip, ConfigEmploie.Position.Blips.couleur) -- Couleur du blip
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(ConfigEmploie.Position.Blips.nom) -- Nom du blips
    EndTextCommandSetBlipName(blip)
end)

 local GlobalPeds = {
    Ped = {
        {hash = "a_f_y_femaleagent", coords = vector4(-268.53475952148, -957.56164550781, 30.223134994507,210.25901794433597)}, -- Car Location
    }
}

Citizen.CreateThread(function()
    for _,v in pairs(GlobalPeds.Ped) do
        local hash = GetHashKey(v.hash)
        while not HasModelLoaded(hash) do
            RequestModel(hash)
            Wait(20)
        end
        ped = CreatePed("Abteww", v.hash, v.coords, false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
    end
end)