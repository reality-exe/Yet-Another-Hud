fx_version 'cerulean'
games { 'gta5' }

author 'Reality.exe'
description 'CoARPs Terminal integration'
version '1.0.0'

files {
    'html/*.*'
}

ui_page 'html/index.html'

client_scripts {
    'cl_main.lua',
}
server_script 'sv_main.lua'

dependency 'nearestpostal' 