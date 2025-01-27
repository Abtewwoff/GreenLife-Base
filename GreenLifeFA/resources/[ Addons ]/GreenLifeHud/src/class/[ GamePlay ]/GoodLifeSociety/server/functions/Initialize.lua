function GreenLifeSociety:Initialize(callback)
    self:LoadGrades(function()

        self:LoadBddSociety(function()
            callback()
        end)
    
        self:LoadEmployees()

    end)
end