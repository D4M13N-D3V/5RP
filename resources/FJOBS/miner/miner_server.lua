	RegisterServerEvent('Miner:Car1')
	AddEventHandler('Miner:Car1', function()
		TriggerClientEvent('Miner:getCar1',source)
	end)

	RegisterServerEvent('Miner:Car2')
	AddEventHandler('Miner:Car2', function()
		TriggerClientEvent('Miner:getCar2',source)
	end)

	RegisterServerEvent('Miner:Car3')
	AddEventHandler('Miner:Car3', function()
		TriggerClientEvent('Miner:getCar3',source)
	end)

	RegisterServerEvent('Miner:serverRequest')
	AddEventHandler('Miner:serverRequest', function (typeRequest)
		local sourcePlayer = tonumber(source)
		TriggerEvent ('f:getPlayer', source, function(user)
			local player = user.get('identifier')
			
			if typeRequest == "GetMinerai" then
				local data = user.getItemData(1)
				TriggerClientEvent('Miner:drawGetMinerai', sourcePlayer, data.q)
			elseif typeRequest == "GetMetal" then
				local data = user.getItemData(1)
				local data2 = user.getItemData(2)
				TriggerClientEvent('Miner:drawGetMetal',sourcePlayer, data.q, data2.q)
			elseif typeRequest == "SellMetal" then
				local data = user.getItemData(2)
				TriggerClientEvent('Miner:drawSellMetal', sourcePlayer, data.q)
			else
				print('DEBUG : Une erreur de type de requête à été détecté')
			end
		end)
	end)
	
RegisterServerEvent('Miner:setService')
AddEventHandler('Miner:setService', function (inService)
	TriggerEvent('f:getPlayer', source , function (Player)
		Player.setSessionVar('MinerInService', inService)
	end)
end)
