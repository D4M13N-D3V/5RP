	RegisterServerEvent('bucheron:Car')
	AddEventHandler('bucheron:Car', function()
		TriggerClientEvent('bucheron:getCar',source)
	end)

	RegisterServerEvent('bucheron:serverRequest')
	AddEventHandler('bucheron:serverRequest', function (typeRequest)
		local sourcePlayer = tonumber(source)
		TriggerEvent ('f:getPlayer', source, function(user)
			local player = user.get('identifier')
			
				if typeRequest == "GetBois" then
					local data = user.getItemData(19)
					TriggerClientEvent('bucheron:drawGetBois', sourcePlayer, data.q)
				elseif typeRequest == "GetPlanche" then
					local data = user.getItemData(19)
					local data2 = user.getItemData(20)
					TriggerClientEvent('bucheron:drawGetPlanche',sourcePlayer, data.q, data2.q)
				elseif typeRequest == "SellPlanche" then
					local data = user.getItemData(20)
					TriggerClientEvent('bucheron:drawSellPlanche', sourcePlayer, data.q)
				else
					print('DEBUG : A query type error has been detected')
				end
			
		end)
	end)

RegisterServerEvent('bucheron:setService')
AddEventHandler('bucheron:setService', function (inService)
	TriggerEvent('f:getPlayer', source , function (Player)
		Player.setSessionVar('bucheronInService', inService)
	end)
end)