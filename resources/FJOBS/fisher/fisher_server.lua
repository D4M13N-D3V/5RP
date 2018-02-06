	RegisterServerEvent('Fisher:Car')
	AddEventHandler('Fisher:Car', function()
		TriggerClientEvent('Fisher:getCar',source)
	end)
	
		RegisterServerEvent('Fisher:Car2')
	AddEventHandler('Fisher:Car2', function()
		TriggerClientEvent('Fisher:getCar2',source)
	end)

	RegisterServerEvent('Fisher:serverRequest')
	AddEventHandler('Fisher:serverRequest', function (typeRequest)
		local sourcePlayer = tonumber(source)
		TriggerEvent ('f:getPlayer', source, function(user)
			local player = user.get('identifier')
			
			if typeRequest == "GetPoisson" then
				local data = user.getItemData(21)
				TriggerClientEvent('Fisher:drawGetPoisson', sourcePlayer, data.q)
			elseif typeRequest == "GetFilet" then
				local data = user.getItemData(21)
				local data2 = user.getItemData(22)
				TriggerClientEvent('Fisher:drawGetFilet',sourcePlayer, data.q, data2.q)
			elseif typeRequest == "SellFilet" then
				local data = user.getItemData(22)
				TriggerClientEvent('Fisher:drawSellFilet', sourcePlayer, data.q)
			else
				print('DEBUG : Une erreur de type de requête à été détecté')
			end
			
		end)
	end)
	
	
		
RegisterServerEvent('Fisher:setService')
AddEventHandler('Fisher:setService', function (inService)
	TriggerEvent('f:getPlayer', source , function (Player)
		Player.setSessionVar('FisherInService', inService)
	end)
end)