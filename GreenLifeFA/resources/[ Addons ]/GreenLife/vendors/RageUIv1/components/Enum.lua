---
--- @author Dylan MALANDAIN
--- @version 2.0.0
--- @since 2020
---
--- RageUIv1 Is Advanced UI Libs in LUA for make beautiful interface like RockStar GAME.
---
---
--- Commercial Info.
--- Any use for commercial purposes is strictly prohibited and will be punished.
---
--- @see RageUIv1
---

---@class Enum
local enums = {
    __index = function(table, key)
        if rawget(table.enums, key) then
            return key
        end
    end
}

---Enum
---@param t table
---@return Enum
function RageUIv1.Enum(t)
    local e = { enums = t }
    return setmetatable(e, enums)
end
