function GreenLifeSociety:AddMoney(amount)
    self.money += tonumber(amount)

    self:Update("money", self.money)
end