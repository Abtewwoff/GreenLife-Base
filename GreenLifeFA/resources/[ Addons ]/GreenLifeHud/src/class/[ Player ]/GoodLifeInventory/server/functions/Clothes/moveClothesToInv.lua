function _GreenLifeInventory:moveClothesToInv(from, to, count)
    from = 'clothes_'..from

    local fromItem = json.decode(json.encode(self.inventoryClothes[from]))
    local toItem = json.decode(json.encode(self.inventoryItems[to]))

    if (not fromItem or not fromItem.count or not toItem) then
        print('~g~[JFW] ^1Item is not exist in the inventory. Event: self.moveClothesToInv ^7')
        return
    end

    local ItemInfo_FROM = MOD_Items:getItem(fromItem.name)
    local ItemInfo_TO = MOD_Items:getItem(toItem.name)

    if ( (not ItemInfo_FROM and fromItem ~= "empty") or (not ItemInfo_TO and toItem ~= "empty") ) then
        print('~g~[JFW] ^1Item is not exist in the system. ^7')
        return
    end

    if (toItem == "empty") then
        self.inventoryItems[to] = fromItem
        self.inventoryItems[to].count = count

        self.inventoryClothes[from] = nil

        TriggerClientEvent('GreenLife:Inventory:InvSkinClothesChange', self.class.source, fromItem.args, true, true, true)

        self:updateClothesSlot(to, self.inventoryItems[to], from, self.inventoryClothes[from]) 
        self:syncToPlayers()

        return true
    end
end