---@return void
function _GreenLifeHud:SetMicState(int)

    sendUIMessage({
        event = 'SetMicState',
        MicState = int
    })

end