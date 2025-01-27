---@return void
function _GreenLifeHud:SetSpeedoMeterValueFuel(value)

    sendUIMessage({
        event = 'SetValueFuel',
        value = value
    })

end