GreenLife = {}
GreenLife.newThread = Citizen.CreateThread
GreenLife.newWaitingThread = Citizen.SetTimeout
--Citizen.CreateThread, CreateThread, Citizen.SetTimeout, SetTimeout, InvokeNative = nil, nil, nil, nil, nil

Job = nil
Jobs = {}
Jobs.list = {}

GreenLifePrefixes = {
    zones = "^1ZONE",
    err = "^1ERREUR",
    blips = "^1BLIPS",
    npcs = "^1NPCS",
    dev = "^6INFOS",
    sync = "^6SYNC",
    jobs = "^6JOBS",
    succes = "^2SUCCÈS"
}

GreenLife.hash = function(notHashedModel)
    return GetHashKey(notHashedModel)
end

GreenLife.prefix = function(title, message)
    return ("[~g~GreenLife^0] (%s^0) %s" .. "^0"):format(title, message)
end

local registredEvents = {}
local function isEventRegistred(eventName)
    for k,v in pairs(registredEvents) do
        if v == eventName then return true end
    end
    return false
end

GreenLife.netRegisterAndHandle = function(eventName, handler)
    local event = "GreenLife:" .. GreenLife.hash(eventName)
    if not isEventRegistred(event) then
        RegisterNetEvent(event)
        table.insert(registredEvents, event)
    end
    AddEventHandler(event, handler)
end


GreenLife.netRegister = function(eventName)
    local event = "GreenLife:" .. GreenLife.hash(eventName)
    RegisterNetEvent(event)
end


GreenLife.netHandle = function(eventName, handler)
    local event = "GreenLife:" .. GreenLife.hash(eventName)
    AddEventHandler(event, handler)
end


GreenLife.netHandleBasic = function(eventName, handler)
    AddEventHandler(eventName, handler)
end

GreenLife.second = function(from)
    return from*1000
end

GreenLife.toInternal = function(eventName, ...)
    TriggerEvent("GreenLife:" .. GreenLife.hash(eventName), ...)
end

