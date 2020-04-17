ESX 						   = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('milomarPranie:washdirty')
AddEventHandler('milomarPranie:washdirty', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local money = xPlayer.getAccount('black_money').money
	if xPlayer.job.name == 'police' then
		if money > 0 then 
			xPlayer.addMoney(tonumber(money))
			xPlayer.removeAccountMoney('black_money', money) -- usuwa brudny hajs
			TriggerClientEvent('esx:showNotification', source, "~g~You washed " ..money.. "$ dirty money")
		    TriggerClientEvent('milomarPranie:animacja', source)
		    TriggerEvent('esx_joblogs:AddInLog', 'pranie', 'pranie', xPlayer.name, money)
	    else
	    	TriggerClientEvent('esx:showNotification', source, "~r~You don't have any dirty money!")
	    end
    end
end)

