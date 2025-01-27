
-- local CheckPlaintes = {}

-- function getPlaintes()
--     ESX.TriggerServerCallback('bcso:getPlaintes', function(cb)
--         if not cb then return end

--         for i = 1, #cb, 1 do
--             local d = cb[i]

--             table.insert(CheckPlaintes, {
--                 prenom = d.Prenom,
--                 nom = d.Nom,
--                 num = d.Num,
--                 prenom1 = d.Prenom1,
--                 nom1 = d.Nom1,
--                 num1 = d.Num1,
--                 raison = d.raison,
--                 auteur = d.auteur
--             })
--         end
--     end)
-- end

-- RegisterNetEvent('bcso:checkplaintes')
-- AddEventHandler('bcso:checkplaintes', function(xPlayers)
--     getPlaintes()
-- end)

-- local open = false
-- local pos = {x = -439.78564453125, y = 6012.6220703125, z = 27.584175109863}

-- function OpenPlainte()
--     if not open then
--         open = true
--         local plaintes = RageUI.CreateMenu("", "Change ta plaque de véhicule :")
--         local infosplaintes = RageUI.CreateSubMenu(plaintes, "", "Liste des plaintes")
        
--         RageUI.Visible(plaintes, true)

--         Citizen.CreateThread(function()
--             while open do
--                 RageUI.IsVisible(plaintes, function() 
--                     RageUI.Line()
--                     RageUI.Button("Consulter les plaintes", nil, {RightLabel = "→→"}, true , {
--                         onSelected = function()
--                             getPlaintes()
--                         end
--                     }, infosplaintes)
--                 end)

--                 RageUI.IsVisible(infosplaintes, function()
--                     RageUI.Line()
--                     for k, v in pairs(CheckPlaintes) do
--                         RageUI.Button("Plainte de: "..v.prenom.. " "..v.nom.. " Num: "..v.num, "Contre: "..v.prenom1.. " "..v.nom1.. " a contacter au: "..v.num1.. " pour la raison: "..v.raison, {RightLabel = "→→"}, true , {
--                             onSelected = function()
--                                 local verif = KeyboardInputBcso("delete", 'Voulez vous supprimer cette plainte ↓ (oui/non)', '', 4)
--                                 local verified = tostring(verif)

--                                 if verified == "oui" then
--                                     TriggerServerEvent('bcso:plaitetraiterbcso', v.prenom, v.nom, v.num)
--                                     RageUI.CloseAll()
--                                     open = false
--                                 else
--                                     ESX.ShowNotification("Suppression annulée")
--                                 end
--                             end
--                         })
--                     end
--                 end)
--                 Wait(1) -- Prevent high CPU usage
--             end
--         end)
--     end
-- end

-- Citizen.CreateThread(function()
--     while true do
--         local wait = 900
--         local playerCoords = GetEntityCoords(PlayerPedId(), false)
--         local dist = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, pos.x, pos.y, pos.z)
        
--         if dist <= 2.0 then 
--             wait = 0
--             DrawMarker(6, pos.x, pos.y, pos.z - 1.0, 0, 0, 0, 0, 0, 0, 0.9, 0.9, 0.9, 30, 255, 0, 255, 0, 0, 0, 0)
--             DrawMarker(1, pos.x, pos.y, pos.z - 1.3, 0, 0, 0, 0, 0, 0, 0.9, 0.9, 0.9, 30, 255, 0, 200, 0, 0, 0, 0)

--             -- TriggerEvent("ui:showInteraction", "E", " pour interagir avec le menu")
            
--             if IsControlJustPressed(1, 51) then 
--                 OpenPlainte()
--             end
--         end
--         Wait(wait)
--     end
-- end)
