CreateThread(function()
    while (MOD_HUD.class == nil) do
        Wait(100)
    end

    MOD_HUD.class:SetHudVisible(true)

    MOD_HUD.ready = true
    TriggerEvent("GreenLife:Hud:ReadyHudClient")
end)