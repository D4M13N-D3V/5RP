RegisterServerEvent('hunting:serverRequest')
AddEventHandler('hunting:serverRequest', function (typeRequest)
	TriggerEvent ('f:getPlayer', source, function(user)
		if typeRequest == "SellViande" then
			local data = user.getItemData(23)
			TriggerClientEvent('hunting:drawSellViande',source,data.q)
		end
	end)
end)