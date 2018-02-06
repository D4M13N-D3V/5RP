RegisterServerEvent('garbage:success')
AddEventHandler('garbage:success', function(amount)
  -- Get the players money amount
TriggerEvent('f:getPlayer', source, function(user)
  local garbagetotal = amount - 500
  if garbagetotal <= 100 then garbagetotal = 250 end
  total = math.random(100,math.floor(garbagetotal))
  -- update player money amount
  user.addMoney((total + tonumber(math.floor(100)) + 0.0))
 end)
end)

-- F-8 r-7 a-6 z-5 z-4 l-3 e-2 . -1
RegisterServerEvent('garbage:getplayerjob')
AddEventHandler('garbage:getplayerjob', function()
  local source = tonumber(source)
  TriggerEvent('f:getPlayer', source, function(user)

    local job = user.getJob()
    TriggerClientEvent("garbage:result", source, job)
  end)
end)