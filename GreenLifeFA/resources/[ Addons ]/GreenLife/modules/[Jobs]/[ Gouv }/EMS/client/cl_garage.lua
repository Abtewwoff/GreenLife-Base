local ConfigGarageAmbu = {}
ConfigGarageAmbu.VehiclesModelName = {
    
    ['emscomet'] = '~h~→ Comet',
    ['ambulance2'] = '~h~→ Camionnette',
    ['ambulance'] = '~h~→ Ambulance',
    ['emsfugitive'] = '~h~→ Fugitive',
}
  
ConfigGarageAmbu.EmsOrderGrades = { 
    { grade = 'boss', name = "Directeur" }, 
    { grade = 'coboss', name = "Co directeur" }, 
    { grade = 'chefs', name = "Chef de service" }, 
    { grade = 'chirurgien', name = "Chirurgien" }, 
    { grade = 'infirmier', name = "Infirmier" }, 
    { grade = 'ambulance', name = "Ambulance" },
}

ConfigGarageAmbu.AuthorizedVehiclesLspd = {
    ambulance = {
      vehicules = {
        { model = 'emscomet' },
        { model = 'ambulance2' },
        { model = 'ambulance' },
        { model = 'emsfugitive' },
      }
    },
  
    infirmier = {
      grades = { 'ambulance' },
    },
  
    chirurgien = {
        grades = { 'ambulance' },
    },
  
    chefs = {
        grades = { 'ambulance' },
    },
  
    coboss = {
        grades = { 'ambulance' },
    },
  
    boss = {
        grades = { 'ambulance' },
    },
}


local GradeVehicules = {}
CreateThread(function()
    local AuthorizedVehiclesLspd = ConfigGarageAmbu.AuthorizedVehiclesLspd

    for key, value in pairs(AuthorizedVehiclesLspd) do
        GradeVehicules[key] = {}

        local GradeAdd = {}
        if (value['grades'] ~= nil) then
            for i=1, #value['grades'] do
                table.insert(GradeAdd, value['grades'][i])
            end
        end

        if (value['vehicules'] ~= nil) then
            GradeVehicules[key][key] = {}
            for i=1, #value['vehicules'] do
                table.insert(GradeVehicules[key][key], value['vehicules'][i])
            end
        end

        if (GradeAdd) then
            for i=1, #GradeAdd do
                local VehListGrade = ConfigGarageAmbu.AuthorizedVehiclesLspd[GradeAdd[i]]?.vehicules

                GradeVehicules[key][GradeAdd[i]] = {}

                if (VehListGrade) then
                    for _i=1, #VehListGrade do
                        table.insert(GradeVehicules[key][GradeAdd[i]], VehListGrade[_i])
                    end
                end
            end
        end
    end
end)



function OpenAmbulanceVehicleSpawnerMenu()
    local mainMenu = RageUI.CreateMenu('', 'Que voulez-vous faire ?')

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openSpawnerAmbulance do
        local grade = ESX.PlayerData.job.grade_name
        local AuthorizedVehiclesLspd = GradeVehicules[grade]

        if (AuthorizedVehiclesLspd == nil) then openSpawnerAmbulance = false return end

        RageUI.IsVisible(mainMenu, function()

            for i=1, #ConfigGarageAmbu.EmsOrderGrades do
                for gradeName, vehicle in pairs(AuthorizedVehiclesLspd) do

                    if (ConfigGarageAmbu.EmsOrderGrades[i].grade == gradeName) then

                        RageUI.Separator("↓ "..ConfigGarageAmbu.EmsOrderGrades[i].name.." ↓")

                        for i=1, #vehicle do
                            RageUI.Button(ConfigGarageAmbu.VehiclesModelName[vehicle[i].model], nil, {RightLabel = "→→"}, true , {
                                onSelected = function()
                                    TriggerServerEvent('ambulance:spawnVehicle');
    
                                    ESX.Game.SpawnVehicle(vehicle[i].model, vector3(-1839.20, -382.19, 40.72), 77.49, function (vehicle)
                                        local newPlate = exports['GreenLife']:GeneratePlate()
                                        SetVehicleNumberPlateText(vehicle, newPlate)
                                        exports["GreenLifeHud"]:SetFuel(vehicle, 100)
                                        TriggerServerEvent('Abteww:GiveDoubleKeys', 'no', newPlate)
                                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                    end)

                                    RageUI.CloseAll()
                                end
                            })
                        end

                    end
                end
            end
        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            openSpawnerAmbulance = false
        end

        Wait(0)
    end
end