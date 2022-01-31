ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


AddEventHandler('onClientResourceStart', function (resourceName)
    if (GetCurrentResourceName() == resourceName) then
        TriggerEvent('chat:addSuggestion', '/codigorecompensa', 'Gerar vários códigos de recompensa', {
            { name="tipo", help="Qual código você deseja gerar. Tipos: cash, bank, black_money, item, weapon, car " },
            { name="montante/nome", help="Montante de dinheiro/Nome de item/arma/car" },
            { name="quantidade", help="Quantidade de items/balas." }
        })
        TriggerEvent('chat:addSuggestion', '/recompensa', 'Resgatar um código de recompensa', {
            { name="código", help="Digite o código que deseja resgatar." }
        })
		TriggerEvent('chat:addSuggestion', '/apagarrecompensa', 'Apagar um código gerado', {
            { name="código", help="Digite o código que deseja apagar." }
        })
    end
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        TriggerEvent('chat:removeSuggestion', '/codigorecompensa')
        TriggerEvent('chat:removeSuggestion', '/recompensa')
    end
end)

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end
function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		if Config.PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. ' ' .. GetRandomNumber(Config.PlateNumbers))
		else
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. GetRandomNumber(Config.PlateNumbers))
		end

		ESX.TriggerServerCallback('zcmg_recompensa:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end


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

