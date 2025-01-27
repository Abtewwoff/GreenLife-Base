

fx_version 'adamant'

game 'gta5'

description 'chat'

ui_page 'web/ui.html'

files {
	'web/*.*',
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
	'ooc.lua',
}

server_scripts {
	'server.lua',
	'commands.lua',
}




server_scripts { '@oxmysql/lib/MySQL.lua' }