-- HELPER FUNCTIONS
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.abs(math.floor(num * mult + 0.5) / mult)
end
--[[
-- Check Bank Balance
TriggerEvent('es:addCommand', 'checkbalance', function(source, args, user)
	local sourcePlayer = tonumber(source)
  TriggerEvent('f:getPlayer', source, function(user)
    TriggerClientEvent("es_freeroam:notify", sourcePlayer, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Your current balance is: ~g~$".. user.getBank())
    CancelEvent()
  end)
end)

-- Bank Deposit
TriggerEvent('es:addCommand', 'deposit', function(source, args, user)
  local amount = ""
  local player = user.identifier
  for i=1,#args do
    amount = args[i]
  end
  TriggerClientEvent('bank:deposit', source, amount)
end)
--]]
RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local sourcePlayer = tonumber(source)
  TriggerEvent('f:getPlayer', source, function(user)
      local rounded = math.abs(math.floor(tonumber(amount)))
      if(string.len(tostring(rounded)) >= 9) then
        TriggerClientEvent('chatMessage', sourcePlayer, "", {0, 0, 200}, "^1Value too large^0")
        CancelEvent()
      else
      	if(tonumber(rounded) <= tonumber(user.getMoney())) then
          user.removeMoney(rounded)
          user.addBank(rounded)
          TriggerClientEvent("es_freeroam:notify", sourcePlayer, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "deposit: ~g~$".. rounded .." ~n~~s~new Balance: ~g~$" .. user.getBank())
          TriggerClientEvent("banking:updateBalance", sourcePlayer, user.getBank())
          CancelEvent()
        else
          TriggerClientEvent('chatMessage', sourcePlayer, "", {0, 0, 200}, "^1Not enough money^0")
          CancelEvent()
        end
      end
  end)
end)
--[[
-- Bank Withdraw
TriggerEvent('es:addCommand', 'withdraw', function(source, args, user)
  local amount = ""
  local player = user.identifier
  for i=1,#args do
    amount = args[i]
  end
  TriggerClientEvent('bank:withdraw', source, amount)
end)
--]]
RegisterServerEvent('bank:withdrawAmende')
AddEventHandler('bank:withdrawAmende', function(amount)
	local sourcePlayer = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
    	user.removeBank(amount)
		TriggerClientEvent("es_freeroam:notify", sourcePlayer, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "New Balance: ~g~$" .. user.getBank())
    TriggerClientEvent("banking:updateBalance", sourcePlayer, user.getBank())
		CancelEvent()
    end)
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local sourcePlayer = tonumber(source)
  TriggerEvent('f:getPlayer', source, function(user)
      local rounded = math.abs(math.floor(tonumber(amount)))
      if(string.len(tostring(rounded)) >= 9) then
        TriggerClientEvent('chatMessage', sourcePlayer, "", {0, 0, 200}, "^1Input too high^0")
        CancelEvent()
      else
        if(tonumber(rounded) <= tonumber(user.getBank())) then
          user.removeBank(rounded)
          user.addMoney(rounded)
          TriggerClientEvent("es_freeroam:notify", sourcePlayer, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "withdrawal: ~g~$".. rounded .." ~n~~s~New Balance: ~g~$" .. user.getBank())
          TriggerClientEvent("banking:updateBalance", sourcePlayer, user.getBank())
          CancelEvent()
        else
          TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough money on the account^0")
          CancelEvent()
        end
      end
  end)
