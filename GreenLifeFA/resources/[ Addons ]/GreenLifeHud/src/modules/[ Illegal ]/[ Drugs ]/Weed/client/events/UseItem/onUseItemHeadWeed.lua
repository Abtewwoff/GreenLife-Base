RegisterNetEvent('GreenLife:Labo:Weed:UseItemHeadWeed')
AddEventHandler('GreenLife:Labo:Weed:UseItemHeadWeed', function(HeadWeed)
    MOD_Weed:StartPlaceHeadWeed(HeadWeed)
end)