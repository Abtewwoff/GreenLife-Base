local buttonSeat = { [157] = -1, [158] = 0, [160] = 1, [164] = 2, [165] = 3, [159] = 4, [161] = 5, [162] = 6, [163] = 7 }
local blockShuffle = true

CreateThread(function()

    while true do
        local attente = 1500

        local Player = PlayerPedId()
        local veh = GetVehiclePedIsIn(Player, false)
        local speed = GetEntitySpeed(veh)*3.6
    
        if IsPedInAnyVehicle(Player, false) then
            attente = 1
            for key, seat in pairs(buttonSeat) do
                if IsDisabledControlJustPressed(1, key) and IsVehicleSeatFree(veh, seat) then
                    if speed > 15 then 
                        ESX.ShowNotification("Vous ne pouvez pas changer de place, ralentissez !")
                    else
                        SetPedIntoVehicle(Player, veh, seat)
                        blockShuffle = seat == 0
                        Wait(2000)
                    end
                end
            end
        end

        Wait(attente)
    end
end)