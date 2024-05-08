O código abaixo é uma otimização do código fornecido, reduzindo a repetição de código semelhante para diferentes eventos de combinação de cozinha. A lógica principal é mantida, mas os eventos são manipulados por uma função auxiliar `combinar` que recebe as informações de itens necessários e resultantes.

```lua
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Função auxiliar para combinar itens
local function combinar(itemRequerido1, itemRequerido2, itemResultado, quantidadeResultado, tempoEspera)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem1 = xPlayer.getInventoryItem(itemRequerido1)
    local xItem2 = xPlayer.getInventoryItem(itemRequerido2)

    if xItem1.count > 0 and xItem2.count > 0 then
        TriggerClientEvent('cooking:animation' , source)
        Citizen.Wait(tempoEspera)
        xPlayer.addInventoryItem(itemResultado, quantidadeResultado)
        xPlayer.removeInventoryItem(itemRequerido1, 1)
        xPlayer.removeInventoryItem(itemRequerido2, 1)
    elseif xItem1.count == 0 then
        TriggerClientEvent('esx:showNotification', source, 'Não tens ' .. xItem1.label .. ' suficiente.')
    elseif xItem2.count == 0 then
        TriggerClientEvent('esx:showNotification', source, 'Não tens ' .. xItem2.label .. ' suficiente.')
    end
end

-- Eventos de combinação para cada receita
RegisterServerEvent('cooking:combination1')
AddEventHandler('cooking:combination1', function()
    combinar('bread', 'water', 'pollo_asado', 1, 10000)
end)

RegisterServerEvent('cooking:combination2')
AddEventHandler('cooking:combination2', function()
    combinar('bread', 'water', 'sandwich_devian', 5, 10000)
end)

RegisterServerEvent('cooking:combination3')
AddEventHandler('cooking:combination3', function()
    combinar('bread', 'water', 'lubina', 1, 10000)
end)

RegisterServerEvent('cooking:combination4')
AddEventHandler('cooking:combination4', function()
    combinar('bread', 'water', 'sopa', 1, 10000)
end)

RegisterServerEvent('cooking:combination5')
AddEventHandler('cooking:combination5', function()
    combinar('bread', 'water', 'chocolate_cupcake', 1, 10000)
end)
```

Este código otimizado torna a manutenção dos eventos de cozinha mais fácil, visto que basta alterar os parâmetros da função `combinar` para cada evento. Além disso, reduz o tamanho do código e facilita a leitura.
