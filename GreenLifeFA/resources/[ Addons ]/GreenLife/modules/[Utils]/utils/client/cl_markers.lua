ZonesListe = {
    ["Jetski"] = {
        Position = vector3(-1596.89 , -1163.28, 1.10),
        Public = true,
        Job = nil, 
        Job2 = nil, 
        Blip = {
            Name = "[PUblic] Location Jetski",
            Sprite = 410,
            Display = 4,
            Scale = 0.6,
            Color = 57
        },
        Action = function()
            MenuJetski()
        end
    },
    ["JetNord"] = {
        Position = vector3(-982.0197, 6603.6030, -0.1211),
        Public = true,
        Job = nil, 
        Job2 = nil, 
        Blip = {
            Name = "[PUblic] Location Jetski",
            Sprite = 410,
            Display = 4,
            Scale = 0.6,
            Color = 57
        },
        Action = function()
            MenuJetski()
        end
    },


    ["MenuVeheculesFBI"] = {
        Position = vector3(2544.805, -375.2866, 92.17),---r
        Public = false,
        Job = "fib", 
        Job2 = nil, 
        Blip = nil,
        Action = function()
            MenuVeheculesFBI()
        end
    },
    ["Menucustom"] = {
        Position = vector3(2552.6318359375,-328.79196166992,92.993560791016),---r
        Public = false,
        Job = "fib", 
        Job2 = nil, 
        Blip = nil,
        Action = function()
            Menucustom()
        end
    },
    ["DeleteVehicleFBI"] = {
        Position = vector3(2531.191, -399.0492, 92.09), 
        Public = false,
        Job = "fib", 
        Job2 = nil, 
        Blip = nil,
        Action = function()
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            if veh ~= nil then 
                DeleteEntity(veh) 
            end
        end
    },
    ["MenuWeaponsFBI"] = {
        Position = vector3(2521.207, -336.6898, 101),
        Public = false,
        Job = "fib", 
        Job2 = nil, 
        Blip = nil,
        Action = function()
            MenuWeaponsFBI()
        end
    },


    
    -- ["MenuVetementsFBI"] = {
    --     Position = vector3(2515.05, -344.4951, 101), ---r
    --     Public = false,
    --     Job = "fib", 
    --     Job2 = nil, 
    --     Blip = nil,
    --     Action = function()
    --         MenuVetementsFBI()
    --     end
    -- }
}

CreateThread(function()
    for _,marker in pairs(ZonesListe) do
        if marker.Blip then
            local blip = AddBlipForCoord(marker.Position)

            SetBlipSprite(blip, marker.Blip.Sprite)
            SetBlipScale(blip, marker.Blip.Scale)
            SetBlipColour(blip, marker.Blip.Color)
            SetBlipDisplay(blip, marker.Blip.Display)
            SetBlipAsShortRange(blip, true)
    
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(marker.Blip.Name)
            EndTextCommandSetBlipName(blip)
        end
	end
end)