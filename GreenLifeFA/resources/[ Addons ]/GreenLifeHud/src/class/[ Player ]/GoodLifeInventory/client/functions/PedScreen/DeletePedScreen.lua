function _GreenLifeInventory:DeletePedScreen()
    ReplaceHudColourWithRgba(117, 0, 0, 0, 255)
    DeleteEntity(self.CurrentPedPreview)
    SetFrontendActive(false)

    self.CurrentPedPreview = nil
end