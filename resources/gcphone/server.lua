--====================================================================================
-- #Author: Jonathan D @Gannon
--====================================================================================

-- AddEventHandler('onMySQLReady', function ()
--====================================================================================
--  Utils
--====================================================================================

function IsNumberUnique(pnumber, cb)
    local unique = true
    local check = MySQL.Sync.fetchScalar("SELECT identifier FROM phone_numbers WHERE number = @pnumber", {['@pnumber'] = pnumber})
    if check == nil then
    else
        unique = false
    end
    cb(unique)
end

function getPhoneRandomNumber()
    local count = math.random(1,222)
    for i = 1,222 do
        local number = '0' .. math.random(600000000,699999999)
        if i == count then
            return number
        end
    end
end

function getSourceFromIdentifier(identifier, cb)
    local s = nil
    TriggerEvent("f:getPlayers", function(users)
        for k , user in pairs(users) do
            if user.getIdentifier() == identifier then
                s = k
                break
            end
        end
    end)
    cb(s)
end

function getNumberPhone(source)
    local n = 0
    TriggerEvent('f:getPlayer', source, function(user)
        n = user.getPhoneNumber()
    end)
    return n
end

function getIdentifierByPhoneNumber(phone_number)
    return MySQL.Sync.fetchScalar("SELECT identifier FROM phone_numbers WHERE number = @pnumber", {['@pnumber'] = phone_number})
end
--====================================================================================
--  Contacts
--====================================================================================
function getContacts(identifier)
    local result = MySQL.Sync.fetchAll("SELECT phone_users_contacts.id, phone_users_contacts.number, phone_users_contacts.display FROM phone_users_contacts WHERE phone_users_contacts.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    return result
end

function addContact(source, identifier, number, display)
    print(number .. ' ' ..  display)
    MySQL.Sync.execute("INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES(@identifier, @number, @display)", {
        ['@identifier'] = identifier,
        ['@number'] = number,
        ['@display'] = display,
    })
    notifyContactChange(source, identifier)
end

function updateContact(source, identifier, id, number, display)
    MySQL.Sync.execute("UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id", { 
        ['@number'] = number,
        ['@display'] = display,
        ['@id'] = id,
    })
    notifyContactChange(source, identifier)
end

function deleteContact(source, identifier, id)
    MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id", {
        ['@identifier'] = identifier,
        ['@id'] = id,
    })
    notifyContactChange(source, identifier)
end

function deleteAllContact(identifier)
    MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier", {
        ['@identifier'] = identifier
    })
end

function notifyContactChange(source, identifier)
    if source ~= nil then 
        TriggerClientEvent("gcPhone:contactList", source, getContacts(identifier))
    end
end

RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact', function(display, phoneNumber)
    local identifier = GetPlayerIdentifiers(source)[1]
    addContact(source, identifier, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact', function(id, display, phoneNumber)
    local identifier = GetPlayerIdentifiers(source)[1]
    updateContact(source, identifier, id, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact', function(id)
    local identifier = GetPlayerIdentifiers(source)[1]
    deleteContact(source, identifier, id)
end)

--====================================================================================
--  Messages
--====================================================================================
function getMessages(identifier, source)
    return MySQL.Sync.fetchAll("SELECT phone_messages.* FROM phone_messages WHERE phone_messages.receiver = @number", {
        ['@number'] = getNumberPhone(source)
    })
end

function _internalAddMessage(transmitter, receiver, message, owner)
    local Query = "INSERT INTO phone_messages (`transmitter`, `receiver`,`message`, `isRead`,`owner`) VALUES(@transmitter, @receiver, @message, @isRead, @owner);"
    local Query2 = 'SELECT * from phone_messages WHERE `id` = (SELECT LAST_INSERT_ID());'
    local Parameters = {
        ['@transmitter'] = transmitter,
        ['@receiver'] = receiver,
        ['@message'] = message,
        ['@isRead'] = owner,
        ['@owner'] = owner
    }
    return MySQL.Sync.fetchAll(Query .. Query2, Parameters)[1]
end

function addMessage(source, identifier, phone_number, message)
    local otherIdentifier = getIdentifierByPhoneNumber(phone_number)
    local myPhone = getNumberPhone(source)
    if otherIdentifier ~= nil then 
        local tomess = _internalAddMessage(myPhone, phone_number, message, 0)
        getSourceFromIdentifier(otherIdentifier, function (osou)
            if osou ~= nil then 
               TriggerClientEvent("gcPhone:receiveMessage", osou, tomess)
            end
        end) 
    end
    local memess = _internalAddMessage(phone_number, myPhone, message, 1)
    TriggerClientEvent("gcPhone:receiveMessage", source, memess)
end

function setReadMessageNumber(identifier, num)
    local mePhoneNumber = getNumberPhone(source)
    MySQL.Sync.execute("UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter", { 
        ['@receiver'] = mePhoneNumber,
        ['@transmitter'] = num
    })
end

function deleteMessage(msgId)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `id` = @id", {
        ['@id'] = msgId
    })
