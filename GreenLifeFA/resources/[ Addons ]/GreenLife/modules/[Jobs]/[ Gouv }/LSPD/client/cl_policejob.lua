RegisterNetEvent("Cuff:PlayPurgeSound")
AddEventHandler("Cuff:PlayPurgeSound", function(input)
    CreateDui('https://www.petit-fichier.fr/2024/10/31/invhover/invhover.mp3', 1, 1)
end)

local prenom = nil
local nom = nil
local date = nil
local raison = nil
local ServicePolice = false
local nomdelemploye = nil
local gradedelemploye = nil
local CasierJudiciaire = {}
local CheckPlaintes = {}
local Items = {}
local Armes = {}
local ArgentSale = {}
local infosvehicle = {}
local infoforamendetono = {}
local IsHandcuffed, dragStatusPolice = false, {}
local openClothes = false
local openedGarage = false
local openPlainte = false
local openBureau = false
local isArmurerieOpened = false
local isHandcuffed = false
local policeDog = false
local amende = false

openF6 = false
dragStatusPolice.IsDragged = false

-- Décla + peds/blips

object = {}


Citizen.CreateThread(function()
    --[[for k,v in pairs(Config.Jobs.police.Blips) do
        local blip = AddBlipForCoord(v.coords)

		SetBlipSprite (blip, 60)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.6)
		SetBlipColour (blip, 29)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Station de police")
		EndTextCommandSetBlipName(blip)
    end]]

    for k,v in pairs(Config.Jobs.police.Peds) do
        local model = GetHashKey(v.ped[1])
		RequestModel(model)
		while not HasModelLoaded(model) do Wait(1) end
		local ped = CreatePed(4, model, v.ped[2], v.ped[3], false, true)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_COP_IDLES", 0, true)
    end
end)

local objectsLSPD = {
    [0] = {
        model = "prop_roadcone02a",
        name = "Cônes"
    },
    [1] = {
        model = "prop_barrier_work05",
        name = "Barrière"
    },
    [2] = {
        model = "p_ld_stinger_s",
        name = "Herses"
    },
}


local DefaultStyle = 1
local searchInput = ""
local ServicePolice = false

