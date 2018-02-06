	RegisterServerEvent('vigneron:Car')
	AddEventHandler('vigneron:Car', function()
		TriggerClientEvent('vigneron:getCar',source)
	end)

	RegisterServerEvent('vigneron:serverRequest')
	AddEventHandler('vigneron:serverRequest', function (typeRequest)
		local sourcePlayer = tonumber(source)
		TriggerEvent ('f:getPlayer', source, function(user)
			if typeRequest == "GetRaisin" then
				local data = user.getItemData(vigneron_ressourceBase)
				TriggerClientEvent('vigneron:drawGetRaisin', sourcePlayer, data.q)
			elseif typeRequest == "GetVin" then
				local data = user.getItemData(vigneron_ressourceBase)
				local data2 = user.getItemData(vigneron_ressourceTraite)
				TriggerClientEvent('vigneron:drawGetVin',sourcePlayer, data.q, data2.q)			
			elseif typeRequest == "SellVin" then
				local data = user.getItemData(vigneron_ressourceTraite)
				TriggerClientEvent('vigneron:drawSellVin', sourcePlayer, data.q)
			else
				print('DEBUG : Une erreur de type de requête à été détecté')
			end			
		end)
	end)

	
RegisterServerEvent('vigneron:setService')
AddEventHandler('vigneron:setService', function (inService)
	TriggerEvent('f:getPlayer', source , function (Player)
		Player.setSessionVar('vigneronInService', inService)
	end)
end)