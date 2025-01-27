function _GreenLifeStatus:getPercent()
    return (self.val / ConfigGreenLifeHud.status.StatusMax) * 100
end