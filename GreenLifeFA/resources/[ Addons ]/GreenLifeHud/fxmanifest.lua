fx_version "cerulean"
game "gta5"

lua54 "yes"
use_fxv2_oal "yes"

author "J0thun"
description "GreenLifeHud By J0thun"

-- RageUI
client_scripts {
    'libs/RageUI/config.lua',
    'libs/RageUI/init.lua',
    'libs/RageUI/menu/RageUI.lua',
    'libs/RageUI/menu/Menu.lua',
    'libs/RageUI/menu/MenuController.lua',
    'libs/RageUI/components/*.lua',
    'libs/RageUI/menu/elements/*.lua',
    'libs/RageUI/menu/items/*.lua',
    'libs/RageUI/menu/panels/*.lua',
    'libs/RageUI/menu/windows/*.lua',
}

shared_scripts {
    -- GreenLifeHud Require
    "imports.lua",

    -- GreenLifeHud Config
    "src/config/config.lua",

    -- GreenLifeHud API
    "src/api/**/_define.lua",
    "src/api/**/shared/*.lua",

    -- GreenLifeHud Class
    "src/class/exportMetatable.lua",

    -- GreenLifeHud modules
    "src/modules/**/_define.lua",
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',

    "init/sv_main.lua",

    -- GreenLifeHud Core
    "src/core/**/server/*.lua",
    "src/core/**/server/events/*.lua",
    "src/core/**/server/functions/*.lua",

    -- GreenLifeHud Class
    "src/class/**/server/_constructor.lua",
    "src/class/**/server/functions/**/*.lua",
    "src/class/**/server/tasks/**/*.lua",

    -- GreenLifeHud modules
    'src/modules/**/server/*.lua',
    "src/modules/**/server/functions/**/*.lua",
    'src/modules/**/server/events/**/*.lua',
    'src/modules/**/server/tasks/*.lua',
    'src/modules/**/server/exports/**/*.lua',

    -- GreenLifeHud addons
    'src/addons/**/server/**',
}

client_scripts {
    "init/cl_main.lua",
    
    -- GreenLifeHud API
    "src/api/**/client/*.lua",

    -- GreenLifeHud Core
    "src/core/client/*.lua",

    -- GreenLifeHud Class
    "src/class/**/client/_constructor.lua",
    "src/class/**/client/functions/**/*.lua",
    "src/class/**/client/tasks/**/*.lua",

    -- GreenLifeHud modules
	'src/modules/main.lua',

    "src/modules/**/client/*.lua",
    "src/modules/**/client/functions/**/*.lua",
    "src/modules/**/client/events/**/*.lua",
    "src/modules/**/client/tasks/*.lua",
    'src/modules/**/client/exports/**/*.lua',
    
    -- GreenLifeHud Menus
    "src/modules/**/client/menus/*.lua",
    "src/addons/**/menus/**/main.lua",

    -- GreenLifeHud addons
    'src/addons/**/client/**',
}



ui_page 'html/index.html'
files {
	'html/index.html',

	'html/sound/*.ogg',

	'html/static/css/*.css',
	'html/static/js/*.js',

	-- IMG
	'html/static/img/**/*.png',

	'html/static/fonts/*.woff',
	'html/static/fonts/*.woff2',
	'html/static/fonts/*.ttf',

    -- GreenLifeHud SubMenu
    "src/modules/**/client/menus/submenus/**/*.lua",
    "src/addons/**/menus/**/submenus/**/*.lua",

    -- GreenLifeHud Enums
    "src/enums/**"
}


data_file 'DLC_ITYP_REQUEST' 'stream/potweed.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/weed_dry.ytyp'

data_file 'DLC_ITYP_REQUEST' 'stream/mac_weed.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/rain_weed.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/tropic_weed.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/candy_weed.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/og_weed.ytyp'server_scripts { '@mysql-async/lib/MySQL.lua' }