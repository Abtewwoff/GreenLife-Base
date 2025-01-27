---@return void
function _GreenLifeHud:onExitSafeZone(time)

    sendUIMessage({
        event = 'ExitSafeZone',
        time = time
    })

end