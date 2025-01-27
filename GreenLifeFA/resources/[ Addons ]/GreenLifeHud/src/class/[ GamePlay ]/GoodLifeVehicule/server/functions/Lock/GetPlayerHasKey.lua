function _GreenLifeVehicule:GetPlayerHasKey(license)
    if (self.owner == license) then
        return true
    end
end