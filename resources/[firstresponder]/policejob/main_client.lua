isCop = false
isInService = false
rank = ""
existingVeh = nil
blipsCops = {}
allServiceCops = {}
settings = {
	force = "LAPD", --AST,NYPD,LAPD
}

local weaponUnracked = false
local weaponUnrackedNumber = 0;




RegisterNetEvent("police:unrack")
AddEventHandler("police:unrack", function(weapon)
	local ply = GetPlayerPed(-1)
	local veh = GetVehiclePedIsUsing(ply)
	if GetVehicleClass(veh) == 18 and not weaponUnracked then
		if(weapon==1)then
			GiveWeaponToPed(GetPlayerPed(-1), "WEAPON_PUMPSHOTGUN", 350, true, true)
			GiveWeaponComponentToPed(GetPlayerPed(-1), "WEAPON_PUMPSHOTGUN", "COMPONENT_AT_AR_FLSH")
			weaponUnracked=true
			weaponUnrackedNumber = 1
			TriggerEvent("pNotify:SendNotification", {
				text = "You have un-racked your shotgun.",
				type = "success",
				timeout = 10000,
				layout = "centerRight",
				queue = "right"
			})
		elseif(weapon==2)then
			GiveWeaponToPed(GetPlayerPed(-1), "WEAPON_CARBINERIFLE", 350, true, true)
			GiveWeaponComponentToPed(GetPlayerPed(-1), "WEAPON_CARBINERIFLE", "COMPONENT_AT_SCOPE_MEDIUM")
			weaponUnracked=true
			weaponUnrackedNumber = 2
			TriggerEvent("pNotify:SendNotification", {
				text = "You have un-racked your M4A4.",
				type = "success",
				timeout = 10000,
				layout = "centerRight",
				queue = "right"
			})
		elseif(weapon==3)then
			GiveWeaponToPed(GetPlayerPed(-1), "WEAPON_SNIPERRIFLE", 350, true, true)
			GiveWeaponComponentToPed(GetPlayerPed(-1), "WEAPON_SNIPERRIFLE", "COMPONENT_AT_SCOPE_LARGE")
			weaponUnracked=true
			weaponUnrackedNumber = 3
			TriggerEvent("pNotify:SendNotification", {
				text = "You have un-racked your M24.",
				type = "success",
				timeout = 10000,
				layout = "centerRight",
				queue = "right"
			})
		elseif(weapon==4)then
			GiveWeaponToPed(GetPlayerPed(-1), "WEAPON_SMG", 350, true, true)
			GiveWeaponComponentToPed(GetPlayerPed(-1), "WEAPON_SMG", "COMPONENT_AT_AR_FLSH")
			weaponUnracked=true
			weaponUnrackedNumber = 4
			TriggerEvent("pNotify:SendNotification", {
				text = "You have un-racked your MP5.",
				type = "success",
				timeout = 10000,
				layout = "centerRight",
				queue = "right"
			})
		end
	end
end)

RegisterNetEvent("police:rack")
AddEventHandler("police:rack", function()
	local ply = GetPlayerPed(-1)
	local veh = GetVehiclePedIsUsing(ply)
	if GetVehicleClass(veh) == 18 and weaponUnracked then
		if(weaponUnrackedNumber==1)then
			weaponUnracked=false
			RemoveWeaponFromPed( GetPlayerPed(-1),"WEAPON_PUMPSHOTGUN")
			TriggerEvent("pNotify:SendNotification", {
				text = "You have re-racked your shotgun.",
				type = "success",
				timeout = 10000,
				layout = "centerRight",
				queue = "right"
			})
		elseif(weaponUnrackedNumber==2)then
			weaponUnracked=false
			TriggerEvent("pNotify:SendNotification", {
				text = "You have re-racked your M4A4.",
				type = "success",
				timeout = 10000,
				layout = "centerRight",
				queue = "right"
			})
		elseif(weaponUnrackedNumber==3)then
			weaponUnracked=false
			RemoveWeaponFromPed( GetPlayerPed(-1),"WEAPON_SNIPERRIFLE")
			TriggerEvent("pNotify:SendNotification", {
				text = "You have re-racked your M24.",
				type = "success",
				timeout = 10000,
				layout = "centerRight",
				queue = "right"
			})
		elseif(weaponUnrackedNumber==4)then
			weaponUnracked=false
			RemoveWeaponFromPed( GetPlayerPed(-1),"WEAPON_SMG")
			TriggerEvent("pNotify:SendNotification", {
				text = "You have re-racked your MP5.",
				type = "success",
				timeout = 10000,
				layout = "centerRight",
				queue = "right"
			})
		end
	end
end)



