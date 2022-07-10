ESX = nil 

TriggerEvent(Config.ESXTrigger, function(obj) ESX = obj end)

local RandomCode = ""


RegisterServerEvent('zcmg_recompensa:gerar')
AddEventHandler('zcmg_recompensa:gerar', function(tipo, valor1, valor2)
	
	RandomCode = RandomCodeGenerator()
	MySQL.Async.execute("INSERT INTO zcmg_recompensa (code, type, data1, data2) VALUES (@code, @type, @data1, @data2)", {
		['@code'] = RandomCode,
		['@type'] = tipo, 
		['@data1'] = valor1,
		['@data2'] = valor2
	})
	TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Códigos gerados com sucesso!</br>O código encontra-se no discord", 5000, 'sucesso')
	logs('**'..GetPlayerName(source)..' ('..source..')** gerou o seguinte código: **'..RandomCode..'**', Config.BotG, Config.BotG_Cor)
	Wait(5)
	RandomCode = ""

end)

RegisterServerEvent('zcmg_recompensa:resgatar')
AddEventHandler('zcmg_recompensa:resgatar', function(codigo)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	MySQL.Async.fetchAll('SELECT * FROM `zcmg_recompensa` WHERE `code` = @code', {
			['@code'] = codigo
	}, function(data)
		if (json.encode(data) == "[]" or json.encode(data) == "null") then
			TriggerClientEvent('zcmg_notificacao:Alerta', _source, "RECOMPENSA", "Código de recompensa não é válido ou já foi utilizado!", 5000, 'erro')
		else
			for i=1, #xPlayers, 1 do
				local xPlayerAdmin = ESX.GetPlayerFromId(xPlayers[i])
				
				for k, v in pairs(Config.Steams) do
					if xPlayer.identifier == v.id then
						TriggerClientEvent('zcmg_notificacao:Alerta', xPlayers[i], "RECOMPENSA", "O Player <b>"..xPlayer.getName().."</b> usou o codigo </br><b>"..codigo.."</b>", 7000, 'sucesso')
					end
				end
			end
			if (codigo == data[1].code) then
				if (data[1].type == "black_money") then
					MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
						['@code'] = codigo,
					})
					xPlayer.addAccountMoney('black_money', tonumber(data[1].data1))
					logs('**'..GetPlayerName(_source)..' ('.._source..')** utilizou o seguinte código: **'..codigo..'** e e recebeu **'..tonumber(data[1].data1)..'€** de dinheiro sujo', Config.BotU, Config.BotU_Cor)
					TriggerClientEvent('zcmg_notificacao:Alerta', _source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu  <b>"..data[1].data1.."€</b> de dinheiro sujo.", 5000, 'sucesso')
				elseif (data[1].type == "bank") then
					MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
						['@code'] = codigo,
					})
					xPlayer.addAccountMoney('bank', tonumber(data[1].data1))
					logs('**'..GetPlayerName(source)..' ('..source..')** utilizou o seguinte código: **'..args[1]..'** e adicionou a sua conta bancária **'..tonumber(data[1].data1)..'€**.', Config.BotU, Config.BotU_Cor)
					TriggerClientEvent('zcmg_notificacao:Alerta', _source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu <b>"..data[1].data1.."€</b> na sua conta bancária.", 5000, 'sucesso')
				elseif (data[1].type == "cash") then
					MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
						['@code'] = codigo,
					})
					xPlayer.addMoney(data[1].data1)
					logs('**'..GetPlayerName(_source)..' ('.._source..')** utilizou o seguinte código: **'..codigo..'** e recebeu **'..tonumber(data[1].data1)..'€**', Config.BotU, Config.BotU_Cor)
					TriggerClientEvent('zcmg_notificacao:Alerta', _source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu <b>"..data[1].data1.."€</b> de dinheiro.", 5000, 'sucesso')
				elseif (data[1].type == "item") then
					MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
						['@code'] = codigo,
					})
					xPlayer.addInventoryItem(data[1].data1, data[1].data2)
					logs('**'..GetPlayerName(_source)..' ('.._source..')** utilizou o seguinte código: **'..codigo..'** e recebeu: **'..data[1].data2..'x** de **'..data[1].data1..'**', Config.BotU, Config.BotU_Cor)
					TriggerClientEvent('zcmg_notificacao:Alerta', _source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu <b>"..data[1].data2.."x de "..data[1].data1.."</b>", 5000, 'sucesso')
				elseif (data[1].type == "weapon") then
					MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
						['@code'] = codigo,
					})
					xPlayer.addWeapon(tostring(data[1].data1), data[1].data2)
					logs('**'..GetPlayerName(_source)..' ('.._source..')** utilizou o seguinte código: **'..codigo..'** e recebeu a arma: **'..data[1].data1..'** com **'..data[1].data2..'** balas.', Config.BotU, Config.BotU_Cor)
					TriggerClientEvent('zcmg_notificacao:Alerta', _source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu a arma <b>"..data[1].data1.." com "..data[1].data2.." balas</b>", 5000, 'sucesso')
				elseif (data[1].type == "car") then
					MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
						['@code'] = codigo,
					})
					TriggerClientEvent('zcmg_recompensa:car', _source, data[1].data1)
					logs('**'..GetPlayerName(_source)..' ('.._source..')** utilizou o seguinte código: **'..codigo..'** e recebeu o carro: **'..data[1].data1..'**' , Config.BotU, Config.BotU_Cor)
					TriggerClientEvent('zcmg_notificacao:Alerta', _source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu o carro <b>"..data[1].data1.."</b>", 5000, 'sucesso')
				end
			else
				TriggerClientEvent('zcmg_notificacao:Alerta', _source, "RECOMPENSA", "Código de recompensa não é válido ou já foi utilizado!", 5000, 'erro')
			end
		end
	end)
