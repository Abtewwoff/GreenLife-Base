
fx_version 'adamant'
game 'gta5'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua", 
    
    'client/**/*.lua',
}

shared_script {
    'config/*.lua'
}


server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

