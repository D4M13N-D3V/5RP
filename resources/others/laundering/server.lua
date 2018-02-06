local cops = 0
local transfer = nil
RegisterServerEvent('dm:check')
AddEventHandler('dm:check', function()
	local source = tonumber(source)
	getPoliceInService( function(p) 
		cops = tonumber(p)
	end)
	if cops >= -1 then
		TriggerClientEvent("dm:status", source, "p")
		TriggerEvent('f:getPlayer', source, function(user)
			if user.getDirty() > 0 then
				transfer = "doing it"
				local savedUser = user
				SetTimeout(90000, function()
					if transfer == "doing it" then
						local dm = user.getDirty()
						savedUser.removeDirtyMoney(dm)
						savedUser.addMoney(dm)
						TriggerClientEvent("pNotify:SendNotification", source, {text = "You have cleaned <span style='color:lime'>$</span><span style='color:white'>"..tonumber(dm).."</span> and now have <span style='color:lime'>$</span><span style='color:white'>"..savedUser.getMoney().."</span>",type = "error",queue = "left",timeout = 10000,layout = "centerRight"})
					end
				end)
			else
				TriggerClientEvent("dm:status", source, "nm")
			end
		end)
	else
		TriggerClientEvent("dm:status", source, "n")
	end
end)

function getPoliceInService(cb)
	TriggerEvent('f:getPlayers', function(players)
		local cop = 0
		for i,v in pairs(players) do
			if v.getSessionVar('policeInService') == true then
				cop = cop + 1
			end
		end
		cb(cop)
	end)
end

RegisterServerEvent('dm:cancel')
AddEventHandler('dm:cancel', function()
	local source = tonumber(source)
	transfer = nil
	TriggerClientEvent("dm:status", source, "cc")
end)