---@return void
function _GreenLifeHud:SetSpeedoMeterVisible(bool)

    sendUIMessage({
        ShowSpeedoMeter = bool
    })

    self.StateSpeedoMeter = bool

end