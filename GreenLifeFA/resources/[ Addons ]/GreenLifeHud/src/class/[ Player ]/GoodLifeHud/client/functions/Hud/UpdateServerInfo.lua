---@return void
function _GreenLifeHud:UpdateServerInfosData(bool)

    sendUIMessage({
        event = 'SetServerInfosData',
        ServerInfos = {
            playerConnected = self.ServerInfos.playerConnected
        }
    })

end