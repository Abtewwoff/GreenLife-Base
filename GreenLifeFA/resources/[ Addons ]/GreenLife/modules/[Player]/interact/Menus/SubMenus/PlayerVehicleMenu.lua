function Abteww:DoorStatus()
	local GetVehicle = GetVehiclePedIsIn(Abteww.PlayerPed, false);
	local GetVehicleDoorLockStatus = GetVehicleDoorLockStatus(GetVehicle);

	if (GetVehicleDoorLockStatus == 1) then
		return "~r~Désactivé";
	elseif (GetVehicleDoorLockStatus == 2) then
		return "~g~Activé";
	end
end

function Abteww:CanManageVehicle()
    if (not IsPedInAnyVehicle(Abteww.PlayerPed, false)) then
		return;
	end
    local Vehicle = GetVehiclePedIsIn(Abteww.PlayerPed, false)
	if (Abteww:DoorStatus() == "~g~Actif") then
		return ESX.ShowNotification("~r~Le véhicule est verrouillé !");
	end
    if (GetPedInVehicleSeat(Vehicle, -1) ~= Abteww.PlayerPed) then
        return ESX.ShowNotification("~r~Vous n'êtes pas conducteur !");
    else
        return true;
    end
    return false;
end

function Abteww:DoorAction(Door, DoorName)
    if not IsPedInAnyVehicle(Abteww.PlayerPed,false) then return end
    local Vehicle = GetVehiclePedIsIn(Abteww.PlayerPed, false);
    if (Door == -1) then
        if (not Abteww.DoorState.DoorName) then
            Abteww.DoorState.DoorName = true;
            for i = 0, 7 do
                SetVehicleDoorOpen(Vehicle, i, false, false);
            end
        else
            Abteww.DoorState.DoorName = false;
            for i = 0, 7 do
                SetVehicleDoorShut(Vehicle, i, false);
            end
        end
        return;
    end
    
    if (not Abteww.DoorState.DoorName) then
        Abteww.DoorState.DoorName = true;
        SetVehicleDoorOpen(Vehicle, Door, false, false);
    else
        Abteww.DoorState.DoorName = false;
        SetVehicleDoorShut(Vehicle, Door, false);
    end
end

function Abteww:GetPlayerVehicleMenu()
	if (IsPedSittingInAnyVehicle(Abteww.PlayerPed)) then
		local GetVehicle = GetVehiclePedIsIn(Abteww.PlayerPed, false);
		local GetVehicleFuel = exports["GreenLifeHud"]:GetFuel(GetVehicle) or 0;
		local VehicleFuelRounded = (math.round(GetVehicleFuel));
		local GetVehicleHealth = (math.round(GetVehicleEngineHealth(GetVehicle)) / 10);

		RageUI.Separator("Verrouillage centralisé : "..Abteww:DoorStatus());
		RageUI.Separator("Carburant : ~g~"..VehicleFuelRounded.."L");
		RageUI.Separator("État du moteur : ~g~"..GetVehicleHealth.."%");
		RageUI.Line();
		RageUI.List("Actions Moteur", Abteww.EngineIndexes, Abteww.VehicleEngineIndex, nil, {}, true, {
			onListChange = function(Index)
				Abteww.VehicleEngineIndex = Index;
			end,
			onSelected = function(Index)
				if (Index == 1) then
                    if (GetVehicleEngineHealth(GetVehicle) > 50) then
					    SetVehicleEngineOn(GetVehicle, true, true, false);
                    else
                        ESX.ShowNotification("~r~Le véhicule est trop endommagé !");
                    end
				else
					SetVehicleEngineOn(GetVehicle, false, true, true);
				end
			end
		});
		RageUI.List("Limiteur de vitesse", Abteww.SpeedLimitIndexes, Abteww.SpeedLimiterIndex, nil, {}, true, {
			onListChange = function(Index)
				Abteww.SpeedLimiterIndex = Index;
			end,
			onSelected = function(Index)
                local VehicleSpeed = math.ceil(GetEntitySpeed(GetVehicle) * 3.6);
                if (Index == 1) then
                    if (VehicleSpeed <= 50) then
                        SetEntityMaxSpeed(GetVehicle, 50.0/3.6);
                        ESX.ShowNotification("Limitateur de vitesse défini sur ~g~50 km/h.");
                    else
                        ESX.ShowNotification("~r~Vous devez rouler à une vitesse inférieure ou égale à 50km/h pour mettre le limiteur.");
                    end
                elseif (Index == 2) then
                    if (VehicleSpeed <= 80) then
                        SetEntityMaxSpeed(GetVehicle, 80.0/3.6);
                        ESX.ShowNotification("Limitateur de vitesse défini sur ~g~80 km/h.");
                    else
                        ESX.ShowNotification("~r~Vous devez rouler à une vitesse inférieure ou égale à 80km/h pour mettre le limiteur.");
                    end
                elseif (Index == 3) then
                    if (VehicleSpeed <= 120) then
                        SetEntityMaxSpeed(GetVehicle, 120.0/3.6);
                        ESX.ShowNotification("Limitateur de vitesse défini sur ~g~120 km/h.");
                    else
                        ESX.ShowNotification("~r~Vous devez rouler à une vitesse inférieure ou égale à 130km/h pour mettre le limiteur.");
                    end
                elseif (Index == 4) then
                    SetEntityMaxSpeed(GetVehicle, 999.0/3.6);
                    ESX.ShowNotification("Limitateur de vitesse ~r~désactivé~s~.");
                end
			end
		});
		RageUI.List("Ouvrir / Fermer", Abteww.DoorListIndexes, Abteww.DoorListIndex, nil, {}, true, {
			onListChange = function(Index)
				Abteww.DoorListIndex = Index;
			end,
			onSelected = function(Index)
				if (Abteww:CanManageVehicle()) then
					if (Index == 1) then
						Abteww:DoorAction(-1, All); 
					elseif (Index == 2) then
						Abteww:DoorAction(0, FrontLeft);
					elseif (Index == 3) then
						Abteww:DoorAction(1, FrontRight);
					elseif (Index == 4) then
						Abteww:DoorAction(2, BackLeft);
					elseif (Index == 5) then
						Abteww:DoorAction(3, BackRight);
					elseif (Index == 6) then
						Abteww:DoorAction(4, Hood);
					elseif (Index == 7) then
						Abteww:DoorAction(5, Trunk);
					end
				end
			end
		});
        RageUI.Button("Tableau de bord", nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                ExecuteCommand("carinfo");
                IsMenuActive = false;
            end
        });

        RageUI.Button("[~r~Beta~s~] AutoPilote", nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                ExecuteCommand("ConduiteAuto");
                ESX.ShowNotification("Autopilote ~g~activé~s~, vous êtes responsable de la conduite du véhicule.") 
            end
        });
	else
		RageUI.Separator("");
		RageUI.Separator("~r~Vous devez être dans un véhicule");
		RageUI.Separator("");
	end
end