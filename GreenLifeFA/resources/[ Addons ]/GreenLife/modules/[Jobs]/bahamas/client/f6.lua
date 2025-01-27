function MenuBahmas()
    local main = RageUI.CreateMenu("", "Menu bahamas")

    RageUI.Visible(main, not RageUI.Visible(main))

    while main do 
        Wait(0)
        RageUI.IsVisible(main, function()

            RageUI.Button("→ Entreprise ouverte", nil, {RightLabel = "→→"}, not codesCooldown1, {
                onSelected = function()
                    codesCooldown1 = true
                    TriggerServerEvent("GreenLife:bahamas:open")
                end
            })

            RageUI.Button("→ Entreprise fermée", nil, {RightLabel = "→→"}, not codesCooldown2, {
                onSelected = function()
                    codesCooldown2 = true
                    TriggerServerEvent("GreenLife:bahamas:close")
                end
            })

            RageUI.Button("→ Annonce Personnalisée", nil, {RightLabel = "→→"}, not codesCooldown3, {
                onSelected = function()
                    codesCooldown3 = true
                    local text = exports["cfx-target"]:ShowSync("Entrez votre annonce : ", true, 600, "text")
                    if text then
                        TriggerServerEvent("GreenLife:bahamas:perso", text)
                    end
                end
            })
        end)

        if not RageUI.Visible(main)then
            main = RMenu:DeleteType("main", true)
            break
        end
    end
end