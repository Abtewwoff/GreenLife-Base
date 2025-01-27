Map = {
 -- {name="Mission Row",color=77, id=60, x=431.09, y=-982.32, z=30.71, r=0.0},
  {name="[Etat] Commissariat", color=77, id=60, x = 81.387985229492, y = -404.39596557617, z = 55.33715057373, r=0.0},
  {name="[Etat] B.C.S.O",color=52, id=58, x = -445.42059326172, y = 6008.5693359375, z = 36.999691009521, r= 0.0},
  {name="[Etat] Gouvernement",color=0, id=419,x = -545.42205810547, y = -203.62646484375, z = 38.214832305908, r= 0.0},
  {name="[Etat] FIB",color=0, id=419, x = 2520.839, y = -415.0426, z = 94.12384, r= 0.0},
  
  {name="[Public] Hôpital",color=2, id=61, scale=0.6,x=-1839.18, y = -382.30, z= 49.39, r= 0.0},
  {name="[Public] Maze Bank Arena",color=0, id=647, x = -322.9858, y = -1970.9514, z = 66.7998, r= 0.0},

  {name= "[Entreprise] Benny's",color=5, id=446, x=-211.27, y = -1323.20, z= 30.89, r= 0},
  {name= "[Entreprise] Ls Customs",color=62, id=777, x=-331.3797, y = -109.7054, z= 39.01394, r= 0},
  {name= "[Entreprise] RockFord Record",color=22, id=136, x = -1007.0557861328, y = -267.97705078125, z = 39.040641784668, r= 0},
  {name = "[Entreprise] Unicorn", color=27, id=121, 12, x=129.246, y = -1300.6, z= 29.2, r= 0},
  
  {name="[Activité] Zone de Chasse",color=1, id=141,x=-567.27, y = 5253.18, z= 70.46, r= 3000.0},
  {name="[Activité] Boucherie",color=34, id=478, x = 960.84, y = -2111.57, z = 31.94, r= 0.0},

  {name="[Entreprise] Vigneron",color=61, id=85, x = -1890.2873535156, y = 2045.201171875, z = 140.8708190918, r= 0.0},

  {name="[Métier LIBRE] Casse",color=28, id=643, x = -511.76, y = -1753.97, z = 18.9, r= 0.0},
  
  {name="[Territoire] Bloods",color=1, id=378,x = -1545.39, y = -407.93, z = 41.98, r= 800.0},
  
  {name="[Territoire] Marabunta",color=26, id=378,x = 1434.1728515625, y = -1501.4385986328, z = 63.245822906494 ,r= 800.0},

  {name="[Territoire] Vagos",color=5, id=378,x=324.73, y = -2031.74, z= 20.87, r= 800.0}, 

  {name="[Territoire] Ballas",color=27, id=378,x=88.05, y = -1925.59, z= 20.79, r= 800.0},

  {name="[Territoire] Families",color=2, id=378,x=-165.40, y = -1632.77, z= 33.65, r= 800.0},
  
}

Citizen.CreateThread(function()
  for i=1, #Map, 1 do
    local blip = AddBlipForCoord(Map[i].x, Map[i].y, Map[i].z) 
      SetBlipSprite (blip, Map[i].id)
      SetBlipDisplay(blip, 4)
      SetBlipScale  (blip, 0.6)
      SetBlipColour (blip, Map[i].color)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING") 
      AddTextComponentString(Map[i].name)
      EndTextCommandSetBlipName(blip)
      local zoneblip = AddBlipForRadius(Map[i].x, Map[i].y, Map[i].z, Map[i].r)
      SetBlipSprite(zoneblip,1)
      SetBlipColour(zoneblip,Map[i].color)
      SetBlipAlpha(zoneblip,100)
  end
end)