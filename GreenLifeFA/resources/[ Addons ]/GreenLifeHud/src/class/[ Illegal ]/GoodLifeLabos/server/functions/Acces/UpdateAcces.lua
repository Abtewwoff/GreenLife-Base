function _GreenLifeLabos:UpdateAcces(name, accesName, state)
    self.AccesList[name][accesName] = state

    local PlayersInBucket = self.bucket:GetPlayersInBucket()
    
    for _, src in pairs(PlayersInBucket) do
        TriggerClientEvent('GreenLife:Labos:UpdateAcces', src, name, self.AccesList[name])
    end
end