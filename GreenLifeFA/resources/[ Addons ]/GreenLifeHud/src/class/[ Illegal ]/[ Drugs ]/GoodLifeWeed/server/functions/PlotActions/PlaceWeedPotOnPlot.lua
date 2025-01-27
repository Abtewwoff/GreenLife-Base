function _GreenLifeDrugWeed:PlaceWeedPotOnPlot(plotSize, plotIndex, potIndex)
    if (self.plotList[plotSize][plotIndex] ~= "empty") then
        local PotProcces = GreenLife.enums.Labos.Types['weed']['procces']['placePot']
        local PotInfos = GreenLife.enums.Labos.Types['weed']['plotManagement'].PlotList[plotSize][plotIndex].PotList[potIndex]

        self.plotList[plotSize][plotIndex].PotList[potIndex] = {
            object = PotProcces.object,
            prop = CreateObjectNoOffset(PotProcces.object, PotInfos.x, PotInfos.y, PotInfos.z - 1.0, true, true, true),
            state = PotProcces.state
        }

        self.plotList[plotSize][plotIndex].PotList[potIndex].propNetId = NetworkGetNetworkIdFromEntity(self.plotList[plotSize][plotIndex].PotList[potIndex].prop)

        FreezeEntityPosition(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, true)
        self.bucket:AddInBucket(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, "object")
    end

    self:SendClientsUpdatePlot(plotSize, plotIndex)
end