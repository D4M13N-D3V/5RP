RegisterNetEvent('prox_chatMessage')
AddEventHandler('prox_chatMessage', function(id, name, message)
	if PlayerId() == GetPlayerFromServerId(id) then
		TriggerEvent('chatMessage', "^0-", {255, 0, 0}, "^5" .. name .."  ".."^3  " .. message )
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(PlayerId())), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(id))), true) < 50.00 then
		TriggerEvent('chatMessage', "^0-", {255, 0, 0}, "^5" .. name .."  ".."^3  " .. message )
	end
end)