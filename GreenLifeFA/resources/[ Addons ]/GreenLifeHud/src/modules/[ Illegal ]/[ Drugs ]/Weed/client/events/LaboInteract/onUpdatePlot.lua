RegisterNetEvent('GreenLife:Labo:Weed:UpdatePlot')
AddEventHandler('GreenLife:Labo:Weed:UpdatePlot', function(plotSize, plotIndex, plotData)
    MOD_Weed:UpdatePlotByIndex(plotSize, plotIndex, plotData)
end)