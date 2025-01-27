RegisterNetEvent('GreenLife:Labo:Weed:PlacePotOnPlot')
AddEventHandler('GreenLife:Labo:Weed:PlacePotOnPlot', function(plotSize, plotIndex, potIndex)
    local xPlayer = ESX.GetPlayerFromId(source)
    local PlyCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))

    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab.Drug:PlaceWeedPotOnPlot(plotSize, plotIndex, potIndex)
    end
end)