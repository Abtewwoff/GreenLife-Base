local timer = Config.TimeToRespawn
local timerVip = Config.TimeToRespawnVip
local gotpressed = false
local noptmort = false

RegisterNetEvent("Abteww:ReceiveDeathStatus", function(isDead)
    if (isDead) then
        openDeathMenuWlh();
    else
        RageUI.CloseAll();
    end
end);
openDeathMenuWlh = function()
    local mainMenu = RageUI.CreateMenu("", "Vous êtes mort")
    mainMenu.Closable = false
    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
    gotpressed = false
    noptmort = false
    CreateThread(function()
        local playerVip = exports.GreenLife:GetVipLevel()
        if playerVip == 3 then
            CreateThread(function()
                while mainMenu do
                    timerVip = timerVip - 1
                    if (timerVip <= 0) then
                        timerVip = Config.TimeToRespawnVip;
                        noptmort = true;
                    end
                    Wait(1000)
                end
            end)
            while mainMenu do
                DisableAllControlActions();
                EnableControlAction(0, 245, true);
                RageUI.IsVisible(mainMenu, function()
                    if (not gotpressed) then
                        RageUI.Button("Envoyer un signal de détresse", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
                                local playerDead = GetPlayerServerId(PlayerId())
                                TriggerServerEvent('ambulance:sendsignal',playerDead, x, y, z)
                            end
                        })
                    else
                        ESX.SetTimeout(300000, function()
                            gotpressed = false
                        end)
                        RageUI.Button("Loading...", "Vous venez d'envoyer un signal patienter 5 minutes avant d'en envoyer un nouveau...", {RightLabel = ""}, true, {
                            onSelected = function()
                          end
                        })
                    end
                    if (not noptmort) then
                        RageUI.Button("~g~[VIP]~s~ Réaparition possible dans "..timerVip.." secondes", nil, {RightLabel = ""}, false, {
                            onSelected = function()
                            end
                        })
                    else
                        RageUI.Button("Réapparaître", nil, {}, true, {
                            onSelected = function()
                                SetEntityCoords(PlayerPedId(), Config.RespawningPlace)
                                TriggerServerEvent('réanimerafterdie')
                            
                                Wait(1000)
                                gotpressed = false
                                noptmort = false
                            end
                        })
                    end
                end)
                if (not RageUI.Visible(mainMenu)) then
                    mainMenu = RMenu:DeleteType(mainMenu, true)
                    gotpressed = false
                    noptmort = false
                    timerVip = Config.TimeToRespawnVip
                end
                Wait(0)
            end
        else
            CreateThread(function()
                while mainMenu do
                    timer = timer - 1
                    if (timer <= 0) then
                        timer = Config.TimeToRespawn;
                        noptmort = true;
                    end
                    Wait(1000)
                end
            end)
            while mainMenu do
                DisableAllControlActions();
                EnableControlAction(0, 245, true);
                RageUI.IsVisible(mainMenu, function()
                    if (not gotpressed) then
                        RageUI.Button("Envoyer un signal de détresse", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
                                local playerDead = GetPlayerServerId(PlayerId())
                                TriggerServerEvent('ambulance:sendsignal',playerDead, x, y, z)
                                -- print(playerDead)
                                gotpressed = true
                            end
                        })
                    else
                        ESX.SetTimeout(300000, function()
                            gotpressed = false
                        end)
                        RageUI.Button("Loading...", "Vous venez d'envoyer un signal patienter 5 minutes avant d'en envoyer un nouveau...", {RightLabel = ""}, true, {
                            onSelected = function()
                          end
                        })
                    end
                    if (not noptmort) then
                        RageUI.Button("Réaparition possible dans "..timer.." secondes", nil, {RightLabel = ""}, false, {
                            onSelected = function()
                            end
                        })
                    else
                        RageUI.Button("Réapparaître", nil, {}, true, {
                            onSelected = function()
                                SetEntityCoords(PlayerPedId(), Config.RespawningPlace)
                                TriggerServerEvent('réanimerafterdie')
                            
                                Wait(1000)
                                gotpressed = false
                                noptmort = false
                            end
                        })
                    end
                end)
                if (not RageUI.Visible(mainMenu)) then
                    mainMenu = RMenu:DeleteType(mainMenu, true)
                    gotpressed = false
                    noptmort = false
                    timer = Config.TimeToRespawn
                end
                Wait(0)
            end
        end
    end)
end

-- AddEventHandler('playerSpawned', function()
--     ExecuteCommand("me dqsdqs dqsd")
-- end)