jobList = {
	{name="Unemployed", id=1},
	{name="police", id=2},
	{name="Pharmacist", id=3},
	{name="Miner", id=9},
	{name="bucheron", id=7},
	{name="Farmer", id=6},
	{name="Fisher", id=10},
	{name="Brewer", id=12},
	{name="vigneron", id=13},
	{name="emergency", id=15},
	{name="mechanic", id=16},
	{name="taxi", id=17},
	{name="Secret Service", id=18},
}
	
RegisterServerEvent('js:isUnemployed')
AddEventHandler('js:isUnemployed', function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local currentJob = user.getJob()
		TriggerClientEvent('js:defineJobMenu', source, currentJob)
	end)
end)

RegisterServerEvent('js:jobs')
AddEventHandler('js:jobs', function(id)
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)		

		local oldJob = user.getJob()

		for _, item in pairs(jobList) do
			if oldJob == item.id then
				TriggerClientEvent(item.name..":deleteBlips", source)
			end
		end

		user.setJob(id)
		local data = user.getJobData()
		
        if id ~= 20 then
          TriggerClientEvent("pool:changedjob", source)
        elseif id ~= 21 then
          TriggerClientEvent("garbage:changedjob", source)
        end
        if id == 22 then
        	TriggerClientEvent("tow:status", source, true)
        else
        	TriggerClientEvent("tow:status", source, false)
        end
        
		TriggerClientEvent("js:updateJob", source, data.name)

		for _, item in pairs(jobList) do
			if id == item.id then
				TriggerClientEvent(item.name..":drawBlips", source)
				TriggerClientEvent(item.name..":drawMarker", source, true)
				TriggerClientEvent(item.name..":marker", source)
			end
		end
	end)
end)
	
RegisterServerEvent('js:firstspawn')
AddEventHandler('js:firstspawn', function(source)
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local currentJob = user.getJob()
		local data = user.getJobData()
			
		for _, item in pairs(jobList) do
			if currentJob == item.id then
				TriggerClientEvent(item.name..":drawBlips", source)
				TriggerClientEvent(item.name..":drawMarker", source, true)
				TriggerClientEvent(item.name..":marker", source)
			end
		end
        if currentJob == 22 then
        	TriggerClientEvent("tow:status", source, true)
        end
		TriggerClientEvent("js:updateJob", source, data.name)
	end)
end)
	
	
-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP Mechanic-------------------
-----------------------------------------------------------------------

TriggerEvent('es:addGroupCommand', 'secadd', "admin", function(source, args, user)
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /secadd [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("f:getPlayer", player, function(target)
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "Congrats, you're now a Secret Service !~w~.")
				TriggerClientEvent('js:getmyjob',player,18)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

TriggerEvent('es:addGroupCommand', 'secrem', "admin", function(source, args, user) 
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /secrem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("f:getPlayer", player, function(target)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "You're no longer Secret Service !~w~.")
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent('js:getmyjob',player,1)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)


TriggerEvent('es:addGroupCommand', 'mecadd', "admin", function(source, args, user)
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /mecadd [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("f:getPlayer", player, function(target)
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "Congrats, you're now a Mechanic !~w~.")
				TriggerClientEvent('js:getmyjob',player,16)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

TriggerEvent('es:addGroupCommand', 'mecrem', "admin", function(source, args, user) 
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /mecrem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("f:getPlayer", player, function(target)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "You're no longer a Mechanic !~w~.")
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent('js:getmyjob',player,1)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP EMS-------------------
-----------------------------------------------------------------------

TriggerEvent('es:addGroupCommand', 'ambadd', "admin", function(source, args, user)
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /ambadd [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("f:getPlayer", player, function(target)
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "Congrats, you're now a EMS !~w~.")
				TriggerClientEvent('js:getmyjob',player,15)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

TriggerEvent('es:addGroupCommand', 'ambrem', "admin", function(source, args, user) 
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /ambrem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("f:getPlayer", player, function(target)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "You're no longer a EMS !~w~.")
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				--TriggerClientEvent('chatMessage', player, 'GOVERNMENT', {255, 0, 0}, "You're no longer a cop !")
				TriggerClientEvent('js:getmyjob',player,1)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP TAXI-------------------
-----------------------------------------------------------------------

TriggerEvent('es:addGroupCommand', 'taxadd', "admin", function(source, args, user)
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /taxadd [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("f:getPlayer", player, function(target)
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "Congrats, you're now a Taxi !~w~.")
				TriggerClientEvent('js:getmyjob',player,17)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

TriggerEvent('es:addGroupCommand', 'taxrem', "admin", function(source, args, user) 
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /taxrem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("f:getPlayer", player, function(target)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "You're no longer a Taxi !~w~.")
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				--TriggerClientEvent('chatMessage', player, 'GOVERNMENT', {255, 0, 0}, "You're no longer a cop !")
				TriggerClientEvent('js:getmyjob',player,1)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

RegisterServerEvent('mission:completed')
AddEventHandler('mission:completed', function(total)
	-- Get the players money amount
	local source = source
TriggerEvent('f:getPlayer', source, function(user)
  -- update player money amount
  user.addMoney((total))
 TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "You received ~g~$".. tonumber(total))
 end)
end)
	
	