


function MenuVigneron()
    local main = RageUI.CreateMenu("", "Menu Vigneron")
    local mainAnnonces = RageUI.CreateSubMenu(main, "", "Annonces Entreprises")
    local farms = RageUI.CreateSubMenu(main, "", "Points de farms")

    RageUI.Visible(main, not RageUI.Visible(main))

    while main do 
        Wait(0)
        RageUI.IsVisible(main, function()
            RageUI.Button("→ Annonces Entreprises", nil, {RightLabel = "→→→"}, true, {}, mainAnnonces)
            RageUI.Button("→ Points de farms", nil, {RightLabel = "→→→"}, true, {}, farms)
        end)

        RageUI.IsVisible(mainAnnonces, function()
            RageUI.Button("→ Entreprise ouverte", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("GreenLife:Vigneron:Annonce", 1)
                end
            })

            RageUI.Button("→ Entreprise fermée", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("GreenLife:Vigneron:Annonce", 2)
                end
            })

            RageUI.Button("→ Annonce Personnalisée", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    local text = exports["cfx-target"]:ShowSync("Entrez votre annonce : ", true, 600, "text")
                    if text then
                        TriggerServerEvent("GreenLife:Vigneron:Annonce", 3, text)
                    end
                end
            })
        end)

        RageUI.IsVisible(farms, function()
            RageUI.Button("→ Point de récote de raisin", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    SetNewWaypoint(Vigneron.Pos.Farm.Raisin)
                end
            })

            RageUI.Button("→ Point de traitement de raisin", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    SetNewWaypoint(Vigneron.Pos.Farm.Traitement)
                end
            })

            RageUI.Button("→ Point de vente de vin", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    SetNewWaypoint(Vigneron.Pos.Farm.Vente)
                end
            })
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(mainAnnonces) and not RageUI.Visible(farms) then
            main = RMenu:DeleteType("main", true)
            break
        end
    end
end