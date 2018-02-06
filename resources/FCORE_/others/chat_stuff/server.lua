AddEventHandler('chatMessage', function(source, author, message)
    local source = tonumber(source)
    local args = stringsplit(message, " ")
    CancelEvent()
    if not string.find(args[1], "/") then
        TriggerClientEvent('chatMessage', -1, "^5OOC", {30, 144, 255}, "^0[^2"..source.."^0]^2 " .. author .."^0: "    .. message)
--        sendChat({username = author, content = message, identifier = getID("steam", source), type = "General Chat", port = GetConvar("endpoint_add_tcp","ripPort"), hostname = GetConvar("sv_hostname","ripHostname")})
    end
end)

--function sendChat(data)
--    PerformHttpRequest('https://heraldofdeath.com/gta5police/staging/chat_input.php', function(err, text, headers) end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
--end

TriggerEvent('es:addCommand', 'tweet', function(source, args, user)
    table.remove(args, 1)
    local message = table.concat(args, " ")
    local author = user.getName()
    TriggerClientEvent('chatMessage', -1, "", {30, 144, 255}, "^0(^3" .. author .." ^5Tweets^0 ): "  .. message)
--    sendChat({username = author, content = message, identifier = getID("steam", source), type = "tweet", port = GetConvar("endpoint_add_tcp","ripPort"), hostname = GetConvar("sv_hostname","ripHostname")})
end, {help = "Post a tweet"})

TriggerEvent('es:addCommand', 't', function(source, args, user)
    table.remove(args, 1)
    local message = table.concat(args, " ")
    local author = user.getName()
    TriggerClientEvent('chatMessage', -1, "", {30, 144, 255}, "^0(^3" .. author .." ^5Tweets^0 ): "  .. message)
--    sendChat({username = author, content = message, identifier = getID("steam", source), type = "tweet", port = GetConvar("endpoint_add_tcp","ripPort"), hostname = GetConvar("sv_hostname","ripHostname")})
end, {help = "Post a tweet"})

--TriggerEvent('es:addCommand', 'anontweet', function(source, args, user)
--    table.remove(args, 1)
--    local message = table.concat(args, " ")
--    TriggerClientEvent('chatMessage', -1, "", {30, 144, 255}, "^0( ^3Anonymous ^5Tweets^0 ): " .. message)
--    sendChat({username = author, content = message, identifier = getID("steam", source), type = "anontweet", port = GetConvar("endpoint_add_tcp","ripPort"), hostname = GetConvar("sv_hostname","ripHostname")})
--end, {help = "Post a anonymous tweet"})

--TriggerEvent('es:addCommand', 'at', function(source, args, user)
--    table.remove(args, 1)
--    local message = table.concat(args, " ")
--    TriggerClientEvent('chatMessage', -1, "", {30, 144, 255}, "^0( ^3Anonymous ^5Tweets^0 ): " .. message)
--    sendChat({username = author, content = message, identifier = getID("steam", source), type = "anontweet", port = GetConvar("endpoint_add_tcp","ripPort"), hostname = GetConvar("sv_hostname","ripHostname")})
--end, {help = "Post a anonymous tweet"})

--TriggerEvent('es:addCommand', 'rp', function(source, args, user)
--    table.remove(args, 1)
--    local message = table.concat(args, " ")
--    local author = user.getName()
--    TriggerClientEvent('chatMessage', -1, "RolePlay", {30, 144, 255}, "^0[^3"..source.."^0]^6 " .. author .."^0: "    .. message)
--    sendChat({username = author, content = message, identifier = getID("steam", source), type = "RolePlay", port = GetConvar("endpoint_add_tcp","ripPort"), hostname = GetConvar("sv_hostname","ripHostname")})
--end, {help = "Role Play Chat"})

TriggerEvent('es:addCommand', 'me', function(source, args, user)
    table.remove(args, 1)
    TriggerClientEvent("prox_chatMessage", -1, source, user.getName(), table.concat(args, " "))
end, {help = "Roleplay with text by describing what you are doing."})

TriggerEvent('es:addCommand', 'rp', function(source, args, user)
    table.remove(args, 1)
    TriggerClientEvent("prox_chatMessage", -1, source, user.getName(), table.concat(args, " "))
end, {help = "RolePlay Chat"})

TriggerEvent('es:addCommand', 'r', function(source, args, user)
    table.remove(args, 1)
    TriggerClientEvent("prox_chatMessage", -1, source, user.getName(), table.concat(args, " "))
end, {help = "RolePlay Chat"})

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end