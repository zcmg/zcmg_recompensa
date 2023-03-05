
AddEventHandler('onClientResourceStart', function (resourceName)
    if (GetCurrentResourceName() == resourceName) then

		TriggerEvent('chat:addSuggestion', '/menurecompensa', 'Menu de Recompensas (Admin)', {})
        TriggerEvent('chat:addSuggestion', '/recompensa', 'Resgatar Recompensa', {})
    end
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        TriggerEvent('chat:removeSuggestion', '/menurecompensa')
        TriggerEvent('chat:removeSuggestion', '/recompensa')
    end
end)

RegisterNetEvent('zcmg_recompensa:car')
AddEventHandler('zcmg_recompensa:car', function(car, codigo)
	local playerPed = PlayerPedId()
	local playerpos = GetEntityCoords(playerPed)
    local matricula = GeneratePlate()

    ESX.Game.SpawnVehicle(car, playerpos, 59.24, function(vehicle)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		vehicleProps.plate = matricula
		TriggerServerEvent('zcmg_recompensa:dono', vehicleProps)

		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleNumberPlateText(vehicle, matricula)
        TriggerServerEvent('zcmg_recompensa:regastarcarro', car, matricula, codigo)
	end)
end)

RegisterNetEvent('zcmg_recompensa:copiarcodigo')
AddEventHandler('zcmg_recompensa:copiarcodigo', function(codigo)
    lib.setClipboard(codigo)
end)

RegisterCommand("recompensa", function(source, args, rawCommand)
    local input = lib.inputDialog('Recompensa', {
        {type = 'input', label = 'Código', default=args[1]}
    })

    if not input then return end

    if input[1] ~= nil then
        TriggerServerEvent('zcmg_recompensa:resgatar', input[1])
    else
        lib.notify({description = 'Código não é válido', type = 'error'})
    end
end)

RegisterCommand("menurecompensa", function(source, args, rawCommand)
    ESX.TriggerServerCallback('zcmg_recompensa:verificar_admin', function(admin)
        if admin then
            local options = {}
            table.insert(options,{label = "Gerar", args='gerar', icon = 'fa-star'})
            table.insert(options,{label = "Apagar", args='apagar', icon = 'fa-trash-can'})
            table.insert(options,{label = "Admins", args='admins', icon = 'fa-user'})

            lib.registerMenu({
                id = 'menu_recompensa',
                title = 'Menu de Recompensa',
                options = options
            }, function(selected, scrollIndex, args)
                if args == "gerar" then
                    gerar()
                elseif args == "apagar" then
                    lista_apagar()
                elseif args == "admins" then
                    lista_admins()
                end
            end)

            lib.showMenu('menu_recompensa')
        else
            lib.notify({description = 'Não tens autorização para fazer isto!', type = 'error'})
        end
    end)
end)

function gerar()
    local options = {}
    table.insert(options,{label = "Dinheiro na Mão", args='cash', icon = 'fa-wallet'})
    table.insert(options,{label = "Dinheiro Conta Bancária", args='bank', icon = 'fa-credit-card'})
    table.insert(options,{label = "Dinheiro sujo", args='black_money', icon = 'fa-sack-dollar'})
    table.insert(options,{label = "Item", args='item', icon = 'fa-box-open'})
    table.insert(options,{label = "Arma", args='weapon', icon = 'fa-gun'})
    table.insert(options,{label = "Veículo", args='car', icon = 'fa-car'})

    lib.registerMenu({
        id = 'menu_gerar',
        title = 'Tipo de Recompensa',
        options = options,
        onClose = function(key)
            lib.showMenu('menu_recompensa')
        end,
    }, function(selected, scrollIndex, args)
        gerar_tipo(args)
    end)

    lib.showMenu('menu_gerar')
end

