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

