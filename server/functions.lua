function logs(msg, canal, cor)
	local corfinal = tonumber(cor:gsub("#",""),16)
	PerformHttpRequest(canal, function(err, text, headers) end, 'POST', json.encode({username = 'ESX Developer Scripts', embeds = {{["color"] = corfinal, ["author"] = {["name"] = 'Esx Developer Portugal', ["icon_url"] = 'https://cdn.discordapp.com/attachments/878328503148355584/880839161924448256/FiveM-Logo2.png'}, ["description"] = msg, ["footer"] = {["text"] = "Esx Developer Portugal - "..os.date("%x %X %p"),["icon_url"] = "https://media.discordapp.net/attachments/878328503148355584/918644161018728528/FiveM-Logo2_tools.png",},}}, avatar_url = 'https://cdn.discordapp.com/attachments/878328503148355584/880839161924448256/FiveM-Logo2.png'}), { ['Content-Type'] = 'application/json' })
end


function RandomCodeGenerator()
		local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

	
		charTable = {}
		for c in chars:gmatch"." do
			table.insert(charTable, c)
		end
	
		for i = 1, 20 do
			RandomCode = RandomCode .. charTable[math.random(1, #charTable)]
		end
	
		return charTable[26]..charTable[3]..charTable[13]..
		charTable[7].."#"..charTable[58]..charTable[56]..
		charTable[53]..charTable[60].."|"..RandomCode
	
end

function verificaritem(item)
	MySQL.Async.fetchScalar('SELECT COUNT(1) FROM items WHERE name = @item ', {
		['@item'] = item 
		}, function(result)
			if result == 0 then
				return 0
			else
				return 1
			end		
	end)

end