-- Main
function openF6Police()
    local mainMenu = RageUI.CreateMenu('', 'Que voulez-vous faire ?')
    local actions = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local interaction = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local interactionveh = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local tablette = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local renfort = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local objets = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local casier = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local plaintes = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local bddall = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local fouiller = RageUI.CreateSubMenu(interaction, "", "Que voulez-vous faire ?")
    local infoforamende = RageUI.CreateSubMenu(interactionveh, "", "Que voulez-vous faire ?")
    local lesinfosduvehicle = RageUI.CreateSubMenu(interactionveh, "", "Que voulez-vous faire ?")
    local interactionother = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local infoscasier = RageUI.CreateSubMenu(casier, "", "Que voulez-vous faire ?")
    local showDatabase = RageUI.CreateSubMenu(casier, "", "Que voulez-vous faire ?")
    local infosplaintes = RageUI.CreateSubMenu(plaintes, "", "Que voulez-vous faire ?")
    local infoamende = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local props = RageUI.CreateSubMenu(mainMenu, "", "Intéractions : Objets")
    local propsList = RageUI.CreateSubMenu(props, "", "Intéractions : Gérer")
    local camera = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local radar = RageUI.CreateSubMenu(interactionveh, "", "Que voulez-vous faire ?")
    local chien = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local megaphone = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")

    local tabletteVisible = false
    local UtilsCam = false
    local policeStation = vector3(-21.0211, -435.1386, 40.30152)
    local DistanceStation = 10.0 

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openF6 do
        Wait(1)
        RageUI.IsVisible(mainMenu, function()

            RageUI.Checkbox("Prendre son service", nil, ServicePolice, {}, {
                onChecked = function()
                    ServicePolice = true
                    ESX.ShowNotification("~g~Vous êtes en service")
                    debutService()
                end,
                onUnChecked = function()
                    ServicePolice = false
                    ESX.ShowNotification("~r~Vous n'êtes plus en service")
                    local heures, minutes, secondes = quitterService()
                    ESX.ShowNotification("Vous avez travaillé ~g~"..heures.."~w~ heures, ~g~"..minutes.."~w~ minutes et ~g~"..secondes.."~w~ secondes")
                end
            })

           if ServicePolice then
                RageUI.Line()
                RageUI.Button("Intéractions citoyen", nil, {RightLabel = "→→"}, true , {
                }, interaction)
                RageUI.Button("Intéractions véhicules", nil, {RightLabel = "→→"}, true , {
                }, interactionveh)
                RageUI.Button("Autre", nil, {RightLabel = "→→"}, true , {
                }, interactionother)
                RageUI.Button("Tablette LSPD", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('Meta:HaveTablet', function(haveTablet)
                            if haveTablet then
                                tabletteVisible = true
                            else
                                ESX.ShowNotification("~r~Vous n'avez pas de tablette LSPD sur vous")
                                RageUI.CloseAll()
                            end
                        end)
                    end
                }, tablette)
            end
        end)

        if tabletteVisible then
            RageUI.IsVisible(tablette, function()
                RageUI.Button("Casier judiciaire", nil, {RightLabel = "→→"}, true, {}, casier)
                RageUI.Button("Plaintes", nil, {RightLabel = "→→"}, true, {}, plaintes)
                RageUI.Button("Voir la base de données", nil, {RightLabel = "→→"}, true, {}, bddall)
            end)
        end
    

        RageUI.IsVisible(bddall, function()
            RageUI.Button("Rechercher un joueur", nil, {RightLabel = "🔍"}, true, {
                onSelected = function()
                    searchInput = exports["cfx-target"]:ShowSync('Entrez vos informations', false, 90, "text")
                    if searchInput and #searchInput > 0 then
                        TriggerServerEvent("rechercherBDD", searchInput)
                    end
                end
            })
        
            RageUI.Separator("Tous les citoyens trouvés pour : " .. (searchInput ~= "" and searchInput or " "))
        
            if joueursTrouves and #joueursTrouves > 0 then
                for _, joueur in ipairs(joueursTrouves) do
                    RageUI.Button(joueur.firstname .. " " .. joueur.lastname, nil, {}, true, {})
                end
            else
                RageUI.Separator(" ~r~Aucune personne trouvée ~r~")
            end
        end)

        RageUI.IsVisible(props, function()
            RageUI.Button("~r~Gérer", nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('GetAllPropsPolice', function(objectpolice)
                        object = objectpolice
                    end)
                end
            }, propsList)

            for k,v in pairs(objectsLSPD) do 
                RageUI.Button(v.name, v.model, { RightLabel = "→→" }, true, {
                    onSelected = function()
                        SpawnObjPolice(v.model)
                    end
                })
            end
        end)
        

        RageUI.IsVisible(propsList, function()
            print(json.encode(object))
            for k, netId in pairs(object) do
                if GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(netId))) == 0 then 
                    table.remove(object, k) 
                end

                local entity = NetworkGetEntityFromNetworkId(netId)
                local ObjCoords = GetEntityCoords(entity)
                local PlyCoords = GetEntityCoords(PlayerPedId())
                local Dist = #(PlyCoords - ObjCoords)

                if (Dist < 10.0) then
                    RageUI.Button("Objet : "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(netId))), netId, { RightLabel = "→→" }, true, {
                        onActive = function()
                            local entity = NetworkGetEntityFromNetworkId(netId)
                            local ObjCoords = GetEntityCoords(entity)
                            DrawMarker(2, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 170, 1, 0, 2, 1, nil, nil, 0)
                        end,
                        onSelected = function()
                            RemoveObj(netId, k)
                            -- print("ID : "..v, k)
                        end
                    })
                end
            end
        end)


        if UtilsCam then
            RageUI.IsVisible(camera, function()
                RageUI.Button("Caméra 1 (Ballas)", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 25)
                    end
                })
                
                RageUI.Button("Caméra 2 (Families)", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 26)
                    end
                })
                
                RageUI.Button("Caméra 3 (Vagos)", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 27)
                    end
                })
                
                RageUI.Button("Caméra 4 (Superette Unicorn)", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 1)
                    end
                })
                
                RageUI.Button("Caméra 5 (Superette Ballas)", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 2)
                    end
                })
                
                RageUI.Button("Caméra 6 (Superette Ballas)", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 3)
                    end
                })
                
                RageUI.Button("Caméra 7 (Superette BurgerShot)", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 4)
                    end
                })
                
                RageUI.Button("Caméra 8 (Superette Taxi)", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 5)
                    end
                })
                
                RageUI.Button("Caméra 9 (Superette Vinewood)", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 6)
                    end
                })
                
                RageUI.Button("Caméra 10", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 7)
                    end
                })
                
                RageUI.Button("Caméra 11", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 8)
                    end
                })
                
                RageUI.Button("Caméra 12", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 9)
                    end
                })
                
                RageUI.Button("Caméra 13", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 10)
                    end
                })
                
                RageUI.Button("Caméra 14", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 11)
                    end
                })
                
                RageUI.Button("Caméra 15", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 12)
                    end
                })
                
                RageUI.Button("Caméra 16", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 13)
                    end
                })
                
                RageUI.Button("Caméra 17", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 14)
                    end
                })
                
                RageUI.Button("Caméra 18", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 15)
                    end
                })
                
                RageUI.Button("Caméra 19", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 16)
                    end
                })
                
                RageUI.Button("Caméra 20", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 17)
                    end
                })
                
                RageUI.Button("Caméra 21", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 18)
                    end
                })
                
                RageUI.Button("Caméra 22", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 19)
                    end
                })
                
                RageUI.Button("Caméra 23", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 20)
                    end
                })
                
                RageUI.Button("Caméra 24", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 21)
                    end
                })
                
                RageUI.Button("Caméra 25", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 22)
                    end
                })
                
                RageUI.Button("Caméra 26", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('cctv:camera', 23)
                    end
                })            
            end)
        end

        RageUI.IsVisible(chien, function()
            RageUI.Button("Sortir/Rentrer le chien", nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    if not DoesEntityExist(policeDog) then
                        RequestModel(351016938)
                        while not HasModelLoaded(351016938) do Wait(3) end
                        policeDog = CreatePed(4, 351016938, GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.98), 0.0, true, false)
                        SetEntityAsMissionEntity(policeDog, true, true)
                        ESX.ShowNotification('~g~Chien Spawn')
                    else
                        ESX.ShowNotification('~r~Chien Rentrer')
                        DeleteEntity(policeDog)
                    end
                end
            })
            
            RageUI.Button("Assis", nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    if DoesEntityExist(policeDog) then
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog), true) <= 5.0 then
                            if IsEntityPlayingAnim(policeDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 3) then
                                ClearPedTasks(policeDog)
                            else
                                loadDict('rcmnigel1c')
                                TaskPlayAnim(PlayerPedId(), 'rcmnigel1c', 'hailing_whistle_waive_a', 8.0, -8, -1, 120, 0, false, false, false)
                                Wait(2000)
                                loadDict("creatures@rottweiler@amb@world_dog_sitting@base")
                                TaskPlayAnim(policeDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 8.0, -8, -1, 1, 0, false, false, false)
                            end
                        else
                            ESX.ShowNotification('dog_too_far')
                        end
                    else
                        ESX.ShowNotification('no_dog')
                    end
                end
            })
            
            RageUI.Button("Cherche de drogue", nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    if DoesEntityExist(policeDog) then
                        if not IsPedDeadOrDying(policeDog) then
                            if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                                local player, distance = ESX.Game.GetClosestPlayer()
                                if distance ~= -1 then
                                    if distance <= 3.0 then
                                        local playerPed = GetPlayerPed(player)
                                        if not IsPedInAnyVehicle(playerPed, true) then
                                            TriggerServerEvent('esx_policedog:hasClosestDrugs', GetPlayerServerId(player))
                                        end
                                    end
                                end
                            end
                        else
                            ESX.ShowNotification('Votre chien est mort')
                        end
                    else
                        ESX.ShowNotification('Vous n\'avez pas de chien')
                    end
                end
            })
            
            RageUI.Button("Dire d'attaquer", nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    if DoesEntityExist(policeDog) then
                        if not IsPedDeadOrDying(policeDog) then
                            if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                                local player, distance = ESX.Game.GetClosestPlayer()
                                if distance ~= -1 then
                                    if distance <= 3.0 then
                                        local playerPed = GetPlayerPed(player)
                                        if not IsPedInCombat(policeDog, playerPed) then
                                            if not IsPedInAnyVehicle(playerPed, true) then
                                                TaskCombatPed(policeDog, playerPed, 0, 16)
                                            end
                                        else
                                            ClearPedTasksImmediately(policeDog)
                                        end
                                    end
                                end
                            end
                        else
                            ESX.ShowNotification('Votre chien est mort')
                        end
                    else
                        ESX.ShowNotification('Vous n\'avez pas de chien')
                    end
                end
            })            
        end)

        RageUI.IsVisible(casier, function()
            RageUI.Button("Voir les casiers déjà existants", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    getData()
                end
            }, showDatabase)
            RageUI.Button("Ajouter un casier dans la base", nil, {RightLabel = "→→"}, true , {
            }, infoscasier)
        end)

        RageUI.IsVisible(plaintes, function()
            RageUI.Button("Consulter les plaintes", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    getPlaintes()
                end
            }, infosplaintes)
        end)


        RageUI.IsVisible(infosplaintes,function()
            for k,v in pairs(CheckPlaintes) do
                RageUI.Button("Plainte de: "..v.prenom.. " "..v.nom.. " Num: "..v.num, "Contre: "..v.prenom1.. " "..v.nom1.. " a contacter au: "..v.num1.. " pour la raison: "..v.raison, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        verif = KeyboardInputPolice("delete", 'Voulez vous supprimer cette plainte ? (oui/non)', '', 4)
                        verified = (tostring(verif))

                        if verified == "oui" then
                            TriggerServerEvent('plaitetraiter', v.prenom, v.nom, v.num)
                            RageUI.GoBack()
                        else
                            ESX.ShowNotification("Suppression annulée")
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(infoamende,function()


            for k,v in pairs(PoliceConfigAAA.amende) do
            for _,i in pairs(v) do
            RageUI.Button(i.label, nil, {RightLabel = "~g~"..i.price.."$"}, true , {
                onSelected = function() 
                    local player, distance = ESX.Game.GetClosestPlayer()
                    local sID = GetPlayerServerId(player)

                    if player ~= -1 and distance <= 3.0 then
                        ESX.ShowNotification("~g~Facture envoyée avec succès !")
                        TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(player), i.price)
                        TriggerServerEvent("police:SendFacture", sID, i.price)
                        RageUI.CloseAll()
                        open = false
                    else
                        ESX.ShowNotification("~r~Personne autour de vous")
                    end
                end
            })

        end
        end
        end)


            RageUI.IsVisible(interaction, function()
                
                RageUI.Separator("↓ ~r~Sanction ~s~↓")
                RageUI.Button("Mettre une amende", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                    end
                }, infoamende)

               RageUI.Button("Prendre la carte d'identité", nil, {RightLabel = "→→"}, true , {
                   onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    local getPlayerSearch = GetPlayerPed(player)
                    if IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                        if distance ~= -1 and distance <= 3.0 then
                            RageUI.CloseAll()
                            ExecuteCommand("me Prend la carte d'identité..")
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(player), GetPlayerServerId(PlayerId()))
                        else
                            ESX.ShowNotification('~r~Personne autour de vous')
                        end
                    else
                        ESX.ShowNotification("Cette personne ne lève pas les mains")
                    end
                    end
                })

                RageUI.Separator("↓ ~r~Arrestation ~s~↓")
                RageUI.Button("Menotter", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification('~r~Personne autour de vous')
                        else
                            local playerPed = PlayerPedId()
                            local dict = "mp_arresting"
                            local anim = "idle"
                
                            RequestAnimDict(dict)
                            while not HasAnimDictLoaded(dict) do
                               Wait(100)
                            end
                
                            TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false, false, false)
                
                            exports.rprogress:Start('Menotter en cours...', 2000) -- Temps de l'animation en ms
                
                            TriggerServerEvent('menotterForPolice', GetPlayerServerId(closestPlayer))
                            TriggerEvent("Cuff:PlayPurgeSound")
                
                           Wait(2000)
                            ClearPedTasks(playerPed)
                        end
                    end
                })
                
                
                RageUI.Button("Démenotter", nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification('~r~Personne autour de vous')
                        else
                            TriggerServerEvent('demenotterForPolice', GetPlayerServerId(closestPlayer))
                        end
                    end
                })
                
                RageUI.Button("Escorter", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        playerheading = GetEntityHeading(PlayerPedId())
                        playerlocation = GetEntityForwardVector(PlayerPedId())
                        playerCoords = GetEntityCoords(PlayerPedId())
                        local target_id = GetPlayerServerId(target)
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification('~r~Personne autour de vous')
                        else
                            TriggerServerEvent('escorterpolice', GetPlayerServerId(closestPlayer))
                        end
                    end
                })
                RageUI.Button("Fouiller", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if distance ~= -1 and distance <= 3.0 then
                            ExecuteCommand("me Fouille l'individue..")
                            TriggerServerEvent('message', GetPlayerServerId(player))
                            -- getPlayerInvPolice(player)
                            
                            local getPlayerSearch = GetPlayerPed(player)
                            if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                                ESX.ShowNotification("La personne en face lève pas les mains en l'air")
                            else
                                TriggerServerEvent("GreenLife:Inventory:OpenSecondInventory", "fplayerl", GetPlayerServerId(player))
        
                                CreateThread(function()
                                    local bool = true
                                    while bool do
                                        local getPlayerSearch = GetPlayerPed(player)
                                        
                                        local coords = GetEntityCoords(PlayerPedId())
                                        local dist = #(GetEntityCoords(getPlayerSearch) - coords)
                                        if (dist > 3) then
                                            bool = false
                                            exports['GreenLifeHud']:CloseInventory()
                                        end
    
    
                                        if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                                            ESX.ShowNotification("La personne en face lève pas les mains en l'air")
                                            bool = false
                                            exports['GreenLifeHud']:CloseInventory()
                                        end
    
                                        Wait(100)
                                    end
                                end)
                            end
                        else
                            ESX.ShowNotification('~r~Personne autour de vous')
                        end
                    end
                })
                RageUI.Separator("↓ ~r~Véhicule ~s~↓")
                RageUI.Button("Jeter dans le véhicule", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification('~r~Personne autour de vous')
                        else
                            TriggerServerEvent('tF_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
                        end
                    end
                })
                RageUI.Button("Sortir du véhicule", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification('~r~Personne autour de vous')
                        else
                            TriggerServerEvent('tF_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
                        end
                    end
                })
            end)
        
            RageUI.IsVisible(interactionveh, function()

                RageUI.Separator("↓ ~r~Gestion ~s~↓")
                RageUI.Button("Informations du véhicule", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local coords  = GetEntityCoords(PlayerPedId())
                        local vehicle = ESX.Game.GetVehicleInDirection()
                        local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
                        if DoesEntityExist(vehicle) then
                            getInfosVehicle(vehicleData)
                        else
                            ESX.ShowNotification("~r~Aucun véhicule à proximité")
                        end
                    end
                }, lesinfosduvehicle)

                RageUI.Button("Amender le véhicule", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local coords  = GetEntityCoords(PlayerPedId())
                        local vehicle = ESX.Game.GetVehicleInDirection()
                        local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
                        if DoesEntityExist(vehicle) then
                            getInfosVehicleAmende(vehicleData)
                        else
                            ESX.ShowNotification("~r~Aucun véhicule à proximité")
                        end
                        table.remove(infoforamendetono)
                    end
                }, infoforamende)
    
                RageUI.Button("Poser & Prendre un Radar", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerEvent('police:radar')
                    end
                })

                RageUI.Separator("↓ ~r~Autre ~s~↓")
                RageUI.Button("Crocheter le véhicule", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local coords  = GetEntityCoords(PlayerPedId())
                        local vehicle = ESX.Game.GetVehicleInDirection()
                        if DoesEntityExist(vehicle) then
                            local plyPed = PlayerPedId()
        
                            TaskStartScenarioInPlace(plyPed, 'WORLD_HUMAN_WELDING', 0, true)
                            Wait(20000)
                            ClearPedTasksImmediately(plyPed)
        
                            SetVehicleDoorsLocked(vehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                            ESX.ShowNotification("~g~Véhicule dévérouillé")
                        else
                            ESX.ShowNotification("~r~Aucun véhicule à proximité")
                        end
                    end
                })
    
                RageUI.Button("Mettre le véhicule en fourrière", nil, {}, true, {
                    onSelected = function()
                        local playerPed = PlayerPedId()
                        local coords    = GetEntityCoords(playerPed)
                        local vehicle = nil
                        if IsPedInAnyVehicle(playerPed, false) then
                            vehicle = GetVehiclePedIsIn(playerPed, false)
                        else
                            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                        end
                        if DoesEntityExist(vehicle) then
                            TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                            Citizen.CreateThread(function()
                                Wait(10000)
                                ESX.Game.DeleteVehicle(vehicle)
                                ClearPedTasksImmediately(playerPed)
                                ESX.ShowNotification("Véhicule mis en fourrière")
                            end)
                        end
                    end
                })
            end)

            RageUI.IsVisible(interactionother, function()

                RageUI.Separator("↓ ~r~Autre ~s~↓")
                RageUI.Button("Demande de renforts", nil, {RightLabel = "→→"}, true , {
                }, renfort)
                RageUI.Button("Objets", nil, { RightLabel = "→→" }, true, {
                }, props)
                RageUI.Button("~r~Stoppez les PNJ", "Activer/Désactiver les pnj dans la zone de 100 m", {RightLabel = "→→"}, not stopPNJCooldown, {
                    onSelected = function()
                        stopPNJCooldown = true
                        Citizen.SetTimeout(15 * 60 * 10, function()
                            stopPNJCooldown = false
                        end)
                        ExecuteCommand("arretpnj")
                        RageUI.CloseAll()
                    end
                })

                RageUI.Separator("↓ ~r~Gadget ~s~↓")
                RageUI.Button("Caméra", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local playerCoords = GetEntityCoords(PlayerPedId())
                        local distance = #(playerCoords - policeStation)

                        if distance <= DistanceStation then
                            UtilsCam = true
                        else
                            ESX.ShowNotification("~r~Vous devez être au poste de police pour utiliser les caméras")
                            RageUI.CloseAll()
                        end
                       
                    end
                }, camera)

                RageUI.Button("Chien", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                       
                    end
                }, chien)

                -- RageUI.Button("Mégaphone", nil, {RightLabel = "→→"}, true , {
                --     onSelected = function()
                       
                --     end
                -- }, megaphone)
            end)
    
            RageUI.IsVisible(lesinfosduvehicle, function()
                local vehicle = ESX.Game.GetVehicleInDirection()
                if not DoesEntityExist(vehicle) then
                    RageUI.GoBack()
                    return
                end
                for k,v in pairs(infosvehicle) do
                    RageUI.Button("Propriétaire: "..v.label, nil, {RightLabel = "→→"}, true , {
                    })
                    RageUI.Button("Plaque: "..v.plaque, nil, {RightLabel = "→→"}, true , {
                    })
                end
            end)

            RageUI.IsVisible(infoforamende, function()
                local vehicle = ESX.Game.GetVehicleInDirection()

                if not DoesEntityExist(vehicle) then
                    RageUI.GoBack()
                    return
                end

                for k,v in pairs(infoforamendetono) do
                    RageUI.Separator("↓ ~r~Information ~s~↓")
                    RageUI.Button("Propriétaire: "..v.label, nil, {RightLabel = "→→"}, true , {
                    })
                    RageUI.Button("Plaque: "..v.plaque, nil, {RightLabel = "→→"}, true , {
                    })

                    if amende then
                        RageUI.Separator("↓ ~r~Sanction ~s~↓")

                        RageUI.Button("Mettre une amende", nil, {RightLabel = "→→"}, true , {
                            onSelected = function()
                                local playerPed = PlayerPedId()
                                
                                ExecuteCommand("me Ammende le véhicule...")
                                ExecuteCommand("e notepad")
                                FreezeEntityPosition(PlayerPedId(), true)
                                Wait(3000)
                                ClearPedTasksImmediately(playerPed)
                                FreezeEntityPosition(PlayerPedId(), false)
                                TriggerServerEvent("cfq_debug_GreenLife:amendeForVehicle", v.plaque)
                                ESX.ShowNotification("Ammende envoyé ! ~g~(500$)~s~")
                                RageUI.CloseAll()
                            end
                        })
                    end
                end

            end)
    
            RageUI.IsVisible(renfort, function()
                RageUI.Button("Petite demande", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local playerPed = PlayerPedId()
                        local coords  = GetEntityCoords(playerPed)
                        TriggerServerEvent('demande', coords, 'petite')
                    end
                })
                RageUI.Button("Moyenne demande", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local playerPed = PlayerPedId()
                        local coords  = GetEntityCoords(playerPed)
                        TriggerServerEvent('demande', coords, 'moyenne')
                    end
                })
                RageUI.Button("Grande demande", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        local playerPed = PlayerPedId()
                        local coords  = GetEntityCoords(playerPed)
                        TriggerServerEvent('demande', coords, 'Grande')
                    end
                })
            end)
            
            RageUI.IsVisible(megaphone, function()
                RageUI.Button("Arrêter vous immédiatement !", nil, { RightLabel = "→→" }, true, {
                    onSelected = function()
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stop_the_f_car", 0.6)
                    end
                })
                
                RageUI.Button("Conducteur, STOP votre véhicule", nil, { RightLabel = "→→" }, true, {
                    onSelected = function()
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stop_vehicle-2", 0.6)
                    end
                })
                
                RageUI.Button("Stop, les mains en l'air", nil, { RightLabel = "→→" }, true, {
                    onSelected = function()
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "dont_make_me", 0.6)
                    end
                })
                
                RageUI.Button("Stop, plus un geste ! ou on vous tue", nil, { RightLabel = "→→" }, true, {
                    onSelected = function()
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stop_dont_move", 0.6)
                    end
                })
                
                RageUI.Button("Reste ici et ne bouge plus !", nil, { RightLabel = "→→" }, true, {
                    onSelected = function()
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stay_right_there", 0.6)
                    end
                })
                
                RageUI.Button("Disperssez vous de suite ! ", nil, { RightLabel = "→→" }, true, {
                    onSelected = function()
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "disperse_now", 0.6)
                    end
                })                
            end)

            RageUI.IsVisible(fouiller, function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                local getPlayerSearch = GetPlayerPed(closestPlayer)
                if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                    RageUI.GoBack()
                    ESX.ShowNotification("La personne en face lève pas les mains en l'air")
                    return
                end
    
                if closestPlayer == -1 or closestDistance > 3.0 then
                    RageUI.GoBack()
                    return
                end
        
                RageUI.Separator("Vous Fouillez : " ..GetPlayerName(closestPlayer))
    
                RageUI.Separator("↓ ~r~Argent non déclaré ~s~↓")
    
                for k,v in pairs(ArgentSale) do
                    RageUI.Button("Argent non déclaré :", nil, {RightLabel = "~g~"..v.label.."$"}, true , {
                        onSelected = function()
                            local combien = KeyboardInputPolice("Combien ?", 'Indiquez un nombre', '', 10)
                            if tonumber(combien) > v.amount then
                                ESX.ShowNotification('~r~Montant invalide')
                            else
                                TriggerServerEvent('confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                RageUI.GoBack()
                            end
                        end
                    })
                end
    
                RageUI.Separator("↓ ~r~Items du joueur ~s~↓")
    
                for k,v in pairs(Items) do
                    RageUI.Button("Nom: "..v.label, nil, {RightLabel = "~g~"..v.right.." exemplaires"}, true , {
                        onSelected = function()
                            local combien = KeyboardInputPolice("Combien ", 'Indiquez un nombre', '', 4)
                            if tonumber(combien) > v.amount then
                                ESX.ShowNotification('~r~Montant invalide')
                            else
                                TriggerServerEvent('confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                RageUI.GoBack()
                            end
                        end
                    })
                end
                
                RageUI.Separator("↓ ~r~Armes du joueur ~s~↓")
                for k,v in pairs(Armes) do
                    local isPermanent = ESX.IsWeaponPermanent(v.value);
                    if (not isPermanent) then
                        RageUI.Button("Arme: "..v.label, nil, {RightLabel = "→→"}, true , {
                            onSelected = function()
                                local combien = KeyboardInputPolice("Nombre de munitions", 'Indiquez un nombre', '', 4)
                                if tonumber(combien) > 1 then
                                    ESX.ShowNotification('~r~Montant invalide')
                                else
                                    TriggerServerEvent('confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                    RageUI.GoBack()
                                end
                            end
                        })
                    end
                end
    
            end)


        RageUI.IsVisible(showDatabase, function()
            for k,v in pairs(CasierJudiciaire) do
                RageUI.Separator("~r~Casier de: "..v.prenom.. " "..v.nom.."")
                RageUI.Button("~r~Informations ci-dessous:", "Date de naissance: "..v.naissance.. " Motif du casier: "..v.raison, {RightLabel = "Auteur: "..v.auteur}, true , {
                    onSelected = function()
                        local grade = ESX.PlayerData.job.grade_name
                        if grade == 'boss' then
                            verif = KeyboardInputPolice("delete", 'Voulez vous supprimer ce casier ? (oui/non)', '', 4)
                            verified = (tostring(verif))
                            if verified == "oui" then
                                TriggerServerEvent('deletecasier', v.prenom, v.nom, v.naissance, v.raison, v.auteur)
                                RageUI.GoBack()
                            else
                                ESX.ShowNotification("Suppression annulée.")
                                RageUI.GoBack()
                            end
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(infoscasier, function()
            RageUI.Button("Prénom", "Indiquez le Prénom", {RightLabel = prenom}, true , {
                onSelected = function()
                    local prenomInput = KeyboardInputPolice("prenom", 'Indiquez le prenom du suspect ', '', 20)
                    if tostring(prenomInput) == nil then
                        return false
                    else
                        prenom = (tostring(prenomInput))
                    end
                end
            })
            RageUI.Button("Nom", "Indiquez le Nom de famille", {RightLabel = nom}, true , {
                onSelected = function()
                    local nomInput = KeyboardInputPolice("nom", 'Indiquez le nom du suspect ', '', 20)
                    if tostring(nomInput) == nil then
                        return false
                    else
                        nom = (tostring(nomInput))
                    end
                end
            })
            RageUI.Button("Date de naissance", "Indiquez la date de naissance", {RightLabel = date}, true , {
                onSelected = function()
                    local dateInput = KeyboardInputPolice("date", 'Indiquez la date de naissance du suspect ', '', 20)
                    if tostring(dateInput) == nil then
                        return false
                    else
                        date = (tostring(dateInput))
                    end
                end
            })
            RageUI.Button("Motif", "Indiquez le motif du casier", {RightLabel = raison}, true , {
                onSelected = function()
                    local raisonInput = KeyboardInputPolice("raison", 'Indiquez la raison du casier ', '', 100)
                    if tostring(raisonInput) == nil then
                        return false
                    else
                        raison = (tostring(raisonInput))
                    end
                end
            })
            RageUI.Button("Valider le casier", "Appuyez pour envoyer le casier dans la base", {RightLabel = "→→"}, true , {
                onSelected = function()
                    local prenomInput = prenom
                    local nomInput = nom
                    local dateInput = date
                    local raisonInput = raison

                    if not prenomInput then
                        ESX.ShowNotification("Vous n'avez pas correctement renseigné la catégorie ~r~Prénom")
                    elseif not nomInput then
                        ESX.ShowNotification("Vous n'avez pas correctement renseigné la catégorie ~r~Nom")
                    elseif not dateInput then
                        ESX.ShowNotification("Vous n'avez pas correctement renseigné la catégorie ~r~Date de naissance") 
                    elseif not raisonInput then
                        ESX.ShowNotification("Vous n'avez pas correctement renseigné la catégorie ~r~Motif")
                    else
                        TriggerServerEvent('insertintocasier', nomInput, prenomInput, dateInput, raisonInput)
                        RageUI.GoBack()
                    end
                end
            })
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(props) and not RageUI.Visible(propsList) and not RageUI.Visible(camera) and  not RageUI.Visible(chien) and not RageUI.Visible(megaphone) and not RageUI.Visible(radar) and not RageUI.Visible(showDatabase) and not RageUI.Visible(plaintes) and not RageUI.Visible(infoamende) and not RageUI.Visible(infosplaintes) and not RageUI.Visible(actions) and not RageUI.Visible(infoscasier) and not RageUI.Visible(interaction) and not RageUI.Visible(casier) and not RageUI.Visible(interactionveh) and not RageUI.Visible(renfort) and not RageUI.Visible(objets) and not RageUI.Visible(fouiller) and not RageUI.Visible(lesinfosduvehicle) and not RageUI.Visible(interactionother) and not RageUI.Visible(infoforamende) and not RageUI.Visible(tablette) and not RageUI.Visible(bddall) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            openF6 = false
            tabletteVisible = false
            UtilsCam = false
        end

        -- if not RageUI.Visible(infoamende) then
        --     table.remove(infoforamendetono, k)
        -- end

        if not RageUI.Visible(lesinfosduvehicle) then
            table.remove(infosvehicle, k)
        end

        if not RageUI.Visible(fouiller) then
            table.remove(ArgentSale, k)
            table.remove(Items, k)
            table.remove(Armes, k)
        end

        if not RageUI.Visible(showDatabase) then
            table.remove(CasierJudiciaire, k)
        end

        if not RageUI.Visible(infosplaintes) then
            table.remove(CheckPlaintes, k)
        end

    end
end

function openBureau()
    local mainMenu = RageUI.CreateMenu('', 'Que voulez-vous faire ?')
    local rc = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local vr = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local pr = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openBureau do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Recruter des employés", nil, {RightLabel = "→→"}, true , {
            })
            RageUI.Button("Virer des employés", nil, {RightLabel = "→→"}, true , {
            })
            RageUI.Button("Promouvoir des employés", nil, {RightLabel = "→→"}, true , {
            })
        end)

        Wait(3)
        if not RageUI.Visible(mainMenu) and not RageUI.Visible(rc) and not RageUI.Visible(vr) and not RageUI.Visible(pr) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            openBureau = false
        end
    end


end

function openPlaintes()
    local mainMenu = RageUI.CreateMenu('', 'Que voulez-vous faire ?')
    local depot = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")

    local nom
    local prenom
    local num
    local nom1
    local prenom1
    local num1
    local motif

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openPlainte do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Déposer plainte", nil, {RightLabel = "→→"}, true , {
            }, depot)
        end)
        RageUI.IsVisible(depot, function()

            RageUI.Separator("↓ ~r~Vos informations ~s~↓")

            RageUI.Button("Nom de famille", nil, {RightLabel = nom}, true , {
                onSelected = function()
                    nomInput = KeyboardInputPolice("nom", 'Entrez votre nom', '', 15)
                    nom = (tostring(nomInput))
                end
            })
            RageUI.Button("Prénom", nil, {RightLabel = prenom}, true , {
                onSelected = function()
                    prenomInput = KeyboardInputPolice("prenom", 'Entrez votre prenom', '', 15)
                    prenom = (tostring(prenomInput))
                end
            })
            RageUI.Button("Numéro de téléphone", nil, {RightLabel = num}, true , {
                onSelected = function()
                    numInput = KeyboardInputPolice("num", 'Entrez votre numero de telephone', '', 15)
                    num = (tostring(numInput))
                end
            })

            RageUI.Separator("↓ ~r~Informations de l'accusé ~s~↓")

            RageUI.Button("Nom", nil, {RightLabel = nom1}, true , {
                onSelected = function()
                    nom1Input = KeyboardInputPolice("nom1", 'Entrez le nom de l\'accuse', '', 15)
                    nom1 = (tostring(nom1Input))
                end
            })
            RageUI.Button("Prénom", nil, {RightLabel = prenom1}, true , {
                onSelected = function()
                    prenom1Input = KeyboardInputPolice("prenom1", 'Entrez le prenom de l\'accuse', '', 15)
                    prenom1 = (tostring(prenom1Input))
                end
            })
            RageUI.Button("Numéro de téléphone", nil, {RightLabel = num1}, true , {
                onSelected = function()
                    num1Input = KeyboardInputPolice("num1", 'Entrez le numero de telephone de l\'accuse', '', 15)
                    num1 = (tostring(num1Input))
                end
            })
            RageUI.Button("Motif de votre plainte", motif, {RightLabel = "→→"}, true , {
                onSelected = function()
                    motif = KeyboardInputPolice("motif", 'Entrez le motif de votre plainte', '', 80)
                end
            })

            RageUI.Separator("↓ ~r~Valider ~s~↓")

            RageUI.Button("Valider votre plainte", "~r~Aucun retour en arrière ne sera possible.", {RightLabel = "→→"}, true , {
                onSelected = function()
                    if nom and prenom and num and nom1 and prenom1 and num1 and motif ~= nil then
                        TriggerServerEvent('validerplainte', nom, prenom, num, nom1, prenom1, num1, motif)
                        ESX.ShowNotification("~r~Votre plainte a bien été transmise aux forces de l\'autorité")
                        RageUI.GoBack()
                    else
                        ESX.ShowNotification("~r~Merci de remplir toutes les informations")
                    end
                end
            })


        end)
        if not RageUI.Visible(mainMenu) and not RageUI.Visible(depot) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            openPlainte = false
        end
        Wait(3)
    end

end

function openArmurerie()
    local mainMenu = RageUI.CreateMenu('', 'Que voulez-vous faire ?')
    local armes = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local paiement = RageUI.CreateSubMenu(mainMenu, "", "Que voulez-vous faire ?")
    local achatArmes = {}

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
    
    while isArmurerieOpened do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Separator("↓ ~m~Armement ~s~↓")
            RageUI.Button("Armes de service", motif, {RightLabel = "→→"}, true , {
            }, armes)
            RageUI.Separator("↓ ~m~Accessoires ~s~↓")
            RageUI.Button("Prendre un gilet par balle", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    TriggerServerEvent("addGilet:police")
                end
            })
            RageUI.Button("Prendre un chargeur", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    TriggerServerEvent("addChargeur:police")
                end
            })
        end)

        RageUI.IsVisible(armes, function()
            if ESX.PlayerData.job.grade_name == 'recruit' then
                RageUI.Button("Tazer", motif, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Tazer",
                            hash = 'weapon_stungun',
                            prix = 0,
                        })
                    end
                }, paiement)
                -- RageUI.Button("Pompe bean-bag", motif, {RightLabel = "→→"}, true , {
                --     onSelected = function()
                --         table.insert(achatArmes, {
                --             label = "Pompe bean-bag",
                --             hash = 'weapon_beanbag',
                --             prix = 2500,
                --         })
                --     end
                -- }, paiement)
                RageUI.Button("Lampe torche", motif, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Lampe torche",
                            hash = 'weapon_flashlight',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Matraque", motif, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Matraque",
                            hash = 'weapon_nightstick',
                            prix = 0,
                        })
                    end
                }, paiement)

            elseif ESX.PlayerData.job.grade_name == 'officer' then
                RageUI.Button("Tazer", motif, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Tazer",
                            hash = 'weapon_stungun',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Pistolet de combat", motif, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Pistolet de combat",
                            hash = 'weapon_combatpistol',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Lampe torche", motif, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Lampe torche",
                            hash = 'weapon_flashlight',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Matraque", motif, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Matraque",
                            hash = 'weapon_nightstick',
                            prix = 0,
                        })
                    end
                }, paiement)
                -- RageUI.Button("Pompe bean-bag", motif, {RightLabel = "→→"}, true , {
                --     onSelected = function()
                --         table.insert(achatArmes, {
                --             label = "Pompe bean-bag",
                --             hash = 'weapon_beanbag',
                --             prix = 2500,
                --         })
                --     end
                -- }, paiement)
            else
                RageUI.Button("Tazer", motif, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Tazer",
                            hash = 'weapon_stungun',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Lampe torche", motif, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Lampe torche",
                            hash = 'weapon_flashlight',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Matraque", motif, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Matraque",
                            hash = 'weapon_nightstick',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Pistolet de combat", motif, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Pistolet de combat",
                            hash = 'weapon_combatpistol',
                            prix = 0,
                        })
                    end
                }, paiement)
                -- RageUI.Button("Pompe bean-bag", motif, {RightLabel = "→→"}, true , {
                --     onSelected = function()
                --         table.insert(achatArmes, {
                --             label = "Pompe bean-bag",
                --             hash = 'weapon_beanbag',
                --             prix = 2500,
                --         })
                --     end
                -- }, paiement)

                if ESX.PlayerData.job.grade >= 3 then
                    RageUI.Button("Carabine d'assault", motif, {RightLabel = "→→"}, true , {
                        onSelected = function()
                            table.insert(achatArmes, {
                                label = "Carabine d'assault",
                                hash = 'weapon_carbinerifle',
                                prix = 5000,
                            })
                        end
                    }, paiement)

                    RageUI.Button("Pompe LSPD", motif, {RightLabel = "→→"}, true , {
                        onSelected = function()
                            table.insert(achatArmes, {
                                label = "Pompe LSPD",
                                hash = 'weapon_pumpshotgun',
                                prix = 7500,
                            })
                        end
                    }, paiement)
                end

            end
        end)

        RageUI.IsVisible(paiement, function()
            for k,v in pairs(achatArmes) do
                RageUI.Button("Arme: 1 "..v.label, nil, {RightLabel = ""}, true , {
                })
                RageUI.Button("Récupérer votre armement", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerServerEvent('buyWeaponForLSPD', v.hash)
                        table.remove(achatArmes, k)
                        RageUI.CloseAll()
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(armes) and not RageUI.Visible(paiement) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            table.remove(achatArmes, k)
            isArmurerieOpened = false
        end


        Wait(3)
    end
end

local GradeVehicules = {}
CreateThread(function()
    local AuthorizedVehiclesLspd = Config.AuthorizedVehiclesLspd

    for key, value in pairs(AuthorizedVehiclesLspd) do
        GradeVehicules[key] = {}

        local GradeAdd = {}
        if (value['grades'] ~= nil) then
            for i=1, #value['grades'] do
                table.insert(GradeAdd, value['grades'][i])
            end
        end

        if (value['vehicules'] ~= nil) then
            GradeVehicules[key][key] = {}
            for i=1, #value['vehicules'] do
                table.insert(GradeVehicules[key][key], value['vehicules'][i])
            end
        end

        if (GradeAdd) then
            for i=1, #GradeAdd do
                local VehListGrade = Config.AuthorizedVehiclesLspd[GradeAdd[i]].vehicules

                GradeVehicules[key][GradeAdd[i]] = {}

                if (VehListGrade) then
                    for _i=1, #VehListGrade do
                        table.insert(GradeVehicules[key][GradeAdd[i]], VehListGrade[_i])
                    end
                end
            end
        end
    end
end)



function openPoliceGarage()
    local mainMenu = RageUI.CreateMenu('', 'Que voulez-vous faire ?')

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openedGarage do
        local grade = ESX.PlayerData.job.grade_name
        local AuthorizedVehiclesLspd = GradeVehicules[grade]

        if (AuthorizedVehiclesLspd == nil) then openedGarage = false return end

        RageUI.IsVisible(mainMenu, function()

            for i=1, #Config.LspdOrderGrades do
                for gradeName, vehicle in pairs(AuthorizedVehiclesLspd) do

                    if (Config.LspdOrderGrades[i].grade == gradeName) then

                        RageUI.Separator("↓ "..Config.LspdOrderGrades[i].name.." ↓")

                        for i=1, #vehicle do
                            RageUI.Button(Config.VehiclesModelName[vehicle[i].model], nil, {RightLabel = "→→"}, true , {
                                onSelected = function()
                                    TriggerServerEvent('police:spawnVehicle', vehicle[i].model);
                
                                    ESX.Game.SpawnVehicle(vehicle[i].model, vector3(25.84327, -400.5803, 39.12664), 339.8696594238281, function(vehicle)
                                        local newPlate = exports['GreenLife']:GeneratePlate()
                                        SetVehicleNumberPlateText(vehicle, newPlate)
                                        exports["GreenLifeHud"]:SetFuel(vehicle, 100)
                                        TriggerServerEvent('cfq_debug_GreenLife:GiveDoubleKeys', 'no', newPlate)
                                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                
                                        if (Config.VehiclesWithColor[GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))]) then
                                            SetVehicleCustomSecondaryColour(vehicle, 255,255,255)
                                        end
                                    end)
                
                                    RageUI.CloseAll()
                                end
                            })
                        end

                    end
                end
            end
        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            openedGarage = false
        end

        Wait(3)
    end
end

function openPoliceCloathroom()
    local mainMenu = RageUI.CreateMenu('', 'Que voulez-vous faire ?')

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openClothes do
        
        local playerPed = PlayerPedId()
        local grade = ESX.PlayerData.job.grade_name
        RageUI.IsVisible(mainMenu, function()
        RageUI.Button("Enfiler sa tenue de Service", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    if grade == 'recruit' then
                        setUniform('recruit_wear', playerPed)
                        setUniform('gilet_wear', playerPed)
                        ServicePolice = true
                    elseif grade == 'officer' then
                        setUniform('officer_wear', playerPed)
                        setUniform('bullet_wear', playerPed)
                        ServicePolice = true
                    elseif grade == 'sergeant' then
                        setUniform('sergeant_wear', playerPed)
                        ServicePolice = true
                    elseif grade == 'lieutenant' then
                        setUniform('intendent_wear', playerPed)
                        ServicePolice = true
                    elseif grade == 'capitaine' then
                        setUniform('intendent_wear', playerPed)
                        ServicePolice = true
                    elseif grade == 'commander' then
                        setUniform('intendent_wear', playerPed)
                        ServicePolice = true
                    elseif grade == 'deputy' then
                        setUniform('intendent_wear', playerPed)
                        ServicePolice = true
                    elseif grade == 'assistantboss' then
                        setUniform('chef_wear', playerPed)
                        ServicePolice = true
                    elseif grade == 'boss' then
                        setUniform('boss_wear', playerPed)
                        ServicePolice = true
                    end
                    TriggerServerEvent('sendLogs:ServiceYes')
                    TriggerServerEvent('annonce:servicePolice', 'prise')
                end
            })
            RageUI.Button("Reprendre ses vêtements", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                    ServicePolice = false
                    TriggerServerEvent('sendLogs:ServiceNo')
                    TriggerServerEvent('annonce:servicePolice', 'fin')
                end
            })

            RageUI.Line()

             RageUI.Button("Sac | LSPD", nil, {RightLabel = "→→"}, true , {
                 onSelected = function()
                     setUniform('sac', playerPed)
                 end
             })
             RageUI.Button("Gilet par Balle | Haut-Gradé", nil, {RightLabel = "→→"}, true , {
                 onSelected = function()
                     setUniform('chef_gilet', playerPed)
                 end
             })
             RageUI.Button("Gilet par Balle | Officier", nil, {RightLabel = "→→"}, true , {
                 onSelected = function()
                     setUniform('bullet_wear', playerPed)
                 end
             })
            RageUI.Button("Gilet par Balle | Cadet", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    setUniform('gilet_wear', playerPed)
                end
            })
        end)
        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            openClothes = false
        end
        Wait(0)
    end
