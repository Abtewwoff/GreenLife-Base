---@return void
function _GreenLifeHud:UpdatePlayersConnected(int)

    self.ServerInfos.playerConnected = int

    self:UpdateServerInfosData()

end