function gerar_tipo(args)
    --Dinheiro na Mão
    if args == "cash" then
        input_number("cash", "", "Dinheiro na Mão", "Valor", false)
    --Dinheiro Conta Bancária
    elseif args == "bank" then
        input_number("bank", "", "Dinheiro Conta Bancária", "Valor", false)
    -- Dinheiro Sujo
    elseif args == "black_money" then
        input_number("black_money", "", "Dinheiro sujo", "Valor", false)
    --Item
    elseif args == "item" then
        local options = {}
        local abc = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}
        table.insert(options,{label = "Introduzir (Código de Spawn)", args='name', icon = 'fa-code'})

        for k, v in pairs(abc) do
            table.insert(options,{label = "Todos Iniciado por "..string.upper(v), args=v, icon = 'fa-'..v})
        end

        lib.registerMenu({
            id = 'menu_item',
            title = 'Item',
            options = options,
            onClose = function(key)
                lib.showMenu('menu_gerar')
            end,
        }, function(selected, scrollIndex, args)
            if args == 'name' then
                local input = lib.inputDialog('Item', {"Código de  Spawn"})

                if not input then return end
        
                if input[1] ~= nil then
                    ESX.TriggerServerCallback('zcmg_recompensa:verificar_item', function(cb)
                        if cb then
                            input_number("item", input[1], "Item", "Quantidade", true)
                        else
                            lib.notify({description = 'O item introduzido não é válido', type = 'error'})
                        end
                    end, input[1])
                    
                else
                    lib.notify({description = 'Montante não é válido', type = 'error'})
                end
            else
                ESX.TriggerServerCallback('zcmg_recompensa:lista_items', function(cb)
                    local items = {}
            
                    for _,v in pairs(cb) do
                        table.insert(items, {label = v.label.." ("..v.name..")" , args = v.name, icon = 'fa-'..args})
                    end

                    lib.registerMenu({
                        id = 'menu_item_abc',
                        title = 'Items ABC',
                        options = items,
                        onClose = function(key)
                            lib.showMenu('menu_item')
                        end,
                    }, function(selected, scrollIndex, args)
                        input_number("item", args, "Item", "Quantidade", true)
                    end)

                    lib.showMenu('menu_item_abc')
                end, args)
            end
        end)
        lib.showMenu('menu_item')
    --Armas
    elseif args == "weapon" then
        local options = {}

        for k, v in pairs(Config.WeaponsCategory) do
            table.insert(options,{label = v.description, args=v.name, icon = v.icon})
        end

        lib.registerMenu({
            id = 'menu_weapon_cat',
            title = 'Categorias Armas',
            options = options,
            onClose = function(key)
                lib.showMenu('menu_gerar')
            end,
        }, function(selected, scrollIndex, args)
            local weapons = {}
            for k, v in pairs(Config.Weapons) do
                if args == v.category then
                    table.insert(weapons, {label= ESX.GetWeaponLabel(v.code) or v.code , args = v.code})
                end
            end

            lib.registerMenu({
                id = 'menu_weapon',
                title = 'Tipo de Recompensa',
                options = weapons,
                onClose = function(key)
                    lib.showMenu('menu_weapon_cat')
                end,
            }, function(selected, scrollIndex, args)
                for k, v in pairs(Config.Weapons) do
                    if args == v.category then
                        table.insert(weapons, {label= ESX.GetWeaponLabel(v.code) or v.code , args = v.code})
                    end
                end
                input_number("weapon", args, "Número de Balas", "Quantidade", true)
            end)
            lib.showMenu('menu_weapon')
        end)

        lib.showMenu('menu_weapon_cat')
    --Veículo
    elseif args == "car" then
        local options = {}
        table.insert(options,{label = "Introduzir (Código de Spawn)", args='name', icon = 'fa-code'})

        for k, v in pairs(Config.Cars) do
            table.insert(options, {label= v.name , args = v.code, icon = v.icon})
        end
    
        lib.registerMenu({
            id = 'menu_car',
            title = 'Veículos',
            options = options,
            onClose = function(key)
                lib.showMenu('menu_gerar')
            end,
        }, function(selected, scrollIndex, args)
            if args == "name" then
                local input = lib.inputDialog('Nome do Veículo', {'Código de Spawn'})

                if not input then return end

                if input[1] ~= nil then
                    TriggerServerEvent('zcmg_recompensa:gerar', "car", input[1] ,"")
                else
                    lib.notify({description = 'Código não é válido', type = 'error'})
                end
            else
                TriggerServerEvent('zcmg_recompensa:gerar', "car", args ,"")
            end
        end)
        lib.showMenu('menu_car')
    end
end

