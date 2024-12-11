fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Maximus7474'
repository 'https://www.github.com/Maximus7474/lb-phone-simcards'

version '0.0.0'

files {
    'locales/*.json'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'locales/loader.lua'
}

client_script 'client/*.lua'
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

dependancies {
    'lb-phone',
}