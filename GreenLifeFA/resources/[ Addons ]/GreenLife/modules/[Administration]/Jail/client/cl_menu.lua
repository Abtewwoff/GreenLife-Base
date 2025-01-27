

ESX = nil
local jail = 0
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(100)
    end
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)
local open = false

ConfigJailMenu = {
    {JailLabel = "Carkill", JailTache = 90},
    {JailLabel = "ComportementHRP", JailTache = 80},
    {JailLabel = "ConduiteHRP", JailTache = 50},
    {JailLabel = "FreeLoot", JailTache = 50},
    {JailLabel = "FreePunch", JailTache = 60},
    {JailLabel = "FreeShoot", JailTache = 60},
    {JailLabel = "Freekill", JailTache = 90},
    {JailLabel = "InsulteStaff", JailTache = 100},
    {JailLabel = "MassRP", JailTache = 70},
    {JailLabel = "NoFear", JailTache = 100},
    {JailLabel = "NoFearOrganisation", JailTache = 85},
    {JailLabel = "NoFearPolice", JailTache = 85},
    {JailLabel = "NoPain", JailTache = 70},
    {JailLabel = "PowerGaming", JailTache = 60},
    {JailLabel = "ProposRaciste", JailTache = 85},
    {JailLabel = "RefusDeScene", JailTache = 120},
    {JailLabel = "Troll", JailTache = 150},
    {JailLabel = "UseBug", JailTache = 75},
}

RegisterNetEvent("JailMenu:OpenMenu")
AddEventHandler("JailMenu:OpenMenu", function(id)
    OpenJailMenu(id)
end)

RegisterNetEvent("JailMenu:AddJailCounter")
AddEventHandler("JailMenu:AddJailCounter", function()
    if jail == 0 then
        jail = jail + 1
        inTimeJail()
    else
        jail = jail + 1
    end
end)
local JailMenu = RageUI.CreateMenu("", "Jail Menu", 0, 0, 'menustyle', 'interaction_bgd')

function OpenJailMenu(id)
	if open then
		open = false
		RageUI.Visible(JailMenu,false)
		return
	else
		open = true
		RageUI.Visible(JailMenu,true)
		CreateThread(function()
			while open do

				RageUI.IsVisible(JailMenu,function() 
                    RageUI.Separator("ID sélectionné : ~r~"..id.."~s~")
					for k,v in pairs(ConfigJailMenu) do
                        RageUI.Button(v.JailLabel.." | ~r~"..v.JailTache.."~s~ Tache", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                TriggerServerEvent("JailMenu:JailPlayer", id, v.JailTache, v.JailLabel)
                                ESX.ShowNotification("~g~Vous avez jail l'ID "..id.." pour "..v.JailTache.." taches ~s~")
                                open = false
                            end
                        })
                    end
                    RageUI.Button("Taches Personalisé", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            local TacheRaison = DEN:KeyboardInput("Raison", "Entre la raison du jail", 30)
                            local tacheNumber = DEN:KeyboardInput("Tache", "Entre le nombre de taches", 30)
                            if TacheRaison ~= nil then
                                if tonumber(tacheNumber) ~= nil then
                                    TriggerServerEvent("JailMenu:JailPlayer", id, tacheNumber, TacheRaison)
                                    ESX.ShowNotification("~g~Vous avez jail l'ID "..id.." pour "..tacheNumber.." taches ~s~")
                                    open = false
                                else
                                    ESX.ShowNotification("~r~Veuillez entrer un nombre de tache valide")
                                end
                            else
                                ESX.ShowNotification("~r~Veuillez entrer une raison valide")
                            end
                        end
                    })
				end)
				Wait(1)
			end
		end)
	end
end

function inTimeJail()
    local timer = 180000
    while timer > 0 do
        if jail >= 10 then
            TriggerServerEvent("JailMenu:AntiMassJail")
        end
        if timer <= 1000 then
            jail = 0
        end
        timer = timer - 1000
        Wait(1000)
    end
end