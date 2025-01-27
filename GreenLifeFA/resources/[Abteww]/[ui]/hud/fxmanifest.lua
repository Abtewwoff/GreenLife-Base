-- FX Information
fx_version 'adamant'
game 'gta5'
lua54 'yes'

-- Resource Information
name 'lc-boarding'
author 'LCODE - LGD'
version '1.0.0'
repository 'https://discord.gg/5PENbrvm4N'
description 'Sinistre'


server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
}


client_scripts {
    'client.lua',
}


ui_page 'html/index.html'

files {
    'html/*.html',
    'html/*.js',
    'html/*.css',
    'html/*.ttf',
    'html/public/*.png',
    'html/public/*.svg',
}
