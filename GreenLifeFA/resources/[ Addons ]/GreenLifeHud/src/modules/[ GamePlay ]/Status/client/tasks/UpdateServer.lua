function MOD_Status:loadUpdateServer()
    Citizen.CreateThread(function()
        while true do
            Wait(ConfigGreenLifeHud.status.UpdateInterval)

            TriggerServerEvent('GreenLife:Status:UpdateStatus', MOD_Status:getState())
        end
    end)
end