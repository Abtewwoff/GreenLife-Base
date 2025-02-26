function MOD_DrugSell:AddZoneSell(coords, radius)
    local NewZoneId = #MOD_DrugSell.ZoneList + 1

    if (MOD_DrugSell.ZoneList[NewZoneId]) then print("Error: This zone already exists") return end

    MOD_DrugSell.ZoneList[NewZoneId] = _GreenLifeDrugsSell(NewZoneId, coords, radius)

    TriggerClientEvent('GreenLife:Drugs:AddSellZone', -1, MOD_DrugSell.ZoneList[NewZoneId]:minify())

    return (MOD_DrugSell.ZoneList[NewZoneId])
end