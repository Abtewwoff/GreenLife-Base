RegisterNetEvent('GreenLife:Labos:ChangeAccesMember')
AddEventHandler('GreenLife:Labos:ChangeAccesMember', function(license, accesName)
    MOD_Labos.LabData.memberList[license].accesName = accesName
end)