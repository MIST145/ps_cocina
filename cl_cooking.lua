local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData              = {}
local isBlip              = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	PlayerData.job = job
	Citizen.Wait(5000)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)
	if PlayerData.job ~= nil and PlayerData.job.name == 'unemployed' and not isBlip then
	isBlip = true
	--blip = AddBlipForCoord(-163.76,-1344.97,30.0) -- Blip on Map Position
	--SetBlipSprite  (blip, 103) -- Blip Model, Puede ser cambiado desde aqui: https://wiki.gtanet.work/index.php?title=Blips
	--SetBlipDisplay (blip, 4)
	--SetBlipScale   (blip, 1.2)
	--SetBlipCategory(blip, 3)
	--SetBlipColour  (blip, 4) -- Blip Color, Puede ser cambiado desde aqui: https://gtaforums.com/topic/864881-all-blip-color-ids-pictured/
	--SetBlipAsShortRange(blip, true)
	--BeginTextCommandSetBlipName("STRING")
	--AddTextComponentString("PS_COCINA") -- Nombre del BLIP
	--EndTextCommandSetBlipName(blip)
  end
  end
end)


local inKitchen = false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if PlayerData.job ~= nil and PlayerData.job.name == 'unemployed' then
		DrawMarker(42, 1984.1,3049.69,47.22, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 1.0, 0.25, 255,0,0, 100, false, true, 2, false, false, false, false) --Posición del marcador de cocina.
			
		local coords = GetEntityCoords(PlayerPedId())
		local distance = GetDistanceBetweenCoords(coords, 1984.1,3049.69,47.22, true)
		
		if distance < 1.0 then
			ESX.ShowHelpNotification('Presiona ~INPUT_PICKUP~ para cocinar.')	
			inKitchen = true
		elseif distance > 1.0 then
			inKitchen = false
		end
		
		if IsControlJustReleased(0, Keys['E']) and inKitchen then
			ESX.UI.Menu.CloseAll()
			openMenu()
		end
		end
	end
end)

RegisterNetEvent('cooking:animation')
AddEventHandler('cooking:animation', function()
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, true) -- animaton 
	Citizen.Wait(10000) -- Progreso de tiempo, en ms, 1 segundo = 1000 ms, el valor es 10000, entonces, sus 10 segundos
	ClearPedTasksImmediately(PlayerPedId()) -- Función para detener la animación.
end)


function openMenu()
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'cooking',
        {
            title    = 'Parilla',
            align    = 'top-right',
            elements = { 
                { label = 'Pollo Asado ', value = 'menu1' }, -- Cambie la etiqueta "Menú 1" a su elemento combinado
                { label = 'Sandwich Devian ', value = 'menu2' },
                { label = 'Fish and chips ', value = 'menu3' },
                { label = 'Sopa Devian ', value = 'menu4' },
                { label = 'Muerte por chocolate ', value = 'menu5' }
   
            }
        },
    function(data, menu)
        local value = data.current.value

        if value == 'menu1' then
            menu.close()
            TriggerServerEvent('cooking:combination1')
		elseif value == 'menu2' then
            menu.close()
            TriggerServerEvent('cooking:combination2')
		elseif value == 'menu3' then
            menu.close()
            TriggerServerEvent('cooking:combination3')
		elseif value == 'menu4' then
            menu.close()
            TriggerServerEvent('cooking:combination4')
		elseif value == 'menu5' then
            menu.close()
            TriggerServerEvent('cooking:combination5')
        end
    end,
    function(data, menu)
        menu.close()
    end)
end
