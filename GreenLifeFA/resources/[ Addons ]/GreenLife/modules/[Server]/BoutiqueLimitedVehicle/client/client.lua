local confirmation = false 
local name = nil
local price = nil
local label = nil

local VehicleInBoutique = {}

RegisterCommand("limitedVehicule", function(source, args, rawCommand)
    OpenVehicleBoutique()
end)

RegisterNetEvent("Boutique:GetVehicle")
AddEventHandler("Boutique:GetVehicle", function(vehicleTable)
	VehicleInBoutique = vehicleTable
end)

local BVehicleMenu = RageUI.CreateMenu("", "Vehicule Limité", 0, 0, 'menustyle', 'interaction_bgd')

BVehicleMenu.Closed = function()
    open = false
	confirmation = false
end

function OpenVehicleBoutique()
	if open then
		open = false
		RageUI.Visible(BVehicleMenu,false)
		return
	else
		open = true
		RageUI.Visible(BVehicleMenu,true)
		CreateThread(function()
			while open do 
				RageUI.IsVisible(BVehicleMenu,function()
					if confirmation == true then
						RageUI.Separator("~g~Pouvez-vous confirmer votre achat ?~s~")
						RageUI.Button("Acheter", nil, {RightLabel = price.." Coins"}, true, {
							onSelected = function()
								TriggerServerEvent("Boutique:BuyVehicle",name,price,label)
								confirmation = false
								name = nil
								price = nil
								label = nil

							end
						})
						RageUI.Button("Annuler", nil, {RightLabel = "→→→"}, true, {
							onSelected = function()
								confirmation = false
							end
						})
					end
					for k,v in pairs(VehicleInBoutique) do 
						if confirmation == false then
							RageUI.Button(v.carLabel, nil, {RightLabel = v.price.." Coins"}, true, {
								onActive = function()
									RageUI.RenderVehicule("Boutique", v.carName, 0, 0, 0, 0, 0, 255, 255)
									RageUI.Info("Véhicules a exemplaire limité", {"Nom : ","Prix : ","KMH max : ","Exemplaire Restant : "}, {v.carLabel,v.price.." Coins",v.description.. " KM/H",v.limite})
								end,
								onSelected = function()
									confirmation = true
									name = v.carName
									price = v.price
									label = v.carLabel
								end
							})
						end
					end
				end)
				Wait(1)
			end
		end)
	end
end
