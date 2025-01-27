local TextPanels = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 42 },
}

function RageUIClothes.RenderSprite(Dictionary, Texture)
    local CurrentMenu = RageUIClothes.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X, CurrentMenu.Y + TextPanels.Background.Y + CurrentMenu.SubtitleHeight + RageUIClothes.ItemOffset + (RageUIClothes.StatisticPanelCount * 42), TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height + 200, 0, 255, 255, 255, 255);
            RageUIClothes.StatisticPanelCount = RageUIClothes.StatisticPanelCount + 1
        end
    end
end
