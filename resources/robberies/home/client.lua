local robbing = false
local home = ""
local secondsRemaining = 0

local homes = {
    ["Premium Home 13"] = {
        position = { ['x'] = 328.00524902344, ['y'] = 429.50967407227, ['z'] = 145.8 },
        reward = math.random(7000,20000),
        nameofhome = "Premium Home 14",
        time = 320,
        lastrobbed = 0,
    },
	["Premium Home 12"] = {
		position = { ['x'] = -170.36956787109, ['y'] = 482.66329956055, ['z'] = 137.5 },
		reward = math.random(5000,15000),
		nameofhome = "Premium Home 15",
		time = 320,
		lastrobbed = 0
	},
	["Premium Home 6"] = {
		position = { ['x'] = -467.18414306641, ['y'] = -700.63586425781, ['z'] = 77.3 },
		reward = math.random(9000,30000),
		nameofhome = "Premium Home 7",
		time = 320,
		lastrobbed = 0
	},
	["Mayors Office 16"] = {
        position = { ['x'] = -1567.5152587891, ['y'] = -586.40936279297, ['z'] = 108.8 },
        reward = math.random(25000,72000),
        nameofhome = "Mayors Office 20",
        time = 320,
        lastrobbed = 0,
    },
}

Citizen.CreateThread(function()
    for k,v in pairs(homes)do
        --local ve = v.position
        --local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
        --SetBlipSprite(blip, 500)
        --SetBlipColour(blip, 6)
        --SetBlipScale(blip, 0.8)
        --SetBlipAsShortRange(blip, true)
        --BeginTextCommandSetBlipName("STRING")
        --AddTextComponentString("Robbable Homes")
        --EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('home:currentlyrobbing')
AddEventHandler('home:currentlyrobbing', function(robb)
	robbing = true
	home = robb
	secondsRemaining = homes[home].time
end)

RegisterNetEvent('home:toofarlocal')
AddEventHandler('home:toofarlocal', function(robb)
	robbing = false
	TriggerEvent('customNotification', "The robbery was cancelled, you will receive nothing.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)


RegisterNetEvent('home:robberycomplete')
AddEventHandler('home:robberycomplete', function(robb)
	robbing = false
	home = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('home:notifycop')
AddEventHandler('home:notifycop', function(cop_msg)
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

		for k,v in pairs(homes)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not robbing then
					DrawMarker(27, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
					
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rob ~b~" .. v.nameofhome .. "~w~ beware, Alarm triggered, police will be alerted!")
						end
						incircle = true
						if(IsControlJustReleased(1, 51))then
							if exports.policejob:getIsInService() == false then
								TriggerServerEvent('home:checkrob', k)
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
			local maxvalue = homes[home].time
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
			
			local pos2 = homes[home].position
			DrawMarker(1, pos2.x, pos2.y, pos2.z - 1, 0, 0, 0, 0, 0, 0, 15.0, 15.0, 0.2, 1555, 0, 0,255, 0, 0, 0,0)
			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('home:toofar', home)
			end
		end

		Citizen.Wait(0)
	end
end)