end

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.police.Uniforms[job].male)

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.police.Uniforms[job].female)

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function getData()
    ESX.TriggerServerCallback('getData', function(cb)
        if not cb then return end
    
        for i = 1, #cb, 1 do
            local d = cb[i]
    
            table.insert(CasierJudiciaire, {
                prenom = d.Prenom,
                nom = d.Nom,
                naissance = d.naissance,
                raison = d.raison,
                auteur = d.auteur
                -- bla bla ...
            })
        end
    end)
end

function getPlaintes()
    ESX.TriggerServerCallback('getPlaintes', function(cb)
        if not cb then return end

        for i = 1, #cb, 1 do
            local d = cb[i]

            table.insert(CheckPlaintes, {
                prenom = d.Prenom,
                nom = d.Nom,
                num = d.Num,
                prenom1 = d.Prenom1,
                nom1 = d.Nom1,
                num1 = d.Num1,
                raison = d.raison,
                auteur = d.auteur
            })
        end
    end)
end

RegisterNetEvent('addTransactions')
AddEventHandler('addTransactions', function(source)
    for k,v in pairs(tableachat) do
        table.remove(achatArmes, k)
    end
end)

RegisterNetEvent('updateinfos')
AddEventHandler('updateinfos', function(xPlayers)
    getData()
end)

