function _GreenLifeGangBuilder:StoreVehicle(plate)
    if (self.vehiclesOut[plate]) then
        self.vehiclesOut[plate] = nil
    end
end