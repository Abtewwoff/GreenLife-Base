RegisterNetEvent('GreenLife:Labos:ChangeStateAcces')
AddEventHandler('GreenLife:Labos:ChangeStateAcces', function(name, accesName, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab:UpdateAcces(name, accesName, state)
    end
end)