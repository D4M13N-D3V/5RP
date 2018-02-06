local robbers = {}
local homes = {
    ["Premium Home 13"] = {
        position = { ['x'] = 328.00524902344, ['y'] = 429.50967407227, ['z'] = 145.8 },
        reward = math.random(7000,20000),
        nameofhome = "Premium Home 14",
        time = 320,
        lastrobbed = 0,
    },
	["Premium Home 12"] = {
		position = { ['x'] = -170.36956787109, ['y'] = 482.66329956055, ['z'] = 137.5 },
		reward = math.random(5000,15000),
		nameofhome = "Premium Home 15",
		time = 320,
		lastrobbed = 0
	},
	["Premium Home 6"] = {
		position = { ['x'] = -467.18414306641, ['y'] = -700.63586425781, ['z'] = 77.3 },
		reward = math.random(9000,30000),
		nameofhome = "Premium Home 7",
		time = 320,
		lastrobbed = 0
	},
	["Mayors Office 16"] = {
        position = { ['x'] = -1567.5152587891, ['y'] = -586.40936279297, ['z'] = 108.8 },
        reward = math.random(25000,72000),
        nameofhome = "Mayors Office 20",
        time = 320,
        lastrobbed = 0,
    }
}

local cooldown = 120--minutes
local cops = 0

RegisterServerEvent('home:toofar')
AddEventHandler('home:toofar', function(robb)
	local source = tonumber(source)
	if(robbers[source])then
		TriggerClientEvent('home:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent("home:notifycop", -1, "Robbery was cancelled at ^2" .. homes[robb].nameofhome)
	end
end)

RegisterServerEvent('home:checkrob')
AddEventHandler('home:checkrob', function(current_home)
	local source = tonumber(source)
	getPoliceInService( function(cops) 
		TriggerEvent('home:rob',current_home,cops,source)
	end)
end)

RegisterServerEvent('home:rob')
AddEventHandler('home:rob', function(current_home,cops,source)
	local source = tonumber(source)
	if homes[current_home] then
		local home = homes[current_home]

		if (os.time() - home.lastrobbed) < (cooldown*60) and home.lastrobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((cooldown*60) - (os.time() - home.lastrobbed))/60)) .. " minutes.")
			return
		end
		if(cops >= 2)then
			TriggerClientEvent("home:notifycop", -1, "home robbery at "..home.nameofhome..".")
			TriggerClientEvent('customNotification', source, "The Alarm has been triggered! <br> Hold the fort for "..(math.floor(home.time/60)).." minutes")
			TriggerClientEvent('home:currentlyrobbing', source, current_home)
			home.lastrobbed = os.time()
			robbers[source] = current_home
			SetTimeout(math.floor((home.time*1000)+2000), function()
				if(robbers[source])then
					TriggerClientEvent('home:robberycomplete', source, job)
					TriggerEvent('f:getPlayer', source, function(target) 
						if(target)then
							target.addDirtyMoney(home.reward) 
							TriggerClientEvent('customNotification', source, "Robbery complete, you received <span style='color:lime'>$</span><span style='color:white'>" .. home.reward.."</span>")
							TriggerClientEvent("home:notifycop", -1, "Robbery is over at " .. home.nameofhome)
						end
					end)
				end
			end)
		else
			TriggerClientEvent('customNotification', source, "There are not enough police online. (At least 2 needed)")
		end
	end
end)