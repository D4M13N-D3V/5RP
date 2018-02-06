RegisterNetEvent("VEM:Title")
AddEventHandler("VEM:Title", function(title)
	Menu.Title(title)
end)

RegisterNetEvent("VEM:Option")
AddEventHandler("VEM:Option", function(option, cb)
	cb(Menu.Option(option))
end)

RegisterNetEvent("VEM:Bool")
AddEventHandler("VEM:Bool", function(option, bool, cb)
	Menu.Bool(option, bool, function(data)
		cb(data)
	end)
end)

RegisterNetEvent("VEM:Update")
AddEventHandler("VEM:Update", function()
	Menu.updateSelection()
end)

local ExtraCount = 0
local extra = {}
local menu = false

Citizen.CreateThread(function()
	
	while true do
	
		local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)

		if IsControlJustPressed(0, 168) then
			if not menu then
				if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
					menu = true
				else
					drawNotification("~r~You have to be the driver of a vehicle to use this Menu.")
				end
			elseif menu then
				menu = false
			end
		end
		
		if menu then
			if IsDisabledControlJustPressed(1, 177) or not (IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1))) then
				menu = false
			end
		end

		if (menu) then
			TriggerEvent("VEM:Title", "~y~~bold~Vehicle Extra Menu")
			
			if ExtraCount == 0 then
				TriggerEvent("VEM:Option", "Your Vehicle has no Extras", function(cb)
					if(cb) then
						drawNotification("Your Vehicle has no Extras!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "Your Vehicle has ~y~" .. ExtraCount .. " ~s~Extras", function(cb)
					if(cb) then
						drawNotification("Your Vehicle has ~y~" .. ExtraCount .. " ~s~Extras!")
					end
				end)
			end
			
			if (DoesExtraExist(playerVeh, 1) == 1) then
				TriggerEvent("VEM:Bool", "Extra 1", extra[1], function(cb)
					extra[1] = cb
					if extra[1] then
						SetVehicleExtra(playerVeh, 1, false)
						drawNotification("~g~Extra 1 Enabled!")
					else
						SetVehicleExtra(playerVeh, 1, true)
						drawNotification("~r~Extra 1 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 1 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 1 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 2) == 1) then
				TriggerEvent("VEM:Bool", "Extra 2", extra[2], function(cb)
					extra[2] = cb
					if extra[2] then
						SetVehicleExtra(playerVeh, 2, false)
						drawNotification("~g~Extra 2 Enabled!")
					else
						SetVehicleExtra(playerVeh, 2, true)
						drawNotification("~r~Extra 2 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 2 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 2 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 3) == 1) then
				TriggerEvent("VEM:Bool", "Extra 3", extra[3], function(cb)
					extra[3] = cb
					if extra[3] then
						SetVehicleExtra(playerVeh, 3, false)
						drawNotification("~g~Extra 3 Enabled!")
					else
						SetVehicleExtra(playerVeh, 3, true)
						drawNotification("~r~Extra 3 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 3 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 3 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 4) == 1) then
				TriggerEvent("VEM:Bool", "Extra 4", extra[4], function(cb)
					extra[4] = cb
					if extra[4] then
						SetVehicleExtra(playerVeh, 4, false)
						drawNotification("~g~Extra 4 Enabled!")
					else
						SetVehicleExtra(playerVeh, 4, true)
						drawNotification("~r~Extra 4 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 4 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 4 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 5) == 1) then
				TriggerEvent("VEM:Bool", "Extra 5", extra[5], function(cb)
					extra[5] = cb
					if extra[5] then
						SetVehicleExtra(playerVeh, 5, false)
						drawNotification("~g~Extra 5 Enabled!")
					else
						SetVehicleExtra(playerVeh, 5, true)
						drawNotification("~r~Extra 5 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 5 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 5 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 6) == 1) then
				TriggerEvent("VEM:Bool", "Extra 6", extra[6], function(cb)
					extra[6] = cb
					if extra[6] then
						SetVehicleExtra(playerVeh, 6, false)
						drawNotification("~g~Extra 6 Enabled!")
					else
						SetVehicleExtra(playerVeh, 6, true)
						drawNotification("~r~Extra 6 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 6 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 6 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 7) == 1) then
				TriggerEvent("VEM:Bool", "Extra 7", extra[7], function(cb)
					extra[7] = cb
					if extra[7] then
						SetVehicleExtra(playerVeh, 7, false)
						drawNotification("~g~Extra 7 Enabled!")
					else
						SetVehicleExtra(playerVeh, 7, true)
						drawNotification("~r~Extra 7 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 7 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 7 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 8) == 1) then
				TriggerEvent("VEM:Bool", "Extra 8", extra[8], function(cb)
					extra[8] = cb
					if extra[8] then
						SetVehicleExtra(playerVeh, 8, false)
						drawNotification("~g~Extra 8 Enabled!")
					else
						SetVehicleExtra(playerVeh, 8, true)
						drawNotification("~r~Extra 8 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 8 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 8 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 9) == 1) then
				TriggerEvent("VEM:Bool", "Extra 9", extra[9], function(cb)
					extra[9] = cb
					if extra[9] then
						SetVehicleExtra(playerVeh, 9, false)
						drawNotification("~g~Extra 9 Enabled!")
					else
						SetVehicleExtra(playerVeh, 9, true)
						drawNotification("~r~Extra 9 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 9 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 9 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 10) == 1) then
				TriggerEvent("VEM:Bool", "Extra 10", extra[10], function(cb)
					extra[10] = cb
					if extra[10] then
						SetVehicleExtra(playerVeh, 10, false)
						drawNotification("~g~Extra 10 Enabled!")
					else
						SetVehicleExtra(playerVeh, 10, true)
						drawNotification("~r~Extra 10 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 10 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 10 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 11) == 1) then
				TriggerEvent("VEM:Bool", "Extra 11", extra[11], function(cb)
					extra[11] = cb
					if extra[11] then
						SetVehicleExtra(playerVeh, 11, false)
						drawNotification("~g~Extra 11 Enabled!")
					else
						SetVehicleExtra(playerVeh, 11, true)
						drawNotification("~r~Extra 11 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 11 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 11 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 12) == 1) then
				TriggerEvent("VEM:Bool", "Extra 12", extra[12], function(cb)
					extra[12] = cb
					if extra[12] then
						SetVehicleExtra(playerVeh, 12, false)
						drawNotification("~g~Extra 12 Enabled!")
					else
						SetVehicleExtra(playerVeh, 12, true)
						drawNotification("~r~Extra 12 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 12 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 12 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 13) == 1) then
				TriggerEvent("VEM:Bool", "Extra 13", extra[13], function(cb)
					extra[13] = cb
					if extra[13] then
						SetVehicleExtra(playerVeh, 13, false)
						drawNotification("~g~Extra 13 Enabled!")
					else
						SetVehicleExtra(playerVeh, 13, true)
						drawNotification("~r~Extra 13 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 13 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 13 Not Existing!")
					end
				end)
			end

			if (DoesExtraExist(playerVeh, 14) == 1) then
				TriggerEvent("VEM:Bool", "Extra 14", extra[14], function(cb)
					extra[14] = cb
					if extra[14] then
						SetVehicleExtra(playerVeh, 14, false)
						drawNotification("~g~Extra 14 Enabled!")
					else
						SetVehicleExtra(playerVeh, 14, true)
						drawNotification("~r~Extra 14 Disabled!")
					end
				end)
			else
				TriggerEvent("VEM:Option", "~r~Extra 14 Not Existing!", function(cb)
					if (cb) then
						drawNotification("~r~Extra 14 Not Existing!")
					end
				end)
			end

			TriggerEvent("VEM:Update")
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function() --Disables Controls Used In The Trainer, When Trainer Is Active
	while true do
		Citizen.Wait(1)
		if menu then
			DisableControlAction(1, 20, true)
			DisableControlAction(1, 21, true)
			DisableControlAction(1, 45, true)
			DisableControlAction(1, 73, true)
			DisableControlAction(1, 74, true)
			DisableControlAction(1, 76, true)
			DisableControlAction(1, 80, true)
			DisableControlAction(1, 85, true)
			DisableControlAction(1, 99, true)
			DisableControlAction(1, 114, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 172, true)
			DisableControlAction(1, 173, true)
			DisableControlAction(1, 174, true)
			DisableControlAction(1, 175, true)
			DisableControlAction(1, 176, true)
			DisableControlAction(1, 177, true)
			DisableControlAction(1, 178, true)
			DisableControlAction(1, 179, true)
		end
	end
end)

Citizen.CreateThread(function() --Disables Trainer When In Pausemenu
	while true do
		Citizen.Wait(0)
		local CF = Citizen.InvokeNative(0x2309595AD6145265)
		if (CF == -1171018317) then
			menu = false
		end
	end
end)

Citizen.CreateThread(function() --Gets Extra States
	local bool = true
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			if bool then
				for i = 1, 14 do
					if DoesExtraExist(GetVehiclePedIsIn(GetPlayerPed(-1), false), i) == 1 then
						ExtraCount = ExtraCount + 1
						if (IsVehicleExtraTurnedOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), i) == 1) then
							extra[i] = true
						else
							extra[i] = false
						end
					end
				end
				bool = false
			end
		else
			bool = true
			ExtraCount = 0
		end
	end
end)

function drawNotification(text) --Just Don't Edit!
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

