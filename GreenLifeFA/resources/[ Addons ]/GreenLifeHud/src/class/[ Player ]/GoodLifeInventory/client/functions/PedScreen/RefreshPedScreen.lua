function _GreenLifeInventory:RefreshPedScreen()
    if DoesEntityExist(self.CurrentPedPreview) then
        self:DeletePedScreen()  -- Supprime l'ancien ped
        Wait(500)
        self:CreatePedScreen()  -- Crée un nouveau ped avec animation
    end
end
