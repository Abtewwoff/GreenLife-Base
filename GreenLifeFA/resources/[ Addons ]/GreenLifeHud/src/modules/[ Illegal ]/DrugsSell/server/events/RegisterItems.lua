CreateThread(function()
    Wait(500)

    
    MOD_Items:createUsableItem("nokia3310", function(source)
        TriggerClientEvent('GreenLife:Drugs:UseNokiaForSellDrugs', source)
    end)
end)