local IdSelect = 0

function MOD_Weed:OnSelectSeedReady(callback)
    IdSelect += 1
    
    sendUIMessage({
        WeedSelectSeed = true,
        seedSelectId = IdSelect
    })
    SetNuiFocus(true, true)

    AddEventHandler('GreenLife:Labo:Weed:ReadySelectWeed:'..IdSelect, function(seedVariety)
        callback(seedVariety)
    end)
end