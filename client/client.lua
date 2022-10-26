ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.ESXTrigger, function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

AddEventHandler('onClientResourceStart', function (resourceName)
    if (GetCurrentResourceName() == resourceName) then

		TriggerEvent('chat:addSuggestion', '/menurecompensa', 'Menu de Recompensas', {
        })
    end
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        TriggerEvent('chat:removeSuggestion', '/codigorecompensa')
        TriggerEvent('chat:removeSuggestion', '/recompensa')
    end
end)


RegisterNetEvent('zcmg_recompensa:car')
AddEventHandler('zcmg_recompensa:car', function(car)
	local playerPed = PlayerPedId()
	local playerpos = GetEntityCoords(playerPed)
    local matricula = GeneratePlate()

    ESX.Game.SpawnVehicle(car, playerpos, 59.24, function(vehicle)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		vehicleProps.plate = matricula
		TriggerServerEvent('zcmg_recompensa:dono', vehicleProps)

		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleNumberPlateText(vehicle, matricula)
	end)
end)


RegisterCommand("menurecompensa", function(source, args, rawCommand)
    local elements = {}
    table.insert(elements, {label= "🔗 Utilizar Código", value = "utilizar"})
	table.insert(elements, {label= "⚙️ Gerar (<font color='red'>Admin</font>)", value = "gerar"})
	table.insert(elements, {label= "🗑️ Apagar (<font color='red'>Admin</font>)", value = "apagar"})
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
		title    = "🎁 Menu de Recompensa",
		align    = 'center',
		elements = elements
	}, function(data, menu)
        if data.current.value == "utilizar" then
            utilizar()
        elseif data.current.value == "gerar" then
            ESX.TriggerServerCallback('zcmg_recompensa:verificar_admin', function(admin)
                if admin then
                    gerar()
                else
                    exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Não tens autorização para fazer isto!", 5000, 'erro') 
                    ESX.UI.Menu.CloseAll()
                end 
            end)
		elseif data.current.value == "apagar" then
            ESX.TriggerServerCallback('zcmg_recompensa:verificar_admin', function(admin)
                if admin then
                    lista_apagar()
                else
                    exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Não tens autorização para fazer isto!", 5000, 'erro') 
                    ESX.UI.Menu.CloseAll()
                end 
            end)
		end
	    end, function(data, menu)
            menu.close()
        end)
end)


