local function Initialize(callback)
    local ItemsLoaded = promise.new()

    MOD_Items:load(function() 
        ItemsLoaded:resolve() 
    end)

    Citizen.Await(ItemsLoaded)

    callback()
end

AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    print("~g~[GreenLifeHud] ^2[SUCCESS] ^7GreenLifeHud is starting ...")

    Initialize(function()
        TriggerEvent('GreenLife:IsReady')
    end)
end)