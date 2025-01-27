_GreenLifeCoffreVehicule = {}

local __instance = {
    __index = _GreenLifeCoffreVehicule
}

setmetatable(_GreenLifeCoffreVehicule, {
    __call = function(_, inventory, model, plate, hasOwner, isCreated)
        local self = setmetatable({}, __instance)

        self.plate = plate
        self.hasOwner = hasOwner or false
        self.model = model
        
        if (hasOwner == true and isCreated == false) then
            MySQL.Async.execute('INSERT INTO trunk_inventory (vehicleModel, vehiclePlate, items) VALUES (@vehicleModel, @vehiclePlate, @items)', {
                vehicleModel = model,
                vehiclePlate = plate,
                items = json.encode({})
            })
        end

        local defaultSlots = 70
        local defaultWeight = self:getMaxWeight()
        self.inventoryClass = MOD_inventory:loadVehiculeInventory(self.plate, inventory, defaultSlots, defaultWeight, self)

        --Functions
        exportMetatable(_GreenLifeCoffreVehicule, self)

        MOD_CoffreVehicule.list[self.plate] = self

        return (self)
    end
})