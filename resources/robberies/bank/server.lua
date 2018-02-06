local robbers = {}
local banks = {
    ["Pacific Standard Bank"] = {
        position = { ['x'] = 255.221, ['y'] = 228.351, ['z'] = 106.5 },
        reward = math.random(47000,92000),
        nameofbank = "Pacific Standard Bank",
        time = 360,
        lastrobbed = 0,
    },
	["fleeca2"] = {
		position = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.9 },
		reward = math.random(25000,45000),
		nameofbank = "Fleeca Bank (Highway)",
		time = 360,
		lastrobbed = 0
	},
	["blainecounty"] = {
		position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.9 },
		reward = math.random(35000,65000),
		nameofbank = "Blaine County Savings",
		time = 360,
		lastrobbed = 0
	}
}

local cooldown = 120--minutes
local cops = 0

RegisterServerEvent('bank:toofar')
AddEventHandler('bank:toofar', function(robb)
	local source = tonumber(source)
	if(robbers[source])then
		TriggerClientEvent('bank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent("bank:notifycop", -1, "Robbery was cancelled at ^2" .. banks[robb].nameofbank)
	end
end)

RegisterServerEvent('bank:checkrob')
AddEventHandler('bank:checkrob', function(current_bank)
	local source = tonumber(source)
	getPoliceInService( function(cops) 
		TriggerEvent('bank:rob',current_bank,cops,source)
	end)
end)

RegisterServerEvent('bank:rob')
AddEventHandler('bank:rob', function(current_bank,cops,source)
	local source = tonumber(source)
	if banks[current_bank] then
		local bank = banks[current_bank]

		if (os.time() - bank.lastrobbed) < (cooldown*60) and bank.lastrobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((cooldown*60) - (os.time() - bank.lastrobbed))/60)) .. " minutes.")
			return
		end
		if(cops >= 3)then
			TriggerClientEvent("bank:notifycop", -1, "Bank robbery at "..bank.nameofbank..".")
			TriggerClientEvent('customNotification', source, "The Alarm has been triggered! <br> Hold the fort for "..(math.floor(bank.time/60)).." minutes")
			TriggerClientEvent('bank:currentlyrobbing', source, current_bank)
			bank.lastrobbed = os.time()
			robbers[source] = current_bank
			SetTimeout(math.floor((bank.time*1000)+2000), function()
				if(robbers[source])then
					TriggerClientEvent('bank:robberycomplete', source, job)
					TriggerEvent('f:getPlayer', source, function(target) 
						if(target)then
							target.addDirtyMoney(bank.reward) 
							TriggerClientEvent('customNotification', source, "Robbery complete, you received <span style='color:lime'>$</span><span style='color:white'>" .. bank.reward.."</span>")
							TriggerClientEvent("bank:notifycop", -1, "Robbery is over at " .. bank.nameofbank)
						end
					end)
				end
			end)
		else
			TriggerClientEvent('customNotification', source, "There are not enough police online. (At least 2 needed)")
		end
	end
end)