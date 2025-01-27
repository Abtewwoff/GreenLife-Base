GreenLifeClientUtils = {}

GreenLifeClientUtils.toServer = function(eventName, ...)
    TriggerServerEvent("GreenLife:" .. GreenLife.hash(eventName), ...)
end
