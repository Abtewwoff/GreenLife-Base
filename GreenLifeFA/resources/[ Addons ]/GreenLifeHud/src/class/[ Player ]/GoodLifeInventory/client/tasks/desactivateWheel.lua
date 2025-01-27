function _GreenLifeInventory:desactivateWheel()
    CreateThread(function()
        while true do
            SetPedConfigFlag(PlayerPedId(), 48, true)
    
            if (IsPedSittingInAnyVehicle(PlayerPedId())) then
                SetPedConfigFlag(PlayerPedId(), 48, false)
            end
    
            Wait(800)
        end
    end)    
end