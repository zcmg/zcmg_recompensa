fx_version 'cerulean'
games { 'gta5' }

author 'zcmg#5307'
description 'V1.3.1'

client_scripts {
	'client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

dependencies {
	'mysql-async',
	'es_extended'
}
