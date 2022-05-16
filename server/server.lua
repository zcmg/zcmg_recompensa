ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local RandomCode = ""

function gerar(source, args, rawCommand)
		if (args[1] == nil) then
			TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Têm que preencher os parametros para poder gerar o código", 5000, 'erro')
		elseif (args[1] ~= nil and args[2] == nil) then
			if (args[1] == "bank" and args[2] == nil) then
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Argumentos inválidos.</br> Usar: /codigorecompensa bank 'montante'", 5000, 'erro')
			elseif (args[1] == "black_money" and args[2] == nil) then
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Argumentos inválidos.</br> Usar: /codigorecompensa black_money 'montante'", 5000, 'erro')
			elseif (args[1] == "cash" and args[2] == nil) then
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Argumentos inválidos.</br> Usar: /codigorecompensa cash 'montante'", 5000, 'erro')
			elseif (args[1] == "item" and args[2] == nil) then
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Argumentos inválidos.</br> Usar: /codigorecompensa item 'nome spawn item' 'quantidade items'", 5000, 'erro')
			elseif (args[1] == "weapon" and args[2] == nil) then
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Argumentos inválidos.</br> Usar: /codigorecompensa weapon 'nome spawn arma' 'numero_balas'", 5000, 'erro')
			elseif (args[1] == "car" and args[2] == nil) then
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Argumentos inválidos.</br> Usar: /codigorecompensa car 'nome spawn do carro'", 5000, 'erro')
			else
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Tipo desconhecido.</br> Tipos possíveis: item, cash, bank, black_money, weapon, car", 5000, 'erro')
			end	
		elseif (string.lower(args[1]) == "bank") then
			RandomCode = RandomCodeGenerator()
			MySQL.Async.execute("INSERT INTO zcmg_recompensa(code, type, data1) VALUES (@code,@type,@data1)", {
				['@code'] = RandomCode,
				['@type'] = "bank", 
				['@data1'] = args[2]
			})
			TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Códigos gerados com sucesso!</br>O código encontra-se no discord", 5000, 'sucesso')
			logs('**'..GetPlayerName(source)..' ('..source..')** gerou o seguinte código: **'..RandomCode..'**', Config.BotG, Config.BotG_Cor)	
			Wait(5)
			RandomCode = ""
		elseif (string.lower(args[1]) == "car") then
			local ver = false
			for k, v in pairs(Config.Cars) do
				if args[2]  == v.code then
					ver = true
					break
				else
					ver = false
				end
			end
			if Config.CarsVerification then
				if ver then
					RandomCode = RandomCodeGenerator()
					MySQL.Async.execute("INSERT INTO zcmg_recompensa (code, type, data1, data2) VALUES (@code,@type,@data1,@data2)", {
						['@code'] = RandomCode,
						['@type'] = "car", 
						['@data1'] = args[2],
						['@data2'] = args[3]
					})
					TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Códigos gerados com sucesso!</br>O código encontra-se no discord", 5000, 'sucesso')
					logs('**'..GetPlayerName(source)..' ('..source..')** gerou o seguinte código: **'..RandomCode..'**', Config.BotG, Config.BotG_Cor)
					Wait(5)
					RandomCode = ""
				else
					TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "O veiculo não se encontra na lista de veiculos autorizados", 5000, 'erro')
				end
			else
				RandomCode = RandomCodeGenerator()
				MySQL.Async.execute("INSERT INTO zcmg_recompensa (code, type, data1, data2) VALUES (@code,@type,@data1,@data2)", {
					['@code'] = RandomCode,
					['@type'] = "car", 
					['@data1'] = args[2],
					['@data2'] = args[3]
				})
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Códigos gerados com sucesso!</br>O código encontra-se no discord", 5000, 'sucesso')
				logs('**'..GetPlayerName(source)..' ('..source..')** gerou o seguinte código: **'..RandomCode..'**', Config.BotG, Config.BotG_Cor)
				Wait(5)
				RandomCode = ""
			end
		elseif (string.lower(args[1]) == "black_money") then
			RandomCode = RandomCodeGenerator()
			MySQL.Async.execute("INSERT INTO zcmg_recompensa(code, type, data1) VALUES (@code,@type,@data1)", {
				['@code'] = RandomCode,
				['@type'] = "black_money", 
				['@data1'] = args[2]
			})
			TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Códigos gerados com sucesso!</br>O código encontra-se no discord", 5000, 'sucesso')
			logs('**'..GetPlayerName(source)..' ('..source..')** gerou o seguinte código: **'..RandomCode..'**', Config.BotG, Config.BotG_Cor)
			Wait(5)
			RandomCode = ""
		elseif (string.lower(args[1]) == "cash") then
			RandomCode = RandomCodeGenerator()
			MySQL.Async.execute("INSERT INTO zcmg_recompensa (code, type, data1) VALUES (@code,@type,@data1)", {
				['@code'] = RandomCode,
				['@type'] = "cash", 
				['@data1'] = args[2]
			})
			TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Códigos gerados com sucesso!</br>O código encontra-se no discord", 5000, 'sucesso')
			logs('**'..GetPlayerName(source)..' ('..source..')** gerou o seguinte código: **'..RandomCode..'**', Config.BotG, Config.BotG_Cor)
			Wait(5)
			RandomCode = ""
		elseif (string.lower(args[1]) == "weapon") then
			if (args[2] == nil or args[3] == nil) then
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Argumentos inválidos", 5000, 'erro')
			else
				if (args[2] == "weapon_dagger" or args[2] == "weapon_bat" or args[2] == "weapon_bottle" or args[2] == "weapon_crowbar" or args[2] == "weapon_flashlight" or args[2] == "weapon_golfclub"
				    or args[2] == "weapon_hammer" or args[2] == "weapon_hatchet" or args[2] == "weapon_knuckle" or args[2] == "weapon_knife" or args[2] == "weapon_machete" or args[2] == "weapon_switchblade"
					or args[2] == "weapon_nightstick" or args[2] == "weapon_wrench" or args[2] == "weapon_battleaxe" or args[2] == "weapon_poolcue" or args[2] == "weapon_stone_hatchet"
					or args[2] == "weapon_pistol" or args[2] == "weapon_pistol_mk2" or args[2] == "weapon_combatpistol" or args[2] == "weapon_appistol" or args[2] == "weapon_stungun" or args[2] == "weapon_pistol50"
					or args[2] == "weapon_snspistol" or args[2] == "weapon_snspistol_mk2" or args[2] == "weapon_heavypistol" or args[2] == "weapon_vintagepistol" or args[2] == "weapon_flaregun" or args[2] == "weapon_marksmanpistol"
					or args[2] == "weapon_revolver" or args[2] == "weapon_revolver_mk2" or args[2] == "weapon_doubleaction" or args[2] == "weapon_raypistol" or args[2] == "weapon_ceramicpistol" or args[2] == "weapon_navyrevolver" or args[2] == "weapon_gadgetpistol"
					or args[2] == "weapon_microsmg" or args[2] == "weapon_smg" or args[2] == "weapon_smg_mk2" or args[2] == "weapon_assaultsmg" or args[2] == "weapon_combatpdw" or args[2] == "weapon_machinepistol"
					or args[2] == "weapon_minismg" or args[2] == "weapon_raycarbine" or args[2] == "weapon_pumpshotgun" or args[2] == "weapon_pumpshotgun_mk2" or args[2] == "weapon_sawnoffshotgun" or args[2] == "weapon_assaultshotgun"
					or args[2] == "weapon_bullpupshotgun" or args[2] == "weapon_musket" or args[2] == "weapon_heavyshotgun" or args[2] == "weapon_dbshotgun" or args[2] == "weapon_autoshotgun" or args[2] == "weapon_combatshotgun"
					or args[2] == "weapon_assaultrifle" or args[2] == "weapon_assaultrifle_mk2" or args[2] == "weapon_carbinerifle" or args[2] == "weapon_carbinerifle_mk2" or args[2] == "weapon_advancedrifle" or args[2] == "weapon_specialcarbine"
					or args[2] == "weapon_specialcarbine_mk2" or args[2] == "weapon_bullpuprifle" or args[2] == "weapon_bullpuprifle_mk2" or args[2] == "weapon_compactrifle" or args[2] == "weapon_militaryrifle" or args[2] == "weapon_mg"
					or args[2] == "weapon_combatmg" or args[2] == "weapon_combatmg_mk2" or args[2] == "weapon_gusenberg" or args[2] == "weapon_sniperrifle" or args[2] == "weapon_heavysniper" or args[2] == "weapon_heavysniper_mk2"
					or args[2] == "weapon_marksmanrifle" or args[2] == "weapon_marksmanrifle_mk2" or args[2] == "weapon_rpg" or args[2] == "weapon_grenadelauncher" or args[2] == "weapon_grenadelauncher_smoke" or args[2] == "weapon_minigun"
					or args[2] == "weapon_firework" or args[2] == "weapon_railgun" or args[2] == "weapon_hominglauncher" or args[2] == "weapon_compactlauncher" or args[2] == "weapon_rayminigun" or args[2] == "weapon_grenade"
					or args[2] == "weapon_bzgas" or args[2] == "weapon_molotov" or args[2] == "weapon_stickybomb" or args[2] == "weapon_proxmine" or args[2] == "weapon_snowball" or args[2] == "weapon_pipebomb"
					or args[2] == "weapon_ball" or args[2] == "weapon_smokegrenade" or args[2] == "weapon_flare" or args[2] == "weapon_petrolcan" or args[2] == "gadget_parachute" or args[2] == "weapon_fireextinguisher"
					or args[2] == "weapon_hazardcan") then
					RandomCode = RandomCodeGenerator()
					MySQL.Async.execute("INSERT INTO zcmg_recompensa (code, type, data1, data2) VALUES (@code,@type,@data1,@data2)", {
						['@code'] = RandomCode,
						['@type'] = "weapon", 
						['@data1'] = args[2],
						['@data2'] = args[3]
					})
					TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Códigos gerados com sucesso!</br>O código encontra-se no discord", 5000, 'sucesso')
					logs('**'..GetPlayerName(source)..' ('..source..')** gerou o seguinte código: **'..RandomCode..'**', Config.BotG, Config.BotG_Cor)
					Wait(5)
					RandomCode = ""
				else
					TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Tipo de arma não é válido", 5000, 'erro')
				end
			end
		elseif (string.lower(args[1]) == "item") then
			if (args[2] == nil or args[3] == nil) then
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Argumentos inválidos", 5000, 'erro')
			else
				RandomCode = RandomCodeGenerator()
				MySQL.Async.execute("INSERT INTO zcmg_recompensa (code, type, data1, data2) VALUES (@code,@type,@data1,@data2)", {
					['@code'] = RandomCode,
					['@type'] = "item", 
					['@data1'] = args[2],
					['@data2'] = args[3]
				})
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Códigos gerados com sucesso!</br>O código encontra-se no discord", 5000, 'sucesso')
				logs('**'..GetPlayerName(source)..' ('..source..')** gerou o seguinte código: **'..RandomCode..'**', Config.BotG, Config.BotG_Cor)
				Wait(5)
				RandomCode = ""
			end	
		end
