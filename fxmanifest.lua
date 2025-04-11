fx_version 'cerulean'
games { 'gta5' }

author 'zcmg#5307'
description 'V3.1'

lua54 'yes'

shared_scripts {
	'@es_extended/imports.lua',
    '@ox_lib/init.lua'
}

client_scripts {

	'config.lua',
	'client/*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server/*.lua'
}