end

function deleteAllMessageFromPhoneNumber(identifier, phone_number)
    local mePhoneNumber = getNumberPhone(source)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number", {
        ['@mePhoneNumber'] = mePhoneNumber,
        ['@phone_number'] = phone_number
    })
end

function deleteAllMessage(identifier)
    local mePhoneNumber = getNumberPhone(source)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber", {
        ['@mePhoneNumber'] = mePhoneNumber
    })
end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(phoneNumber, message)
    local identifier = GetPlayerIdentifiers(source)[1]
    print(identifier)
    addMessage(source, identifier, phoneNumber, message)
end)

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage', function(msgId)
    deleteMessage(msgId)
end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber', function(number)
    local identifier = GetPlayerIdentifiers(source)[1]
    deleteAllMessageFromPhoneNumber(identifier, number)
    TriggerClientEvent("gcPhone:allMessage", source, getMessages(identifier,source))
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage', function()
    local identifier = GetPlayerIdentifiers(source)[1]
    deleteAllMessage(identifier)
    TriggerClientEvent("gcPhone:allMessage", source, getMessages(identifier,source))
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber', function(num)
    local identifier = GetPlayerIdentifiers(source)[1]
    setReadMessageNumber(identifier, num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL', function()
    local source = source
    local identifier = GetPlayerIdentifiers(source)[1]
    deleteAllMessage(identifier)
    deleteAllContact(identifier)
    TriggerClientEvent("gcPhone:contactList", source, {})
    TriggerClientEvent("gcPhone:allMessage", source, {})
end)

RegisterServerEvent('gcPhone:internalSendMessage')
AddEventHandler('gcPhone:internalSendMessage', function(identifier, from, message)
    local phone = getNumberPhone(source)
    if phone ~= nil then 
        local mess = _internalAddMessage(from, phone, message, 0)
        getSourceFromIdentifier(identifier, function (osou)
            if osou ~= nil then 
                TriggerClientEvent("gcPhone:receiveMessage", osou, mess)
            end
        end) 
    end
end)
--====================================================================================
--  OnLoad
--====================================================================================
RegisterServerEvent('phone:firstspawn')
AddEventHandler('phone:firstspawn',function(source)
    local source = tonumber(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local myPhoneNumber = getNumberPhone(source)
    TriggerEvent('f:getPlayer', source, function(user)
        while myPhoneNumber == nil or tonumber(myPhoneNumber) == 0 do
            local randomNumberPhone = getPhoneRandomNumber()
            IsNumberUnique(randomNumberPhone, function(response)
                if response ~= nil then
                    if response == true then
                        user.setPhoneNumber(randomNumberPhone)
                        MySQL.Sync.execute("INSERT INTO phone_numbers (`identifier`, `number`) VALUES (@identifier, @number)", { 
                            ['@identifier'] = identifier,
                            ['@number'] = randomNumberPhone
                        })
                        myPhoneNumber = randomNumberPhone
                    end
                end
            end)
        end
    end)
    TriggerClientEvent("gcPhone:myPhoneNumber", source, myPhoneNumber)
    TriggerClientEvent("gcPhone:contactList", source, getContacts(identifier))
    TriggerClientEvent("gcPhone:allMessage", source, getMessages(identifier,source))
end)


-- Just For reload
RegisterServerEvent('gcPhone:allUpdate')
AddEventHandler('gcPhone:allUpdate', function()
    local source = source
    local identifier = GetPlayerIdentifiers(source)[1]
    TriggerClientEvent("gcPhone:myPhoneNumber", source, getNumberPhone(source))
    TriggerClientEvent("gcPhone:allMessage", source, getMessages(identifier,source))
    TriggerClientEvent("gcPhone:contactList", source, getContacts(identifier))  
end)


-- MySQLReady
-- end)

