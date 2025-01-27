GreenLifeServerUtils = {}

GreenLifeServerUtils.toClient = function(eventName, targetId, ...)
    TriggerClientEvent("GreenLife:" .. GreenLife.hash(eventName), targetId, ...)
end

GreenLifeServerUtils.toAll = function(eventName, ...)
    TriggerClientEvent("GreenLife:" .. GreenLife.hash(eventName), -1, ...)
end

GreenLifeServerUtils.registerConsoleCommand = function(command, func)
    RegisterCommand(command, function(source,args)
        if source ~= 0 then return end
        func(source, args)
    end, false)
end

GreenLifeServerUtils.getLicense = function(source)
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
    return ""
end

GreenLifeServerUtils.trace = function(message, prefix)
end

local webhookColors = {
    ["red"] = 16711680,
    ["green"] = 56108,
    ["grey"] = 8421504,
    ["orange"] = 16744192
}

GreenLifeServerUtils.getIdentifiers = function(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for _, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers[_]
        end
        return identifiers
    end
end
