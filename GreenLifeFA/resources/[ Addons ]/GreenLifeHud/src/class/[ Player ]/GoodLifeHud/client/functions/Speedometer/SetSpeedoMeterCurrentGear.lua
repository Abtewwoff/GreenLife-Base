---@return void
function _GreenLifeHud:GetVehicleCurrentGear(value)

    if (value == 0) then
        value = 'R'
    end

    sendUIMessage({
        event = 'SetValueGear',
        value = value
    })

end