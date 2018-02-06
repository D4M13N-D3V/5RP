function getPoliceInService(cb)
	TriggerEvent('f:getPlayers', function(players)
		local nbPolice = 0
		for i,p in pairs(players) do
			if p.getSessionVar('policeInService') == true then
				nbPolice = nbPolice + 1
			end
		end
		cb(nbPolice)
	end)
end