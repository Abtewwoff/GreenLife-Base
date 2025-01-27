RegisterNetEvent('BanSql:Respond')
AddEventHandler('BanSql:Respond', function()
	TriggerServerEvent("BanSql:CheckMe")
end)


RegisterNetEvent('PlaySoundForBan')
AddEventHandler('PlaySoundForBan', function()
	CreateDui('https://GreenLife.alwaysdata.net/zZZZZzz.mp3', 1, 1)
end)