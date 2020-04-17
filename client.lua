ESX 			    			= nil
local miejscewyprania          = { x = 459.59, y = -992.97, z = 30.69 }
local wypraniezasieg = false --don't change it, otherwise police officer will be able to sell dirty money everywhere
local przycisk  = 38 -- E
local IsCop = false --don't touch it
local PlayerData	= {} --don't touch it



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then
		IsCop = true
	end
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1000)
        local coords = GetEntityCoords(PlayerPedId())
            if(GetDistanceBetweenCoords(coords, miejscewyprania.x, miejscewyprania.y, miejscewyprania.z, true) < 5.0) then
                wypraniezasieg = true
            else
                wypraniezasieg = false
            end
        end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	IsCop = (job.name == 'police') or false
end)

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
    	local coords      = GetEntityCoords(GetPlayerPed(-1))
			if wypraniezasieg == true and IsCop == true then 
                DrawText3D(460.53, -994.05, 30.91, '~g~[E] ~w~Wash your dirty money', 0.5)
                if IsControlJustReleased(1, przycisk) then
                  TriggerServerEvent('milomarPranie:washdirty')
                  Citizen.Wait(5000)
              end
            end
        end
end)

RegisterNetEvent('milomarPranie:animacja')
AddEventHandler('milomarPranie:animacja', function()
  local pid = PlayerPedId()
  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
  while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
    TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(550)
    StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
end)


