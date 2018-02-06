	RegisterServerEvent('Brewer:Car')
	AddEventHandler('Brewer:Car', function()
		TriggerClientEvent('Brewer:getCar',source)
	end)

	RegisterServerEvent('Brewer:serverRequest')
	AddEventHandler('Brewer:serverRequest', function (typeRequest)
		local sourcePlayer = tonumber(source)
		TriggerEvent ('f:getPlayer', source, function(user)
			local player = user.get('identifier')
				if typeRequest == "GetOrge" then
					local data = user.getItemData(Brewer_ressourceBase)
					TriggerClientEvent('Brewer:drawGetOrge', sourcePlayer, data.q)
				elseif typeRequest == "GetBiere" then
					local data = user.getItemData(Brewer_ressourceBase)
					local data2 = user.getItemData(Brewer_ressourceTraite)
					TriggerClientEvent('Brewer:drawGetBiere',sourcePlayer, data.q, data2.q)
				elseif typeRequest == "SellBiere" then
					local data = user.getItemData(Brewer_ressourceTraite)
					TriggerClientEvent('Brewer:drawSellBiere', sourcePlayer, data.q)
				else
					print('DEBUG : A query type error has been detected')
				end
			
		end)
	end)

RegisterServerEvent('Brewer:setService')
AddEventHandler('Brewer:setService', function (inService)
	TriggerEvent('f:getPlayer', source , function (Player)
		Player.setSessionVar('BrewerInService', inService)
	end)
end)