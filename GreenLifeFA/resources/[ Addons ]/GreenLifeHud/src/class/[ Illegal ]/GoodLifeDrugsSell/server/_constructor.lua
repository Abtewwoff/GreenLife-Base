_GreenLifeDrugsSell = {}

local __instance = {
    __index = _GreenLifeDrugsSell
}

setmetatable(_GreenLifeDrugsSell, {
    __call = function(_, DrugsSellId, coords, radius)
        local self = setmetatable({}, __instance)

        self.id = DrugsSellId

        self.coords = coords
        self.radius = radius

        --Functions
        exportMetatable(_GreenLifeDrugsSell, self)

        return (self)
    end
})