function MOD_Status:loadStatus(status)
    CreateThread(function()
        while true do
			local playerPed = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health = prevHealth

            for name, status in pairs(MOD_Status.list) do
                status:onTick()

                if (status.val == 0) then
                    if prevHealth <= 150 then
                        health = health - 5
                    else
                        health = health - 1
                    end
                end
            end

            if (health ~= prevHealth) then
                SetPedHealth(playerPed, health)
            end

            Wait(ConfigGreenLifeHud.status.TickTime)
        end
    end)
end