---
--- @author Azagal
--- Create at [01/11/2022] 20:15:54
--- Current project [GreenLife-V1]
--- File name [_main]
---

Helipad = {}
Helipad.Config = {
    ["ambulance"] = {
        menuPosition = vector3(-1850.00, -354.93, 58.08),
        spawnPosition = vector4(-1867.50, -352.91, 58.09, 140.56),
        models = {
            "nksvolitoems"
        }
    },
    ["police"] = {
        menuPosition = vector3(-405.92, -344.49, 70.95),
        spawnPosition = vector4(-395.31, -337.35, 72.84, 310.385),
        models = {
            "polmav"
        }
    },
    ["bcso"] = {
        menuPosition = vector3(1832.306, 3684.211, 42.97942),
        spawnPosition = vector4(1824.31, 3686.481, 42.97942, 31.804555892944),
        models = {
            "bcsheriffheli"
        }
    },
    ["gouv"] = {
        menuPosition = vector3(-448.4686, 1137.1080, 327.6861),
        spawnPosition = vector4(-453.6555, 1145.2871, 327.6859, 314.7523),
        models = {
            "presheli"
        }
    },
    playerLoad = {}
}

RegisterNetEvent("Helipad:Request:LoadConfig", function()
    local _src = source

    local xPlayer = ESX.GetPlayerFromId(_src)
    if (xPlayer ~= nil) then
        if (Helipad.Config.playerLoad[_src] == nil) then
            Helipad.Config.playerLoad[_src] = true
        else
            return
        end

        xPlayer.triggerEvent("Helipad:ClientReturn:Config", Helipad.Config)
    end
end)