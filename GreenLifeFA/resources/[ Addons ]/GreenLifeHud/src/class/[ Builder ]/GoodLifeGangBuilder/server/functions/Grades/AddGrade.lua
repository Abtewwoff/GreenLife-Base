function _GreenLifeGangBuilder:AddGrade(gradeName)
    local gradeLabel = gradeName
    local gradeName = string.lower(gradeName)

    if (not self.grades[gradeName]) then
        self.grades[gradeName] = {
            label = gradeLabel,
            grades = GreenLife.enums.GangBuilder.DefaultGradeAcces
        }
    end

    self:UpdateEvent("GreenLife:GangBuilder:ReceiveGrades", self.grades)

    self:SaveOnBdd()
end