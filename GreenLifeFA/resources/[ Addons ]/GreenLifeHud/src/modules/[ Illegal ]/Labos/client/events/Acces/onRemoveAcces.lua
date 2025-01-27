RegisterNetEvent('GreenLife:Labos:RemoveAcces')
AddEventHandler('GreenLife:Labos:RemoveAcces', function(accesName)
    MOD_Labos.LabData.AccesList[accesName] = nil
end)