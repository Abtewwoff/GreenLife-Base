RegisterNetEvent('GreenLife:Labo:Weed:PlaceGrassOnPot')
AddEventHandler('GreenLife:Labo:Weed:PlaceGrassOnPot', function(plotSize, plotIndex, potIndex)
    local xPlayer = ESX.GetPlayerFromId(source)
    local PlyCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))

    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab.Drug:PlaceGrassOnWeedPot(plotSize, plotIndex, potIndex)
    end
end)