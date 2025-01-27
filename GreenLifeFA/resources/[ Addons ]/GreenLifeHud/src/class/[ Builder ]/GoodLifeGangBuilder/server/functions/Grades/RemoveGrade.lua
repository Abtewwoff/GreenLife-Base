function _GreenLifeGangBuilder:RemoveGrade(gradeName)
    local gradeName = string.lower(gradeName)

    self.grades[gradeName] = nil

    for key, membre in pairs(self:GetAllMembre()) do
        if (membre.grade == gradeName and not membre.isOwner) then
            self:ModifMembre(membre.identifier, "default")
        end
    end

    self:UpdateEvent("GreenLife:GangBuilder:ReceiveGrades", self.grades)

    self:SaveOnBdd()
end