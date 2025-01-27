RegisterNetEvent('GreenLife:Labos:AddNewAcces')
AddEventHandler('GreenLife:Labos:AddNewAcces', function(accesName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab:AddNewAcces(accesName)
    end
end)