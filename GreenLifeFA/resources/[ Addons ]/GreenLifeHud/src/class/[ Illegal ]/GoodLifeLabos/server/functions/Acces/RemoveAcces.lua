function _GreenLifeLabos:RemoveAcces(accesName)
    self.AccesList[accesName] = nil

    local PlayersInBucket = self.bucket:GetPlayersInBucket()
    
    for _, src in pairs(PlayersInBucket) do
        TriggerClientEvent('GreenLife:Labos:RemoveAcces', src, accesName)
    end
end