RegisterServerEvent("doorLock-Unlock")
AddEventHandler("doorLock-Unlock", function(i)
print("tset")
	TriggerClientEvent("doorLock-setLock",-1,i,false)
end)

RegisterServerEvent("doorLock-Lock")
AddEventHandler("doorLock-Lock", function(i)
	TriggerClientEvent("doorLock-setLock",-1,i,true)
end)

-- restart dRdoors