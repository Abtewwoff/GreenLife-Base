---- Gerer les png ---- 

DensityMultiplier = 0.8
CreateThread(function()
	while true do
	    Wait(0)
	    SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetPedDensityMultiplierThisFrame(DensityMultiplier)
	  	SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
	   	SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
	end
end)

local TrafficAmount = 50
local PedestrianAmount = 30
local ParkedAmount = 0
local EnableDispatch = false

CreateThread(function()
	for i = 1, 13 do
		EnableDispatchService(i, EnableDispatch)
	end
	while true do
		SetVehicleDensityMultiplierThisFrame((TrafficAmount/100)+.0)
		SetPedDensityMultiplierThisFrame((PedestrianAmount/100)+.0)
		SetRandomVehicleDensityMultiplierThisFrame((TrafficAmount/100)+.0)
		SetParkedVehicleDensityMultiplierThisFrame((ParkedAmount/100)+.0)
		SetScenarioPedDensityMultiplierThisFrame((PedestrianAmount/100)+.0, (PedestrianAmount/100)+.0)
		Wait(0)
	end
end)


---- Roulade ---- 

CreateThread(function()
    while true do
        Wait(5)
        if IsControlPressed(0, 25)
            then DisableControlAction(0, 22, true)
        end
    end
end)

---- Désactiver l'action shot in vehicle ----

CreateThread(function()
	while true do 
		Wait(0)

		local PlayerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(PlayerPed,false)

		if vehicle ~= 0 and not IsPedOnFoot(PlayerPed) then 

			if IsPedDoingDriveby(PlayerPed)then 
				SetPlayerCanDoDriveBy(PlayerPedId(), false)
			end 
		else 
			SetPlayerCanDoDriveBy(PlayerPedId(), true)

		end 
	end 
end)