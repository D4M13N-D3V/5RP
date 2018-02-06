Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            veh = GetVehiclePedIsUsing(PlayerPedId())
            angle = GetVehicleSteeringAngle(veh)
            veh2 = GetPlayersLastVehicle()
            sped = GetEntitySpeed(veh)
            Citizen.Wait(5)
            if sped <= 25 then
                SetVehicleSteeringAngle(veh2, angle)
            end
        end
    end
end)
