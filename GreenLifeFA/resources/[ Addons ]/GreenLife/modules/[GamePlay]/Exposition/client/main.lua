local LesVoitureSontSpawn = false
local VehicleSpawned = {}
local ExpositionConcess = {
    {model = 'bati', position = vector3(143.004, -164.1579, 54.86)},
    {model = 'blista', position = vector3(131.8923, -160.0627, 54.86)},
    {model = 'bmx', position = vector3(137.4842, -162.391, 54.86)},
    {model = 'rebla', position = vector3(126.1133, -158.1348, 54.86)},
    {model = 'adder', position = vector3(120.5887, -156.1439, 54.86)}
}

Citizen.CreateThread(function()
    while not ESXLoaded do Wait(1) end
    while true do
        local isProche = false
            local dist = Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(143.004, -164.1579, 54.86))

            if dist < 1500 then
                if not LesVoitureSontSpawn then 
                    LesVoitureSontSpawn = true
                    for k,v in pairs(ExpositionConcess) do 
                        ESX.Game.SpawnLocalVehicle(v.model, v.position, 20.562, function(vehicle)
                            FreezeEntityPosition(vehicle, true)
                            SetVehicleDoorsLocked(vehicle, 2)
                            SetEntityInvincible(vehicle, true)
                            SetVehicleFixed(vehicle)
                            SetVehicleDirtLevel(vehicle, 0.0)
                            SetVehicleEngineOn(vehicle, true, true, true)
                            SetVehicleLights(vehicle, 2)
                            SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                            SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                            table.insert(VehicleSpawned, {model = vehicle})
                        end)
                    end
                end
                isProche = true
            end
            if dist > 1500 and dist < 1600 then 
                for k,v in pairs(VehicleSpawned) do 
                    if DoesEntityExist(v.model) then
                        DeleteEntity(v.model)
                        LesVoitureSontSpawn = false
                        -- print(v.model..' despawn')
                    end
                end
            end
		if isProche then
			Wait(3)
		else
			Wait(2000)
		end
	end
end)