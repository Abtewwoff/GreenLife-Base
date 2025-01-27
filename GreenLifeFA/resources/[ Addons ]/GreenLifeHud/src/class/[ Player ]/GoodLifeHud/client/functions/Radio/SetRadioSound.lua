---@return void
function _GreenLifeHud:SetRadioSound(sound, valume)

    sendUIMessage({
        event = 'SetRadioSound',
        dataSound = {
            sound = sound,
            volume = valume
        }
    })

end