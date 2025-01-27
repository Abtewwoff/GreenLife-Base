RegisterNetEvent('GreenLife:Labos:RemoveMember')
AddEventHandler('GreenLife:Labos:RemoveMember', function(license)
    MOD_Labos.LabData.memberList[license] = nil
end)