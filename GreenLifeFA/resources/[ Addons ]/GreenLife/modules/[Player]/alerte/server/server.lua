ESX = exports['Framework']:getSharedObject()

local playerLastGunshots = {}

local function isPlayerWhitelisted(playerJob)
    jobAcces = {"police", "fbi", "bsco"}
    for _, job in ipairs(jobAcces) do
        if playerJob.name == job then
            return true
        end
    end
    return false
end

RegisterServerEvent('Abteww:Alerte:GunShoot')
AddEventHandler('Abteww:Alerte:GunShoot', function(targetCoords, streetName)
    local _source = source
    local xPlayers = ESX.GetExtendedPlayers()
    local currentTime = os.time()

    if playerLastGunshots[_source] and (currentTime - playerLastGunshots[_source] < 10) then
        return
    end

    playerLastGunshots[_source] = currentTime

    for _, xPlayer in ipairs(xPlayers) do
        if isPlayerWhitelisted(xPlayer.getJob()) then
            local alert = string.format("Alerte : ~b~Un coup de feu a été entendu<br/>~s~Avenue : ~g~ %s", streetName)
            TriggerClientEvent('Abteww:Alerte:Notify', xPlayer.source, alert, targetCoords)
        end
    end
end)