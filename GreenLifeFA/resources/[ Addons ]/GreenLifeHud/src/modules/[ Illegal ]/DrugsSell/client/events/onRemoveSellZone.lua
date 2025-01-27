RegisterNetEvent('GreenLife:Drugs:RemoveSellZone')
AddEventHandler('GreenLife:Drugs:RemoveSellZone', function(zoneId)
    MOD_DrugSell:delete(zoneId)
end)