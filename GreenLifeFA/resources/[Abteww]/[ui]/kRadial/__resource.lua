resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"


ui_page('index.html') 
files({
    'index.html',
    'assets/index.js',
    'assets/css/fonts.css',
    'assets/css/style.css',
})

client_script {
    '@Framework/locale/locale.lua',
    "main.lua"
}

server_scripts {
    '@Framework/locale/locale.lua',
    '@oxmysql/lib/MySQL.lua',
}