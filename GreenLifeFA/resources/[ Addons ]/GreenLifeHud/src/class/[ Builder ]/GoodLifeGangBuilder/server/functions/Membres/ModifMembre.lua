function _GreenLifeGangBuilder:ModifMembre(license, name)
    self.membres[license].grade = name

    self:UpdateEvent("GreenLife:GangBuilder:ReceiveMembres", self.membres)

    self:SaveOnBdd()
end