RegisterNetEvent("runPlateCommand")
AddEventHandler("runPlateCommand", function(plate)
			if(plate)then
				TriggerServerEvent("police:checkingPlate", plate)
			else
				local pos = GetEntityCoords(GetPlayerPed(-1))
				local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
				local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
				local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
				if(DoesEntityExist(vehicleHandle)) then
					local isRental = DecorGetBool(vehicleHandle, "isRental")
					if isRental then
						exports.pNotify:SendNotification({text = "This vehicle belongs to Escalera, Rent-a-Car!",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})
					else
						TriggerServerEvent("police:checkingPlate", GetVehicleNumberPlateText(vehicleHandle))
					end
				else
					Messages(1)
				end 
			end
end)


RegisterNetEvent("readPlateCommand")
AddEventHandler("readPlateCommand", function()
			print("test")
			print("test")
			local pos = GetEntityCoords(GetPlayerPed(-1))
			local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

			local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
			local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
			if(DoesEntityExist(vehicleHandle)) then
				exports.pNotify:SendNotification({text = "You press the button on your plate reader, it shows '"..GetVehicleNumberPlateText(vehicleHandle).."'",type = "error",queue = "left",timeout = 25000,layout = "centerRight"})
			else
				Messages(1)
			end 
end)

-- Location to enable an officer service
local takingService = {
	{name="Police Station", id = 60, colour = 28, x=457.956909179688, y=-992.72314453125, z=30.9},  -- Mission Row
	{name="Police Station", id = 60, colour = 28, x=-449.90, y=6016.22, z= 31.72}, -- Paleto Bay
	{name="Police Station", id = 60, colour = 28, x=1857.01, y=3689.50, z=34.27}, -- Sandy Shores
	{name="Police Station", id = 60, colour = 28, x=-1113.65, y=-849.21, z=13.8}, -- San Andreas Ave
	{name="Police Station", id = 60, colour = 28, x=-561.28, y=-132.60, z=38.04}, -- Rockford Hills
}
local inamount = 0

RegisterNetEvent('police:activate')
AddEventHandler('police:activate', function(r)
	print("Im a cop")
	isCop = true
	rank = r
end)

RegisterNetEvent('police:nowCop')
AddEventHandler('police:nowCop', function(r)
	print("Im a cop")
	TriggerServerEvent("js:jobs", 2)
	isCop = true
	rank = r
end)

RegisterNetEvent('police:noLongerCop')
AddEventHandler('police:noLongerCop', function()
	isCop = false
	isInService = false
	TriggerServerEvent("js:jobs", 1)
	TriggerServerEvent("police:setService", isInService)
	TriggerServerEvent("police:breakService")
	BlipRemoval()
 	RemoveAllPedWeapons(GetPlayerPed(-1), true)
	TriggerServerEvent("clothes:spawn")
	if(existingVeh ~= nil) then
		SetEntityAsMissionEntity(existingVeh, true, true)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
		existingVeh = nil
	end
end)

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawThisTxt(x,y ,width,height,scale, text, r,g,b,a,font)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function getIsInService()
	return isInService
end

function getIsCuffed()
	return handCuffed
end

function getPoliceRank()
	return rank
end

