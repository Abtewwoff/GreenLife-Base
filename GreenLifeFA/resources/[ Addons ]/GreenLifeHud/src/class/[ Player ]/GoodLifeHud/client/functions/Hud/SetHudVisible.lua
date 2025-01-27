---@return void
function _GreenLifeHud:SetHudVisible(bool)

    sendUIMessage({
        ShowHud = bool
    })

    self.StateHud = bool

end