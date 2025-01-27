_GreenLifeStatus = {}
_GreenLifeStatus.className = "_GreenLifeStatus"

local __instance = {
    __index = _GreenLifeStatus,
}

setmetatable(_GreenLifeStatus, {
    __call = function(_, name, value, tickcallback)
        local self = setmetatable({}, __instance)

        self.name = name
        self.val = value
        self.tickcallback = tickcallback

        --Functions
        exportMetatable(_GreenLifeStatus, self)

        return (self)
    end
})