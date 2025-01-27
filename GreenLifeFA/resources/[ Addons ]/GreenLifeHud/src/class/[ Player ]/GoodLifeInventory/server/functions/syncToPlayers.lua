function _GreenLifeInventory:syncToPlayers()
    for src,_ in pairs(self.playersOpened) do
        self:updateSecondInventory(src)
    end
end