--=============================================================================
--  Jonathan D @ Gannon
--=============================================================================

RegisterServerEvent('illegal:requestNbCop')
AddEventHandler('illegal:requestNbCop', function()
	getPoliceInService( function(nbPolicier) 
        local nbPolice = nbPolicier
	    TriggerClientEvent('illegal:setcop',source,nbPolice)
	end)
end)

function getPoliceInService(cb)
	TriggerEvent('f:getPlayers', function(players)
		local nbPolicier = 0
		for i,p in pairs(players) do
			if p.getSessionVar('policeInService') == true then
				nbPolicier = nbPolicier + 1
			end
		end
		cb(nbPolicier)
	end)
end


function getTime()
    return os.time()
end

RegisterServerEvent('illegal:showSmoke')
AddEventHandler('illegal:showSmoke', function (posX, posY, posZ)
	TriggerClientEvent('illegal:showSmoke', -1, posX, posY, posZ)
end)