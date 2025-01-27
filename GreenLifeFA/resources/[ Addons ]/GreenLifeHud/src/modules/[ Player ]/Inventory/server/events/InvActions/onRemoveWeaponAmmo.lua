RegisterNetEvent('GreenLife:Inventory:RemoveWeaponAmmo')
AddEventHandler('GreenLife:Inventory:RemoveWeaponAmmo', function(weaponid, ammo)
    local xPlayer = ESX.GetPlayerFromId(source)

    local WeaponSelect = xPlayer.getWeaponsById(weaponid)
    local WeaponAmmo = WeaponSelect.args.ammo

    local NewAmmo = (WeaponAmmo - ammo)

    xPlayer.setWeaponsAmmoById(weaponid, NewAmmo)
end)