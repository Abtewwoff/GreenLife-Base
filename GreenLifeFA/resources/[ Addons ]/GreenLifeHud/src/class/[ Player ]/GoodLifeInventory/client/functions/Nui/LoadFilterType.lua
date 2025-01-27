function _GreenLifeInventory:LoadFilterType()
    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i] ~= "empty") then
            for k=1, #ConfigGreenLifeHud.filterItem['weapons'] do
                local ItemName = ConfigGreenLifeHud.filterItem['weapons'][k]
                if (self.inventoryItems[i].name == ItemName) then
                    self.inventoryItems[i].filterType = 'weapons'
                end
            end
            for k=1, #ConfigGreenLifeHud.filterItem['foods'] do
                local ItemName = ConfigGreenLifeHud.filterItem['foods'][k]
                if (self.inventoryItems[i].name == ItemName) then
                    self.inventoryItems[i].filterType = 'foods'
                end
            end
            for k=1, #ConfigGreenLifeHud.filterItem['clothes'] do
                local ItemName = ConfigGreenLifeHud.filterItem['clothes'][k]
                if (self.inventoryItems[i].name == ItemName) then
                    self.inventoryItems[i].filterType = 'clothes'
                end
            end
        end
    end
end