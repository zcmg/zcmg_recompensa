fx_version 'cerulean'
games { 'gta5' }

author 'zcmg#5307'
description 'V2.2'

client_scripts {
	'config.lua',
	'client/*.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/*.lua'
}