RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        SetPlayerWantedLevel(PlayerId(), 0, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
	end
end)

--Disable melee when a weapon is out
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedArmed(PlayerPedId(), 6) then
	    	DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)

--Weapon drop
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
			local ped = PlayerPedId()
			local wep = GetSelectedPedWeapon(ped)
			SetPedDropsWeaponsWhenDead(ped, true)
			RequestAnimDict("mp_weapon_drop")
			if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) and not IsPauseMenuActive() and IsPedArmed(ped, 7) and IsControlJustPressed(1, 56) then -- INPUT_DROP_WEAPON (F9)
			TaskPlayAnim(ped, "mp_weapon_drop", "drop_bh", 8.0, 2.0, -1, 0, 2.0, 0, 0, 0 )
			SetPedDropsInventoryWeapon(ped, wep, 0, 2.0, 0, -1)
			SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
			ShowNotification("~r~Weapon Dropped")
        end
    end
end)

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end