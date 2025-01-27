---@return void
function _GreenLifeHud:SetMicStatus(bool)

    sendUIMessage({
        event = 'SetMicStatus',
        MicStatus = bool
    })

end