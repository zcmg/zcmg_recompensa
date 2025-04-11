local RandomCode = ""

RegisterServerEvent('zcmg_recompensa:gerar')
AddEventHandler('zcmg_recompensa:gerar', function(tipo, valor1, valor2)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local admin = admin(_source)
	local nome = GetPlayerName(_source)
	RandomCode = RandomCodeGenerator()

	if admin then
		MySQL.insert("INSERT INTO zcmg_recompensa (code, type, data1, data2, owner) VALUES (?, ?, ?, ?, ?)", {RandomCode, tipo, valor1, valor2, nome})
		TriggerClientEvent('ox_lib:notify', _source, { type = 'success', description = 'Códigos gerados com sucesso!'})
		Wait(1000)
		TriggerClientEvent('ox_lib:notify', _source, {description = 'Código copiado para area de transferência.'})
		TriggerClientEvent('zcmg_recompensa:copiarcodigo', _source, RandomCode)
		logs('**'..nome..' ('.._source..')** gerou o seguinte código: **'..RandomCode..'**', Config.Logs.Gerar.Webhook, Config.Logs.Gerar.Cor)
		Wait(5)
		RandomCode = ""
	else
		logs('**'..nome..' ('.._source..')** tentou usar cheats para gerar código', Config.Logs.Cheater.Webhook, Config.Logs.Cheater.Cor)
		DropPlayer(_source, 'Boa tentativa 😈')
	end
end)

RegisterServerEvent('zcmg_recompensa:dono')
AddEventHandler('zcmg_recompensa:dono', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.insert("INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)", {xPlayer.identifier, vehicleProps.plate, json.encode(vehicleProps)})

end)

RegisterServerEvent('zcmg_recompensa:resgatar')
AddEventHandler('zcmg_recompensa:resgatar', function(codigo)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local autorizado = true

	MySQL.query('SELECT * FROM zcmg_recompensa WHERE code = ?', {codigo},
	function(data)
		if (json.encode(data) == "[]" or json.encode(data) == "null") then
			TriggerClientEvent('ox_lib:notify', _source, { type = 'error', description = 'Código de recompensa não é válido ou já foi utilizado!'})
		else
			if (codigo == data[1].code) then
				if (data[1].type == "black_money") then
					xPlayer.addAccountMoney('black_money', tonumber(data[1].data1))
					logs('**'..GetPlayerName(_source)..' ('.._source..')** utilizou o seguinte código: **'..codigo..'** e e recebeu **'..tonumber(data[1].data1)..'€** de dinheiro sujo', Config.Logs.Utilizar.Webhook, Config.Logs.Utilizar.Cor)
					TriggerClientEvent('ox_lib:notify', _source, { type = 'success', description = 'Código resgatado com sucesso!'})
					Wait(1000)
					TriggerClientEvent('ox_lib:notify', _source, { description = 'Você recebeu  '..data[1].data1..'€ de dinheiro sujo.'})
				elseif (data[1].type == "bank") then
					xPlayer.addAccountMoney('bank', tonumber(data[1].data1))
					logs('**'..GetPlayerName(_source)..' ('.._source..')** utilizou o seguinte código: **'..codigo..'** e adicionou a sua conta bancária **'..tonumber(data[1].data1)..'€**.', Config.Logs.Utilizar.Webhook, Config.Logs.Utilizar.Cor)
					TriggerClientEvent('ox_lib:notify', _source, { type = 'success', description = 'Código resgatado com sucesso!'})
					Wait(1000)
					TriggerClientEvent('ox_lib:notify', _source, { description = 'Você recebeu '..data[1].data1..'€ na sua conta bancária.'})
				elseif (data[1].type == "cash") then
					xPlayer.addMoney(data[1].data1)
					logs('**'..GetPlayerName(_source)..' ('.._source..')** utilizou o seguinte código: **'..codigo..'** e recebeu **'..tonumber(data[1].data1)..'€**', Config.Logs.Utilizar.Webhook, Config.Logs.Utilizar.Cor)
					TriggerClientEvent('ox_lib:notify', _source, { type = 'success', description = 'Código resgatado com sucesso!'})
					Wait(1000)
					TriggerClientEvent('ox_lib:notify', _source, { description = 'Você recebeu '..data[1].data1..'€ de dinheiro.'})
				elseif (data[1].type == "item") then
					xPlayer.addInventoryItem(data[1].data1, data[1].data2)
					logs('**'..GetPlayerName(_source)..' ('.._source..')** utilizou o seguinte código: **'..codigo..'** e recebeu: **'..data[1].data2..'x** de **'..data[1].data1..'**', Config.Logs.Utilizar.Webhook, Config.Logs.Utilizar.Cor)
					TriggerClientEvent('ox_lib:notify', _source, { type = 'success', description = 'Código resgatado com sucesso!'})
					Wait(1000)
					TriggerClientEvent('ox_lib:notify', _source, { description = 'Você recebeu '..data[1].data2..'x de '..ESX.GetItemLabel(data[1].data1)})
				elseif (data[1].type == "weapon") then
					if xPlayer.hasWeapon(tostring(data[1].data1)) then
						autorizado = false
						TriggerClientEvent('ox_lib:notify', _source, { type = 'error', description = 'Já tem no seu inventário a arma '..ESX.GetWeaponLabel(data[1].data1)})
					else
						xPlayer.addWeapon(tostring(data[1].data1), data[1].data2)
						logs('**'..GetPlayerName(_source)..' ('.._source..')** utilizou o seguinte código: **'..codigo..'** e recebeu a arma: **'..ESX.GetWeaponLabel(data[1].data1)..'** com **'..data[1].data2..'** balas.', Config.Logs.Utilizar.Webhook, Config.Logs.Utilizar.Cor)
						TriggerClientEvent('ox_lib:notify', _source, { type = 'success', description = 'Código resgatado com sucesso!'})
						Wait(1000)
						TriggerClientEvent('ox_lib:notify', _source, { description = 'Você recebeu a arma '..ESX.GetWeaponLabel(data[1].data1)..' com '..data[1].data2..' balas'})
					end
				elseif (data[1].type == "car") then
					TriggerClientEvent('zcmg_recompensa:car', _source, data[1].data1, codigo)
				end
				
				if autorizado then
					MySQL.update("DELETE FROM zcmg_recompensa WHERE code = ?", {codigo})

					for i=1, #xPlayers, 1 do
						if admin(xPlayers[i]) then
							TriggerClientEvent('zcmg_notificacao:Alerta', xPlayers[i], "RECOMPENSA (ADMIN)", "O Player <b>"..xPlayer.getName().."</b> usou o codigo </br><b>"..codigo.."</b>", 7000, 'sucesso')
						end
					end
				end
			else
				TriggerClientEvent('ox_lib:notify', _source, { type = 'error', description = 'Código de recompensa não é válido ou já foi utilizado!'})
			end
		end
	end)
end)

