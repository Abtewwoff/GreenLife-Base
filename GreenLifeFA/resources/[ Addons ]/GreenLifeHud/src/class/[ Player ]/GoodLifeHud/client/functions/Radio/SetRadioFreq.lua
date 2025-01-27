---@return void
function _GreenLifeHud:SetRadioFreq(string)

    sendUIMessage({
        event = 'SetRadioFreq',
        RadioFreq = string
    })

end