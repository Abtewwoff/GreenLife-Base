--[[
  This file is part of GreenLife RolePlay.
  Copyright (c) GreenLife RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

  ESX = nil
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local GoFast = {}
local CanProgramming = true
local reward = Config.GoFast.Reward

ESX.RegisterServerCallback('checkDisponibility', function(source, cb)
    if CanProgramming then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('StartGoFast')
AddEventHandler('StartGoFast', function()
    if not CanProgramming then
        xPlayer.ban(0, '(StartGoFast');
        return
    end
    GoFast[source] = {
        hasStarted = true
    }
    CanProgramming = false
    Citizen.SetTimeout(1000*60*30, function()
        CanProgramming = true
    end)
end)

RegisterNetEvent('GoFast:Ending', function(source, bonus)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if bonus ~= Config.GoFast.Reward then
        xPlayer.ban(0, '(GoFast:Ending)');
    else
        xPlayer.addAccountMoney('dirtycash', Config.GoFast.Reward)
    end
end)