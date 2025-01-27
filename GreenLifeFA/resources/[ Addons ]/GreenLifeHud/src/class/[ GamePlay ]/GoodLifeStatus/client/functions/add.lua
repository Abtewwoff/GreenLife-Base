function _GreenLifeStatus:add(value)
    if self.val + value > ConfigGreenLifeHud.status.StatusMax then
        self.val = ConfigGreenLifeHud.status.StatusMax
    else
        self.val = self.val + value
    end
end