RegisterNetEvent('GreenLife:Labo:ExitLabo')
AddEventHandler('GreenLife:Labo:ExitLabo', function(laboType)

    MOD_Labos.LabData = {}

    if (laboType == "weed") then
        MOD_Weed:ExitWeedLabo()
    end
end)