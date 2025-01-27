function _GreenLifeInventory:setSettingsInventory(settings)
    
    if (settings.PedEnable and self.StateInventory) then
        self:CreatePedScreen(true)
    else
        self:DeletePedScreen()
    end

    self.settings = settings

end