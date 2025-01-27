RegisterNetEvent('GreenLife:Labo:Weed:PlaceLampOnPlot')
AddEventHandler('GreenLife:Labo:Weed:PlaceLampOnPlot', function(plotSize, plotIndex, potIndex)
    local xPlayer = ESX.GetPlayerFromId(source)
    local PlyCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))

    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab.Drug:PlaceWeedLampOnPlot(plotSize, plotIndex, potIndex)
    end
end)