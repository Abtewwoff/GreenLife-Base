_GreenLifeVehicule = {}
_GreenLifeVehicule.className = "_GreenLifeStatus"

local __instance = {
    __index = _GreenLifeVehicule,
}

local function IsString(var)
    return type(var) == "string"
end

setmetatable(_GreenLifeVehicule, {
    __call = function(_, model, position, heading, plate, owner)
        local self = setmetatable({}, __instance)

        self.model = IsString(model) and GetHashKey(model) or model
        self.position = position
        self.heading = heading
        self.plate = plate
        self.networkId = nil

        self.owner = owner

        --Functions
        exportMetatable(_GreenLifeVehicule, self)

        return (self)
    end
})