end)

RegisterServerEvent('zcmg_recompensa:dono')
AddEventHandler('zcmg_recompensa:dono', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	})
end)

ESX.RegisterServerCallback('zcmg_recompensa:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('zcmg_recompensa:lista_items', function (source, cb, letra)
	local result = MySQL.Sync.fetchAll("SELECT name, label FROM items WHERE label LIKE '"..letra.."%'", {})
		
	cb(result)
end)

ESX.RegisterServerCallback('zcmg_recompensa:lista_apagar',function(source, cb)	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll("SELECT * FROM `zcmg_recompensa`",{}, function(data) 
		cb(data)
	end)
end)

ESX.RegisterServerCallback('zcmg_recompensa:verificar_item', function(source, cb, item)
	print('aqui')
	local result = MySQL.Sync.fetchAll("SELECT name FROM items WHERE name = @item ", {['@item'] = item})

	if result[1] then
		cb(true)
	else
		cb(false)
	end		
end)


ESX.RegisterServerCallback('zcmg_recompensa:verificar_admin',function(source, cb)	
	local xPlayer = ESX.GetPlayerFromId(source)
	local admin = false
	
	for k, v in pairs(Config.Steams) do
		if xPlayer.identifier == v.id then
			admin = true
			break
		else
			admin = false
		end
	end

	cb(admin)
end)

RegisterServerEvent('zcmg_recompensa:apagar')
AddEventHandler('zcmg_recompensa:apagar', function(codigo)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local ver = false
	
	MySQL.Async.fetchAll('SELECT * FROM `zcmg_recompensa` WHERE `code` = @code', {
		['@code'] = codigo
	}, function(data)
		if (json.encode(data) == "[]" or json.encode(data) == "null") then
			TriggerClientEvent('zcmg_notificacao:Alerta', _source, "RECOMPENSA", "Código de recompensa não é válido!", 5000, 'erro')
		else
			MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
				['@code'] = codigo,
			})
			logs('**'..GetPlayerName(_source)..' ('.._source..')** apagou o seguinte código: **'..codigo..'**', Config.BotA, Config.BotA_Cor)
			TriggerClientEvent('zcmg_notificacao:Alerta', _source, "RECOMPENSA", "Código apagado com sucesso!", 5000, 'sucesso')							
		end
	end)	
end)