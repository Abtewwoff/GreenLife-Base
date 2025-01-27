---
--- @author Azagal
--- Create at [23/10/2022] 20:51:36
--- Current project [GreenLife-V1]
--- File name [zoneInteract]
---

local atmObjects = {
    "prop_fleeca_atm",
    "prop_atm_01",
    "prop_atm_03",
    "prop_atm_02"
}

local bankPositions = {
    vector3(149.92, -1040.83, 29.37),
    vector3(-1212.980, -330.841, 37.56),
    vector3(-2962.582, 482.627, 15.703),
    vector3(-112.202, 6469.295, 31.626),
    vector3(314.187, -278.621, 54.170),
    vector3(-351.534, -49.529, 49.042),
    vector3(1175.0643310547, 2706.6435546875, 38.094036102295)
}

CreateThread(function()
    for i = 1, #bankPositions do
        local bankPosition = bankPositions[i]
        if (bankPosition ~= nil) then
            local blip = AddBlipForCoord(bankPosition)
            SetBlipSprite(blip, 108)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, 2)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("[Public] Banque")
            EndTextCommandSetBlipName(blip)
        end
    end

    while true do
        local interval = 1500
        local playerCoords = GetEntityCoords(PlayerPedId())

        for i = 1, #bankPositions do
            local bankPosition = bankPositions[i]
            if (bankPosition ~= nil) then
                local dist = #(bankPosition - playerCoords)
                if (dist < 10) then interval = 0 end

                if (dist < 1.5) then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la banque")
                    if IsControlJustReleased(0, 38) then
                        Bank:openMenu("bank")
                    end
                end
            end
        end
        Wait(interval)
    end
end)

RegisterCommand("__è&Banking&é__", function(source, args, rawCommand)
    local isNearATM = false

    for i = 1, #atmObjects do
        local atmHash = GetHashKey(atmObjects[i])
        local atmEntity = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.5, atmHash, false, false, false)
        if atmEntity ~= 0 then
            isNearATM = true
            break
        end
    end

    if isNearATM then
        Bank:openMenu("bank")
    else
        ESX.ShowNotification("Vous devez être proche d'un ATM pour utiliser cette commande.")
    end
end, false)