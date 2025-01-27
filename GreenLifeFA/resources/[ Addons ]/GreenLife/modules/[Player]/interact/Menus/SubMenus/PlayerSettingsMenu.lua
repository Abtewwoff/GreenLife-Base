--function Abteww:DrawText(text, x, y, scale)
--    SetTextFont(0)
--    SetTextScale(scale.size, scale.size)
--    SetTextOutline()
--    SetTextEntry("STRING")
--    SetTextCentre(true)
--    AddTextComponentString(text)
--    DrawText(x, y)
--end
--
--function degreesToIntercardinalDirection(dgr)
--	dgr = dgr % 360.0
--	
--	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
--		return "N "
--	elseif dgr >= 22.5 and dgr < 67.5 then
--		return "NE"
--	elseif dgr >= 67.5 and dgr < 112.5 then
--		return "E"
--	elseif dgr >= 112.5 and dgr < 157.5 then
--		return "SE"
--	elseif dgr >= 157.5 and dgr < 202.5 then
--		return "S"
--	elseif dgr >= 202.5 and dgr < 247.5 then
--		return "SW"
--	elseif dgr >= 247.5 and dgr < 292.5 then
--		return "W"
--	elseif dgr >= 292.5 and dgr < 337.5 then
--		return "NW"
--	end
--end
--
--local compass = { cardinal={}, intercardinal={}}
--
--compass.show = true
--compass.position = {x = 0.5, y = 0.07, centered = true}
--compass.width = 0.25
--compass.fov = 180
--compass.followGameplayCam = true
--
--compass.ticksBetweenCardinals = 9.0
--compass.tickColour = {r = 255, g = 255, b = 255, a = 255}
--compass.tickSize = {w = 0.001, h = 0.008}
--
--compass.cardinal.textSize = 0.25
--compass.cardinal.textOffset = 0.015
--compass.cardinal.textColour = {r = 255, g = 255, b = 255, a = 255}
--
--compass.cardinal.tickShow = true
--compass.cardinal.tickSize = {w = 0.001, h = 0.01}
--compass.cardinal.tickColour = {r = 255, g = 255, b = 255, a = 255}
--
--compass.intercardinal.show = true
--compass.intercardinal.textShow = true
--compass.intercardinal.textSize = 0.2
--compass.intercardinal.textOffset = 0.015
--compass.intercardinal.textColour = {r = 255, g = 255, b = 255, a = 255}
--
--compass.intercardinal.tickShow = true
--compass.intercardinal.tickSize = {w = 0.001, h = 0.01}
--compass.intercardinal.tickColour = {r = 255, g = 255, b = 255, a = 255}
--
--CreateThread(function()
--	if compass.position.centered then
--		compass.position.x = compass.position.x - compass.width / 2
--	end
--	
--	while compass.show do
--		
--		local pxDegree = compass.width / compass.fov
--		local playerHeadingDegrees = 0
--		
--		if compass.followGameplayCam then
--			-- Converts [-180, 180] to [0, 360] where E = 90 and W = 270
--			local camRot = Citizen.InvokeNative(0x837765A25378F0BB, 0, Citizen.ResultAsVector())
--			playerHeadingDegrees = 360.0 - ((camRot.z + 360.0) % 360.0)
--		else
--			-- Converts E = 270 to E = 90
--			playerHeadingDegrees = 360.0 - GetEntityHeading(Abteww.PlayerPed)
--		end
--		
--		local tickDegree = playerHeadingDegrees - compass.fov / 2
--		local tickDegreeRemainder = compass.ticksBetweenCardinals - (tickDegree % compass.ticksBetweenCardinals)
--		local tickPosition = compass.position.x + tickDegreeRemainder * pxDegree
--		
--		tickDegree = tickDegree + tickDegreeRemainder
--		
--		while tickPosition < compass.position.x + compass.width do
--			if (tickDegree % 90.0) == 0 then
--				-- Draw cardinal
--				if compass.cardinal.tickShow then
--					DrawRect(tickPosition, compass.position.y, compass.cardinal.tickSize.w, compass.cardinal.tickSize.h, compass.cardinal.tickColour.r, compass.cardinal.tickColour.g, compass.cardinal.tickColour.b, compass.cardinal.tickColour.a)
--				end
--				
--				Abteww:DrawText(degreesToIntercardinalDirection(tickDegree), tickPosition, compass.position.y + compass.cardinal.textOffset, {
--					size = compass.cardinal.textSize,
--					colour = compass.cardinal.textColour,
--					outline = true,
--					centered = true
--				})
--			elseif (tickDegree % 45.0) == 0 and compass.intercardinal.show then
--				-- Draw intercardinal
--				if compass.intercardinal.tickShow then
--					DrawRect(tickPosition, compass.position.y, compass.intercardinal.tickSize.w, compass.intercardinal.tickSize.h, compass.intercardinal.tickColour.r, compass.intercardinal.tickColour.g, compass.intercardinal.tickColour.b, compass.intercardinal.tickColour.a)
--				end
--				
--				if compass.intercardinal.textShow then
--					Abteww:DrawText(degreesToIntercardinalDirection(tickDegree), tickPosition, compass.position.y + compass.intercardinal.textOffset, {
--						size = compass.intercardinal.textSize,
--						colour = compass.intercardinal.textColour,
--						outline = true,
--						centered = true
--					})
--				end
--			else
--				-- Draw tick
--				DrawRect(tickPosition, compass.position.y, compass.tickSize.w, compass.tickSize.h, compass.tickColour.r, compass.tickColour.g, compass.tickColour.b, compass.tickColour.a)
--			end
--			
--			-- Advance to the next tick
--			tickDegree = tickDegree + compass.ticksBetweenCardinals
--			tickPosition = tickPosition + pxDegree * compass.ticksBetweenCardinals
--		end
--		Wait(7)
--	end
--end)
--
--local streetName = {}
--
--streetName.show = true
--streetName.position = {x = 0.5, y = 0.02, centered = true}
--streetName.textSize = 0.3
--streetName.textColour = {r = 255, g = 255, b = 255, a = 255}
--
--CreateThread(function()
--	local lastStreetA = 0
--	local lastStreetB = 0
--	local lastStreetName = {}
--	
--	while streetName.show do
--		
--		local playerPos = GetEntityCoords(PlayerPedId(), true)
--		local streetA, streetB = Citizen.InvokeNative(0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
--        street = {}
--		
--		if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
--			-- Ignores the switcharoo while doing circles on intersections
--			lastStreetA = streetA
--			lastStreetB = streetB
--		end
--		
--		if lastStreetA ~= 0 then
--			table.insert(street, GetStreetNameFromHashKey(lastStreetA))
--		end
--		
--		if lastStreetB ~= 0 then
--			table.insert(street, GetStreetNameFromHashKey(lastStreetB))
--		end
--        
--		Wait(3000)
--	end
--end)
--
--CreateThread(function()
--	while streetName.show do
--		Abteww:DrawText(table.concat(street, " & "), streetName.position.x, streetName.position.y, {
--			size = streetName.textSize,
--			colour = streetName.textColour,
--			outline = true,
--			centered = streetName.position.centered
--		})
--		Wait(7)
--	end
--end)

function Abteww:GetIDproche()
    for _, player in ipairs(GetActivePlayers()) do
        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
        local coords = GetEntityCoords(GetPlayerPed(player))
        local sta = GetPlayerServerId()

        if IsEntityVisible(GetPlayerPed(player)) then
            if dst < 3.0 then
                if sta ~= "me" then
                    RageUI.Button("ID : ~o~"..GetPlayerServerId(player).. " ~s~| "..GetPlayerName(player), nil, {}, true, function(h,a,s)      
                        if a then
                            DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 128, 4, 245, 100, true, true)
                        end
                        if s then
                            ESX.ShowNotification("L'ID de cette personne est le ~g~"..GetPlayerServerId(player))
                        end
                    end)
                end
            end
        end
    end
