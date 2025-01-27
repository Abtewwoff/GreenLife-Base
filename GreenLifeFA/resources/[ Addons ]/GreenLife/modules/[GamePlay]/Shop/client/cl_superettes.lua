LTDItem = {
    {name = 'bread', label = 'Pain', price = 15},
    {name = 'water', label = 'Eau de source', price = 15},

    {name = 'radio', label = 'Radio', price = 1000},
    {name = 'phone', label = 'Samsung', price = 1500},
   {name = 'fishingrod', label = 'Canne à pêche', price = 1000},
}


local maxCount = {1}
local IndexShop = {
    Count = 1
}

function OpenMenuLtd()
    local menu = RageUI.CreateMenu("", "Market", nil, 100, "shopui_title_gasstation", "shopui_title_gasstation")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(3)
        RageUI.IsVisible(menu, function()
        pos = GetEntityCoords(PlayerPedId())
        RageUI.Separator("~g~LTD~s~ Gasoline de ~g~"..GetStreetNameFromHashKey(GetStreetNameAtCoord(pos.x, pos.y, pos.z)).."~s~")
        RageUI.Line()
        for k,v in pairs(LTDItem) do
            RageUI.Button("~g~"..v.price.."$~s~ - "..v.label, nil, {}, true, {
                onSelected = function()
                    local numberQty = tonumber(KeyboardInput("Combien en voulez-vous ?", "", 1))
                    if (numberQty ~= nil and numberQty > 0) then
                        -- TriggerServerEvent('GreenLifePass:taskCountAdd:standart', 4, 1)
                        OpenMenuPaiement(v.name, v.price, numberQty)
                    end
                end
            })
        end
        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

function OpenMenuPaiement(item, price, numberQty)
    local menu = RageUI.CreateMenu("Magasin", "Comment voulez vous payer ?")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(3)
        RageUI.IsVisible(menu, function()

        RageUI.Button('Paiement en Carte Liquide', nil, {}, true, {
            onSelected = function()
                RageUI.CloseAll()
                TriggerServerEvent('core:achat', item, price, 1, numberQty)
            end
        })
        RageUI.Button('Paiement en Carte Bancaire', nil, {}, true, {
            onSelected = function()
                RageUI.CloseAll()
                TriggerServerEvent('core:achat', item, price, 2, numberQty)
            end
        })

        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end