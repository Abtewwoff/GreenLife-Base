function _My()
    Action_Config = {
        My = {
            {
                Type = "buttom",
                IsRestricted = false,
                Blocked = false,
                CloseOnClick = false,
                Label = ("Mon ID : %s"):format(GetPlayerServerId(PlayerId())),
                OnClick = function()
                end,
            },
            {
                Type = "buttom",
                IsRestricted = false,
                Blocked = false,
                CloseOnClick = false,
                Label = ("Mon nom : %s"):format(GetPlayerName(PlayerId())),
                OnClick = function()
                end,
            },
            {
                Type = "buttom",
                IsRestricted = false,
                Blocked = false,
                CloseOnClick = true,
                Label = "Me (...)",
                OnClick = function()
                    local imput = exports["cfx-target"]:ShowSync('Veuillez indiquer votre prénom (ex : Enzo) ', true, 600, "small_text")
                    -- local imput = exports["cfx-target"]:ShowSync('Entrez un nom', false, 600., "small_text")
                    ExecuteCommand('me '..imput)
                end,
            }
        },
    }
end