function gerar()
    local elements = {}
    table.insert(elements, {label= "💵 Dinheiro na Mão", value = "cash"})
	table.insert(elements, {label= "💳 Dinheiro conta bancária", value = "bank"})
    table.insert(elements, {label= "💰 Dinheiro sujo", value = "black_money"})
    table.insert(elements, {label= "📦 Item", value = "item"})
	table.insert(elements, {label= "🔫 Arma", value = "weapon"})
    table.insert(elements, {label= "🚗 Veículo", value = "car"})
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gerar', {
		title    = "🎁 Tipo de Recompensa",
		align    = 'center',
		elements = elements
	}, function(data, menu)
        --Dinheiro na Mão
		if data.current.value == "cash" then
            menu.close()
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bddata1', {
                title = 'Montante de dinheiro'
            }, function(data3, menu)
                local bddata1 = data3.value
                if bddata1 == nil then
                    exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Tem que preeencher o campo!", 5000, 'erro')
                else
                    if verificarnumero(bddata1) then
                        TriggerServerEvent('zcmg_recompensa:gerar', "cash", bddata1 ,"")
                        menu.close()
                    else
                        exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Montante não é valido", 5000, 'erro')
                    end 
                end
            end, function(data3, menu)
                menu.close()
            end)
        --Dinheiro conta bancária
        elseif data.current.value == "bank" then
            menu.close()
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bddata1', {
                title = 'Montante de dinheiro'
            }, function(data4, menu)
                local bddata4 = data4.value
                if bddata4 == nil then
                    exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Tem que preeencher o campo!", 5000, 'erro')
                else
                    if verificarnumero(bddata4) then
                        TriggerServerEvent('zcmg_recompensa:gerar', "bank", bddata4 ,"")
                        menu.close()
                    else
                        exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Montante não é valido", 5000, 'erro')
                    end
                    
                end
            end, function(data4, menu)
                menu.close()
            end)
        -- Dinheiro Sujo
        elseif data.current.value == "black_money" then
            menu.close()
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bddata1', {
                title = 'Montante de dinheiro sujo'
            }, function(data4, menu)
                local bddata1 = data4.value
                if bddata1 == nil then
                    exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Tem que preeencher o campo!", 5000, 'erro')
                else
                    if verificarnumero(bddata1) then
                        TriggerServerEvent('zcmg_recompensa:gerar', "black_money", bddata1 ,"")
                        menu.close()
                    else
                        exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Montante não é valido", 5000, 'erro')
                    end
                    
                end
            end, function(data4, menu)
                menu.close()
            end)
        --Item
        elseif data.current.value == "item" then
            local elements = {}

            table.insert(elements, {label= "Introduzir (<font color='green'>Código de Spawn</font>)", value = "name"})
            table.insert(elements, {label= "A", value = "a"})
            table.insert(elements, {label= "B", value = "b"})
            table.insert(elements, {label= "C", value = "c"})
            table.insert(elements, {label= "D", value = "d"})
            table.insert(elements, {label= "E", value = "e"})
            table.insert(elements, {label= "F", value = "f"})
            table.insert(elements, {label= "G", value = "g"})
            table.insert(elements, {label= "H", value = "h"})
            table.insert(elements, {label= "I", value = "i"})
            table.insert(elements, {label= "J", value = "j"})
            table.insert(elements, {label= "K", value = "k"})
            table.insert(elements, {label= "L", value = "l"})
            table.insert(elements, {label= "M", value = "m"})
            table.insert(elements, {label= "N", value = "n"})
            table.insert(elements, {label= "O", value = "o"})
            table.insert(elements, {label= "P", value = "p"})
            table.insert(elements, {label= "Q", value = "q"})
            table.insert(elements, {label= "R", value = "r"})
            table.insert(elements, {label= "S", value = "s"})
            table.insert(elements, {label= "T", value = "t"})
            table.insert(elements, {label= "U", value = "u"})
            table.insert(elements, {label= "V", value = "v"})
            table.insert(elements, {label= "W", value = "w"})
            table.insert(elements, {label= "X", value = "x"})
            table.insert(elements, {label= "Y", value = "y"})
            table.insert(elements, {label= "Z", value = "z"})
            
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armas', {
                title    = "📦 Items",
                align    = 'center',
                elements = elements
            }, function(data, menu)
                if data.current.value == "name" then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bddata1', {
                        title = 'Nome de Spawn'
                    }, function(data3, menu)
                        local bddata1 = data3.value
                        if bddata1 == nil then
                            exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Tem que preeencher o campo!", 5000, 'erro')
                        else
                            ESX.TriggerServerCallback('zcmg_recompensa:verificar_item', function(cb)
                                if cb then
                                    menu.close()
                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bddata2', {
                                        title = 'Quantidade'
                                    }, function(data2, menu2)
                                        local bddata2 = data2.value
                                        if bddata2 == nil then
                                            exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Tem que preeencher o campo!", 5000, 'erro')
                                        else
                                            if verificarnumero(bddata2) then
                                                TriggerServerEvent('zcmg_recompensa:gerar', "item", bddata1 ,bddata2)
                                                menu2.close()
                                            else
                                                exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Montante não é valido", 5000, 'erro')
                                            end
                                        end
                                    end, function(data3, menu2)
                                        menu2.close()
                                    end)
                                else
                                    exports['zcmg_notificacao']:Alerta("RECOMPENSA", "O item introduzido não é válido", 5000, 'erro')
                                end
                            end, bddata1)
                        end
                    end, function(data3, menu)
                        menu.close()
                    end)
                    menu.close()
                else
                    ESX.TriggerServerCallback('zcmg_recompensa:lista_items', function(cb)
                        local items = {}
                
                        for _,v in pairs(cb) do
                            table.insert(items, {label = v.label.." (<font color='green'>"..v.name.."</font>)" , value = v.name})
                        end
        
                        ESX.UI.Menu.CloseAll()
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'items', {
                            title    = "📦 Items",
                            align    = 'center',
                            elements = items
                        }, function(data, menu)
                            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bddata10', {
                                title = 'Numero de items'
                            }, function(data10, menu)
                                local bddata10 = data10.value
                                if bddata10 == nil then
                                    exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Tem que preeencher o campo!", 5000, 'erro')
                                else
                                    if verificarnumero(bddata10) then
                                        TriggerServerEvent('zcmg_recompensa:gerar', "item", data.current.value , bddata10)
                                        menu.close()
                                    else
                                        exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Montante não é valido", 5000, 'erro')
                                    end
                                    
                                end
                            end, function(data10, menu)
                                menu.close()
                            end)
                            menu.close()
                        end, function(data, menu)
                            menu.close()
                        end)
                    end, data.current.value)
                end
            end, function(data, menu)
                menu.close()
            end)
        --Veículo
        elseif data.current.value == "car" then
            ESX.UI.Menu.CloseAll()

            local elements2 = {}

            table.insert(elements2, {label= "Introduzir (<font color='green'>Código de Spawn</font>)", value = "nomespawn"})
            table.insert(elements2, {label= "--Listagem--", value = "listagem"})
                
            for k, v in pairs(Config.Cars) do
                    table.insert(elements2, {label= v.name , value = v.code})
            end
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'veiculos', {
                title    = "🚗 Veículos",
                align    = 'center',
                elements = elements2
            }, function(data, menu2)
                if data.current.value == 'nomespawn' then
                    menu2.close()
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bddata1', {
                            title = 'Nome de Spawn do carro'
                        }, function(data3, menu2)
                            local bddata1 = data3.value
                            if bddata1 == nil then
                                exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Tem que preeencher o campo!", 5000, 'erro')
                            else
                                TriggerServerEvent('zcmg_recompensa:gerar', "car", bddata1 ,"")
                                menu2.close()
                            end
                        end, function(data3, menu2)
                            menu2.close()
                        end)
                elseif data.current.value ~= 'listagem' then
                    TriggerServerEvent('zcmg_recompensa:gerar', "car", data.current.value ,"")
                    menu2.close()
                end
            end, function(data, menu)
                menu.close()
            end)
        --Armas
        elseif data.current.value == "weapon" then
            local elements = {}

            for k, v in pairs(Config.WeaponsCategory) do
                    table.insert(elements, {label= v.description, value = v.name})
            end
            
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armas', {
                title    = "🔫 Categoria Armas",
                align    = 'center',
                elements = elements
            }, function(data, menu)
                local elements2 = {}

                for k, v in pairs(Config.Weapons) do
                    if data.current.value == v.category then
                        table.insert(elements2, {label= ESX.GetWeaponLabel(v.code) or v.code , value = v.code})
                    end
                end
                ESX.UI.Menu.CloseAll()
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armas', {
                    title    = "🔫 Armas",
                    align    = 'center',
                    elements = elements2
                }, function(data, menu)
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bddata1', {
                        title = 'Número de balas'
                    }, function(data3, menu)
                        local bddata1 = data3.value
                        if bddata1 == nil then
                            exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Tem que preeencher o campo!", 5000, 'erro')
                        else
                            if verificarnumero(bddata1) then
                                TriggerServerEvent('zcmg_recompensa:gerar', "weapon", data.current.value ,bddata1)
                                menu.close()
                            else
                                exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Montante não é valido", 5000, 'erro')
                            end
                            
                        end
                    end, function(data3, menu)
                        menu.close()
                    end)
                    menu.close()
                end, function(data, menu)
                    menu.close()
                end)
            end, function(data, menu)
                menu.close()
            end)
        end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function utilizar()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'codigo', {
		title = 'Código'
	}, function(data, menu)
		local valor = data.value

		if valor ~= nil then
            TriggerServerEvent('zcmg_recompensa:resgatar', valor)
            menu.close()
		else
            exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Introduza um código!", 5000, 'erro')
		end

	end, function(data, menu)
		menu.close()
	end)
	
