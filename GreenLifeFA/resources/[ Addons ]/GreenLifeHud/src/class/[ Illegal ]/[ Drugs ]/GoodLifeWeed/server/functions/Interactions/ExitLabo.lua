function _GreenLifeDrugWeed:ExitLabo(source)
    self.plotManag:removeZoneToClient(source)
    self.securityManag:removeZoneToClient(source)

    TriggerClientEvent('GreenLife:Labo:ExitLabo', source, 'weed')
end