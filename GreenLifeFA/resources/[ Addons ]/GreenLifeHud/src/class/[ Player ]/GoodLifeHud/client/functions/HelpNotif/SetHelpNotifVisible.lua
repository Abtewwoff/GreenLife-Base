---@return void
function _GreenLifeHud:SetHelpNotifVisible(message)

    sendUIMessage({
        HelpNotifShow = true,
        HelpText = message
    })

end