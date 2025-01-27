function _GreenLifeCoffreVehicule:getMaxWeight()
    local vehicleModel = self:getModel()
    if (vehicleModel) then
        return ConfigGreenLifeHud.VehiculeMaxWeight[vehicleModel] or 150.0
    end
end