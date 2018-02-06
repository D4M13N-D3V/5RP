RegisterServerEvent('gc:openIdentity')
AddEventHandler('gc:openIdentity',function(other)
    local sourcePlayer = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        local data = user.getIdentity()
        local data2 = user.getJobData()
        local gender
        if data.g == "male" then
            gender = "h"
        elseif data.g == "female" then
            gender = "f"
        end
        if data ~= nil then 
            TriggerClientEvent('gc:showItentity', tonumber(other), {
                nom = data.sname,
                prenom = data.fname,
                sexe = gender,
                dateNaissance = tostring(data.dob),
                jobs = data2.name,
                taille = data.height,
                id = sourcePlayer
            })
        end
    end)
end)

RegisterServerEvent('gc:openMeIdentity')
AddEventHandler('gc:openMeIdentity',function()
    local sourcePlayer = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        local data = user.getIdentity()
        local data2 = user.getJobData()
        local gender
        if data.g == "male" then
            gender = "h"
        elseif data.g == "female" then
            gender = "f"
        end
        if data ~= nil then 
            TriggerClientEvent('gc:showItentity', sourcePlayer, {
                nom = data.sname,
                prenom = data.fname,
                sexe = gender,
                dateNaissance = tostring(data.dob),
                jobs = data2.name,
                taille = data.height,
                id = sourcePlayer
            })
        end
    end)
end)