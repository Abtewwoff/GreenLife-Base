function GreenLife:onGreenLifeReady(callback)
    AddEventHandler('GreenLife:IsReady', function()
        callback()
    end)
end