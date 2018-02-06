local group
local states = {}
states.frozen = false
states.frozenPos = nil

-------------------------CHAT SHIT--------------------
RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "^0-", {255, 0, 0}, "^5" .. name .."  ".."^3  " .. message )
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 50.00 then
		TriggerEvent('chatMessage', "^0-", {255, 0, 0}, "^5" .. name .."  ".."^3  " .. message )
	end
end)

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, rank, colour, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "^6Local ^3| ^7"..rank, colour, message )
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 50.00 then
		TriggerEvent('chatMessage', "^6Local ^3| ^7"..rank, colour, message )
	end
end)
-------------------------
-------------------------
-------------------------

Citizen.CreateThread(function()
	while true do
		Wait(0)

		if (IsControlJustPressed(1, 212) and IsControlJustPressed(1, 213)) then
			if group == "owner" or group == "admin" or group == "superadmin" then
				SetNuiFocus(true, true)
				SendNUIMessage({type = 'open', players = getPlayers()})
			end
		end
	end
end)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false)
end)

RegisterNUICallback('quick', function(data, cb)
	if data.type == "slay_all" or data.type == "bring_all" or data.type == "slap_all" then
		TriggerServerEvent('es_admin:all', data.type)
	else
		TriggerServerEvent('es_admin:quick', data.id, data.type)
	end
end)

RegisterNUICallback('set', function(data, cb)
	TriggerServerEvent('es_admin:set', data.type, data.user, data.param)
end)

RegisterNUICallback('ban', function(data, cb)
	print(data.user.." "..data.time.." "..data.type.." "..data.reason)
	if data.time ~= "" and data.reason ~= "" then
		local time = data.time.. ""..data.type
		TriggerServerEvent('FAC:Ban', data.user, time, data.reason)
	end
end)

RegisterNUICallback('kick', function(data, cb)
	if	data.reason ~= "" then
		TriggerServerEvent('FAC:Kick', data.user, data.reason)
	end
end)

local noclip = false
RegisterNetEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(t, target)
	if t == "slay" then SetEntityHealth(PlayerPedId(), 0) end
	if t == "goto" then SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) end
	if t == "bring" then 
		states.frozenPos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
		SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) 
	end
	if t == "crash" then 
		Citizen.Trace("You're being crashed, so you know. This server sucks.\n")
		Citizen.CreateThread(function()
			while true do end
		end) 
	end
	if t == "slap" then ApplyForceToEntity(PlayerPedId(), 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false) end
	if t == "noclip" then
		local msg = "disabled"
		if(noclip == false)then
			noclip_pos = GetEntityCoords(GetPlayerPed(-1), false)
		end

		noclip = not noclip

		if(noclip)then
			msg = "enabled"
		end

		TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
	end
	if t == "freeze" then
		local player = PlayerId()

		local ped = GetPlayerPed(-1)

		states.frozen = not states.frozen
		states.frozenPos = GetEntityCoords(ped, false)

		if not state then
			if not IsEntityVisible(ped) then
				SetEntityVisible(ped, true)
			end

			if not IsPedInAnyVehicle(ped) then
				SetEntityCollision(ped, true)
			end

			FreezeEntityPosition(ped, false)
			--SetCharNeverTargetted(ped, false)
			SetPlayerInvincible(player, false)
		else
			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
			--SetCharNeverTargetted(ped, true)
			SetPlayerInvincible(player, true)
			--RemovePtfxFromPed(ped)

			if not IsPedFatallyInjured(ped) then
				ClearPedTasksImmediately(ped)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if(states.frozen)then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetEntityCoords(GetPlayerPed(-1), states.frozenPos)
		end
	end
end)

