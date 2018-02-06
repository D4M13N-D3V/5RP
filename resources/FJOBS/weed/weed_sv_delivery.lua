function jobid(identifier)
  return MySQL.Sync.fetchScalar("SELECT job FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
end



RegisterServerEvent('agopostal:checkjob')
AddEventHandler('agopostal:checkjob', function()
  local source = tonumber(source)
  TriggerEvent('f:getPlayer', source, function(user)
    local job = user.getJob()
    if job == 3 then --here you change the jobname (from your database)
      TriggerClientEvent('agopostal:deliverytrue', source)
    else
      TriggerClientEvent('agopostal:deliveryfalse', source)
    end
  end)
end)


--Essential payment functions 

RegisterServerEvent('agopostal:success')
AddEventHandler('agopostal:success', function(price)
  TriggerEvent('f:getPlayer', source, function(user)
    user.addMoney(tonumber(price)*1.25)
   end)
end)

RegisterServerEvent('gopostal:fail')
AddEventHandler('agopostal:fail', function(price)
  TriggerEvent('f:getPlayer', source, function(user)
   -- update player money amount
   user.removeMoney(tonumber(price))
   end)
end)