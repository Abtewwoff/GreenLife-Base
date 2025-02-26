MOD_Society.Menus.MainSociety = RageUI.CreateMenu("", "Society")

local SocietyManageAccounts = require 'src.addons.[ Gameplay ].Society.menus.submenus.accounts.index'
SocietyManageAccounts:LoadMenu(MOD_Society.Menus.MainSociety)

local SocietyManageEmployees = require 'src.addons.[ Gameplay ].Society.menus.submenus.employees.index'
SocietyManageEmployees:LoadMenu(MOD_Society.Menus.MainSociety)

local SocietyManageSalary = require 'src.addons.[ Gameplay ].Society.menus.submenus.salary.index'
SocietyManageSalary:LoadMenu(MOD_Society.Menus.MainSociety)

MOD_Society.Menus.MainSociety:IsVisible(function(Items)

    Items:Button("Gestion des comptes", nil, { }, true, {
        onSelected = function()
            TriggerServerEvent('GreenLife:Society:RequestMoney', MOD_Society.data.name)
            TriggerServerEvent('GreenLife:Society:RequestDirtyMoney', MOD_Society.data.name)
        end
    }, SocietyManageAccounts.Menu);

    Items:Button("Gestion des employés", nil, { }, true, {
        onSelected = function()
            TriggerServerEvent('GreenLife:Society:RequestEmployees', MOD_Society.data.name)
        end
    }, SocietyManageEmployees.Menu);

    Items:Button("Gestion des salaires", nil, { }, true, {
        onSelected = function()
            TriggerServerEvent('GreenLife:Society:RequestGrades', MOD_Society.data.name)
        end
    }, SocietyManageSalary.Menu);

end, nil, function()
    MOD_Society.data = {}
end)


RegisterNetEvent('GreenLife:Society:OpenMenuBoss')
AddEventHandler('GreenLife:Society:OpenMenuBoss', function(societyData)
    MOD_Society.Menus.MainSociety:Toggle()

    MOD_Society.data = societyData
end)

GreenLife:OnJobChange(function(typeJob, job)
    if (typeJob == "job") then
        MOD_Society.Menus.MainSociety:Close()
    end
end)