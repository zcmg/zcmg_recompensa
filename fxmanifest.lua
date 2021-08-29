fx_version 'cerulean'
games { 'gta5' }

author 'zcmg#5307'
description 'V1.1'

client_scripts {
	'client.lua',
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

dependencies {
	'async',
	'mysql-async',
	'es_extended'
}