local heading = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(noclip)then
			SetEntityCoordsNoOffset(GetPlayerPed(-1),  noclip_pos.x,  noclip_pos.y,  noclip_pos.z,  0, 0, 0)

			if(IsControlPressed(1,  34))then
				heading = heading + 1.5
				if(heading > 360)then
					heading = 0
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  9))then
				heading = heading - 1.5
				if(heading < 0)then
					heading = 360
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
			end
			if(IsControlPressed(1,  32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1,  27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, 1.0)
			end
			if(IsControlPressed(1,  173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, -1.0)
			end
		end
	end
end)

RegisterNetEvent('es_admin:spawnVehicle')
AddEventHandler('es_admin:spawnVehicle', function(v)
	local carid = GetHashKey(v)
	local playerPed = GetPlayerPed(-1)
	if playerPed and playerPed ~= -1 then
		RequestModel(carid)
		while not HasModelLoaded(carid) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)

		veh = CreateVehicle(carid, playerCoords, 0.0, true, false)
		SetVehicleAsNoLongerNeeded(veh)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
	end
end)

RegisterNetEvent('es_admin:freezePlayer')
AddEventHandler("es_admin:freezePlayer", function(state)
	local player = PlayerId()

	local ped = GetPlayerPed(-1)

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		--SetCharNeverTargetted(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		--SetCharNeverTargetted(ped, true)
		SetPlayerInvincible(player, true)
		--RemovePtfxFromPed(ped)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(x, y, z)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)

RegisterNetEvent('es_admin:slap')
AddEventHandler('es_admin:slap', function()
	local ped = GetPlayerPed(-1)

	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('es_admin:givePosition')
AddEventHandler('es_admin:givePosition', function(option)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local heading = GetEntityHeading(GetPlayerPed(-1))
	local string = ""
	if option == "n" then
		string = "{x=" .. pos.x .. ", y=" .. pos.y .. ", z=" .. pos.z .. "},\n"
	else
		string = "{x=" .. pos.x .. ", y=" .. pos.y .. ", z=" .. pos.z .. ", h=" .. heading .. "},\n"
	end
	TriggerServerEvent('es_admin:givePos', string)
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Position saved to file.')
end)

RegisterNetEvent('es_admin:kill')
AddEventHandler('es_admin:kill', function()
	SetEntityHealth(GetPlayerPed(-1), 0)
end)

RegisterNetEvent('es_admin:heal')
AddEventHandler('es_admin:heal', function()
	SetEntityHealth(GetPlayerPed(-1), 200)
end)

RegisterNetEvent('es_admin:crash')
AddEventHandler('es_admin:crash', function()
	while true do
	end
end)

RegisterNetEvent("es_admin:noclip")
AddEventHandler("es_admin:noclip", function(t)
	local msg = "disabled"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(GetPlayerPed(-1), false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
	end

	TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
end)

function getPlayers()
	local players = {}
	for i = 0,32 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, {id = GetPlayerServerId(i), name = GetPlayerName(i)})
		end
	end
	return players
end

RegisterNetEvent("kickall")
AddEventHandler("kickall",function(reason)
	TriggerServerEvent("kickall", reason)
end)

local distanceToCheck = 5.0
RegisterNetEvent('es_admin:deleteVehicle')
AddEventHandler('es_admin:deleteVehicle', function()
    local ped = GetPlayerPed( -1 )
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
        local pos = GetEntityCoords(ped)
        if (IsPedSittingInAnyVehicle(ped)) then 
            local vehicle = GetVehiclePedIsIn(ped, false)

            if (GetPedInVehicleSeat( vehicle, -1 ) == ped) then 
                TriggerEvent("customNotification", "Vehicle deleted." )
                SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)
            else 
                TriggerEvent("customNotification", "You must be in the driver's seat!")
            end 
        else
            local playerPos = GetEntityCoords(ped, 1)
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0)
            local vehicle = GetVehicleInDirection(playerPos, inFrontOfPlayer)

            if(DoesEntityExist(vehicle)) then 
                TriggerEvent("customNotification", "Vehicle deleted.")
                SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)
            else 
                TriggerEvent("customNotification", "You must be in or near a vehicle to delete it.")
            end 
        end 
    end 
end)

function deleteCar(entity)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
end

function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end
