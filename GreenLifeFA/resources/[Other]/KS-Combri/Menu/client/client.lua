ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Wait(5000)
    end
end)

-- Menus

local JamsouMenu = {
    Base = { Title = "menu ventezz", HeaderColor = {93, 194, 39} },
    Data = { currentMenu = "vente objet:" },
    Events = {
        onSelected = function(self, _, btn, JMenu, menuData, currentButton, currentSlt, result)
            
            if btn.name == "Tableau" then
                print ("tableaua") 
                TriggerServerEvent('esx_cambriolage:menutableau')
            elseif btn.name == "Télé" then
                print ("télé")
            elseif btn.name == "Pc" then
                print ("Pc")
            elseif btn.name == "Vase" then
                print ("Vase")
            elseif btn.name == "Enceinte" then
                print ("Enceinte")
            elseif btn.name == "Bijoux" then
                print ("Bijoux")
                        
            end
        end
        
    },

    Menu = {
        ["vente objet:"] = {
            b = {
                {name = "Tableau", ask = "→", askX = true},
                {name = "Télé", ask = "→", askX = true},
                {name = "Pc", ask = "→", askX = true},
                {name = "Vase", ask = "→", askX = true},
                {name = "Enceinte", ask = "→", askX = true},
                {name = "Bijoux", ask = "→", askX = true},
            }
        },
    }
}


-- Ouverture du Menu
