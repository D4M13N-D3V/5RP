local holdingup = false
local store = ""
local secondsRemaining = 0

local stores = {
	["Great Ocean Freeway 24/7"] = {
		position = { ['x'] = 1734.510, ['y'] = 6420.202, ['z'] = 35.5 },
		reward = math.random(900,3200),
		nameofstore = "24/7 (Paleto Bay)",
		time = 300,
		lastrobbed = 0
	},
	["Palomino Freeway 24/7"] = {
		position = { ['x'] = 2549.6711425781, ['y'] = 384.73248291016, ['z'] = 109.0 },
		reward = math.random(1500,4000),
		nameofstore = "Palomino FWY 24/7",
		time = 300,
		lastrobbed = 0
	},
	["Senora FWY 24/7"] = {
		position = { ['x'] = 2673.0771484375, ['y'] = 3286.4147949219, ['z'] = 55.5 },
		reward = math.random(1000,2500),
		nameofstore = "Senora FWY 24/7",
		time = 300,
		lastrobbed = 0
	},
	["Bahama Mamas"] = {
		position = { ['x'] = -1382.4459228516, ['y'] = -629.47082519531, ['z'] = 31.2 },
		reward = math.random(5000,8000),
		nameofstore = "Bahama Mamas",
		time = 400,
		lastrobbed = 0
	},
	["LittleSeoul 24/7"] = {
		position = { ['x'] = -709.17022705078, ['y'] = -904.21722412109, ['z'] = 19.5 },
		reward = math.random(1200,3300),
		nameofstore = "24/7 (Little Seoul)",
		time = 300,
		lastrobbed = 0
	}
}

Citizen.CreateThread(function()
    for k,v in pairs(stores)do
        local ve = v.position
          local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
        SetBlipSprite(blip, 500)
        SetBlipColour(blip, 6)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Robbable Store")
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('holdup:currentlyrobbing')
AddEventHandler('holdup:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
	secondsRemaining = stores[store].time
end)

RegisterNetEvent('holdup:toofarlocal')
AddEventHandler('holdup:toofarlocal', function(robb)
	holdingup = false
	TriggerEvent('customNotification', "The robbery was cancelled, you will receive nothing.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)


RegisterNetEvent('holdup:robberycomplete')
AddEventHandler('holdup:robberycomplete', function(robb)
	holdingup = false
	store = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('holdup:notifycop')
AddEventHandler('holdup:notifycop', function(cop_msg)
	if exports.policejob:getIsInService() == true then
		TriggerEvent('customNotification', cop_msg)
	end
end)

Citizen.CreateThread(function()
	while true do
		if holdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end

		Citizen.Wait(0)
	end
end)

local incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 20.0)then
				if not holdingup then
					DrawMarker(27, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
					
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rob ~b~" .. v.nameofstore .. "~w~ beware, the police will be alerted!")
						end
						incircle = true
						if(IsControlJustReleased(1, 51))then
							if exports.policejob:getIsInService() == false then
								TriggerServerEvent('holdup:checkrob', k)
							else
								TriggerEvent('customNotification', "You are a cop, you cannot break the law.")
							end
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then
			local value = secondsRemaining
			local maxvalue = stores[store].time
			local width = 0.2
			local height = 0.025
			local xvalue = 0.4
			local yvalue = 0.05
			local outlinecolour = {0, 0, 0, 150}
			local barcolour = {255, 0, 0}
            DrawRect(xvalue + (width/2), yvalue, width + 0.004, height + 0.006705, outlinecolour[1], outlinecolour[2], outlinecolour[3], outlinecolour[4]) -- Box that creates outline
            drawHelpTxt(xvalue + (((maxvalue/2)/((maxvalue/2)/width))/2 + 0.045), yvalue + 0.0275, 0.1, 0.1, 0.5, value, 255, 255, 255, 255, 6) -- Text display of timer
            DrawRect(xvalue + (width/2), yvalue, width, height, barcolour[1], barcolour[2], barcolour[3], 75) --  Static full bar
            DrawRect(xvalue + ((value/(maxvalue/width))/2), yvalue, value/(maxvalue/width), height, barcolour[1], barcolour[2], barcolour[3], 255) -- Moveable Bar	
			
			local pos2 = stores[store].position
			DrawMarker(1, pos2.x, pos2.y, pos2.z - 1, 0, 0, 0, 0, 0, 0, 15.0, 15.0, 0.2, 1555, 0, 0,255, 0, 0, 0,0)			

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('holdup:toofar', store)
			end
		end

		Citizen.Wait(0)
	end
end)