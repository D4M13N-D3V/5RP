local stationGarage = {
    {x=452.115966796875, y=-1018.10681152344, z=28.9}, -- Mission row
    {x=-457.88, y=6024.79, z=31.8}, -- Paleto Bay
    {x=1866.84, y=3697.15, z=33.9}, -- Sandy Shores
    {x=-1068.95, y=-859.73, z=5.2}, -- San Andreas Ave
    {x=-570.28, y=-145.50, z=37.79}, -- Rockford Hills
}

local stationHeliGarage = {
    {x=449.150207519531, y=-981.246459960938, z=43.9}, -- Mission row
    {x=-475.33, y=5988.55, z=31.9}, -- Paleto Bay
    {x=1770.2397460938, y=3239.8703613281, z=42.5}, -- Sandy Shores
    {x=-1051.86, y=-855.40, z=5.2}, -- San Andreas Ave
}

car_menu = false
heli_menu = false
cars = {}

if settings.force == "AST" then
    --AST
    cars = {       -- {"2011 CVPI", {model="police",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"2016 Charger", {model="police2",type=""},{"city cadet", "city officer","city senior officer","city sergeant","city deputy chief","city chief","county recruit","county deputy","county senior deputy","county sergeant","county colonel","county undersheriff","county sheriff","state trooper","state senior trooper","state corporal","state sergeant","state captain","state major","state commisioner of state","doj"}},
		{"Supervisor Charger", {model="sheriffblue",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
		{"Supervisor Tahoe", {model="sheriff2blue",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
		{"Police Explorer", {model="pd4",type=""},{"doj"}},
        {"Police Explorer 2", {model="pd5",type=""},{"doj"}},
        {"2015 Police Mustang", {model="2015polstang",type=""},{"city chief","doj","county sheriff", "state commisioner of state"}},
        {"2013 Explorer", {model="police5",type=""},{"city cadet", "city officer","city senior officer","city sergeant","city deputy chief","city chief","county recruit","county deputy","county senior deputy","county sergeant","county colonel","county undersheriff","county sheriff","state trooper","state senior trooper","state corporal","state sergeant","state captain","state major","state commisioner of state","doj"}},
        {"UM CVPI", {model="Police4",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        {"police F350", {model="pd6",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        {"police Silverado", {model="pd7",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        {"2008 Tahoe S/T", {model="Police6",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        -- {"FBI", {model="police7",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Chevy Impala", {model="police8",type=""},{"city cadet", "city officer","city senior officer","city sergeant","city deputy chief","city chief","county recruit","county deputy","county senior deputy","county sergeant","county colonel","county undersheriff","county sheriff","state trooper","state senior trooper","state corporal","state sergeant","state captain","state major","state commisioner of state","doj"}},
        -- {"2014 Charger", {model="sheriff",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"2008 Tahoe 2", {model="sheriff2",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"2011 CVPI 2", {model="sheriff3",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"CHP CVPI Vector Lightar", {model="hwaycar2",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"CHP 2011 Charger Vector lightbar", {model="hwaycar3",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
		-- {"Police SUV", {model="hwaycar",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
		{"2014 UM Charger", {model="fbi",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        {"2008 Tahoe UM", {model="fbi2",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
       	--{"Unmarked Tahoe", {model="psubby16",type="undercover"},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
    }
elseif settings.force == "LAPD" then
    --LAPD
    cars = {
       -- {"2011 CVPI", {model="police",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"2016 Charger", {model="police2",type=""},{"city cadet","city officer","city senior officer","city sergeant","city deputy chief","city chief","county recruit","county deputy","county senior deputy","county sergeant","county colonel","county undersheriff","county sheriff","state trooper","state senior trooper","state corporal","state sergeant","state captain","state major","state commisioner of state","doj"}},
		{"Supervisor Charger", {model="sheriffblue",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
		{"Supervisor Tahoe", {model="sheriff2blue",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}}, {"Police Explorer", {model="pd4",type=""},{"doj"}},
        {"Police Explorer 2", {model="pd5",type=""},{"doj"}},
        {"2015 Police Mustang", {model="2015polstang",type=""},{"city police","doj","county sheriff", "state commisioner of state"}},
        {"2013 Explorer", {model="police5",type=""},{"city cadet","city officer","city senior officer","city sergeant","city deputy chief","city chief","county recruit","county deputy","county senior deputy","county sergeant","county colonel","county undersheriff","county sheriff","state trooper","state senior trooper","state corporal","state sergeant","state captain","state major","state commisioner of state","doj"}},
        {"UM CVPI", {model="Police4",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        {"police F350", {model="pd6",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        {"police Silverado", {model="pd7",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state","doj"}},
        {"2008 Tahoe S/T", {model="Police6",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state","doj"}},
        -- {"FBI", {model="police7",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Chevy Impala", {model="police8",type=""},{"city cadet","city officer","city senior officer","city sergeant","city deputy chief","city chief","county recruit","county deputy","county senior deputy","county sergeant","county colonel","county undersheriff","county sheriff","state trooper","state senior trooper","state corporal","state sergeant","state captain","state major","state commisioner of state","doj"}},
        -- {"2014 Charger", {model="sheriff",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"2008 Tahoe 2", {model="sheriff2",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"2011 CVPI 2", {model="sheriff3",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"CHP CVPI Vector Lightar", {model="hwaycar2",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"CHP 2011 Charger Vector lightbar", {model="hwaycar3",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
		-- {"Police SUV", {model="hwaycar",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
		{"2014 UM Charger", {model="fbi",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        {"2008 Tahoe UM", {model="fbi2",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
       	--{"Unmarked Tahoe", {model="psubby16",type="undercover"},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
		
    }
elseif settings.force == "NYPD" then
    --NYPD
    cars = {       -- {"2011 CVPI", {model="police",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
		{"Supervisor Charger", {model="sheriffblue",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
		{"Supervisor Tahoe", {model="sheriff2blue",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
		{"2016 Charger", {model="police2",type=""},{"city cadet","city officer","city senior officer","city sergeant","city deputy chief","city chief","county recruit","county deputy","county senior deputy","county sergeant","county colonel","county undersheriff","county sheriff","state trooper","state senior trooper","state corporal","state sergeant","state captain","state major","state commisioner of state","doj"}},
        {"Police Explorer", {model="pd4",type=""},{"doj"}},
        {"Police Explorer 2", {model="pd5",type=""},{"doj"}},
        {"2015 Police Mustang", {model="2015polstang",type=""},{"city police","doj","county sheriff", "state commisioner of state"}},
        {"2013 Explorer", {model="police5",type=""},{"city cadet","city officer","city senior officer","city sergeant","city deputy chief","city chief","county recruit","county deputy","county senior deputy","county sergeant","county colonel","county undersheriff","county sheriff","state trooper","state senior trooper","state corporal","state sergeant","state captain","state major","state commisioner of state","doj"}},
        {"UM CVPI", {model="Police4",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        {"police F350", {model="pd6",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        {"police Silverado", {model="pd7",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        {"2008 Tahoe S/T", {model="Police6",type=""},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        -- {"FBI", {model="police7",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Chevy Impala", {model="police8",type=""},{"city cadet","city officer","city senior officer","city sergeant","city deputy chief","city chief","county recruit","county deputy","county senior deputy","county sergeant","county colonel","county undersheriff","county sheriff","state trooper","state senior trooper","state corporal","state sergeant","state captain","state major","state commisioner of state","doj"}},
        -- {"2014 Charger", {model="sheriff",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"2008 Tahoe 2", {model="sheriff2",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"2011 CVPI 2", {model="sheriff3",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"CHP CVPI Vector Lightar", {model="hwaycar2",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        -- {"CHP 2011 Charger Vector lightbar", {model="hwaycar3",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
		-- {"Police SUV", {model="hwaycar",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
		{"2014 UM Charger", {model="fbi",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
        {"2008 Tahoe UM", {model="fbi2",type=""},{"doj","city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
       	--{"Unmarked Tahoe", {model="psubby16",type="undercover"},{"city sergeant","city deputy chief","city chief","county sergeant","county colonel","county undersheriff","county sheriff","state sergeant","state captain","state major","state commisioner of state"}},
    }
end

heli = {
    {settings.force.." Chopper",{model="polmav",type="helicopter"},{"sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
}

function isNearStationGarage()
    for i = 1, #stationGarage do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(stationGarage[i].x, stationGarage[i].y, stationGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 30) then
            DrawMarker(27, stationGarage[i].x, stationGarage[i].y, stationGarage[i].z-1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 0, 128, 255, 155, 0, 0, 2, 0, 0, 0, 0)
            if(distance < 2) then
                return true
            elseif distance > 2 then
                car_menu = false
            end
        end
    end
end

function isNearStationHeliGarage()
    for i = 1, #stationHeliGarage do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(stationHeliGarage[i].x, stationHeliGarage[i].y, stationHeliGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 30) then
            DrawMarker(27, stationHeliGarage[i].x, stationHeliGarage[i].y, stationHeliGarage[i].z-1, 0, 0, 0, 0, 0, 0, 9.0, 9.0, 2.5, 0, 128, 255, 155, 0, 0, 2, 0, 0, 0, 0)
            if(distance < 7) then
                return true
            elseif distance > 7 then
                heli_menu = false
            end
        end
    end
end

function carmenu()
    Menu.SetupMenu("car_menu","Police garage")
    Menu.Switch(nil,"car_menu")
    for k,v in pairs(cars) do
    	for i = 1,#cars[k][3] do
	        if v[3][i] == rank then
	            Menu.addOption("car_menu", function()
	                if(Menu.Option(v[1]))then
	                    spawncar(v[2])
	                end
	            end)
	        end
	    end
    end
end

function helimenu()
    Menu.SetupMenu("heli_menu","Heli garage")
    Menu.Switch(nil,"heli_menu")
    for k,v in pairs(heli) do
    	for i = 1,#cars[k][3] do
	        if v[3][i] == rank then
	            Menu.addOption("heli_menu", function()
	                if(Menu.Option(v[1]))then
	                    spawncar(v[2])
	                end
	            end)
	        end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isCop) then
            if(isInService) then
                if(isNearStationGarage()) then
                    if(existingVeh == nil) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~collect your cruiser~w~!")
                    else
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~store your cruiser~w~!")
                    end
        
                    if IsControlJustPressed(1, 38)  then
                        if(existingVeh ~= nil) then
                            SetEntityAsMissionEntity(existingVeh, true, true)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
                            existingVeh = nil
                        else
                            GUI.maxVisOptions = 10; GUI.titleText = {255, 0, 0, 255, 1}; GUI.titleRect = {0, 0, 0, 255}; GUI.optionText = {255, 0, 0, 255, 6}; GUI.optionRect = {0, 0, 0, 190}; GUI.scroller = {50, 50, 50, 255}; titleTextSize = {0.85, 0.80}; titleRectSize = {0.16, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.16, 0.035}; menuX = 0.75; menuXOption = 0.075; menuXOtherOption = 0.050; menuYModify = 0.3000; menuYOptionDiv = 8.56; menuYOptionAdd = 0.36;
                            carmenu() -- Menu to draw
                            car_menu = not car_menu                 
                        end
                    end     
                end
                if(isNearStationHeliGarage()) then
                    if(existingVeh ~= nil) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~collect your chopper~w~!")
                    else
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~store your chopper~w~!")
                    end
        
                    if IsControlJustPressed(1, 38)  then
                        if(existingVeh ~= nil) then
                            SetEntityAsMissionEntity(existingVeh, true, true)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
                            existingVeh = nil
                        else
                            GUI.maxVisOptions = 10; GUI.titleText = {255, 0, 0, 255, 1}; GUI.titleRect = {0, 0, 0, 255}; GUI.optionText = {255, 0, 0, 255, 6}; GUI.optionRect = {0, 0, 0, 190}; GUI.scroller = {50, 50, 50, 255}; titleTextSize = {0.85, 0.80}; titleRectSize = {0.16, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.16, 0.035}; menuX = 0.75; menuXOption = 0.075; menuXOtherOption = 0.050; menuYModify = 0.3000; menuYOptionDiv = 8.56; menuYOptionAdd = 0.36;
                            helimenu()
                            heli_menu = not heli_menu                         
                        end
                    end
                end
            end
        end
        if car_menu then
            menuX = 0.75
            heli_menu = false
            cop_menu = false
            armoury_menu = false
            clothing_menu = false
            Menu.DisplayCurMenu()
        end
        if heli_menu then
            menuX = 0.75
            car_menu = false
            cop_menu = false
            armoury_menu = false
            clothing_menu = false
            Menu.DisplayCurMenu()
        end
    end
end)

function spawncar(car)
    local plate = settings.force..math.random(1,999)
    local helicopter = true
    local tint = false
    if car.type == "helicopter" or car.type == "heli" then
        helicopter = true
    elseif car.type == "undercover" then
        tint = true
        plate = math.random(00000000,99999999)
    end
    local carhashed = GetHashKey(car.model)
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    RequestModel(carhashed)
    while not HasModelLoaded(carhashed) do
        Citizen.Wait(0)
    end
                            
    existingVeh = CreateVehicle(carhashed, plyCoords["x"], plyCoords["y"], plyCoords["z"], 90.0, true, false)
    local id = NetworkGetNetworkIdFromEntity(existingVeh)
    SetNetworkIdCanMigrate(id, true)
    SetVehicleMod(existingVeh, 11, 3)
    SetVehicleMod(existingVeh, 12, 3)
    SetVehicleMod(existingVeh, 13, 3)
    SetVehicleMod(existingVeh, 15, 3)
    SetVehicleMod(existingVeh, 16, 0)
	ToggleVehicleMod(existingVeh, 18, true)
    SetVehicleTyresCanBurst(existingVeh, false)
    SetVehicleNumberPlateText(existingVeh, plate)
	
	if(string.find(rank,"city"))then
		SetVehicleLivery(existingVeh, 0)
	elseif(string.find(rank,"county"))then
		SetVehicleLivery(existingVeh, 1)
	elseif(string.find(rank,"state"))then
		SetVehicleLivery(existingVeh, 2)
	else
		SetVehicleLivery(existingVeh, 0)
	end
	
    if tint then
        SetVehicleWindowTint(existingVeh, 1)
    elseif helicopter then
        SetVehicleLivery(existingVeh, 0)
    else
        SetVehicleWindowTint(existingVeh, 0)
    end
    SetVehicleDirtLevel(existingVeh, 0)
    TaskWarpPedIntoVehicle(ply, existingVeh, -1)
    car_menu = false
    heli_menu = false
end

function GarageBlips()
    for _, item in pairs(stationGarage) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, 50)
      SetBlipColour(item.blip, 18)
      SetBlipScale(item.blip, 0.6)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Police Garages")
      EndTextCommandSetBlipName(item.blip)
    end
    for _, item in pairs(stationHeliGarage) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, 43)
      SetBlipColour(item.blip, 18)
      SetBlipScale(item.blip, 0.6)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Helipads")
      EndTextCommandSetBlipName(item.blip)
    end
end

function RemoveGarageBlips()
    for _, item in pairs(stationGarage) do
        RemoveBlip(item.blip)
    end
    for _, item in pairs(stationHeliGarage) do
        RemoveBlip(item.blip)
    end
end