end

function Abteww:visualisationnn()

    RageUI.Checkbox("Vue & lumières améliorées", nil, Config.vision, {}, {
        onChecked = function()
            Config.vision = true
            SetTimecycleModifier('tunnel')
        end,
        onUnChecked = function()
            Config.vision = false
            SetTimecycleModifier('default')
        end
    })
    RageUI.Checkbox("Vue & lumières améliorées x2", nil, Config.vision2, {}, {
        onChecked = function()
            Config.vision2 = true
            SetTimecycleModifier('CS3_rail_tunnel')
        end,
        onUnChecked = function()
            Config.vision2 = false
            SetTimecycleModifier('default')
        end
    })
    RageUI.Checkbox("Vue & lumières améliorées x3", nil, Config.vision3, {}, {
        onChecked = function()
            Config.vision3 = true
            SetTimecycleModifier('MP_lowgarage')
        end,
        onUnChecked = function()
            Config.vision3 = false
            SetTimecycleModifier('default')
        end
    })
    RageUI.Checkbox("Vue lumineux", nil, Config.vision4, {}, {
        onChecked = function()
            Config.vision4 = true
            SetTimecycleModifier('rply_vignette_neg')
        end,
        onUnChecked = function()
            Config.vision4 = false
            SetTimecycleModifier('default')
        end
    })
    RageUI.Checkbox("Vue lumineux x2", nil, Config.vision5, {}, {
        onChecked = function()
            Config.vision5 = true
            SetTimecycleModifier('rply_saturation_neg')
        end,
        onUnChecked = function()
            Config.vision5 = false
            SetTimecycleModifier('default')
        end
    })
    RageUI.Checkbox("Couleurs amplifiées", nil, Config.vision6, {}, {
        onChecked = function()
            Config.vision6 = true
            SetTimecycleModifier('rply_saturation')
        end,
        onUnChecked = function()
            Config.vision6 = false
            SetTimecycleModifier('default')
        end
    })
    RageUI.Checkbox("Noir & blancs", nil, Config.vision7, {}, {
        onChecked = function()
            Config.vision7 = true
            SetTimecycleModifier('rply_saturation_neg')
        end,
        onUnChecked = function()
            Config.vision7 = false
            SetTimecycleModifier('default')
        end
    })
    RageUI.Checkbox("Visual 1", nil, Config.vision8, {}, {
        onChecked = function()
            Config.vision8 = true
            SetTimecycleModifier('yell_tunnel_nodirect')
        end,
        onUnChecked = function()
            Config.vision8 = false
            SetTimecycleModifier('default')
        end
    })
    RageUI.Checkbox("Blanc", nil, Config.vision9, {}, {
        onChecked = function()
            Config.vision9 = true
            SetTimecycleModifier('rply_contrast_neg')
        end,
        onUnChecked = function()
            Config.vision9 = false
            SetTimecycleModifier('default')
        end
    })
    RageUI.Checkbox("Dégats", nil, Config.vision10, {}, {
        onChecked = function()
            Config.vision10 = true
            SetTimecycleModifier('rply_vignette')
        end,
        onUnChecked = function()
            Config.vision10 = false
            SetTimecycleModifier('default')
        end
    })
    RageUI.Checkbox("Boost FPS", nil, FPSBoost, {}, {
        onChecked = function()
            SetTimecycleModifier("yell_tunnel_nodirect");
        end,
        onUnChecked = function()
            SetTimecycleModifier("");
        end,
        onSelected = function(Index)
            FPSBoost = Index;
        end
    })