function isNearTakeService()
	for i = 1, #takingService do
		local pos = GetEntityCoords(GetPlayerPed(-1), 0)
		local distance = GetDistanceBetweenCoords(takingService[i].x, takingService[i].y, takingService[i].z, pos.x, pos.y, pos.z, true)
		if(distance < 30) then
			DrawMarker(27, takingService[i].x, takingService[i].y, takingService[i].z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 128, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

function isUseraCop()
    return isCop
end

Citizen.CreateThread(function()
    for _, item in pairs(takingService) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, item.colour)
      SetBlipScale(item.blip, 0.8)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
    while true do
        Citizen.Wait(0)
        if(isCop) then
			if(isNearTakeService()) then
				if(isInService) then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~r~off duty~w~.")
				else
					DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~g~on duty~w~.")
				end
				if IsControlJustReleased(1, 38)  then
					isInService = not isInService
					TriggerServerEvent("police:setService", isInService)
					
					if(isInService) then
						TriggerServerEvent("police:loadclothing")
						TriggerServerEvent("police:takeService")
						AddPoliceBlips()
					else
						RemoveAllPedWeapons(GetPlayerPed(-1), true)
						TriggerServerEvent("clothes:spawn")
						TriggerServerEvent("police:breakService")
						RemovePoliceBlips()
						BlipRemoval()
					end
				end
			end
			if(isInService) then
				inamount = 0.03
				drawThisTxt(0.286, 0.935, 0.25, 0.03, 0.50,MissionInformation,255,255,255,255,6)
			end			
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if CopCallStatus ~= 0 then
            if CopCallStatus == 1 then
                drawThisTxt(0.286, 0.935 - inamount, 0.25, 0.03, 0.50,'~g~A unit will arrive at the location of the call',255,255,255,255,6)
            else 
                if activeCops == 0 then
                    drawThisTxt(0.286, 0.935 - inamount, 0.25, 0.03, 0.50,'~r~No police officers in service',255,255,255,255,6)
                elseif availableCops == 0 then
                    drawThisTxt(0.286, 0.935 - inamount, 0.25, 0.03, 0.50,'~o~All our units are occupied',255,255,255,255,6)
                else
                    drawThisTxt(0.286, 0.935 - inamount, 0.25, 0.03, 0.50,'~b~Your call is on hold',255,255,255,255,6)
                end
            end 
        end
    end
end)

function NotInService()
    isInService = false
    TriggerServerEvent("police:setService", isInService)
	RemoveAllPedWeapons(GetPlayerPed(-1), true)
	TriggerServerEvent("clothes:spawn")
	TriggerServerEvent("police:breakService")
   	BlipRemoval()
end

RegisterNetEvent('emergency:forceRespawn')
AddEventHandler('emergency:forceRespawn', function()
	if(isCop and isInService) then
		NotInService()
	end
		
	if(handCuffed == true) then
		handCuffed = false
	end
end)

function enableCopBlips()

	for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
	blipsCops = {}
	
	local localIdCops = {}
	for id = 0, 64 do
		if(NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
			for i,c in pairs(allServiceCops) do
				if(i == GetPlayerServerId(id)) then
					localIdCops[id] = c
					break
				end
			end
		end
	end
	
	for id, c in pairs(localIdCops) do
		local ped = GetPlayerPed(id)
		local blip = GetBlipFromEntity(ped)
		
		if not DoesBlipExist( blip ) then

			blip = AddBlipForEntity( ped )
			SetBlipSprite( blip, 1 )
			Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			HideNumberOnBlip( blip )
			SetBlipNameToPlayerName( blip, id )
			
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 255 )
			SetBlipColour( blip, 38 )
			
			table.insert(blipsCops, blip)
		else
			
			blipSprite = GetBlipSprite( blip )
			
			HideNumberOnBlip( blip )
			if blipSprite ~= 1 then
				SetBlipSprite( blip, 1 )
				Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			end
			
			Citizen.Trace("Name : "..GetPlayerName(id))
			SetBlipNameToPlayerName( blip, id )
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 225 )
			SetBlipColour( blip, 38 )
			
			table.insert(blipsCops, blip)
		end
	end
end

function BlipRemoval()
	allServiceCops = {}
	
	for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
	blipsCops = {}
end

RegisterNetEvent('police:resultAllCopsInService')
AddEventHandler('police:resultAllCopsInService', function(array)
	allServiceCops = array
	enableCopBlips()
end)

function AddPoliceBlips()
	ClothingBlips()
	ArmouryBlips()
	GarageBlips()
end

function RemovePoliceBlips()
	RemoveClothingBlips()
	RemoveArmouryBlips()
	RemoveGarageBlips()
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
    RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
    RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
  end
end)
