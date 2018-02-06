local robbing = false
local bank = ""
local secondsRemaining = 0

local banks = {
    ["Pacific Standard Bank"] = {
        position = { ['x'] = 255.221, ['y'] = 228.351, ['z'] = 106.5 },
        reward = math.random(47000,92000),
        nameofbank = "Pacific Standard Bank",
        time = 360,
        lastrobbed = 0,
    },
	["fleeca2"] = {
		position = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.9 },
		reward = math.random(25000,45000),
		nameofbank = "Fleeca Bank (Highway)",
		time = 360,
		lastrobbed = 0
	},
	["blainecounty"] = {
		position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.9 },
		reward = math.random(35000,65000),
		nameofbank = "Blaine County Savings",
		time = 360,
		lastrobbed = 0
	},
}

Citizen.CreateThread(function()
    for k,v in pairs(banks)do
        local ve = v.position

        local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
        SetBlipSprite(blip, 500)
        SetBlipColour(blip, 6)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Robbable Bank")
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('bank:currentlyrobbing')
AddEventHandler('bank:currentlyrobbing', function(robb)
	robbing = true
	bank = robb
	secondsRemaining = banks[bank].time
end)

RegisterNetEvent('bank:toofarlocal')
AddEventHandler('bank:toofarlocal', function(robb)
	robbing = false
	TriggerEvent('customNotification', "The robbery was cancelled, you will receive nothing.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)


RegisterNetEvent('bank:robberycomplete')
AddEventHandler('bank:robberycomplete', function(robb)
	robbing = false
	bank = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('bank:notifycop')
AddEventHandler('bank:notifycop', function(cop_msg)
	if exports.policejob:getIsInService() == true then
		TriggerEvent('customNotification', cop_msg)
	end
end)

Citizen.CreateThread(function()
	while true do
		if robbing then
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

		for k,v in pairs(banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 20.0)then
				if not robbing then
					DrawMarker(27, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
					
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rob ~b~" .. v.nameofbank .. "~w~ beware, Alarm triggered, police will be alerted!")
						end
						incircle = true
						if(IsControlJustReleased(1, 51))then
							if exports.policejob:getIsInService() == false then
								TriggerServerEvent('bank:checkrob', k)
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

		if robbing then
			local value = secondsRemaining
			local maxvalue = banks[bank].time
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
			
			local pos2 = banks[bank].position
			DrawMarker(1, pos2.x, pos2.y, pos2.z - 1, 0, 0, 0, 0, 0, 0, 15.0, 15.0, 0.2, 1555, 0, 0,255, 0, 0, 0,0)
			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('bank:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)