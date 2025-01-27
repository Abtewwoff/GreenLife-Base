---@return void
function _GreenLifeHud:onEnterSafeZone(time)
    
    sendUIMessage({
        event = 'EnterSafeZone',
        time = time
    })

end