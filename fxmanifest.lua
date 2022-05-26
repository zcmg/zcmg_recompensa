fx_version 'cerulean'
games { 'gta5' }

author 'zcmg#5307'
description 'V1.5.1'

client_scripts {
	'config.lua',
	'client/client.lua',
	'client/functions.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/server.lua',
	'server/functions.lua'
}