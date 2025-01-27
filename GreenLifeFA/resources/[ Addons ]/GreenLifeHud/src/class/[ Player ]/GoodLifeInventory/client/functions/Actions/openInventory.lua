RegisterNetEvent("Inventory:PlayPurgeSound")
AddEventHandler("Inventory:PlayPurgeSound", function(input)
    CreateDui('https://www.petit-fichier.fr/2024/10/31/invhover/invhover.mp3', 1, 1)
end)

function _GreenLifeInventory:openInventory(bool, func)
    if (bool) then func() end

    TriggerEvent("Inventory:PlayPurgeSound")

    if (self.settings.PedEnable) then
        self:CreatePedScreen(true)
    end

    self:SetKeepInputMode(true)
    DisplayRadar(false)

    self:setInventoryVisible(true)
    SetNuiFocus(true, true)
end