end

function lista_apagar()
    local cash = false
    local bank = false
    local black_money = false
    local item = false
    local weapon = false
    local car = false

    ESX.TriggerServerCallback('zcmg_recompensa:lista_apagar', function(codigo)

        if not next(codigo) then
            exports['zcmg_notificacao']:Alerta("RECOMPENSA", "Não existem codigos para poder apagar!", 5000, 'erro')
        else
            local elements = {}
            
            for _,v in pairs(codigo) do
                if v.type == "cash" then
                    cash=true
                end
                if v.type == "bank" then
                    bank=true
                end
                if v.type == "black_money" then
                    black_money=true
                end
                if v.type == "item" then
                    item=true
                end
                if v.type == "weapon" then
                    weapon=true
                end
                if v.type == "car" then
                    car=true
                end
            end

            if cash then
                table.insert(elements, {label= "💵 Dinheiro na Mão", value = "cash"})
            end
            if bank then
                table.insert(elements, {label= "💳 Dinheiro conta bancária", value = "bank"})
            end
            if black_money then
                table.insert(elements, {label= "💰 Dinheiro sujo", value = "black_money"})
            end
                    if item then
                table.insert(elements, {label= "📦 Item", value = "item"})
            end
            if weapon then
                table.insert(elements, {label= "🔫 Arma", value = "weapon"})
            end
            if car then
                table.insert(elements, {label= "🚗 Veículo", value = "car"})
            end

            ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'apagarcodigo',
            {
                title    = 'Apagar Codigo',
                align    = 'center',
                elements = elements,
            },
            function(data, menu)
                elements2 = {}
                --Dinheiro Mão
                if data.current.value == "cash" then
                    for _,v in pairs(codigo) do
                        if v.type == "cash" then
                            table.insert(elements2, {label = "<font color='green'>Montante: "..v.data1.."€</font> - "..v.code.." - Gerado por: <font color='red'>"..v.owner.."</font>", value = codigo[_].code})

                            ESX.UI.Menu.CloseAll()
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apagar', {
                                title    = "💵 Dinheiro na Mão",
                                align    = 'center',
                                elements = elements2
                            }, function(data2, menu2)
                                apagarcodigo(data2.current.value)
                                menu2.close()
                            end, function(data2, menu2)
                                menu2.close()
                            end)
                        end
                    end
                --Dinheiro conta bancária
                elseif data.current.value == "bank" then
                    for _,v in pairs(codigo) do
                        if v.type == "bank" then
                            table.insert(elements2, {label = "<font color='green'>Montante: "..v.data1.."€</font> - "..v.code.." - Gerado por: <font color='red'>"..v.owner.."</font>", value = codigo[_].code})

                            ESX.UI.Menu.CloseAll()
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apagar', {
                                title    = "💳 Dinheiro conta bancária",
                                align    = 'center',
                                elements = elements2
                            }, function(data2, menu2)
                                apagarcodigo(data2.current.value)
                                menu2.close()
                            end, function(data2, menu2)
                                menu2.close()
                            end)
                        end
                    end
                --Dinheiro sujo
                elseif data.current.value == "black_money" then
                    for _,v in pairs(codigo) do
                        if v.type == "black_money" then
                            table.insert(elements2, {label = "<font color='green'>Montante: "..v.data1.."€</font> - "..v.code.." - Gerado por: <font color='red'>"..v.owner.."</font>", value = codigo[_].code})

                            ESX.UI.Menu.CloseAll()
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apagar', {
                                title    = "💰 Dinheiro sujo",
                                align    = 'center',
                                elements = elements2
                            }, function(data2, menu2)
                                apagarcodigo(data2.current.value)
                                menu2.close()
                            end, function(data2, menu2)
                                menu2.close()
                            end)
                        end
                    end
                --Item
                elseif data.current.value == "item" then
                    for _,v in pairs(codigo) do
                        if v.type == "item" then
                            table.insert(elements2, {label = "<font color='green'>"..v.data1.." "..v.data2.."x</font> - "..v.code.." - Gerado por: <font color='red'>"..v.owner.."</font>", value = codigo[_].code})

                            ESX.UI.Menu.CloseAll()
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apagar', {
                                title    = "📦 Item",
                                align    = 'center',
                                elements = elements2
                            }, function(data2, menu2)
                                apagarcodigo(data2.current.value)
                                menu2.close()
                            end, function(data2, menu2)
                                menu2.close()
                            end)
                        end
                    end
                --Armas
                elseif data.current.value == "weapon" then
                    for _,v in pairs(codigo) do
                        if v.type == "weapon" then
                            table.insert(elements2, {label = "<font color='green'>"..ESX.GetWeaponLabel(v.data1).." "..v.data2.."x</font> - "..v.code.." - Gerado por: <font color='red'>"..v.owner.."</font>", value = codigo[_].code})

                            ESX.UI.Menu.CloseAll()
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apagar', {
                                title    = "🔫 Arma",
                                align    = 'center',
                                elements = elements2
                            }, function(data2, menu2)
                                apagarcodigo(data2.current.value)
                                menu2.close()
                            end, function(data2, menu2)
                                menu2.close()
                            end)
                        end
                    end
                --Veiculos
                elseif data.current.value == "car" then
                    for _,v in pairs(codigo) do
                        if v.type == "car" then
                            table.insert(elements2, {label = "<font color='green'>"..v.data1.."</font> - "..v.code.." - Gerado por: <font color='red'>"..v.owner.."</font>", value = codigo[_].code})

                            ESX.UI.Menu.CloseAll()
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apagar', {
                                title    = "📦 Item",
                                align    = 'center',
                                elements = elements2
                            }, function(data2, menu2)
                                apagarcodigo(data2.current.value)
                                menu2.close()
                            end, function(data2, menu2)
                                menu2.close()
                            end)
                        end
                    end
                end

            end,
            function(data, menu)
                menu.close()
            end)
        end
    end)
end

function apagarcodigo(codigo)
    local elements2 = {}
    table.insert(elements2, {label= "<font color='green'>Sim</font>", value = "sim"})
    table.insert(elements2, {label= "<font color='red'>Não</font>", value = "nao"})

    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirmarapagar', {
        title    = "Tem a certeza que quer apagar este código?",
        align    = 'center',
        elements = elements2
    }, function(data2, menu)
        if data2.current.value == "sim" then
            TriggerServerEvent('zcmg_recompensa:apagar', codigo)

        end
        if data2.current.value == "nao" then
            lista_apagar()
            menu.close()
        end
        menu.close()
    end, function(data2, menu)
        menu.close()
    end)
end
