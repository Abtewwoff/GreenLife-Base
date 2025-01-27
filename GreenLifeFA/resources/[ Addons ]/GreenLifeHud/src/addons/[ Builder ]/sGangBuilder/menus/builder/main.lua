MOD_GangBuilder.Menus.MainBuilder = RageUI.CreateMenu("", "Gang builder")

local GangBuilderCreate = require 'src.addons.[ Builder ].sGangBuilder.menus.builder.submenus.CreateGang.index'
GangBuilderCreate:LoadMenu(MOD_GangBuilder.Menus.MainBuilder)

local GangBuilderList = require 'src.addons.[ Builder ].sGangBuilder.menus.builder.submenus.ListGang.index'
GangBuilderList:LoadMenu(MOD_GangBuilder.Menus.MainBuilder)

MOD_GangBuilder.Menus.MainBuilder:IsVisible(function(Items)
    Items:Button("Crée un gang", "Vous permet de crée un gang", {RightLabel = "→→" }, true, {
    }, GangBuilderCreate.Menu);

    Items:Button("Liste des gang", "Vous permet de modifier un gang existant", {RightLabel = "→→" }, true, {
    }, GangBuilderList.Menu);
end)


RegisterNetEvent('GreenLife:GangBuilder:OpenGangBuilder')
AddEventHandler('GreenLife:GangBuilder:OpenGangBuilder', function(dataGang)
    MOD_GangBuilder.Menus.MainBuilder:Toggle()

    MOD_GangBuilder.GangList = dataGang
end)