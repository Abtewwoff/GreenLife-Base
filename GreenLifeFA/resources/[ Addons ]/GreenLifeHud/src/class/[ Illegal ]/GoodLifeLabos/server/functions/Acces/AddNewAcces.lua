function _GreenLifeLabos:AddNewAcces(accesName)
    self.AccesList[accesName] = {}

    local PlayersInBucket = self.bucket:GetPlayersInBucket()
    
    for _, src in pairs(PlayersInBucket) do
        TriggerClientEvent('GreenLife:Labos:AddNewAcces', src, accesName, self.AccesList[accesName])
    end
end