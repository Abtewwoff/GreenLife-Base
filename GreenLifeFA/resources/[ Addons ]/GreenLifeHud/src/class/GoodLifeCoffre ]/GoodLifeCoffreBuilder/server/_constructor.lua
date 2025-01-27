_GreenLifeCoffreBuilder = {}

local __instance = {
    __index = _GreenLifeCoffreBuilder
}

setmetatable(_GreenLifeCoffreBuilder, {
    __call = function(_, jobCoffre, idCoffre, coordsCoffre, inventory, maxWeight)
        local self = setmetatable({}, __instance)

        self.idCoffre = idCoffre
        self.jobCoffre = jobCoffre

        self.coordsCoffre = idCoffre

        local defaultSlots = 100
        self.inventoryClass = MOD_inventory:loadCoffreBuilderInventory(idCoffre, inventory, defaultSlots, maxWeight, self)

        --Functions
        exportMetatable(_GreenLifeCoffreBuilder, self)

        MOD_CoffreBuilder.list[idCoffre] = self

        return (self)
    end
})