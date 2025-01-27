local isInInterfaceValue = false
exports('drawInfo', function(title, table)
    SendNUIMessage({
        action = 'show',
        title = title,
        data = table
    })
end)

exports('hideInfo', function(title, table)
    SendNUIMessage({
        action = 'hide',
    })
end)

function isInInterface()
    return isInInterfaceValue
end

function setInInterface(interfaceName)
    isInInterfaceValue = interfaceName

    Citizen.CreateThread(function()
        while isInInterfaceValue do 
            Wait(0)
            SetPauseMenuActive(false) 
            DisableControlAction(0, 37, true)
            DisableControlAction(1, 263)
        end
    end)
end

function clearInterface()
    isInInterfaceValue = false
end