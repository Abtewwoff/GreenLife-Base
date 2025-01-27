_GreenLifeItems = {}

local __instance = {
    __index = _GreenLifeItems
}

setmetatable(_GreenLifeItems, {
    __call = function(_, type, data)
        local self = setmetatable({}, __instance)
    
        self.type = type
        self.name = data.name
        self.label = data.label
        self.weight = data.weight
        self.unique = false

        if (data.unique == 1) then
            self.unique = true
        end
        

        --Functions
        exportMetatable(_GreenLifeItems, self)

        return (self)
    end
})