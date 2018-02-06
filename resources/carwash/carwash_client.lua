--DO-NOT-EDIT-BELLOW-THIS-LINE--

Key = 201 -- ENTER

vehicleWashStation = {
	{26.5906,  -1392.0261,  28.6},
	{170.9113,  -1717.9705,  29.0},
	{168.0578,  -1715.3697,  29.0},
	{-74.5693,  6427.8715,  30.5},
	{-699.6325,  -932.7043,  18.2}
}


Citizen.CreateThread(function ()
	Citizen.Wait(0)
	for i = 1, #vehicleWashStation do
		garageCoords = vehicleWashStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 100) -- 100 = carwash
		SetBlipAsShortRange(stationBlip, true)
	end
    return
end)

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			for i = 1, #vehicleWashStation do
				garageCoords2 = vehicleWashStation[i]
				DrawMarker(27, garageCoords2[1], garageCoords2[2], garageCoords2[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5 then
					DrawSpecialText("Press [~g~ENTER~s~] to clean your vehicle")
					if(IsControlJustPressed(1, Key)) then
						TriggerServerEvent('carwash:checkmoney')
					end
				end
			end
		end
	end
end)

RegisterNetEvent('carwash:success')
AddEventHandler('carwash:success', function(price)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
	msg = "Vehicle ~y~ Clean~s~! ~g~-$" .. price .. "~s~!"
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)

RegisterNetEvent('carwash:notenoughmoney')
AddEventHandler('carwash:notenoughmoney', function(moneyleft)
	msg = "~h~~r~not enough money $" .. moneyleft .. ""
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)

RegisterNetEvent('carwash:free')
AddEventHandler('carwash:free', function()
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
	msg = "Vehicle ~y~Wash~s~ free!"
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)