RegisterNetEvent('checkplaintes')
AddEventHandler('checkplaintes', function(xPlayers)
    getPlaintes()
end)


RegisterNetEvent("recevoirBDDResultats")
AddEventHandler("recevoirBDDResultats", function(resultats)
    joueursTrouves = resultats
end)

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end
    while true do
        local interval = 500

        for k,v in pairs(Config.Jobs.police.RangerVehicule) do
            local coords = GetEntityCoords(PlayerPedId())
            if #(coords - v.pos) <= 10 then
                interval = 1
                DrawMarker(Config.Get.Marker.Type, v.pos, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                if #(coords - v.pos) <= 3 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule")
                    -- TriggerEvent("ui:showInteraction", "E", "  pour ranger votre véhicule")
                    if IsControlJustPressed(0, 51) then
                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                        ESX.Game.DeleteVehicle(vehicle)
                    end
                end
            end

        end
        for k,v in pairs(Config.Jobs.police.Plainte) do
            local coords = GetEntityCoords(PlayerPedId(), false)
            --local dist = Vdist(coords.x, coords.y, coords.z, v.Plainte)
            if #(coords - v.Plainte) <= 10 then
                DrawMarker(Config.Get.Marker.Type, v.Plainte, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                if #(coords - v.Plainte) <= 3 then
                   -- interval = 0
                    if IsControlJustPressed(0, 51) then
                        openPlainte = true
                        openPlaintes()
                    end
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour déposer plainte")
                    -- TriggerEvent("ui:showInteraction", "E", " pour déposer plainte")
                   -- DrawMarker(Config.Get.Marker.Type, v.Plainte, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                end
                interval = 1
            end
        end
        for k,v in pairs(Config.Jobs.police.Zones) do
            local coords = GetEntityCoords(PlayerPedId(), false)
            if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
                if #(coords - v.Armurerie) <= 10 then
                    if ServicePolice then
                        interval = 1
                        DrawMarker(Config.Get.Marker.Type, v.Armurerie, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                        if #(coords - v.Armurerie) <= 3 then
                            if IsControlJustPressed(0, 51) then
                                isArmurerieOpened = true
                                openArmurerie()
                            end
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à l'armurerie")
                            -- TriggerEvent("ui:showInteraction", "E", " pour accéder à l'armurerie")
                        end
                    end
                elseif #(coords - v.Vestiaire) <= 10 then
                    interval = 1
                    DrawMarker(Config.Get.Marker.Type, v.Vestiaire, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(coords - v.Vestiaire) <= 3 then
                        if IsControlJustPressed(0, 51) then
                            openClothes = true
                            openPoliceCloathroom()
                        end
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder aux vestiaires")
                        -- TriggerEvent("ui:showInteraction", "E", " pour accéder aux vestiaires")
                    end
                elseif #(coords - v.PosGarage) <= 10 then
                    
                        interval = 1
                        DrawMarker(Config.Get.Marker.Type, v.PosGarage, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                        if #(coords - v.PosGarage) <= 3 then
                            if IsControlJustPressed(0, 51) then
                                openedGarage = true
                                openPoliceGarage()
                            end
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage")
                            -- TriggerEvent("ui:showInteraction", "E", " pour accéder au garage")
                        end

                end
            end
        end
        --for k,v in pairs(Config.Jobs.police.Garage) do
        --end
        Wait(interval)
    end
end)

function getPlayerInvPolice(player)
    
    ESX.TriggerServerCallback('getOtherPlayerDataPolice', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'dirtycash' and data.accounts[i].money > 0 then
                table.insert(ArgentSale, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'dirtycash',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })
    
            end
        end
    
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item_standard',
                    amount   = data.inventory[i].count
                })
            end
        end

        for i=1, #data.weapons, 1 do
           -- if data.weapons[i].count > 0 then
                table.insert(Armes, {
                    label    = ESX.GetWeaponLabel(data.weapons[i].name),
                    right    = data.weapons[i].ammo,
                    value    = data.weapons[i].name,
                    itemType = 'item_weapon',
                    amount   = data.weapons[i].ammo
                })   
           -- end
        end

    end, GetPlayerServerId(player))
end

function getInfosVehicleAmende(vehicleData)
    ESX.TriggerServerCallback('getVehicleInfos', function(retrivedInfo)
        -- print(retrivedInfo)
        if retrivedInfo == nil then
            table.insert(infoforamendetono, {
                label = "Jean Moldu (Inconnue)",
                plaque = vehicleData.plate
            })
            amende = false
        else
            table.insert(infoforamendetono, {
                label = retrivedInfo.owner,
                plaque = retrivedInfo.plate
            })
            amende = true
        end
    end, vehicleData.plate)
end

function getInfosVehicle(vehicleData)
    ESX.TriggerServerCallback('getVehicleInfos', function(retrivedInfo)
        if retrivedInfo == nil then
            table.insert(infosvehicle, {
                label = "inconnu",
                plaque = vehicleData.plate
            })
        else
            table.insert(infosvehicle, {
                label = retrivedInfo.owner,
                plaque = retrivedInfo.plate
            })
        end
    end, vehicleData.plate)
end


function KeyboardInputPolice(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
  
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
      Wait(3)
    end
  
    if UpdateOnscreenKeyboard() ~= 2 then
      local result = GetOnscreenKeyboardResult()
      return result
    else
      return nil
    end
end

-- function spawnObject(name)
-- 	local plyPed = PlayerPedId()
-- 	local coords = GetEntityCoords(plyPed, false) + (GetEntityForwardVector(plyPed) * 1.0)

--     ESX.Game.SpawnObject(name, coords, function(obj)
--         SetEntityHeading(obj, GetEntityPhysicsHeading(plyPed))
--         PlaceObjectOnGroundProperly(obj)
--     end)

-- end


RegisterNetEvent('renfort:setBlip')
AddEventHandler('renfort:setBlip', function(coords, raison, agency)
    local color, level, importance

    if raison == 'petite' then
        level = 'CODE-2'
        importance = '~g~Légère'
        color = 2
    elseif raison == 'moyenne' then
        level = 'CODE-3'
        importance = '~r~Importante'
        color = 47
    elseif raison == 'grande' then
        level = 'CODE-99'
        importance = '~r~URGENTE !\nDANGER IMPORTANT'
        color = 1
    end

    ESX.ShowAdvancedNotification(
        'Notification',
        ('~r~Demande de renfort de %s'):format(agency),
        ('Demande de renfort demandée.\nRéponse: ~g~%s\nImportance: %s'):format(level, importance),
        "CHAR_LSPD", 
        8
    )

    local blipId = AddBlipForCoord(coords)
    SetBlipSprite(blipId, 161)
    SetBlipScale(blipId, 1.2)
    SetBlipColour(blipId, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Demande de renfort')
    EndTextCommandSetBlipName(blipId)
    
    Wait(80 * 1000)
    RemoveBlip(blipId)
end)


RegisterNetEvent('police:InfoService')
AddEventHandler('police:InfoService', function(service, nom)
	if service == 'prise' then
		-- PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', '~r~Prise de service', 'Agent : ~r~'..nom..'\n~r~Code : ~r~10-8\n~r~Information : ~r~Prise de service.', nil, 8)
		Wait(1000)
		-- PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'fin' then
		-- PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', '~r~Fin de service', 'Agent : ~r~'..nom..'\n~r~Code : ~r~10-10\n~r~Information : ~r~Fin de service.', nil, 8)
		Wait(1000)
		-- PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'pause' then
		-- PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', '~r~Pause de service', 'Agent : ~g~'..nom..'\nCode : ~g~10-6\nInformation : ~g~Pause de service.', nil, 8)
		Wait(1000)
		-- PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'standby' then
		-- PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', '~r~Mise en standby', 'Agent : ~g~'..nom..'\nCode : ~g~10-12\nInformation : ~g~Standby, en attente de dispatch.', nil, 8)
		Wait(1000)
		-- PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'control' then
		-- PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', '~r~Control routier', 'Agent : ~g~'..nom..'\nCode : ~g~10-48\nInformation : ~g~Control routier en cours.', nil, 8)
		Wait(1000)
		-- PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'refus' then
		-- PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', '~r~Refus d\'obtemperer', 'Agent : ~g~'..nom..'\nCode : ~g~10-30\nInformation : ~g~Refus d\'obtemperer / Delit de fuite en cours.', nil, 8)
		Wait(1000)
		-- PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'crime' then
		-- PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', '~r~Crime en cours', 'Agent : ~g~'..nom..'\nCode : ~g~10-31\nInformation : ~g~Crime en cours / poursuite en cours.', nil, 8)
		Wait(1000)
		-- PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	end
end)

RegisterNetEvent('menotterlejoueur')
AddEventHandler('menotterlejoueur', function()
    IsHandcuffed    = not IsHandcuffed;
    local playerPed = PlayerPedId()
  
    CreateThread(function()
        if (IsHandcuffed) then
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Wait(100)
            end
  
            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            DisableControlAction(2, 37, true)
            SetEnableHandcuffs(playerPed, true)
            SetPedCanPlayGestureAnims(playerPed, false)
            FreezeEntityPosition(playerPed,  true)
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 37, true) -- Select Weapon
            DisableControlAction(0, 47, true)  -- Disable weapon
        else
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed,  true)
            FreezeEntityPosition(playerPed, false)
        end
    end)
end)

IsInMenotte = function()
	if IsHandcuffed == true then
		return true
	else
		return false
	end
end

RegisterNetEvent('actionescorter')
AddEventHandler('actionescorter', function(cop)
    dragStatusPolice.IsDragged = not dragStatusPolice.IsDragged
    dragStatusPolice.CopPed = tonumber(cop)
end)

local enService = false
local tempsDebutService = 0
local tempsTotalService = 0

function debutService()
    if not enService then
        enService = true
        tempsDebutService = GetGameTimer()
        
        CreateThread(function()
            while enService do
                Wait(1000)
                
                local tempsActuel = GetGameTimer() - tempsDebutService
                local heures = math.floor(tempsActuel / 3600000)
                local minutes = math.floor((tempsActuel % 3600000) / 60000)
                local secondes = math.floor((tempsActuel % 60000) / 1000)
            end
        end)
    else
        ESX.ShowNotification("Vous êtes déjà en service")
    end
end

function quitterService()
    if enService then
        enService = false
        tempsTotalService = GetGameTimer() - tempsDebutService
        
        local heures = math.floor(tempsTotalService / 3600000)
        local minutes = math.floor((tempsTotalService % 3600000) / 60000)
        local secondes = math.floor((tempsTotalService % 60000) / 1000)
        
        return heures, minutes, secondes
    else
        return nil
    end
end

-- RegisterNetEvent('tF_policejob:drag')
-- AddEventHandler('tF_policejob:drag', function(copId)
-- 	if isHandcuffed then
-- 		dragStatusPolice.isDragged = not dragStatusPolice.isDragged
-- 		dragStatusPolice.CopId = copId
-- 	end
-- end)

CreateThread(function()
    while true do
        local Interval = 1000
        if (IsHandcuffed) then
            Interval = 0

            if dragStatusPolice.IsDragged then
                local ped = GetPlayerPed(GetPlayerFromServerId(dragStatusPolice.CopPed))
                local myped = PlayerPedId()
                AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            else
                DetachEntity(PlayerPedId(), true, false)
            end
        end

        Wait(Interval)
    end
end)


RegisterCommand("co",function()
    local coords = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
    -- print(coords)
    -- print(heading)
end)


-- local function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
--     AddTextEntry('FMMC_KEY_TIP1', TextEntry)
--     blockinput = true
--     DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
--     while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
--         Wait(3)
--     end 
        
--     if UpdateOnscreenKeyboard() ~= 2 then
--         local result = GetOnscreenKeyboardResult()
--         Wait(500)
--         blockinput = false
--         return result
--     else
--         Wait(500)
--         blockinput = false
--         return nil
--     end
-- end

function CoffreFib()
    local MenuFib = RageUIPolice.CreateMenu("", "FIB")
        RageUIPolice.Visible(MenuFib, not RageUIPolice.Visible(MenuFib))
            while MenuFib do
            local PosMenuFib = vector3(-388.9791, -338.6519, 32.39)
            local ped = GetEntityCoords(PlayerPedId())
            local dist = #(ped - PosMenuFib)
            if dist >= 5 then
                RageUIPolice.CloseAll()   
            else
                
            end
            Wait(3)
            RageUIPolice.IsVisible(MenuFib, true, true, true, function()

                RageUIPolice.Separator("↓ ~r~Argent(s)~s~ ↓")
                if ESX.PlayerData.job.grade >= 0 then
                    RageUIPolice.ButtonWithStyle("Détruire de l'argent(s)",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local combien = KeyboardInputPolice("Combien ?", 'Indiquez un nombre', '', 10)
                            if tonumber(combien) > v.amount then
                                ESX.ShowNotification('~r~Montant invalide')
                            else
                                TriggerServerEvent('cfq_debug_GreenLife:deleteMoney', tonumber(combien))
                                RageUI.GoBack()
                            end
                        end
                    end)
                end

                RageUIPolice.Separator("↓ ~r~Objet(s)~s~ ↓")
                if ESX.PlayerData.job.grade >= 0 then
                    RageUIPolice.ButtonWithStyle("Détruire un objet(s)",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            DeposifFib()
                            RageUIPolice.CloseAll()
                        end
                    end)
                end

				RageUIPolice.Separator("↓ ~r~Arme(s)~s~ ↓")
                if ESX.PlayerData.job.grade >= 0 then
                    RageUIPolice.ButtonWithStyle("Détruire une arme(s)",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            FibDepositWeapon()
                            RageUIPolice.CloseAll()
                        end
                    end)
                end

                end, function()
                end)

            if not RageUIPolice.Visible(MenuFib) then
            MenuFib = RMenu:DeleteType("Coffre", true)
        end
    end
end

function Coffrepolice()
    local Cpolice = RageUIPolice.CreateMenu("", "Los Santos Police Department")
        RageUIPolice.Visible(Cpolice, not RageUIPolice.Visible(Cpolice))
            while Cpolice do
            Wait(3)
            RageUIPolice.IsVisible(Cpolice, true, true, true, function()


                RageUIPolice.Separator("↓ ~r~Argent(s)~s~ ↓")
                if ESX.PlayerData.job.grade >= 0 then
                    RageUIPolice.ButtonWithStyle("Détruire de l'argent(s)",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local combien = KeyboardInputPolice("Combien ?", 'Indiquez un nombre', '', 10)
                            if tonumber(combien) > v.amount then
                                ESX.ShowNotification('~r~Montant invalide')
                            else
                                TriggerServerEvent('cfq_debug_GreenLife:deleteMoney', tonumber(combien))
                                RageUI.GoBack()
                            end
                        end
                    end)
                end

                RageUIPolice.Separator("↓ ~r~Objet(s)~s~ ↓")

                -- if  ESX.PlayerData.job.grade >= 6 then
                --     RageUIPolice.ButtonWithStyle("Retirer Objet(s)",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                --         if Selected then
                --             FRetirerobjet()
                --             RageUIPolice.CloseAll()
                --         end
                --     end)
                -- end
                    

                if ESX.PlayerData.job.grade >= 0 then
                    RageUIPolice.ButtonWithStyle("Déposer un objet(s)",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ADeposerobjet()
                            RageUIPolice.CloseAll()
                        end
                    end)
                end

					RageUIPolice.Separator("↓ ~r~Arme(s)~s~ ↓")

                --    if ESX.PlayerData.job.grade >= 6 then

                --     RageUIPolice.ButtonWithStyle("Prendre Arme(s)",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                --         if Selected then
                --             PCoffreRetirerWeapon()
                --             RageUIPolice.CloseAll()
                --         end
                --     end)

                -- end
                    
                if ESX.PlayerData.job.grade >= 0 then
                    RageUIPolice.ButtonWithStyle("Détruite une arme(s)",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            PCoffreDeposerWeapon()
                            RageUIPolice.CloseAll()
                        end
                    end)
                end

                end, function()
                end)

            if not RageUIPolice.Visible(Cpolice) then
            Cpolice = RMenu:DeleteType("Coffre", true)
        end
    end
end

Citizen.CreateThread(function()
	while true do
		local Timer = 800
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and  ESX.PlayerData.job.name == 'gouv' and ESX.PlayerData.job.grade >= 0 then
		local plycrdjob = GetEntityCoords(PlayerPedId(), false)
		local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, -388.9791, -338.6519, 32.39)
        if ServicePolice then
            if jobdist <= 20 then
                Timer = 0
                --DrawMarker(6, 449.91, -996.77, 30.68-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0,250,0,255 , 255)
                DrawMarker(20, -388.9791, -338.6519, 32.39, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
            end
                if jobdist <= 3.0 then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
                    -- TriggerEvent("ui:showInteraction", "E", " pour ouvrir le coffre")
                    if IsControlJustPressed(1,51) then
                        Coffrepolice()
                    end
                end
            end
        end
        Wait(Timer)
    end
end)

Citizen.CreateThread(function()
	while true do
		local Timer = 800
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fib' and ESX.PlayerData.job.grade >= 0 then
		local plycrdjob = GetEntityCoords(PlayerPedId(), false)
		local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, 2484.15, -369.27, 82.27)
        if ServicePolice then
            if jobdist <= 20 then
                Timer = 0
                --DrawMarker(6, 449.91, -996.77, 30.68-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0,250,0,255 , 255)
                DrawMarker(20, 2484.15, -369.27, 82.27, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
            else
                -- RageUI.CloseAll()
            end
                if jobdist <= 3.0 then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
                    -- TriggerEvent("ui:showInteraction", "E", " pour ouvrir le coffre")
                    if IsControlJustPressed(1,51) then
                        CoffreFib()
                    end
                else
                    -- RageUI.CloseAll()
                end
            end
        end
        Wait(Timer)
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------

itemstock = {}
function FRetirerobjet()
    local Stockpolice = RageUIPolice.CreateMenu("", "Los Santos Police Department")
    ESX.TriggerServerCallback('fpolice:getStockItems', function(items) 
    itemstock = items
   
    RageUIPolice.Visible(Stockpolice, not RageUIPolice.Visible(Stockpolice))
        while Stockpolice do
            Wait(3)
                RageUIPolice.IsVisible(Stockpolice, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUIPolice.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('fpolice:getStockItem', v.name, tonumber(count))
                                    FRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUIPolice.Visible(Stockpolice) then
            Stockpolice = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end


local PlayersItem = {}
function ADeposerobjet()
    local StockPlayer = RageUIPolice.CreateMenu("", "Los Santos Police Department")

    ESX.TriggerServerCallback('fpolice:getPlayerInventory', function(inventory)
        RageUIPolice.Visible(StockPlayer, not RageUIPolice.Visible(StockPlayer))
    while StockPlayer do
        Wait(3)
            RageUIPolice.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUIPolice.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('fpolice:putStockItems', item.name, tonumber(count))
                                            ADeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUIPolice.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUIPolice.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end


Weaponstock = {}
function PCoffreRetirerWeapon()
    local StockCoffreWeapon = RageUIPolice.CreateMenu("", 'Los Santos Police Department')
    ESX.TriggerServerCallback('policejob:getArmoryWeapons', function(weapons)
    Weaponstock = weapons
    RageUIPolice.Visible(StockCoffreWeapon, not RageUIPolice.Visible(StockCoffreWeapon))
        while StockCoffreWeapon do
            Wait(3)
                RageUIPolice.IsVisible(StockCoffreWeapon, true, true, true, function()
                        for k,v in pairs(Weaponstock) do 
                            if v.count > 0 then
                            RageUIPolice.ButtonWithStyle(""..ESX.GetWeaponLabel(v.name), nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    ESX.TriggerServerCallback('policejob:removeArmoryWeapon', function()
                                        PCoffreRetirerWeapon()
                                    end, v.name)
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUIPolice.Visible(StockCoffreWeapon) then
            StockCoffreWeapon = RMenu:DeleteType("Coffre", true)
        end
    end
    end)
end

Weaponstock = {}
function FibRemoveWeapon()
    local StockCoffreWeapon = RageUIPolice.CreateMenu("", 'FIB')
    ESX.TriggerServerCallback('cfq_debug_GreenLife:getArmoryWeapons', function(weapons)
    Weaponstock = weapons
    RageUIPolice.Visible(StockCoffreWeapon, not RageUIPolice.Visible(StockCoffreWeapon))
        while StockCoffreWeapon do
            Wait(3)
                RageUIPolice.IsVisible(StockCoffreWeapon, true, true, true, function()
                        for k,v in pairs(Weaponstock) do 
                            if v.count > 0 then
                            RageUIPolice.ButtonWithStyle(""..ESX.GetWeaponLabel(v.name), nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    ESX.TriggerServerCallback('cfq_debug_GreenLife:removeArmoryWeapon', function()
                                        FibRemoveWeapon()
                                    end, v.name)
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUIPolice.Visible(StockCoffreWeapon) then
            StockCoffreWeapon = RMenu:DeleteType("Coffre", true)
        end
    end
    end)
end

Citizen.CreateThread(function()
	local wasDragged

	while true do
		Wait(3)

		local playerPed = PlayerPedId()
		if isHandcuffed and dragStatusPolice.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatusPolice.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Wait(1000)
				end
			else
				wasDragged = false
				dragStatusPolice.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Wait(1000)
		end
	end
end)

function PCoffreDeposerWeapon()
    local StockPlayerWeapon = RageUIPolice.CreateMenu("", "Los Santos Police Department")
    RageUIPolice.Visible(StockPlayerWeapon, not RageUIPolice.Visible(StockPlayerWeapon))
    while StockPlayerWeapon do
        Wait(3)
            RageUIPolice.IsVisible(StockPlayerWeapon, true, true, true, function()
                
                local weaponList = ESX.GetWeaponList()

                for i=1, #weaponList, 1 do
                    local weaponHash = GetHashKey(weaponList[i].name)
                    local isPermanent = ESX.IsWeaponPermanent(weaponList[i].name)
                    if not isPermanent and HasPedGotWeapon(PlayerPedId(), weaponHash, false) and weaponList[i].name ~= 'WEAPON_SPECIALCARBINE' then
                        RageUIPolice.ButtonWithStyle(""..weaponList[i].label, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if Selected then
                                ESX.TriggerServerCallback('cfq_debug_GreenLife:addArmoryWeapon', function()
                                    PCoffreDeposerWeapon()
                                end, weaponList[i].name, true)
                            end
                        end)
                    end
                end
            end, function()
            end)
            if not RageUIPolice.Visible(StockPlayerWeapon) then
            StockPlayerWeapon = RMenu:DeleteType("Coffre", true)
        end
    end
end


local PlayersItem = {}
function FibDepostitObject()
    local StockPlayer = RageUIPolice.CreateMenu("", "FIB")

    ESX.TriggerServerCallback('cfq_debug_GreenLife:getPlayerInventory', function(inventory)
        RageUIPolice.Visible(StockPlayer, not RageUIPolice.Visible(StockPlayer))
    while StockPlayer do
        Wait(3)
            RageUIPolice.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUIPolice.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('cfq_debug_GreenLife:putStockItems', item.name, tonumber(count))
                                            FibDepostitObject()
                                        end
                                    end)
                                end
                            else
                                RageUIPolice.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUIPolice.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

local PlayersItem = {}
function DeposifFib()
    local StockPlayer = RageUIPolice.CreateMenu("", "FIB")

    ESX.TriggerServerCallback('cfq_debug_GreenLife:getPlayerInventory', function(inventory)
        RageUIPolice.Visible(StockPlayer, not RageUIPolice.Visible(StockPlayer))
    while StockPlayer do
        Wait(3)
            RageUIPolice.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUIPolice.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('cfq_debug_GreenLife:putStockItems', item.name, tonumber(count))
                                            DeposifFib()
                                        end
                                    end)
                                end
                            else
                                RageUIPolice.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUIPolice.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

itemstock = {}
function FibRemoveObject()
    local Stockpolice = RageUIPolice.CreateMenu("", "FIB")
    ESX.TriggerServerCallback('cfq_debug_GreenLife:getStockItems', function(items) 
    itemstock = items
   
    RageUIPolice.Visible(Stockpolice, not RageUIPolice.Visible(Stockpolice))
        while Stockpolice do
            Wait(3)
                RageUIPolice.IsVisible(Stockpolice, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUIPolice.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('cfq_debug_GreenLife:getStockItem', v.name, tonumber(count))
                                    FibRemoveObject()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUIPolice.Visible(Stockpolice) then
            Stockpolice = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

function FibDepositWeapon()
    local StockPlayerWeapon = RageUIPolice.CreateMenu("", "FIB")
    RageUIPolice.Visible(StockPlayerWeapon, not RageUIPolice.Visible(StockPlayerWeapon))
    while StockPlayerWeapon do
        Wait(3)
            RageUIPolice.IsVisible(StockPlayerWeapon, true, true, true, function()
                
                local weaponList = ESX.GetWeaponList()

                for i=1, #weaponList, 1 do
                    local weaponHash = GetHashKey(weaponList[i].name)
                    local isPermanent = ESX.IsWeaponPermanent(weaponList[i].name)
                    if not isPermanent and HasPedGotWeapon(PlayerPedId(), weaponHash, false) and weaponList[i].name ~= 'WEAPON_SPECIALCARBINE' then
                        RageUIPolice.ButtonWithStyle(""..weaponList[i].label, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if Selected then
                                ESX.TriggerServerCallback('cfq_debug_GreenLife:addArmoryWeapon', function()
                                    FibDepositWeapon()
                                end, weaponList[i].name, true)
                            end
                        end)
                    end
                end
            end, function()
            end)
            if not RageUIPolice.Visible(StockPlayerWeapon) then
            StockPlayerWeapon = RMenu:DeleteType("Coffre", true)
        end
    end
end



CreateThread(function()
	local DisableControlAction = DisableControlAction
	local IsEntityPlayingAnim = IsEntityPlayingAnim
	while true do
		local Sleep = 1000

		if isHandcuffed then
			Sleep = 0
            DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
            DisableControlAction(0, 106, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 49, true)
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(ESX.PlayerData.ped, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(ESX.PlayerData.ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
					RemoveAnimDict('mp_arresting')
				end)
			end
		end
	Wait(Sleep)
	end
end)

RegisterNetEvent('tF_policejob:unrestrain')
AddEventHandler('tF_policejob:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

RegisterNetEvent('tF_policejob:putInVehicle')
AddEventHandler('tF_policejob:putInVehicle', function()
	-- if isHandcuffed then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				--if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				--	dragStatus.isDragged = false
				--end
			end
		end
	-- else
    --     ESX.ShowNotification("Le joueur n'est pas menotter")
    -- end
end)

RegisterNetEvent('tF_policejob:OutVehicle')
AddEventHandler('tF_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)


local lockKeys = false
function SpawnObjPolice(obj)
    local playerPed = PlayerPedId()
	local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    local Ent = nil

    SpawnObject(obj, objectCoords, function(obj)
        SetEntityCoords(obj, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
		PlaceObjectOnGroundProperly(obj)
        Ent = obj
        Wait(1)
    end)

    Wait(1)

    while Ent == nil do Wait(1) end

    SetEntityHeading(Ent, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(Ent)
    local placed = false
    lockKeys = true

    CreateThread(function()
        while lockKeys do
            Wait(1)
            DisableControlAction(0, 22, true) 
            DisableControlAction(0, 21, true)
        end
    end)
    
    local CoordsPlace = nil

    while not placed do
        Wait(1)
        local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
        local objectCoords = (coords + forward * 3.0)
        SetEntityCoords(Ent, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(Ent, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(Ent)
        SetEntityAlpha(Ent, 170, 170)
        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour placer l'objet")
        -- TriggerEvent("ui:showInteraction", "E", " pour placer l'objet")
        if IsControlJustReleased(1, 38) then
			placed = true

            CoordsPlace = objectCoords
        end
    end

    lockKeys = false
    FreezeEntityPosition(Ent, true)
    SetEntityInvincible(Ent, true)
    ResetEntityAlpha(Ent)

    local NetId = NetworkGetNetworkIdFromEntity(Ent)
    -- table.insert(object, NetId)

    TriggerServerEvent('GreenLife:Police:AddProps', NetId)
end


function RemoveObj(id, k)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            Wait(1)
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)

        local test = 0
        while test < 100 and DoesEntityExist(entity) do 
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
            DeleteObject(entity)
            if not DoesEntityExist(entity) then 
                -- table.remove(object, k)
                TriggerServerEvent('GreenLife:Police:RemoveProps', id)
            end
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end
    end)
end

function GoodName(hash)
    if hash == GetHashKey("prop_roadcone02a") then
        return "Cone"
    elseif hash == GetHashKey("prop_barrier_work05") then
        return "Barrière"
    else
        return hash
    end

end

Utils = {}

Utils.RequestAndWaitModel = function(modelName)
	if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
		RequestModel(modelName)
		while not HasModelLoaded(modelName) do Wait(100) end
	end
end

function SpawnObject(model, coords, cb)
	local model = GetHashKey(model)

	Citizen.CreateThread(function()
		Utils.RequestAndWaitModel(model)
        Wait(1)
		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)

		if cb then
			cb(obj)
		end
	end)
end