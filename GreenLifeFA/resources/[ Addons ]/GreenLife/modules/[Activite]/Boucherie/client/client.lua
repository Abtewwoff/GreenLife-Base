local config = {
    color = "~r~",
    ped = {pos = vector3(961.6025390625,-2111.5151367188,30.948392868042), heading = 94.76, model = "s_m_y_factory_01"},
    menu = {pos = vector3(961.33172607422,-2111.466796875,31.948392868042), message = "pour parler a l'acheteur"},
    items = {
        {
            itemReseller = "viande_1",
            itemSeller = "morviande_1",
            label = "Viande Blanche",
            priceSeller = 10,
            priceReseller = 125,
        },
        {
            itemReseller = "viande_2",
            itemSeller = "morviande_2",
            label = "Viande Rouge",
            priceSeller = 12,
            priceReseller = 150
        }
    },
}
local function openMenu()
    local mainMenu = RageUI.CreateMenu("", "Boucherie")
    local resellerMenu = RageUI.CreateMenu("", "Boucherie")
    local sellerMenu = RageUI.CreateMenu("", "Boucherie")

    RageUI.Visible(resellerMenu, not RageUI.Visible(resellerMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    while mainMenu do
        Wait(1)
        RageUI.IsVisible(resellerMenu, function()
            for k,v in pairs(config.items) do
                RageUI.Button("Vendre de la "..config.color..""..v.label, nil, {RightLabel = v.priceReseller.."~g~$~s~"}, true, {
                    onSelected = function()
                        local count = tonumber(exports["cfx-target"]:ShowSync('Veuillez indiquer la quantité souhaitée', true, 600, "small_text"))
                        if count == "" or count == nil then return ESX.ShowNotification("❌ Cette quantité est invalide !") end
                        TriggerServerEvent("Boucherie:sellItem", v.itemReseller, count)
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(resellerMenu) and not RageUI.Visible(sellerMenu) then
            mainMenu = RMenu:DeleteType("menu", true)
        end
    end

    FreezeEntityPosition(PlayerPedId(), false)
end 

CreateThread(function()
    local model = GetHashKey(config.ped.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    local ped = CreatePed(9, model, config.ped.pos, config.ped.heading, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)

    while true do
        local waiting = 1000
        local pedCoords = GetEntityCoords(PlayerPedId())
        local dist = #(pedCoords - config.menu.pos)

        if dist < 10 then
            waiting = 1

            if dist < 1.0 then
                -- TriggerEvent("ui:showInteraction", "E", config.menu.message)
                ESX.ShowHelpNotification(config.menu.message)
                if IsControlJustReleased(0, 51) then
                    CreateThread(function()
                        openMenu()
                    end)
                end
            end
        end

        Wait(waiting)
    end
end)