function jobid(identifier)
  return MySQL.Sync.fetchScalar("SELECT job FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
end



RegisterServerEvent('gopostal:checkjob')
AddEventHandler('gopostal:checkjob', function()
  local source = tonumber(source)
  TriggerEvent('f:getPlayer', source, function(user)
    local job = user.getJob()
    if job == 19 then --here you change the jobname (from your database)
      TriggerClientEvent('gopostal:deliverytrue', source)
    else
      TriggerClientEvent('gopostal:deliveryfalse', source)
    end
  end)
end)


--Essential payment functions 

RegisterServerEvent('gopostal:success')
AddEventHandler('gopostal:success', function(price)
  TriggerEvent('f:getPlayer', source, function(user)
    user.addMoney(tonumber(price))
   end)
end)

RegisterServerEvent('gopostal:fail')
AddEventHandler('gopostal:fail', function(price)
  TriggerEvent('f:getPlayer', source, function(user)
   -- update player money amount
   user.removeMoney(tonumber(price))
   end)
end)