MOD_HUD:onReady(function()
   AddEventHandler('GreenLife:Hud:SetHudRadioFreq', function(string)
        MOD_HUD.class:SetRadioFreq(string)
    end) 
end)