end)
--[[
-- Bank Transfer
TriggerEvent('es:addCommand', 'transfer', function(source, args, user)
  local fromPlayer
  local toPlayer
  local amount
  if (args[2] ~= nil and tonumber(args[3]) > 0) then
    fromPlayer = tonumber(source)
    toPlayer = tonumber(args[2])
    amount = tonumber(args[3])
    TriggerClientEvent('bank:transfer', source, fromPlayer, toPlayer, amount)
		else
    TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Use /transfer [id] [amount]^0")
    return false
  end
end)
--]]
RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(fromPlayer, toPlayer, amount)
    fromPlayer = tonumber(source)
    local sourcePlayer = tonumber(source)
  if tonumber(fromPlayer) == tonumber(toPlayer) then
    TriggerClientEvent('chatMessage', sourcePlayer, "", {0, 0, 200}, "^1You can not transfer to yourself^0")
    CancelEvent()
  else
    TriggerEvent('f:getPlayer', fromPlayer, function(user)
        local rounded = math.abs(math.floor(tonumber(amount)))
        if(string.len(tostring(rounded)) >= 9) then
          TriggerClientEvent('chatMessage', sourcePlayer, "", {0, 0, 200}, "^1Value to large^0")
          CancelEvent()
        else
          if(tonumber(rounded) <= tonumber(user.getBank())) then
          	user.removeBank(rounded)
            TriggerClientEvent("es_freeroam:notify", sourcePlayer, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Transferd: ~r~-$".. rounded .." ~n~~s~New Balance: ~g~$" .. user.getBank())
            TriggerClientEvent("banking:updateBalance", sourcePlayer, user.getBank())
            TriggerEvent('f:getPlayer', toPlayer, function(user2)
            	user2.addBank(rounded)
                TriggerClientEvent("es_freeroam:notify", tonumber(toPlayer), "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Recieved: ~g~$".. rounded .." ~n~~s~New Balance: ~g~$" .. user2.getBank())
                TriggerClientEvent("banking:updateBalance", tonumber(toPlayer), user2.getBank())
                CancelEvent()
            end)
            CancelEvent()
          else
            TriggerClientEvent('chatMessage', sourcePlayer, "", {0, 0, 200}, "^1Not enought money to complete^0")
            CancelEvent()
          end
        end
    end)
  end
end)

--[[
TriggerEvent('es:addCommand', 'givecash', function(source, args, user)
  local fromPlayer
  local toPlayer
  local amount
  if (args[2] ~= nil and tonumber(args[3]) > 0) then
    fromPlayer = tonumber(source)
    toPlayer = tonumber(args[2])
    amount = tonumber(args[3])
    TriggerClientEvent('bank:givecash', source, toPlayer, amount)
	else
    TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Use /givecash [id] [amount]^0")
    return false
  end
end)

TriggerEvent('es:addCommand', 'givedirty', function(source, args, user)
  local fromPlayer
  local toPlayer
  local amount
  if (args[2] ~= nil and tonumber(args[3]) > 0) then
    fromPlayer = tonumber(source)
    toPlayer = tonumber(args[2])
    amount = tonumber(args[3])
    TriggerClientEvent('bank:givedirty', source, toPlayer, amount)
	else
    TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Use /givedirty [id] [amount]^0")
    return false
  end
end)
--]]
RegisterServerEvent('bank:givecash')
AddEventHandler('bank:givecash', function(toPlayer, amount)
	local sourcePlayer = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		if (tonumber(user.getMoney()) >= tonumber(amount)) then
			user.removeMoney(amount)
			TriggerEvent('f:getPlayer', toPlayer, function(recipient)
				recipient.addMoney(amount)
				TriggerClientEvent("es_freeroam:notify", sourcePlayer, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Money spent: ~r~-$".. amount .." ~n~~s~Wallet: ~g~$" .. user.getMoney())
				TriggerClientEvent("es_freeroam:notify", tonumber(toPlayer), "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Money Recieved: ~g~$".. amount .." ~n~~s~Wallet: ~g~$" .. recipient.getMoney())
			end)
		else
			if (tonumber(user.getMoney()) < tonumber(amount)) then
        TriggerClientEvent('chatMessage', sourcePlayer, "", {0, 0, 200}, "^1Not enough money^0")
        CancelEvent()
			end
		end
	end)
end)

RegisterServerEvent('bank:givedirty')
AddEventHandler('bank:givedirty', function(toPlayer, amount)
	local sourcePlayer = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		if (tonumber(user.getDirty) >= tonumber(amount)) then
			user.removeDirtyMoney(amount)
			TriggerEvent('f:getPlayer', toPlayer, function(recipient)
				recipient:addDirtyMoney(amount)
				TriggerClientEvent("es_freeroam:notify", sourcePlayer, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Money spent: ~r~-$".. amount .." ~n~~s~Wallet: ~g~$" .. user.getDirty())
				TriggerClientEvent("es_freeroam:notify", tonumber(toPlayer), "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Money Recieved: ~g~$".. amount .." ~n~~s~Wallet: ~g~$" .. recipient.getDirty())
			end)
		else
			if (tonumber(user.getDirty()) < tonumber(amount)) then
        TriggerClientEvent('chatMessage', sourcePlayer, "", {0, 0, 200}, "^1Not enough money^0")
        CancelEvent()
			end
		end
	end)
end)