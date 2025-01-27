_GreenLifeDrugWeed = {}

local __instance = {
    __index = _GreenLifeDrugWeed
}

setmetatable(_GreenLifeDrugWeed, {
    __call = function(_, bucket)
        local self = setmetatable({}, __instance)

        self.bucket = bucket

        self.plotManagCoords = GreenLife.enums.Labos.Types['weed']['plotManagement'].coords
        self.securityManagCoords = GreenLife.enums.Labos.Types['weed']['securityManagement'].coords

        self.plotList = {}
        self.plotList['small'] = {}
        self.plotList['big'] = {}

        local SmallPlot = GreenLife.enums.Labos.Types['weed']['plotManagement'].PlotList['small']
        local BigPlot = GreenLife.enums.Labos.Types['weed']['plotManagement'].PlotList['big']

        for i=1, #SmallPlot, 1 do
            self.plotList['small'][i] = "empty"
        end
        for i=1, #BigPlot, 1 do
            self.plotList['big'][i] = "empty"
        end


        self.plotManag = MOD_Zones:AddZone(vector3(self.plotManagCoords), function(xPlayer, Zone)
            TriggerClientEvent('GreenLife:Labo:Weed:OpenWeedLaboManagement', xPlayer.source)
        end, false, 0.8, "Ouvrir le menu de gestion du labos de weed", true)

        self.securityManag = MOD_Zones:AddZone(vector3(self.securityManagCoords), function(xPlayer, Zone)
            
        end, false, 0.8, "Ouvrir le menu de gestion du system de sécurité du labos", true)


        self:InitTickPot()

        --Functions
        exportMetatable(_GreenLifeDrugWeed, self)

        return (self)
    end
})



-- _GreenLifeDrugWeedPot = {}

-- local __instance = {
--     __index = _GreenLifeDrugWeedPot
-- }

-- setmetatable(_GreenLifeDrugWeedPot, {
--     __call = function(_, plotSize, plotIndex, potIndex)
--         local self = setmetatable({}, __instance)

--         self.plotSize = plotSize
--         self.plotIndex = plotIndex

--         self.potIndex = potIndex

--         self.state = "empty"

--         --Functions
--         exportMetatable(_GreenLifeDrugWeedPot, self)

--         return (self)
--     end
-- })