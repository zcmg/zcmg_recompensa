Config = {}
Config.Steams = {  --Steam ids de quem pode gerar os codigos
	{id ="steam:11000010064f1d9"}, -- Steam ID zcmg
	{id ="steam:11000010067f1d8"}
}

ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local RandomCode = ""


function RandomCodeGenerator()

		local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
		local length = 20
	
		charTable = {}
		for c in chars:gmatch"." do
			table.insert(charTable, c)
		end
	
		for i = 1, length do
			RandomCode = RandomCode .. charTable[math.random(1, #charTable)]
		end
	
		return RandomCode
	
end

--[[
Função Gerar o Código
]]
function gerar(source, args, rawCommand)
		if (args[1] == nil) then
			TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Têm que preencher os parametros para poder gerar o código." }, color = 255,255,255 })
		elseif (args[1] ~= nil and args[2] == nil) then
			if (args[1] == "bank" and args[2] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos. Usar: /codigorecompensa bank 'montante'" }, color = 255,255,255 })
			elseif (args[1] == "black_money" and args[2] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos. Usar: /codigorecompensa black_money 'montante'" }, color = 255,255,255 })
			elseif (args[1] == "cash" and args[2] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos. Usar: /codigorecompensa cash 'montante'" }, color = 255,255,255 })
			elseif (args[1] == "item" and args[2] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos. Usar: /codigorecompensa item 'nome spawn item' 'quantidade items'" }, color = 255,255,255 })
			elseif (args[1] == "weapon" and args[2] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos. Usar: /codigorecompensa weapon 'nome spawn arma' 'numero_balas'" }, color = 255,255,255 })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Tipo desconhecido. Tipos possíveis: item, cash, bank, black_money, weapon" }, color = 255,255,255 })
			end	
		elseif (string.lower(args[1]) == "bank") then -- Banco
			RandomCode = RandomCodeGenerator()
			MySQL.Async.execute("INSERT INTO recompensa(code, type, data1) VALUES (@code,@type,@data1)", {
				['@code'] = RandomCode,
				['@type'] = "bank", 
				['@data1'] = args[2]
			})
			TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Códigos gerados com sucesso! O código é o seguinte: "..RandomCode}, color = 255,255,255 })
			exports.JD_logs:discord('**'..GetPlayerName(source)..'** gerou o seguinte código: **'..RandomCode..'**', source, 0, '#00FF00', '')	
			Wait(5)
			RandomCode = ""
		elseif (string.lower(args[1]) == "black_money") then -- Dinheiro Sujo
			RandomCode = RandomCodeGenerator()
			MySQL.Async.execute("INSERT INTO recompensa(code, type, data1) VALUES (@code,@type,@data1)", {
				['@code'] = RandomCode,
				['@type'] = "black_money", 
				['@data1'] = args[2]
			})
			TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Códigos gerados com sucesso! O código é o seguinte: "..RandomCode}, color = 255,255,255 })
			exports.JD_logs:discord('**'..GetPlayerName(source)..'** gerou o seguinte código: **'..RandomCode..'**', source, 0, '#00FF00', '')	
			Wait(5)
			RandomCode = ""
		elseif (string.lower(args[1]) == "cash") then -- Dinheiro
			RandomCode = RandomCodeGenerator()
			MySQL.Async.execute("INSERT INTO recompensa (code, type, data1) VALUES (@code,@type,@data1)", {
				['@code'] = RandomCode,
				['@type'] = "cash", 
				['@data1'] = args[2]
			})
			TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Códigos gerados com sucesso! O código é o seguinte: "..RandomCode}, color = 255,255,255 })
			exports.JD_logs:discord('**'..GetPlayerName(source)..'** gerou o seguinte código: **'..RandomCode..'**', source, 0, '#00FF00', '')
			Wait(5)
			RandomCode = ""
		elseif (string.lower(args[1]) == "weapon") then -- Arma
			if (args[2] == nil or args[3] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos." }, color = 255,255,255 })
			else
				--Codigo em costrução V1.1 Ainda por testar
				--[[
				if (args[3] == "weapon_dagger" or args[3] == "weapon_bat" or args[3] == "weapon_bottle" or args[3] == "weapon_crowbar" or args[3] == "weapon_flashlight" or args[3] == "weapon_golfclub"
				    or args[3] == "weapon_hammer" or args[3] == "weapon_hatchet" or args[3] == "weapon_knuckle" or args[3] == "weapon_hammer" or args[3] == "weapon_hammer" or args[3] == "weapon_hammer")
					--Gerar o código	
				else
					TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Tipo de arma não é válido." }, color = 255,255,255 })
				end
				--]]
				-- Fim V1.1
			
				RandomCode = RandomCodeGenerator()
				MySQL.Async.execute("INSERT INTO recompensa (code, type, data1, data2) VALUES (@code,@type,@data1,@data2)", {
					['@code'] = RandomCode,
					['@type'] = "weapon", 
					['@data1'] = args[2],
					['@data2'] = args[3]
				})
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Códigos gerados com sucesso! O código é o seguinte: "..RandomCode}, color = 255,255,255 })
				exports.JD_logs:discord('**'..GetPlayerName(source)..'** gerou o seguinte código: **'..RandomCode..'**', source, 0, '#00FF00', '')
				Wait(5)
				RandomCode = ""
			end
		elseif (string.lower(args[1]) == "item") then -- Item
			if (args[2] == nil or args[3] == nil) then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Argumentos inválidos." }, color = 255,255,255 })
			else
				RandomCode = RandomCodeGenerator()
				MySQL.Async.execute("INSERT INTO recompensa (code, type, data1, data2) VALUES (@code,@type,@data1,@data2)", {
					['@code'] = RandomCode,
					['@type'] = "item", 
					['@data1'] = args[2],
					['@data2'] = args[3]
				})
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Códigos gerados com sucesso! O código é o seguinte: "..RandomCode}, color = 255,255,255 })
				exports.JD_logs:discord('**'..GetPlayerName(source)..'** gerou o seguinte código: **'..RandomCode..'**', source, 0, '#00FF00', '')
				Wait(5)
				RandomCode = ""
			end		
		end
end	

function erro(source)
	TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Não tem premisões para fazer isto!"}, color = 255,255,255 })
end


--[[
Função Apagar o Código
]]
function apagar(source, args, rawCommand)
	
end

--[[
Apagar Código
]]
RegisterCommand("apagarrecompensa", function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local ver = false
		
		for k, v in pairs(Config.Steams) do
			if xPlayer.identifier == v.id then
				ver = true
				break
			else
				ver = false
			end
		end
		
		if ver then
			apagar(source, args, rawCommand)
		else
			erro(source)
		end
end, true)

--[[
Gerar Código
]]--
RegisterCommand("codigorecompensa", function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local ver = false
		
		for k, v in pairs(Config.Steams) do
			if xPlayer.identifier == v.id then
				ver = true
				break
			else
				ver = false
			end
		end
		
		if ver then
			gerar(source, args, rawCommand)
		else
			erro(source)
		end
end, true)

--[[
Regastar a recompensa
]]
RegisterCommand("recompensa", function(source, args, rawCommand)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if (args[1] == nil) then 
			TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Têm que preencher o código!" }, color = 255,255,255 })
	else
    	MySQL.Async.fetchAll('SELECT * FROM `recompensa` WHERE `code` = @code', {
				['@code'] = args[1]
		}, function(data)
			if (json.encode(data) == "[]" or json.encode(data) == "null") then
				TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Código de recompensa não é válido ou já foi utilizado!" }, color = 255,255,255 })
			else
				if (args[1] == data[1].code) then
						if (data[1].type == "black_money") then -- Dinheiro Sujo
							MySQL.Async.execute("DELETE FROM recompensa WHERE code = @code;", {
								['@code'] = args[1],
							})
							xPlayer.addAccountMoney('black_money', tonumber(data[1].data1))
							exports.JD_logs:discord('**'..GetPlayerName(source)..'** utilizou o seguinte código: **'..args[1]..'** e e recebeu **'..tonumber(data[1].data1)..'€** de dinheiro sujo', source, 0, '#00FF00', '')
							TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Código resgatado com sucesso! Você recebeu  "..data[1].data1.."€ na sua conta bancária." }, color = 255,255,255 })
						elseif (data[1].type == "bank") then -- Banco
							MySQL.Async.execute("DELETE FROM recompensa WHERE code = @code;", {
								['@code'] = args[1],
							})
							xPlayer.addAccountMoney('bank', tonumber(data[1].data1))
							exports.JD_logs:discord('**'..GetPlayerName(source)..'** utilizou o seguinte código: **'..args[1]..'** e adicionou a sua conta bancária **'..tonumber(data[1].data1)..'€**', source, 0, '#00FF00', '')
							TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Código resgatado com sucesso! Você recebeu  "..data[1].data1.."€ na sua conta bancária." }, color = 255,255,255 })
						elseif (data[1].type == "cash") then --Dinheiro
							MySQL.Async.execute("DELETE FROM recompensa WHERE code = @code;", {
								['@code'] = args[1],
							})
							xPlayer.addMoney(data[1].data1)
							exports.JD_logs:discord('**'..GetPlayerName(source)..'** utilizou o seguinte código: **'..args[1]..'** e recebeu **'..tonumber(data[1].data1)..'€**', source, 0, '#00FF00', '')
							TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Código resgatado com sucesso! Você recebeu "..data[1].data1.."€ de dinheiro." }, color = 255,255,255 })
						elseif (data[1].type == "item") then -- Items
							MySQL.Async.execute("DELETE FROM recompensa WHERE code = @code;", {
								['@code'] = args[1],
							})
							xPlayer.addInventoryItem(data[1].data1, data[1].data2)
							exports.JD_logs:discord('**'..GetPlayerName(source)..'** utilizou o seguinte código: **'..args[1]..'** e recebeu: **'..data[1].data2..'x** de **'..data[1].data1..'**', source, 0, '#00FF00', '')
							TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Código resgatado com sucesso! Você recebeu: "..data[1].data2.."x de "..data[1].data1.."." }, color = 255,255,255 })
						elseif (data[1].type == "weapon") then -- Arma
							MySQL.Async.execute("DELETE FROM recompensa WHERE code = @code;", {
								['@code'] = args[1],
							})
							xPlayer.addWeapon(tostring(data[1].data1), data[1].data2)
							exports.JD_logs:discord('**'..GetPlayerName(source)..'** utilizou o seguinte código: **'..args[1]..'** e recebeu a arma: **'..data[1].data1..'** com **'..data[1].data2..'** balas.', source, 0, '#00FF00', '')
							TriggerClientEvent('chat:addMessage', source, { args = { '^7[^2Sucesso^7]^2', "Código resgatado com sucesso! Você recebeu a arma: "..data[1].data1.." com "..data[1].data2.." balas." }, color = 255,255,255 })
						end
				else
					TriggerClientEvent('chat:addMessage', source, { args = { '^7[^1Erro^7]^2', "Código de recompensa não é válido ou já foi utilizado!" }, color = 255,255,255 })
				end
			end
		end)
	end
end, false)


