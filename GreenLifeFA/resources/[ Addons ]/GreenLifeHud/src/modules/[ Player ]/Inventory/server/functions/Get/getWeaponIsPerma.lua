function MOD_inventory:getWeaponIsPerma(name)
    for i=1, #ConfigGreenLifeHud.permanentWeapons, 1 do
        if (string.lower(ConfigGreenLifeHud.permanentWeapons[i]) == name) then
            return true
        end
    end

    return false
end