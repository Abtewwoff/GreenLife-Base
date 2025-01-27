RegisterNetEvent('GreenLife:Labos:ChangeMemberAcces')
AddEventHandler('GreenLife:Labos:ChangeMemberAcces', function(license, accesName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab:ChangeMemberAcces(license, accesName)
    end
end)