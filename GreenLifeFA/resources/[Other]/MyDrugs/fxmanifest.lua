

fx_version 'adamant'
game 'gta5'

lua54 'yes'
escrow_ignore {
    'config.lua',
	
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@Framework/locale.lua',
    'config.lua',
    'server/server.lua',
   
    
}

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
}


client_scripts {
    '@Framework/locale.lua',
    'config.lua',
    'client/client.lua',
 

}

dependencies {
    'rprogress'
    
}