function lista_apagar()
    ESX.TriggerServerCallback('zcmg_recompensa:lista_apagar', function(codigo)
        if not next(codigo) then
            lib.notify({description = 'Não existem codigos para poder apagar!', type = 'error'})
        else
            local tipo = {}
            local options = {}

            for _,v in pairs(codigo) do
                if v.type == "cash" and not tipo['cash'] then tipo['cash'] = true table.insert(options,{label = "Dinheiro na Mão", args='cash', icon = 'fa-wallet'}) end
                if v.type == "bank" and not tipo['bank'] then tipo['bank'] = true table.insert(options,{label = "Dinheiro Conta Bancária", args='bank', icon = 'fa-credit-card'}) end
                if v.type == "black_money" and not tipo['black_money'] then tipo['black_money'] = true table.insert(options,{label = "Dinheiro sujo", args='black_money', icon = 'fa-sack-dollar'}) end
                if v.type == "item" and not tipo['item'] then tipo['item'] = true table.insert(options,{label = "Item", args='item', icon = 'fa-box-open'}) end
                if v.type == "weapon" and not tipo['weapon'] then tipo['weapon'] = true table.insert(options,{label = "Arma", args='weapon', icon = 'fa-gun'}) end
                if v.type == "car" and not tipo['car'] then tipo['car'] = true table.insert(options,{label = "Veículo", args='car', icon = 'fa-car'}) end
            end

            lib.registerMenu({
                id = 'menu_apagar',
                title = 'Apagar',
                options = options,
                onClose = function(key)
                    lib.showMenu('menu_recompensa')
                end,
            }, function(selected, scrollIndex, args)
                apagar(args)
            end)
            lib.showMenu('menu_apagar')
        end
    end)
end

function apagar(tipo)
    ESX.TriggerServerCallback('zcmg_recompensa:lista_apagar', function(codigo)
        local options = {}

        for _,v in pairs(codigo) do
            if v.type == tipo then
                if tipo == 'cash' then
                    table.insert(options,{label = v.code, values = {'Por: '..v.owner, 'Valor: '..v.data1}, args=v.code, icon = 'fa-wallet'})
                elseif tipo == 'bank' then
                    table.insert(options,{label = v.code, values = {'Por: '..v.owner, 'Valor: '..v.data1}, args=v.code, icon = 'fa-credit-card'})
                elseif tipo == 'black_money' then
                    table.insert(options,{label = v.code, values = {'Por: '..v.owner, 'Valor: '..v.data1}, args=v.code, icon = 'fa-sack-dollar'})
                elseif tipo == 'item' then
                    local label = lib.callback.await('zcmg_recompensa:item_label', false, v.data1)
                    table.insert(options,{label = v.code, values = {'Por: '..v.owner, 'Item: '..label, 'Quantidade: '..v.data2}, args=v.code, icon = 'fa-box-open'})
                elseif tipo == 'weapon' then
                    table.insert(options,{label = v.code, values = {'Por: '..v.owner, 'Arma: '..ESX.GetWeaponLabel(v.data1) or v.data1}, args=v.code, icon = 'fa-gun'})
                elseif tipo == 'car' then
                    table.insert(options,{label = v.code, values = {'Por: '..v.owner, 'Veículo '..v.data1}, args=v.code, icon = 'fa-car'})
                end
            end
        end

        lib.registerMenu({
            id = 'sub_menu_apagar',
            title = 'Apagar',
            options = options,
            onClose = function(key)
                lib.showMenu('menu_apagar')
            end,
        }, function(selected, scrollIndex, args)
            apagarcodigo(args)
        end)
        lib.showMenu('sub_menu_apagar')
    end)
end

function apagarcodigo(codigo)
    local alert = lib.alertDialog({
        header = 'Recompensa',
        content = 'Tem a certeza que pretende eliminar este código:    \n '..codigo,
        centered = true,
        cancel = true
    })

    if alert == 'confirm' then TriggerServerEvent('zcmg_recompensa:apagar', codigo) end
end

function lista_admins()
    ESX.TriggerServerCallback('zcmg_recompensa:lista_admins', function(cb)
        local admins = {}

        for _,v in pairs(cb) do
            table.insert(admins, {label = v.name, values = {'Grupo: '..v.group_admin, 'Identifier: '..v.identifier}, icon = 'fa-user'})
            local info_admin = ''
        end

        lib.registerMenu({
            id = 'menu_admins',
            title = 'Admins',
            options = admins,
            onClose = function(key)
                lib.showMenu('menu_recompensa')
            end,
        })

        lib.showMenu('menu_admins')
    end)
end