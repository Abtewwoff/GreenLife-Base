Config.VehiclesWithColor = {

}
  
Config.VehiclesModelNameBcso = {
    ['scorcher'] = 'Velo',
    ['polstanierr'] = 'Rouki',
    ['poltorencer'] = 'impala',
    ['polfugitiver'] = 'Fugitive',
    ['polalamor2'] = 'Ranger',
    ['polbuffalor'] = 'Bravado Buffalo',
    ['polscoutr'] = 'polscoutr',
    ['polcarar'] = 'polcarar',
    ['lspdbuffalostxum'] = 'Bravado Banalisé',
    ['polspeedor'] = 'Rombo',
    ['polbuffalor2'] = 'Buffalo',
    ['polcoquetter'] = 'Coquette',
    ['nddrs6'] = 'RS6',
    ['21f250'] = 'RAM 250',
    ['21durangobb'] = 'Durango 2021',
}
  
Config.BcsoOrderGrades = { 
    { grade = 'boss', name = "Boss" }, 
    { grade = 'undersheriff', name = "undersheriff" }, 
    { grade = 'assistsheriff', name = "assistsheriff" }, 
    { grade = 'chefdeputy', name = "chefdeputy" }, 
    { grade = 'major', name = "major" }, 
    { grade = 'captain', name = "captain" }, 
    { grade = 'lieutenant', name = "lieutenant" }, 
    { grade = 'mastersergeant', name = "mastersergeant" }, 
    { grade = 'sergeant', name = "sergeant" }, 
    { grade = 'caporal', name = "caporal" }, 
    { grade = 'masterdeputy', name = "masterdeputy" },
    { grade = 'seniordeputy', name = "seniordeputy" },
    { grade = 'deputytre', name = "deputytre" },
    { grade = 'deputytwo', name = "deputytwo" },
    { grade = 'deputyone', name = "deputyone" },
    { grade = 'recruit', name = "recruit" }
}

Config.AuthorizedVehiclesBcso = {
    recruit = {
        vehicules = {
            {model = 'scorcher'},
            {model = 'polstanierr'},
            {model = '21durangobb'},
        }
    },
  
    deputyone = {
        grades = { 'recruit' },
        vehicules = {
            {model = 'poltorencer'},
        }
    },

    deputytwo = {
        grades = { 'recruit', 'deputyone' },
        vehicules = {
            {model = '21f250'},
        }
    },
    
    deputytre = {
        grades = { 'recruit', 'deputyone', 'deputytwo' },
        vehicules = {
            {model = 'polfugitiver'},
            {model = 'polalamor2'},
        }
    },

    seniordeputy = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre' },
        vehicules = {
            {model = 'polbuffalor'},
        }
    },

    masterdeputy = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy' },
        vehicules = {
            {model = 'polscoutr'},
        }
    },

    caporal = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy' },
        vehicules = {
            {model = 'polcarar'},
            {model = 'lspdbuffalostxum'},
        }
    },
    sergeant = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal' },
        vehicules = {
            {model = 'polspeedor'},
        }
    },

    mastersergeant = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant' },
        vehicules = {
            {model = 'polbuffalor2'},
        }
    },
    
    lieutenant = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant' },
        vehicules = {
        }
    },
    captain = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant' },
        vehicules = {
            {model = 'polcoquetter'},
            {model = 'nddrs6'},
        }
    },
    major = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant', 'captain' },
    },
    chefdeputy = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant', 'captain' },
    },
    assistsheriff = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant', 'captain' },
    },
    undersheriff = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant', 'captain' },
    },
    boss = {
        grades = { 'recruit', 'deputyone', 'deputytwo', 'deputytre', 'seniordeputy', 'masterdeputy', 'caporal', 'sergeant', 'mastersergeant', 'lieutenant', 'captain' },
    }
}