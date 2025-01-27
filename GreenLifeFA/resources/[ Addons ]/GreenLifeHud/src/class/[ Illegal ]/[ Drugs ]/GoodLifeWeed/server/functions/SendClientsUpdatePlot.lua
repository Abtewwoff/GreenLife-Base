function _GreenLifeDrugWeed:SendClientsUpdatePlot(plotSize, plotIndex)
    local PlayersInBucket = self.bucket:GetPlayersInBucket()
    
    for _, src in pairs(PlayersInBucket) do
        TriggerClientEvent('GreenLife:Labo:Weed:UpdatePlot', src, plotSize, plotIndex, self:GetPlotByIndex(plotSize, plotIndex))
    end
end