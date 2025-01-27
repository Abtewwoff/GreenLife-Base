---@return void
function _GreenLifeHud:SetRadioStatus(bool)

    sendUIMessage({
        event = 'SetRadioStatus',
        RadioStatus = bool
    })

end