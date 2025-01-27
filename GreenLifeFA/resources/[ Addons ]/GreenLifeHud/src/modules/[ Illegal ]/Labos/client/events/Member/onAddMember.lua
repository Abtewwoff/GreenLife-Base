RegisterNetEvent('GreenLife:Labos:AddMember')
AddEventHandler('GreenLife:Labos:AddMember', function(license, data)
    MOD_Labos.LabData.memberList[license] = data
end)