RegisterServerEvent("informer:getweed")
AddEventHandler("informer:getweed", function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local price = 5000
		if (tonumber(user.getMoney()) >= tonumber(price)) then
		user.removeMoney(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "I heard it's hidden in the mountains near a freeway, then you have to take it somewhere, I know seems FISHY" )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:convertweed")
AddEventHandler("informer:convertweed", function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local price = 10000
		if (tonumber(user.getMoney()) >= tonumber(price)) then
			user.removeMoney(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Cannabis is normally converted at one of the jettys at the top of the lake by Sandy, the blue house." )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:sellweed")
AddEventHandler("informer:sellweed", function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local price = 5000
		if (tonumber(user.getMoney()) >= tonumber(price)) then
		user.removeMoney(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Try asking your peers on the pier?" )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:sellweedbulk")
AddEventHandler("informer:sellweedbulk", function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local price = 10000
		if (tonumber(user.getMoney()) >= tonumber(price)) then
		user.removeMoney(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Near the Smoke in the Water, there's an all green building, the buyer lives in one of the apartments" )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:getmeth")
AddEventHandler("informer:getmeth", function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local price = 15000
		if (tonumber(user.getMoney()) >= tonumber(price)) then
		user.removeMoney(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Vehicle: Jesse and Heisenberg use one of these, you may need one and get to Grapeseed!." )
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "A Meth lab would probably be a great place to start looking for chemicals to produce Meth")
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:producemeth")
AddEventHandler("informer:producemeth", function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local price = 15000
		if (tonumber(user.getMoney()) >= tonumber(price)) then
		user.removeMoney(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Erm..Meth heads cook at a dock, off the Great Ocean Highway." )
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "When looking at the map, just North, west of the Chiliad Mountains")
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:sellmeth")
AddEventHandler("informer:sellmeth", function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local price = 15000
		if (tonumber(user.getMoney()) >= tonumber(price)) then
		user.removeMoney(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Pretty sure a good place is El Burro Heights? there is a abandon warehouse, you can't miss it!" )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:getguns")
AddEventHandler("informer:getguns", function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local price = 50000
		if (tonumber(user.getMoney()) >= tonumber(price)) then
		user.removeMoney(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Theres alot of bikers." )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:getmarket")
AddEventHandler("informer:getmarket", function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local price = 25000
		if (tonumber(user.getMoney()) >= tonumber(price)) then
		user.removeMoney(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Cabin near a gas station in the great ocean." )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:getlaunder")
AddEventHandler("informer:getlaunder", function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local price = 20000
		if (tonumber(user.getMoney()) >= tonumber(price)) then
		user.removeMoney(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, " At the docks there is a red office building that you can enter, inside will be a machine to clean your money!" )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
