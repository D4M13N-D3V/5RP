RegisterServerEvent('Farmer:Car')
AddEventHandler('Farmer:Car', function()
	TriggerClientEvent('Farmer:getCar',source)
end)

RegisterServerEvent('Farmer:serverRequest')
AddEventHandler('Farmer:serverRequest', function (typeRequest)
	local sourcePlayer = tonumber(source)
	TriggerEvent ('f:getPlayer', source, function(user)
		local player = user.get('identifier')
			
		if typeRequest == "GetBle" then
			local data = user.getItemData(10)
			TriggerClientEvent('Farmer:drawGetBle', sourcePlayer, data.q)
		elseif typeRequest == "GetFarine" then
			local data = user.getItemData(10)
			local data2 = user.getItemData(5)
			TriggerClientEvent('Farmer:drawGetFarine',sourcePlayer, data.q, data2.q)
		elseif typeRequest == "SellFarine" then
			local data = user.getItemData(5)
			TriggerClientEvent('Farmer:drawSellFarine', sourcePlayer, data.q)
		else
			print('DEBUG : Error')
		end
	end)
end)
	
RegisterServerEvent('Farmer:setService')
AddEventHandler('Farmer:setService', function (inService)
	TriggerEvent('f:getPlayer', source , function (Player)
		Player.setSessionVar('FarmerInService', inService)
	end)
end)