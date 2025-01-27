_GreenLifeLabos = {}

local __instance = {
    __index = _GreenLifeLabos
}

setmetatable(_GreenLifeLabos, {
    __call = function(_, LaboId, owner, _type, enterCoords)
        local self = setmetatable({}, __instance)

        self.id = LaboId

        self.owner = owner
        self.type = _type
        self.bucket = MOD_Buckets:AddBucket()

        self.memberList = {}
        self.AccesList = {}

        self.ListPlayerOnLabo = {}

        self.enterCoords = enterCoords
        self.exitCoords = GreenLife.enums.Labos.Types[self.type]['exit'].coords

        self.enterZone = MOD_Zones:AddZone(vector3(self.enterCoords), function(xPlayer, Zone)
            TriggerEvent('GreenLife:Labos:PlayerEnter', xPlayer, Zone, self.id)
        end, false, 0.8, "Entrer dans le labos", false)

        self.exitZone = MOD_Zones:AddZone(vector3(self.exitCoords), function(xPlayer, Zone)
            TriggerEvent('GreenLife:Labos:PlayerExit', xPlayer, Zone, self.id)
        end, false, 0.8, "Sortir du labos", true)

        if (_type == "weed") then
            self.Drug = _GreenLifeDrugWeed(self.bucket)
        end
        
        --Functions
        exportMetatable(_GreenLifeLabos, self)

        return (self)
    end
})