ESX.StartPayCheck = function()
	function payCheck()
		local xPlayers = ESX.GetPlayers()

		for i = 1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer then
				local salary = xPlayer.job.grade_salary

				if salary > 0 then
					if xPlayer.job.grade_name == 'unemployed' then
						xPlayer.addAccountMoney('bank', salary)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', salary), 'CHAR_BANK_FLEECA', 9)
					elseif Config.EnableSocietyPayouts then
						local society = ESX.DoesSocietyExist(xPlayer.job.name);
						if society ~= nil then
							if ESX.GetSocietyMoney(xPlayer.job.name) >= salary then
								ESX.RemoveSocietyMoney(xPlayer.job.name, tonumber(salary));
								if xPlayer.getVIP() == 3 then  
									xPlayer.addAccountMoney('bank', salary * 1.50)
									local salayrVip = salary * 1.50
									xPlayer.showNotification("Vous avez reçu votre salaire: ~g~"..salayrVip.."$ \n+50% VIP~s~");
								else
									xPlayer.addAccountMoney('bank', salary)
									xPlayer.showNotification("Vous avez reçu votre salaire: ~g~"..salary.."$~s~");
								end
							else
								TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, xPlayer.job.name, _U('bank'), _U('company_nomoney'), 'CHAR_BANK_FLEECA', 1)
							end
						else
							TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, xPlayer.job.name, '', "Une erreur est survenue, Code erreur ~g~'society_not_exist_error'~s~. Veuillez contacter un ~g~administrateur~s~.", 'CHAR_BANK_FLEECA', 1)
						end
					end
				end
			end
		end
		SetTimeout(Config.PaycheckInterval, payCheck)
	end
	SetTimeout(Config.PaycheckInterval, payCheck)
end
