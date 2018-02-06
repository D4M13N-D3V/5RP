local robbers = {}
local stores = {
	["Great Ocean Freeway 24/7"] = {
		position = { ['x'] = 1734.510, ['y'] = 6420.202, ['z'] = 35.5 },
		reward = math.random(900,3200),
		nameofstore = "24/7 (Paleto Bay)",
		time = 300,
		lastrobbed = 0
	},
	["Palomino Freeway 24/7"] = {
		position = { ['x'] = 2549.6711425781, ['y'] = 384.73248291016, ['z'] = 109.0 },
		reward = math.random(1500,4000),
		nameofstore = "Palomino FWY 24/7",
		time = 300,
		lastrobbed = 0
	},
	["Senora FWY 24/7"] = {
		position = { ['x'] = 2673.0771484375, ['y'] = 3286.4147949219, ['z'] = 55.5 },
		reward = math.random(1000,2500),
		nameofstore = "Senora FWY 24/7",
		time = 300,
		lastrobbed = 0
	},
	["Bahama Mamas"] = {
		position = { ['x'] = -1382.4459228516, ['y'] = -629.47082519531, ['z'] = 31.2 },
		reward = math.random(5000,8000),
		nameofstore = "Bahama Mamas",
		time = 400,
		lastrobbed = 0
	},
	["LittleSeoul 24/7"] = {
		position = { ['x'] = -709.17022705078, ['y'] = -904.21722412109, ['z'] = 19.5 },
		reward = math.random(1200,3300),
		nameofstore = "24/7 (Little Seoul)",
		time = 300,
		lastrobbed = 0
	}
}

local cooldown = 15--minutes
local cops = 0

RegisterServerEvent('holdup:toofar')
AddEventHandler('holdup:toofar', function(current_store)
	local source = tonumber(source)
	if(robbers[source])then
		TriggerClientEvent('holdup:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent("holdup:notifycop", -1, "Robbery was cancelled at " .. stores[current_store].nameofstore)
	end
end)

RegisterServerEvent('holdup:checkrob')
AddEventHandler('holdup:checkrob', function(k)
	local source = tonumber(source)
	getPoliceInService( function(cops) 
		TriggerEvent('holdup:rob',k,cops,source)
	end)
end)

RegisterServerEvent('holdup:rob')
AddEventHandler('holdup:rob', function(current_store,cops,source)
	local source = tonumber(source)
	if stores[current_store] then
		local store = stores[current_store]

		if (os.time() - store.lastrobbed) < (cooldown*60) and store.lastrobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((cooldown*60) - (os.time() - store.lastrobbed))/60)) .. " minutes.")
			return
		end
		if(cops >= 2)then
			TriggerClientEvent("holdup:notifycop", -1, "Store robbery at "..store.nameofstore..".")
			TriggerClientEvent('customNotification', source, "The Alarm has been triggered! <br> Hold the fort for "..(math.floor(store.time/60)).." minutes")
			TriggerClientEvent('holdup:currentlyrobbing', source, current_store)
			stores[current_store].lastrobbed = os.time()
			robbers[source] = current_store
			SetTimeout(math.floor((store.time*1000)+2000), function()
				if(robbers[source])then
					TriggerClientEvent('holdup:robberycomplete', source, job)
					TriggerEvent('f:getPlayer', source, function(target) 
						if(target)then
							target.addDirtyMoney(store.reward) 
							TriggerClientEvent('customNotification', source, "Robbery complete, you received <span style='color:lime'>$</span><span style='color:white'>" .. store.reward.."</span>")
							TriggerClientEvent("bank:notifycop", -1, "Robbery is over at " .. store.nameofstore)	
						end
					end)
				end
			end)
		else
			TriggerClientEvent('customNotification', source, "There are not enough police online. (At least 2 needed)")
		end				
	end
end)