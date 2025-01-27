RegisterNetEvent('sAdmin:UpdateStaffBoardCount')
AddEventHandler('sAdmin:UpdateStaffBoardCount', function(myReports, AvgReports, playerName, gradeName, staffList)
    exports['GreenLifeHud']:onSetStaffBoardInfos(myReports, AvgReports, playerName, gradeName, sAdmin.inService, staffList)
end)