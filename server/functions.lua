function logs(msg, canal, cor)
	local corfinal = tonumber(cor:gsub("#",""),16)
	PerformHttpRequest(canal, function(err, text, headers) end, 'POST', json.encode({username = 'ESX Developer Scripts', embeds = {{["color"] = corfinal, ["author"] = {["name"] = 'Esx Developer Portugal', ["icon_url"] = 'https://cdn.discordapp.com/attachments/878328503148355584/880839161924448256/FiveM-Logo2.png'}, ["description"] = msg, ["footer"] = {["text"] = "Esx Developer Portugal - "..os.date("%x %X %p"),["icon_url"] = "https://media.discordapp.net/attachments/878328503148355584/918644161018728528/FiveM-Logo2_tools.png",},}}, avatar_url = 'https://cdn.discordapp.com/attachments/878328503148355584/880839161924448256/FiveM-Logo2.png'}), { ['Content-Type'] = 'application/json' })
end

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
	if Config.ESX12 then
		for k, v in pairs(Config.Identifier) do
			if xPlayer.identifier == v.id then
				admin = true
				break
			else
				admin = false
			end
		end
	else
		for k, v in pairs(Config.Steams) do
			if xPlayer.identifier == v.id then
				admin = true
				break
			else
				admin = false
			end
		end
	end

	return admin
end

PerformHttpRequest('https://raw.githubusercontent.com/zcmg/'..GetCurrentResourceName()..'/main/fxmanifest.lua', function(code, res, headers)
	local version = GetResourceMetadata(GetCurrentResourceName(), 'description')
	local versao = ''
	local update = ''

	if res ~= nil then
		local t = {}
		for i = 1, #res do
			t[i] = res:sub(i, i)
		end
		versao = t[73]..t[74]..t[75]..t[76]

		if versao == version then
			update = "Ultima Versão"
		else
			update = "^2Precisa de atualizar^1"
		end

	else
		update = "Impossivel verificar a versão"
	end

	

	print(([[^1--------------------------------------------------------------------------
	███████╗ ██████╗███╗   ███╗ ██████╗      ██████╗ ██████╗ ██████╗ ███████╗
	╚══███╔╝██╔════╝████╗ ████║██╔════╝     ██╔════╝██╔═══██╗██╔══██╗██╔════╝
	  ███╔╝ ██║     ██╔████╔██║██║  ███╗    ██║     ██║   ██║██████╔╝█████╗  
	 ███╔╝  ██║     ██║╚██╔╝██║██║   ██║    ██║     ██║   ██║██╔══██╗██╔══╝  
	███████╗╚██████╗██║ ╚═╝ ██║╚██████╔╝    ╚██████╗╚██████╔╝██║  ██║███████╗
	╚══════╝ ╚═════╝╚═╝     ╚═╝ ╚═════╝      ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ 
	-----------------------^0https://www.github.com/zcmg/^1----------------------- 
	
	--------------------------------------------------------------------------
	-- ESX DEVELOPER PORTUGAL (^0https://discord.gg/Qt5WraEMxf^1)
	-- Versão: %s (%s)
	--------------------------------------------------------------------------^0]]):format(versao, update))

end,'GET')