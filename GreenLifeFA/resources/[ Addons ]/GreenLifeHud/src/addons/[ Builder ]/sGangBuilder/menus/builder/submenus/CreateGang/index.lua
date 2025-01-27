
local menu = {}

local function ShowInputDialog(prompt, maxLength)
    local keyboard = exports["ox_lib"]:inputDialog(prompt, {
        { type = "input", label = prompt, max = maxLength }
    })

    return keyboard and keyboard[1]
end

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Crée un Gang")

    local gangData = {}

    local Params = {
        name = false,
        label = false,
        posBoss = false,
        posCoffre = false,
        posGarage = false,
        posSpawnVeh = false,
        posDeleteVeh = false
    }

    local function GetAllParamsValid()
        for name, bool in pairs(Params) do
            if (not bool) then
                return false
            end
        end

        return true
    end

    menu.Menu:IsVisible(function(Items)
        Items:Separator('↓ Informations sur le gang ↓')
        Items:Button("Nom du gang", "Indiquer le nom du gang", { RightLabel = gangData.name  or "~r~Indéfini~s~"}, true, {
            onSelected = function()
                -- local GangName = ShowInputDialog("Indiquer le nom du gang", 50)
                local GangName = KeyboardInput("Indiquer le nom du gang", "", 99);

                
                if (GangName) then
                    gangData.name = GangName

                    Params.name = true
                end
            end
        });
        Items:Button("Label du gang", "Indiquer le label du gang", { RightLabel = gangData.label  or "~r~Indéfini~s~"}, true, {
            onSelected = function()
                -- local GangLabel = ShowInputDialog("Indiquer le label du gang", 50)
                local GangLabel = KeyboardInput("Indiquer le label du gang", "", 99);

                if (GangLabel) then
                    gangData.label = GangLabel

                    Params.label = true
                end
            end
        });

        Items:Separator('↓ Postions du gang ↓')
        Items:Button("Position du boss", "Indiquer la position du Menu Boss", {RightLabel = gangData.posBoss or "~r~Indéfini~s~"}, true, {
            onSelected = function()
                gangData.posBoss = GetEntityCoords(PlayerPedId())

                Params.posBoss = true
            end
        });
        Items:Button("Position du coffre", "Indiquer la position du Menu coffre", {RightLabel = gangData.posCoffre or "~r~Indéfini~s~"}, true, {
            onSelected = function()
                gangData.posCoffre = GetEntityCoords(PlayerPedId())

                Params.posCoffre = true
            end
        });
        Items:Button("Position du garage", "Indiquer la position du Menu garage", {RightLabel = gangData.posGarage or "~r~Indéfini~s~"}, true, {
            onSelected = function()
                gangData.posGarage = GetEntityCoords(PlayerPedId())

                Params.posGarage = true
            end
        });
        Items:Button("Position du spawn des vehicules", "Indiquer la position du Menu spawn des vehicules", {RightLabel = gangData.posSpawnVeh or "~r~Indéfini~s~"}, true, {
            onSelected = function()
                gangData.posSpawnVeh = GetEntityCoords(PlayerPedId())

                Params.posSpawnVeh = true
            end
        });
        Items:Button("Position du delete des vehicules", "Indiquer la position du Menu delete des vehicules", {RightLabel = gangData.posDeleteVeh or "~r~Indéfini~s~"}, true, {
            onSelected = function()
                gangData.posDeleteVeh = GetEntityCoords(PlayerPedId())

                Params.posDeleteVeh = true
            end
        });

        Items:Line()
        
        Items:Button("Crée le gang", "Vous permet de valider la création du gang", {RightLabel = "✔️"}, true, {
            onSelected = function()
                if (GetAllParamsValid()) then
                    TriggerServerEvent("GreenLife:GangBuilder:CreateNewGang", gangData)

                    menu.Menu:Toggle()
                end
            end
        });
    end, nil, function()
        gangData = {}
        Params = {
            name = false,
            label = false,
            posBoss = false,
            posCoffre = false,
            posGarage = false,
            posSpawnVeh = false,
            posDeleteVeh = false
        }
    end)

end

return menu