AddEventHandler('onClientResourceStart', function (resourceName)
    if (GetCurrentResourceName() == resourceName) then
        TriggerEvent('chat:addSuggestion', '/codigorecompensa', 'Gerar vários códigos de recompensa', {
            { name="tipo", help="Qual código você deseja gerar. Tipos: cash, bank, black_money, item, weapon " },
            { name="montante/nome", help="Montante de dinheiro/Nome de item/arma" },
            { name="quantidade", help="Quantidade de items/balas." }
        })
        TriggerEvent('chat:addSuggestion', '/recompensa', 'Resgatar um código de recompensa', {
            { name="código", help="Digite o código que deseja resgatar." }
        })
    end
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        TriggerEvent('chat:removeSuggestion', '/codigorecompensa')
        TriggerEvent('chat:removeSuggestion', '/recompensa')
    end
end)