RegisterServerEvent('job:success')
AddEventHandler('job:success', function(amount)
	print(amount)
	-- Get the players money amount
TriggerEvent('f:getPlayer', source, function(user)
  local pooltotal = amount - 500
  pooltotal = pooltotal/2 -- nerf
  if pooltotal <= 100 then 
  	pooltotal = 250
  end
  total = math.random(100,math.floor(pooltotal))
  -- update player money amount
  user.addMoney((total + tonumber(math.floor(100)) + 0.0))
 end)
end)

RegisterServerEvent('pool:getplayerjob')
AddEventHandler('pool:getplayerjob', function()
	local source = tonumber(source)
  TriggerEvent('f:getPlayer', source, function(user)
    local job = user.getJob()
    TriggerClientEvent("pool:result", source, job)
  end)
end)