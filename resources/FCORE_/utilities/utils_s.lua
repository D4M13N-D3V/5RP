function GetIdentity(id)
	local name = ""
	TriggerEvent("f:getPlayer", id, function(user) 
		if user then
			local identity = user.getIdentity()
			name = identity.fname.." "..identity.sname or ""
		else
			name = GetPlayerName(id)
		end
	end)
	return name
end

function getID(type, source)
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" and (type == "steam" or type == 1) then
            return v
        elseif string.sub(tostring(v), 1, string.len("license:")) == "license:" and (type == "license" or type == 2) then
            return v
        elseif string.sub(tostring(v), 1, string.len("ip:")) == "ip:" and (type == "ip" or type == 3) then
            return v
        end
    end
    return nil
end