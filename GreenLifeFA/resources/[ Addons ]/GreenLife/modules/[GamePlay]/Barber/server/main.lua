--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

RegisterServerEvent('barbershop:pay')
AddEventHandler('barbershop:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
  if (price <= xPlayer.getAccount("cash").money) then
    xPlayer.removeAccountMoney('cash', 15)
    TriggerClientEvent('esx:showNotification', _source, "Vous avez payé ~g~15$")
  else
    xPlayer.showNotification("~r~Vous n'avez pas assez d'argent !");
  end
end)