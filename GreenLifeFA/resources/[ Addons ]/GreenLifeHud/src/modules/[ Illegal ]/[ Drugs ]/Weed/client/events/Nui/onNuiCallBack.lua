RegisterNUICallback('nui:GreenLife:Weed:CallbackSelectSeed', function(data)
    sendUIMessage({
        WeedSelectSeed = false,
        seedSelectId = 0
    })
    SetNuiFocus(false, false)

    TriggerEvent('GreenLife:Labo:Weed:ReadySelectWeed:'..data.selectSeedId, data.variety)
end)
RegisterNUICallback('nui:GreenLife:Drugs:Weed:CloseWeedSelectSeed', function(data)
    sendUIMessage({
        WeedSelectSeed = false,
        seedSelectId = 0
    })
    SetNuiFocus(false, false)

    TriggerEvent('GreenLife:Labo:Weed:ReadySelectWeed:'..data.selectSeedId, false)
end)


RegisterNUICallback('nui:GreenLife:Drugs:Weed:CloseWeedManagePlant', function()
    sendUIMessage({
        WeedInfosPlant = false
    })

    SetNuiFocus(false, false)

    MOD_Weed.LabData.OpenManagePlant = nil
end)

RegisterNUICallback('nui:GreenLife:Drugs:Weed:AddWater', function()
    local Info = MOD_Weed.LabData.OpenManagePlant
    TriggerServerEvent('GreenLife:Labo:Weed:AddWaterOnPot', Info.sizePlot, Info.indexPlot, Info.indexPot)
    
    ESX.TriggerServerCallback("GreenLife:Labos:Weed:GetWeedInfosPot", function(infos)
        sendUIMessage({
            event = 'UpdateWeedInfosPot',
            DataWeedInfosPlant   = {
                variety = infos.variety,
    
                state = infos.state,
    
                water = infos.water,
                health = infos.health,
                fertilizer = infos.fertilizer
            }
        })
    end, Info.sizePlot, Info.indexPlot, Info.indexPot)
end)

RegisterNUICallback('nui:GreenLife:Drugs:Weed:AddFertilizer', function()
    local Info = MOD_Weed.LabData.OpenManagePlant
    TriggerServerEvent('GreenLife:Labo:Weed:AddFertilizer', Info.sizePlot, Info.indexPlot, Info.indexPot)
    
    ESX.TriggerServerCallback("GreenLife:Labos:Weed:GetWeedInfosPot", function(infos)
        sendUIMessage({
            event = 'UpdateWeedInfosPot',
            DataWeedInfosPlant   = {
                variety = infos.variety,
    
                state = infos.state,
    
                water = infos.water,
                health = infos.health,
                fertilizer = infos.fertilizer
            }
        })
    end, Info.sizePlot, Info.indexPlot, Info.indexPot)
end)