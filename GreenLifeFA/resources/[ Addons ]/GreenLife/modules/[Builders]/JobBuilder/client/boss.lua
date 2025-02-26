local societyJobsmoney = nil
local jobsData = {};

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

RegisterNetEvent('jobbuilder:restarted', function(player)

    ESX.PlayerData = player

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end);

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

    ESX.PlayerData.job = job

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

local function JobBuilderKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(3)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

local JobsEmployeList = {}
local JobBuilder = {
    Boss = {}
};

function MenuBoss(LabelJob)
  local MenuBoss = RageUIPolice.CreateMenu("", LabelJob)
  local MenuGestEmployeJobs = RageUIPolice.CreateSubMenu(MenuBoss, "", LabelJob)
  local MenuGestEmployeJobs2 = RageUIPolice.CreateSubMenu(MenuGestEmployeJobs, "", LabelJob)
    RageUIPolice.Visible(MenuBoss, not RageUIPolice.Visible(MenuBoss))
            while MenuBoss do
                Wait(3)
                    RageUIPolice.IsVisible(MenuBoss, true, true, true, function()

                    if societyJobsmoney ~= nil then
                        RageUIPolice.Button("Argent société :", nil, {RightLabel = "$" .. societyJobsmoney}, true, function()
                        end)
                    end

                    RageUIPolice.Button("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local Cbmoney = JobBuilderKeyboardInput("Combien ?", '' , 15)
                            Cbmoney = tonumber(Cbmoney)
                            if Cbmoney == nil then
                                RageUIPolice.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('JobBuilder:withdrawMoney', JobBuilder.Boss.SocietyName, Cbmoney)
                                RefreshJobsMoney()
                            end
                        end
                    end)

                    RageUIPolice.Button("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local Cbmoneyy = JobBuilderKeyboardInput("Montant", "", 10)
                            Cbmoneyy = tonumber(Cbmoneyy)
                            if Cbmoneyy == nil then
                                RageUIPolice.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('JobBuilder:depositMoney', JobBuilder.Boss.SocietyName, Cbmoneyy)
                                RefreshJobsMoney()
                            end
                        end
                    end)


                    RageUIPolice.Button("Gestion employés", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                            local GangName = JobBuilder.Boss.Name
                            loadEmployeJobs(GangName)
                        end
                    end, MenuGestEmployeJobs)

            end, function()
            end)

            RageUIPolice.IsVisible(MenuGestEmployeJobs, true, true, true, function()

                if #JobsEmployeList == 0 then
                    RageUIPolice.Separator("")
                    RageUIPolice.Separator("~r~Aucun Employé")
                    RageUIPolice.Separator("")
                end

                for k,v in pairs(JobsEmployeList) do
                    RageUIPolice.Button(v.Name, false, {RightLabel = "~g~→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            Ply = v
                        end
                    end, MenuGestEmployeJobs2)
                end

            end, function()
            end)

            RageUIPolice.IsVisible(MenuGestEmployeJobs2, true, true, true, function()

                RageUIPolice.Button("Virer ~g~"..Ply.Name,nil, {RightLabel = "~g~→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('JobBuilder:Bossvirer', Ply.InfoMec)
                        RageUIPolice.CloseAll()
                    end
                end)

                RageUIPolice.Button("Promouvoir ~g~"..Ply.Name,nil, {RightLabel = "~g~→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('JobBuilder:Bosspromouvoir', Ply.InfoMec)
                        RageUIPolice.CloseAll()
                    end
                end)

                RageUIPolice.Button("Destituer ~g~"..Ply.Name,nil, {RightLabel = "~g~→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('JobBuilder:Bossdestituer', Ply.InfoMec)
                        RageUIPolice.CloseAll()
                    end
                end)

            end, function()
            end)

            if not RageUIPolice.Visible(MenuBoss) and not RageUIPolice.Visible(MenuGestEmployeJobs) and not RageUIPolice.Visible(MenuGestEmployeJobs2) then
            MenuBoss = RMenu:DeleteType("MenuBoss", true)
        end
    end
end

function loadEmployeJobs(jobName)
    ESX.TriggerServerCallback('JobBuilder:GetJobsEmploye', function(Employe)
        JobsEmployeList = Employe
    end, jobName)
end

function RefreshJobsMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('JobBuilder:getSocietyMoney', function(money)
            UpdateSocietyJobsMoney(money)
        end, "society_"..ESX.PlayerData.job.name)
    end
end

function UpdateSocietyJobsMoney(money)
    societyJobsmoney = ESX.Math.GroupDigits(money)
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        for k,v in pairs(jobsData) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Name and ESX.PlayerData.job.grade_name == 'boss' then
                
                local plyPos = GetEntityCoords(PlayerPedId())
                local Boss = vector3(json.decode(v.PosBoss).x, json.decode(v.PosBoss).y, json.decode(v.PosBoss).z)
                local dist = #(plyPos-Boss)
                if dist <= 20.0 then
                    Timer = 0
                    DrawMarker(2, Boss, 0, 0, 0, 0.0, nil, nil, 0.2, 0.2, 0.2, 0, 129, 211, 255, 0, 1, 0, 0, nil, nil, 0)
                end
                if dist <= 3.0 then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder aux actions patron")
                    if IsControlJustPressed(1,51) then
                        JobBuilder.Boss = v
                        -- ESX.OpenSocietyMenu(v.Name);
                        --RefreshJobsMoney()
                        --MenuBoss(v.Label)
                    end
                end
            end
        end
        Wait(Timer)
    end
end);