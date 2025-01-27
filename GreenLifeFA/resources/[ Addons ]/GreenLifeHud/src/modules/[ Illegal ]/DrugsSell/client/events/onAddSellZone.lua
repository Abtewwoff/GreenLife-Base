RegisterNetEvent('GreenLife:Drugs:AddSellZone')
AddEventHandler('GreenLife:Drugs:AddZSellone', function(zone)
    MOD_DrugSell:add(zone)
end)