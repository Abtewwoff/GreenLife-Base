RegisterNetEvent('GreenLife:Drugs:AddSellZones')
AddEventHandler('GreenLife:Drugs:AddSellZones', function(zones)
    for _, zone in pairs(zones) do
        MOD_DrugSell:add(zone)
    end
end)