RegisterServerEvent('zcmg_recompensa:regastarcarro')
AddEventHandler('zcmg_recompensa:regastarcarro', function(car, matricula, codigo)
	local _source = source

	logs('**'..GetPlayerName(_source)..' ('.._source..')** utilizou o seguinte código: **'..codigo..'** e recebeu o carro **'..car..'** com a matricula **'.. matricula..'**', Config.Logs.Utilizar.Webhook, Config.Logs.Utilizar.Cor)
	TriggerClientEvent('ox_lib:notify', _source, { type = 'success', description = 'Código resgatado com sucesso!'})
	Wait(1000)
	TriggerClientEvent('ox_lib:notify', _source, { description = 'Você recebeu o carro '..car})
end)

ESX.RegisterServerCallback('zcmg_recompensa:verficar_matricula', function (source, cb, plate)
	MySQL.query('SELECT * FROM owned_vehicles WHERE plate = ?', {plate}, 
	function (result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('zcmg_recompensa:lista_items', function (source, cb, letra)
	local result = MySQL.query.await("SELECT name, label FROM items WHERE label LIKE ?", {letra..'%'})
		
	cb(result)
end)

ESX.RegisterServerCallback('zcmg_recompensa:lista_admins', function (source, cb)
	local result = MySQL.query.await("SELECT * FROM zcmg_recompensa_admins")
	cb(result)
end)

ESX.RegisterServerCallback('zcmg_recompensa:lista_apagar',function(source, cb)	
	MySQL.query("SELECT * FROM zcmg_recompensa",{}, function(data) 
		cb(data)
	end)
end)

ESX.RegisterServerCallback('zcmg_recompensa:verificar_item', function(source, cb, item)
	local result = MySQL.query.await("SELECT name FROM items WHERE name = ? ", {item})

	if result[1] then
		cb(true)
	else
		cb(false)
	end		
end)

ESX.RegisterServerCallback('zcmg_recompensa:verificar_admin',function(source, cb)
	cb(admin(source))
end)

RegisterServerEvent('zcmg_recompensa:apagar')
AddEventHandler('zcmg_recompensa:apagar', function(codigo)
	local _source = source
	local nome = GetPlayerName(_source)
		
	if admin(_source) then
		MySQL.query('SELECT * FROM zcmg_recompensa WHERE code = ?', {codigo},
		function(data)
			if (json.encode(data) == "[]" or json.encode(data) == "null") then
				TriggerClientEvent('ox_lib:notify', _source, { type = 'error', description = 'Código de recompensa não é válido!'})
			else
				MySQL.update('DELETE FROM zcmg_recompensa WHERE code = ?', {codigo})
				logs('**'..GetPlayerName(_source)..' ('.._source..')** apagou o seguinte código: **'..codigo..'**', Config.Logs.Apagar.Webhook, Config.Logs.Apagar.Cor)	
				TriggerClientEvent('ox_lib:notify', _source, { type = 'success', description = 'Código apagado com sucesso!'})						
			end
		end)	
	else
		logs('**'..nome..' ('.._source..')** tentou usar cheats para apagar um código',Config.Logs.Cheater.Webhook, Config.Logs.Cheater.Cor)
		DropPlayer(_source, 'Boa tentativa 😈')
	end
end)

RegisterServerEvent('zcmg_recompensa:apagar_admin')
AddEventHandler('zcmg_recompensa:apagar_admin', function(info)
	local _source = source
	local nome = GetPlayerName(_source)

	if admin(_source) then
		MySQL.update('DELETE FROM zcmg_recompensa_admins WHERE identifier = ?', {info.identifier})
		logs('**'..GetPlayerName(_source)..' ('.._source..')** apagou o admin: **'..info.name..'** da lista de admins!', Config.Logs.ApagarAdmin.Webhook, Config.Logs.ApagarAdmin.Cor)	
		TriggerClientEvent('ox_lib:notify', _source, { type = 'success', description = 'Admin removido da lista de admins!'})	
	else
		logs('**'..nome..' ('.._source..')** tentou usar cheats para apagar um código', Config.Logs.Cheater.Webhook, Config.Logs.Cheater.Cor)
		DropPlayer(_source, 'Boa tentativa 😈')
	end
end)

ESX.RegisterCommand('adminrecompensa', 'admin', function(xPlayer, args, showError)
	criar_admin(args.playerId.source)
end, true, {help = 'Definir admins com acesso ao menu recompensa', validate = true, arguments = {
	{name = 'playerId', help = 'ID Player', type = 'player'},
}})