--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@author Razzway

  RegisterNetEvent(_Prefix..':accessories:pay')
  AddEventHandler(_Prefix..':accessories:pay', function()
      local xPlayer = ESX.GetPlayerFromId(source)
      local price = _Config.clotheshop.accessoriesPrice
      if xPlayer.getAccount('cash').money >= price then
          xPlayer.removeAccountMoney('cash', price)
          TriggerClientEvent('esx:showNotification', source,"~y~Nouvel accessoire~s~\n~g~"..price.." $~s~ vous ont été prélevés de votre portefeuille.")
          TriggerClientEvent(_Prefix..':saveSkin', source)
      else
          TriggerClientEvent('esx:showNotification', source, "~r~Il semblerait que vous ne possédiez pas l'argent nécessaire.")
      end
  end)
  
  RegisterNetEvent(_Prefix..':outfit:pay')
  AddEventHandler(_Prefix..':outfit:pay', function()
      local xPlayer = ESX.GetPlayerFromId(source)
      local price = _Config.clotheshop.price
      if xPlayer.getAccount('cash').money >= price then
          xPlayer.removeAccountMoney('cash', price)
          TriggerClientEvent('esx:showNotification', source,"~y~Vêtement - Nouvelle tenue~s~\n~g~"..price.." $~s~ vous ont été prélevés de votre portefeuille.")
          TriggerClientEvent(_Prefix..':saveSkin', source)
      else
          TriggerClientEvent('esx:showNotification', source, "~r~Il semblerait que vous ne possédiez pas l'argent nécessaire.")
      end
  end)

  RegisterNetEvent(_Prefix..':animation:pay')
  AddEventHandler(_Prefix..':animation:pay', function()
      local src = source
    --   local xPlayer = ESX.GetPlayerFromId(source)
      TriggerClientEvent(_Prefix..':anim', src)
      TriggerClientEvent('esx:showNotification', src,"~y~Aide assister ~s~\n Vous pouvez appuyer sur X pour faire disparaître les sacs de shopping")
  end)
  