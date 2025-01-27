RegisterNetEvent('GreenLife:Labos:AddNewAcces')
AddEventHandler('GreenLife:Labos:AddNewAcces', function(accesName, data)
    MOD_Labos.LabData.AccesList[accesName] = data
end)