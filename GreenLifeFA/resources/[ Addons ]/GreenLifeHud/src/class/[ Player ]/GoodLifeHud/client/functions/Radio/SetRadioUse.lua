---@return void
function _GreenLifeHud:SetRadioUse(bool)

    sendUIMessage({
        event = 'SetRadioUse',
        RadioUse = bool
    })

end