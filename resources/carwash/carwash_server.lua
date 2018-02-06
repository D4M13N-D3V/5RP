--Settings--

enableprice = true -- true = carwash is paid, false = carwash is free

price = 100 -- you may edit this to your liking. if "enableprice = false" ignore this one

--DO-NOT-EDIT-BELLOW-THIS-LINE--

RegisterServerEvent('carwash:checkmoney')
AddEventHandler('carwash:checkmoney', function()
	local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
		if(enableprice == true) then
	    if (tonumber(user.getMoney()) >= tonumber(price)) then
			    user.removeMoney((price))
				TriggerClientEvent('carwash:success', source, price)
			else
				TriggerClientEvent("pNotify:SendNotification", source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
			end
		else
		  TriggerClientEvent('carwash:free', source)
		end
	end)
end)
