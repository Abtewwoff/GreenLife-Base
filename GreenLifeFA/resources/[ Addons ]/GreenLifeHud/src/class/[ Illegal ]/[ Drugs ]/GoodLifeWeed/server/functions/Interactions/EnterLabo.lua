function _GreenLifeDrugWeed:EnterLabo(source, accesList, memberList)
    self.plotManag:addZoneToClient(source)
    self.securityManag:addZoneToClient(source)

    TriggerClientEvent('GreenLife:Labo:EnterLabo', source, 'weed', accesList, memberList, self.plotList)
end