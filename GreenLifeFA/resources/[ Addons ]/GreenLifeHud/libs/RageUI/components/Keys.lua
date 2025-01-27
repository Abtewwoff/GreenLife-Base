Keys = {};

function Keys.Register(Controls, ControlName, Description, Action)
    local _Keys = {
        CONTROLS = Controls
    }
    RegisterKeyMapping(string.format('RageUIMenus-%s', ControlName), Description, "keyboard", Controls)
    RegisterCommand(string.format('RageUIMenus-%s', ControlName), function(source, args)
        if (Action ~= nil) then
            Action();
        end
    end, false)
    return setmetatable(_Keys, Keys)
end

function Keys:Exists(Controls)
    return self.CONTROLS == Controls and true or false
end