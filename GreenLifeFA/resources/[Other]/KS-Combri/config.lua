Config={}

------------------------------------[[  ZONNE DE CONFIGURATIONS  ]]------------------------------------
Config.legacy = "oui" -- non ou oui

Config.ESX_GetCoreObject_client = function() 
	ESX = exports["Framework"]:getSharedObject()
end

Config.ESX_GetCoreObject_serveur = function() 
	ESX = exports["Framework"]:getSharedObject()	
end



Config.flic = 1 -- nombre de flic pour pourvoir faire le cambriolage. / par défaut c'est 3 police en ville

Config.tempsalerte = 15 -- mettrez votre temps en seconde pour l'alerte de la police. / par défaut c'est 1 minute

Config.entrer = 5     -- mettrez votre temps en seconde pour le temps de l'entrer. / par défaut c'est 5 seconde

Config.Command = 'cambriolage'    -- entre les ' ' Le nom de la commande pour activé les blips ou les désactiver

cartemakers = true	-- true activé les makers / false enlever les makers en jeu devant les portes.

Config.Commandpnjventeur = 'pnjvendeur'

Config.default_pnj_revente = true
---------------------------------
-------- Prix de revente --------
---------------------------------

-- mettez votre mini et le max entre les () pour chaque objet.


Config.PrixTableau = math.random(100,200)

Config.PrixTV = math.random(300,400)

Config.PrixPc = math.random(400,500)

Config.PrixVase = math.random(75,100)

Config.Prixenceinte = math.random(200,300)

Config.PrixBijoux = math.random(600,700)


---------------------------------
-------- temps par objet --------
---------------------------------

-- mettrez votre temps pour prendre les objets. (( en seconde ))

Config.tempstableau = 10

Config.tempstele = 20

Config.tempspc = 5

Config.tempsvase = 10

Config.tempsenceinte = 15

Config.tempsbijoux = 15


----------------------------------[[  FIN DE ZONNE DE CONFIGURATIONS  ]]--------------------------------


Config.blipscarte = {
                -- Maison style luxe --
    luxe1= {Pos = {x = -469.1, y = 329.99, z = 104.75}}, 
    luxe2= {Pos = {x = -1277.70, y = 629.8, z = 143.19}},
    luxe3= {Pos = {x = -1090.43, y = 548.36, z = 103.63}},    
    luxe4= {Pos = {x = -912.45, y = 777.55, z = 187.01}},
    luxe5= {Pos = {x = -536.72, y = 818.51, z = 197.51}},
    luxe6= {Pos = {x = -293.61, y = 601.12, z = 181.58}},


                    -- Maison style basic --
    basic1= {Pos = {x = 254.56, y = -1013.19, z = 29.27}}, 
    basic2= {Pos = {x = -809.54, y = -978.37, z = 14.22}},
    basic3= {Pos = {x = 115.77, y = -271.30, z = 54.51}},
    basic4= {Pos = {x = -99.68 , y = 9.64, z = 74.44}},
	basic5= {Pos = {x = -1536.57 , y = -270.47, z = 48.28}}
} 
  
Config.marker = {
      
    luxe1= {Pos = {x = -469.1, y = 329.99, z = 104.75}, id = "luxe1", type = "luxe"}, 
    luxe2= {Pos = {x = -1277.70, y = 629.8, z = 143.19}, id = "luxe2", type = "luxe"}, 
    luxe3= {Pos = {x = -1090.43, y = 548.36, z = 103.63}, id = "luxe3", type = "luxe"},    
    luxe4= {Pos = {x = -912.45, y = 777.55, z = 187.01}, id = "luxe4", type = "luxe"},
    luxe5= {Pos = {x = -536.72, y = 818.51, z = 197.51}, id = "luxe5", type = "luxe"},
    luxe6= {Pos = {x = -293.61, y = 601.12, z = 181.58}, id = "luxe6", type = "luxe"},


    basic1= {Pos = {x = 254.56, y = -1013.19, z = 29.27}, id = "basic1",type = "basic"},
    basic2= {Pos = {x = -809.54, y = -978.37, z = 14.22}, id = "basic2", type = "basic"},
    basic3= {Pos = {x = 115.77, y = -271.30, z = 54.51}, id = "basic3", type = "basic"},
    basic4= {Pos = {x = -99.68 , y = 9.64, z = 74.44}, id = "basic4", type = "basic"},
	basic5= {Pos = {x = -1536.57 , y = -270.47, z = 48.28}, id = "basic5", type = "basic"} 	
}
    
Config.objet = {
    
    tableau= {Pos = {x = -680.7, y = 586.68, z = 145.38}, item = "tableau", type = "luxe"},
    tableau2= {Pos = {x = 256.60, y = -997.2, z = -99.01}, item = "tableau", type = "basic"},

    tele= {Pos = {x = -664.87, y = 585.67, z = 144.97}, item = "tele", type = "luxe"},
    tele2= {Pos = {x = 262.67, y = -1002.51, z = -99.01}, item = "tele", type = "basic"},

    pc= {Pos = {x = -675.11, y = 588.76, z = 137.77}, item = "pc", type = "basic"},

    vase= {Pos = {x = -668.29, y = 588.05, z = 145.17}, item = "vase", type = "basic"},

    enceinte= {Pos = {x = -672.16, y = 581.54, z = 144.97}, item = "enceinte", type = "luxe"},
    enceinte2= {Pos = {x = 261.54, y = -1002.46, z = -99.01}, item = "enceinte", type = "basic"},

    bijoux= {Pos = {x = -671.04, y = 580.28, z = 141.57}, item = "bijoux", type = "luxe"},
    bijoux2= {Pos = {x = 265.94, y = -999.38, z = -99.01}, item = "bijoux", type = "basic"}
    
}


Config.sortie = {

sortieluxe= {Pos = {x = -682.54, y =  592.64, z = 145.38}},
sortiebasic= {Pos = {x = 265.59, y =  -1002.84, z = -99.01}}

}

Config.vente = {
    
    sortie1= {Pos = {x = -277.65, y = 2205.53, z = 129.4, h = 60.39},    
        hash  =  0xB3F3EE34,
        type  = "vendeur",
                },
 
}
  

