RegisterNetEvent('GreenLife:Labos:Weed:RecoltWeedOnPot')
AddEventHandler('GreenLife:Labos:Weed:RecoltWeedOnPot', function(plotSize, plotIndex, potIndex)
    local xPlayer = ESX.GetPlayerFromId(source)

    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab.Drug:RecoltWeedOnPot(plotSize, plotIndex, potIndex)
    end
end)