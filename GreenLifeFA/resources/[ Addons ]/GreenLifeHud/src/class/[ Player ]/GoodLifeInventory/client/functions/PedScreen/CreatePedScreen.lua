function _GreenLifeInventory:CreatePedScreen()
    if (self.CurrentPedPreview) then return end

    CreateThread(function()
        local playerPed = PlayerPedId()
        self.CurrentPedPreview = CreatePed(26, GetEntityModel(playerPed), 0.0, 0.0, 0.0, GetEntityHeading(playerPed), false, false)

        ClonePedToTarget(playerPed, self.CurrentPedPreview)
        SetEntityCollision(self.CurrentPedPreview, false, false)
        SetEntityInvincible(self.CurrentPedPreview, true)
        NetworkSetEntityInvisibleToNetwork(self.CurrentPedPreview, true)
        SetEntityVisible(self.CurrentPedPreview, true, false)
        SetEntityCanBeDamaged(self.CurrentPedPreview, false)
        SetBlockingOfNonTemporaryEvents(self.CurrentPedPreview, true)
        DisableIdleCamera(true)

        local positionBuffer = {}
        local bufferSize = 5
        local animDict = "anim@amb@nightclub@peds@" -- New animation dictionary
        local anim = "rcmme_amanda1_stand_loop_cop" -- New animation

        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(100)
        end

        TaskPlayAnim(self.CurrentPedPreview, animDict, anim, 8.0, -8.0, -1, 50, 0, false, false, false)

        while self.CurrentPedPreview do
            if (GetEntitySpeed(playerPed) * 3.6) < 50 then
                local world, normal = GetWorldCoordFromScreenCoord(0.5, 0.75)
                local depth = 4.0
                local target = world + normal * depth
                local camRot = GetGameplayCamRot(2)

                table.insert(positionBuffer, target)
                if #positionBuffer > bufferSize then
                    table.remove(positionBuffer, 1)
                end

                local averagedTarget = vector3(0, 0, 0)
                for _, position in ipairs(positionBuffer) do
                    averagedTarget = averagedTarget + position
                end
                averagedTarget = averagedTarget / #positionBuffer

                SetEntityCoords(self.CurrentPedPreview, averagedTarget.x, averagedTarget.y, averagedTarget.z, false, false, false, false)
                SetEntityHeading(self.CurrentPedPreview, camRot.z + 180.0)
                SetEntityRotation(self.CurrentPedPreview, camRot.x * -1, 0, camRot.z + 180.0, false, false)
            else
                SetEntityVisible(self.CurrentPedPreview, false)
            end

            Wait(0)
        end

        if DoesEntityExist(self.CurrentPedPreview) then
            DeleteEntity(self.CurrentPedPreview)
            self.CurrentPedPreview = nil
        end
    end)
end
