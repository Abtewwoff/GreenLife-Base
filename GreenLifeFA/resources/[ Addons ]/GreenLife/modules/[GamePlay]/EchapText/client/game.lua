local onlinePlayers = 0

RegisterNetEvent('GreenLife:Hud:UpdatePlayersCount')
AddEventHandler('GreenLife:Hud:UpdatePlayersCount', function(int)
	onlinePlayers = int
end)

CreateThread(function()
    while true do
        AddTextEntry('FE_THDR_GTAO', ('~g~ GreenLife ~s~RP ~s~| [~g~'..GetPlayerServerId(PlayerId())..'~s~] | [~g~'..GetPlayerName(PlayerId()))..'~s~] | [~g~'..onlinePlayers..'~s~] Joueurs | discord.gg/~g~GreenLife')
        AddTextEntry('PM_PANE_KEYS', 'Configurer vos Touches')
        AddTextEntry('PM_PANE_AUD', 'Audio & Son')
        AddTextEntry('PM_PANE_GTAO', 'Touches Basique')
        AddTextEntry('PM_PANE_CFX', '~g~ GreenLife')
        AddTextEntry('PM_PANE_LEAVE', 'Retourner sur la liste des serveurs.')
        AddTextEntry('PM_PANE_QUIT', 'Quitter ~g~ GreenLife')
        AddTextEntry('PM_SCR_MAP', 'Carte de Los Santos ∑')
        AddTextEntry('PM_SCR_GAM', 'Prendre l\'avion')
        AddTextEntry('PM_SCR_INF', 'Logs')
        AddTextEntry('PM_SCR_SET', 'Configuration')
        AddTextEntry('PM_SCR_STA', 'Statistiques')
        AddTextEntry('PM_SCR_RPL', '')
        AddTextEntry(0x5617744E, "Déconnexion de GreenLife. Veuillez patienter...")
	
        Wait(1000)
    end
end)

CreateThread(function()
	while true do
		SetDiscordAppId(1324191052915015753)
		SetDiscordRichPresenceAsset('logo')
		SetDiscordRichPresenceAssetText('Rejoins nous !')
		SetRichPresence(GetPlayerName(PlayerId()) .." ["..GetPlayerServerId(PlayerId()).."] - "..onlinePlayers.." joueurs")
		SetDiscordRichPresenceAction(0, "Rejoindre le discord", "https://discord.gg/greenLife")
		SetDiscordRichPresenceAction(1, "Boutique du serveur", "https://greenlifefa.tebex.io/")

		Wait(5000)
	end
end)


-- CreateThread(function()
-- 	local wait = 15
-- 	local count = 60
-- 	local KO = false

-- 	while true do
-- 		if IsPedInMeleeCombat(PlayerPedId()) then
-- 			if GetEntityHealth(PlayerPedId()) < 115 then
-- 				ESX.ShowNotification("Vous êtes assommé")
-- 				wait = 15
-- 				KO = true
-- 				SetPedHealth(PlayerPedId(), 116)
-- 			end
-- 		end

-- 		if KO then
-- 			SetPlayerInvincible(PlayerId(), true)
-- 			DisablePlayerFiring(PlayerId(), true)
-- 			SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
-- 			ResetPedRagdollTimer(PlayerPedId())

-- 			if wait >= 0 then
-- 				count = count - 1

-- 				if count == 0 then
-- 					count = 60
-- 					wait = wait - 1
-- 					SetPedHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 4)
-- 				end
-- 			else
-- 				SetPlayerInvincible(PlayerId(), false)
-- 				KO = false
-- 			end
-- 		end

-- 		Wait(3)
-- 	end
-- end)