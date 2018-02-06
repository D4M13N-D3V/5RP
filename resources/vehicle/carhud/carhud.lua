function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

Citizen.CreateThread(function()
	while true do
	
		Citizen.Wait(1)
		local get_ped = GetPlayerPed(-1) -- current ped
		local get_ped_veh = GetVehiclePedIsIn(GetPlayerPed(-1),false) -- Current Vehicle ped is in
		local plate_veh = GetVehicleNumberPlateText(get_ped_veh) -- Vehicle Plate
		local veh_stop = IsVehicleStopped(get_ped_veh) -- Parked or not
		local veh_engine_health = GetVehicleEngineHealth(get_ped_veh) -- Vehicle Engine Damage 
		local veh_body_health = GetVehicleBodyHealth(get_ped_veh)
		local veh_burnout = IsVehicleInBurnout(get_ped_veh) -- Vehicle Burnout

		if(IsPedInAnyVehicle(GetPlayerPed(-1), false))then
			local kmh = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6
            local mph = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.236936
			drawRct(0.108, 0.932, 0.046,0.03,0,0,0,100) 	-- UI:panel kmh
            drawRct(0.108, 0.895, 0.046,0.03,0,0,0,100) 	-- UI:panel mph	
            --drawRct(0.108, 0.858, 0.046,0.03,0,0,0,100) 	-- UI:panel fuel
			drawRct(0.0147, 0.807, 0.045, 0.042, 0,0,0,150)        -- UI: 1 Plate Box
			drawRct(0.1558, 0.793, 0.0035, 0.190, 0,0,0,150)        -- UI: 6 Right Side Map
            --drawRct(0.015, 0.803, 0.145, 0.005, 0,0,0,150)        -- UI: 11 Top Map
			
            drawTxt(0.61, 1.42, 1.0,1.0,0.64 , "~w~" .. math.ceil(kmh), 255, 255, 255, 255)  -- INT: kmh
			drawTxt(0.631, 1.434, 1.0,1.0,0.4, "~w~ km/h", 255, 255, 255, 255)	-- TXT: kmh
            drawTxt(0.61, 1.384, 1.0,1.0,0.64 , "~w~" .. math.ceil(mph), 255, 255, 255, 255)  -- INT: kmh
            drawTxt(0.634, 1.397, 1.0,1.0,0.4, "~w~ mph", 255, 255, 255, 255)	-- TXT: mph
			drawTxt(0.518, 1.318, 1.0,1.0,0.42, "~w~" .. plate_veh, 255, 255, 255, 255) -- TXT: Plate
            drawTxt(0.526, 1.298, 1.0,1.0,0.4, "~w~ PLATE", 255, 255, 255, 255)	-- TXT: Word Plate
            --drawTxt(0.634, 1.360, 1.0,1.0,0.4, "~w~ Fuel", 255, 255, 255, 255)	-- TXT: Fuel
			end
		end		
end)