end

function Abteww:GetPlayerSettingsMenu()

    RageUI.Checkbox("Mode Cinématique", nil, Abteww.Cenematique, {}, {
        onChecked = function()
            ExecuteCommand("noir")
        end,
        onUnChecked = function()
            ExecuteCommand("noir")
        end,
        onSelected = function(Index)
            Abteww.Cenematique = Index;
        end
    });

    RageUI.Checkbox("Masquer l\'interface", nil, Abteww.Interface, {}, {
        onChecked = function()
            TriggerEvent('GreenLife:Hud:StateHud', false)
        end,
        onUnChecked = function()
            TriggerEvent('GreenLife:Hud:StateHud', true)
        end,
        onSelected = function(Index)
            Abteww.Interface = Index;
        end
    });

    RageUI.Checkbox("Désactiver Casque de moto", nil, Abteww.CasqueMoto, {}, {
        onChecked = function()
            SetPedHelmet(PlayerPedId(), false)
        end,
        onUnChecked = function()
            SetPedHelmet(PlayerPedId(), true)
        end,
        onSelected = function(Index)
            Abteww.CasqueMoto = Index;
        end
    });

    RageUI.Checkbox("Vente de drogue", nil, Abteww.SellingDrug, {}, {
        onChecked = function()
            ExecuteCommand("ventedrogue");
        end,
        onUnChecked = function()
            ExecuteCommand("ventedrogue");
        end,
        onSelected = function(Index)
            Abteww.SellingDrug = Index;
        end
    });

    RageUI.Checkbox("Caméra AFK", nil, Abteww.IdleCam, {}, {
        onChecked = function()
            DisableIdleCamera(false);
            SetResourceKvp("idleCam", "on");
            ESX.ShowNotification("Caméra AFK : ~g~ON");
        end,
        onUnChecked = function()
            DisableIdleCamera(true);
            SetResourceKvp("idleCam", "off");
            ESX.ShowNotification("Caméra AFK : ~r~OFF");
        end,
        onSelected = function(Index)
            Abteww.IdleCam = Index;
        end
    });

    RageUI.Checkbox("Afficher la minimap", nil, Abteww.ShowMinimap, {}, {
    onChecked = function()
        DisplayRadar(true);
    end,
    onUnChecked = function()
        DisplayRadar(false);
    end,
    onSelected = function(Index)
        Abteww.ShowMinimap = Index;
    end
});

RageUI.Separator("↓ ~c~Autre Option~s~ ↓")

RageUI.Button("ID proche", nil, {RightLabel = "→→"}, true, {}, Abteww.IDproche);

end
