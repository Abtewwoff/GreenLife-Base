function _GreenLifeGangBuilder:ModifGrade(gradeName, accesName, state)
    local gradeName = string.lower(gradeName)

    self.grades[gradeName][accesName] = state

    self:UpdateEvent("GreenLife:GangBuilder:ReceiveGrades", self.grades)

    self:SaveOnBdd()
end