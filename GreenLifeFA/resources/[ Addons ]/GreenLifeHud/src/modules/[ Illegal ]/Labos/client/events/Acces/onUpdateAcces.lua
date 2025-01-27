RegisterNetEvent('GreenLife:Labos:UpdateAcces')
AddEventHandler('GreenLife:Labos:UpdateAcces', function(accesName, data)
    MOD_Labos.LabData.AccesList[accesName] = data
end)