end	


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
			MySQL.Async.fetchAll('SELECT * FROM `zcmg_recompensa` WHERE `code` = @code', {
				['@code'] = args[1]
			}, function(data)
				if (json.encode(data) == "[]" or json.encode(data) == "null") then
					TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Código de recompensa não é válido ou já foi utilizado!", 5000, 'erro')
				else
					MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
						['@code'] = args[1],
					})
					logs('**'..GetPlayerName(source)..' ('..source..')** apagou o seguinte código: **'..args[1]..'**', Config.BotA, Config.BotA_Cor)
					TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Código apagado com sucesso!", 5000, 'sucesso')							
				end
			end)	
		else
			TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Não tem premisões para fazer isto!", 5000, 'erro')
		end
end, true)


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
			TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Não tem premisões para fazer isto!", 5000, 'erro')
		end
end, true)

RegisterCommand("recompensa", function(source, args, rawCommand)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if (args[1] == nil) then 
		TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Têm que preencher o código!", 5000, 'erro')
	else
    	MySQL.Async.fetchAll('SELECT * FROM `zcmg_recompensa` WHERE `code` = @code', {
				['@code'] = args[1]
		}, function(data)
			if (json.encode(data) == "[]" or json.encode(data) == "null") then
				TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Código de recompensa não é válido ou já foi utilizado!", 5000, 'erro')
			else
				if (args[1] == data[1].code) then
						if (data[1].type == "black_money") then
							MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
								['@code'] = args[1],
							})
							xPlayer.addAccountMoney('black_money', tonumber(data[1].data1))
							logs('**'..GetPlayerName(source)..' ('..source..')** utilizou o seguinte código: **'..args[1]..'** e e recebeu **'..tonumber(data[1].data1)..'€** de dinheiro sujo', Config.BotU, Config.BotU_Cor)
							TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu  "..data[1].data1.."€ de dinheiro sujo.", 5000, 'sucesso')
		
						elseif (data[1].type == "bank") then
							MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
								['@code'] = args[1],
							})
							xPlayer.addAccountMoney('bank', tonumber(data[1].data1))
							logs('**'..GetPlayerName(source)..' ('..source..')** utilizou o seguinte código: **'..args[1]..'** e adicionou a sua conta bancária **', Config.BotU, Config.BotU_Cor)
							TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu  "..data[1].data1.."€ na sua conta bancária.", 5000, 'sucesso')
						elseif (data[1].type == "cash") then
							MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
								['@code'] = args[1],
							})
							xPlayer.addMoney(data[1].data1)
							logs('**'..GetPlayerName(source)..' ('..source..')** utilizou o seguinte código: **'..args[1]..'** e recebeu **'..tonumber(data[1].data1)..'€**', Config.BotU, Config.BotU_Cor)
							TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu  "..data[1].data1.."€ de dinheiro.", 5000, 'sucesso')
						elseif (data[1].type == "item") then
							MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
								['@code'] = args[1],
							})
							xPlayer.addInventoryItem(data[1].data1, data[1].data2)
							logs('**'..GetPlayerName(source)..' ('..source..')** utilizou o seguinte código: **'..args[1]..'** e recebeu: **'..data[1].data2..'x** de **'..data[1].data1..'**', Config.BotU, Config.BotU_Cor)
							TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu: "..data[1].data2.."x de "..data[1].data1, 5000, 'sucesso')
						elseif (data[1].type == "weapon") then
							MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
								['@code'] = args[1],
							})
							xPlayer.addWeapon(tostring(data[1].data1), data[1].data2)
							logs('**'..GetPlayerName(source)..' ('..source..')** utilizou o seguinte código: **'..args[1]..'** e recebeu a arma: **'..data[1].data1..'** com **'..data[1].data2..'** balas.', Config.BotU, Config.BotU_Cor)
							TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu a arma: "..data[1].data1.." com "..data[1].data2.." balas", 5000, 'sucesso')
						elseif (data[1].type == "car") then
							MySQL.Async.execute("DELETE FROM zcmg_recompensa WHERE code = @code;", {
								['@code'] = args[1],
							})

							TriggerClientEvent('zcmg_recompensa:car', source, data[1].data1)
							logs('**'..GetPlayerName(source)..' ('..source..')** utilizou o seguinte código: **'..args[1]..'** e recebeu o carro: **'..data[1].data1..'**' , Config.BotU, Config.BotU_Cor)
							TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Código resgatado com sucesso!</br>Você recebeu o carro : "..data[1].data1, 5000, 'sucesso')

						end
				else
					TriggerClientEvent('zcmg_notificacao:Alerta', source, "RECOMPENSA", "Código de recompensa não é válido ou já foi utilizado!", 5000, 'erro')
				end
			end
		end)
	end
end, false)


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
