ESX.Logs = {
    ---@param message string
    ["Info"] = function (message, ...)
        exports["GreenLifeHud"]:Info(message, ...);
    end,

    ---@param message string
    ["Warn"] = function (message, ...)
        exports["GreenLifeHud"]:Warn(message, ...);
    end,

    ---@param message string
    ["Error"] = function (message, ...)
        exports["GreenLifeHud"]:Error(message, ...);
    end,

    ---@param message string
    ["Success"] = function (message, ...)
        exports["GreenLifeHud"]:Success(message, ...);
    end
};

