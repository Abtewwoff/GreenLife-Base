function _GreenLifeCoffreBuilder:logsDepot(source, xPlayer, itemName, itemId, itemCount)

     local Title = "Items Dépose - Coffre : "..self.jobCoffre
     local Message
     local WeebHook

     -- Logs Job
     if self.jobCoffre == "ltd_sud" then
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1226442772131745812/ijgxzBBdprb2JJASIN_Br0zXfTiUmHaLlK59kBR9ek3vHYHCuY0wfb2TEsBwrEY4WuhJ"
     elseif self.jobCoffre == "avocat" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324640859362431057/8zlxFrUhEcO8fCjoY7_19Lw5sdvxtV7Nztu4fTef2pW-vJQ5xEK95hS8Lx6Ql1bGRPLV"
     elseif self.jobCoffre == "boatseller" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324640919529721918/-AjaZm6KapNArLSbAjgoqiiny7DQUKdm0hcsOdzKg5Ei4omIho-2c_aNW5t8dEDFahyd"
     elseif self.jobCoffre == "burgershot" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324641148601630762/oG7w7i_SkeADLuNB2vW53RaRiiw2CVpP6BODfj_7LTCKxFtn5KbF5Gti_Qg2WqcXapXB"
     elseif self.jobCoffre == "journalist" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324641239206989824/D2_l2lqm-0DaPpGw1hS7fUmm16wu4FqbeugElXvzIWnQ39-VLKF_aJzUV-7-xSYDJ-vH"
     elseif self.jobCoffre == "mecano2" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324641321431859210/WxReqoSrpmGAfWfKVG4FGfzwTMuyY5jED68ddCVFTdVVyAh9BMNW29C8dENiLohCavyF"
     elseif self.jobCoffre == "realestateagent" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324641444899852370/TOiqeeEGx_pDSck3QutOZqTeit0daLZK9Ppk7jae_9suxkMvaezjNqo6l2kPJ8dwQPDf"
     elseif self.jobCoffre == "ambulance" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324641652677279745/Sb8flTZ1gyQHdLswNYucUC9Hhw6LXvNLizsSuArZfX_ZVx7DBGV-KAfKulz1zSBFgX2b"
     elseif self.jobCoffre == "label" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1226442772131745812/ijgxzBBdprb2JJASIN_Br0zXfTiUmHaLlK59kBR9ek3vHYHCuY0wfb2TEsBwrEY4WuhJ"
     elseif self.jobCoffre == "mecano" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324641768389738557/-3UaggmBkv-CCFOTJsNYpFJCtGRf2N39UhO7AJnCckp2x123Hz7ELx1OagHrBzUfq7ae"
     elseif self.jobCoffre == "planeseller" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324641865039085670/pD0KIvt83NgxaHvRp7G8YOXJUy176B4x6E8BY_sDeLpKlPNqnRENz_cm5YWgWG-u4DoL"
     elseif self.jobCoffre == "taxi" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324641984467439646/0n3VtkVBcaZkxjbFwnD_13bB_L7aZg7d7-DE_7wEK8NTplmz46-JYM6AesFos1Tbj5Tj"
     elseif self.jobCoffre == "tequilala" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324642368732790805/_tKAJ5zxk_NjJwqNtQHyIKZ444-Zsr08KQhuqdUldxzIug9RtGLw7UysmLtpZs-vx4-E"
     elseif self.jobCoffre == "unicorn" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324642458449088563/oyPvxkLjebIjXNO1PlAkouoLlxN_eWfsMHMvWRx8AzFBe8PgssYysklioy-jPCKG51hY"
     elseif self.jobCoffre == "cardealer" then 
          Message = "Item déposé par **"..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n Information : **\n Item : "..itemName.."\n Nombre : "..itemCount
          WeebHook = "https://discord.com/api/webhooks/1324642540573425796/K5w3m-WY1laPrF5WrmZFPm0uOT-ZZDUAKVmu19oTpe24pOWFt-dyBwr0pdxcfnHc5073"
     end


     ---LOGS LEGAL
     self:sendWebHook(Title, Message, WeebHook, 65280)
     
     ---ADMIN
     self:sendWebHook(Title, Message, "https://discord.com/api/webhooks/1324642620533903412/pDcAqq4OQuRTzWoUeO0_43NtksL9VSuYmvjaKXmJqbMJgqng4-p8iJZYnA_ZnyzblO9m", 65280)
end