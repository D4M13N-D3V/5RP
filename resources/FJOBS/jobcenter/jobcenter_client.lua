	job_menu = false	
	function metier_callSE(id)
		job_menu = false
		TriggerServerEvent("js:jobs", id)
	end
	
	function menuJobsUnemployed()
		local MenujobsList = {
			{name="Pharmacist", id=3},
			{name="Farmer", id=6},
			{name="Lumberjack", id=7},
			{name="Miner", id=9},
			{name="Fisher", id=10},
			{name="Brewer", id=12},
			{name="Vigneron", id=13},
        	{name="Courier", id=19},
            {name="Pool Cleaner", id=20}, 
        	{name="Garbage Collector", id=21},
        	{name="Tow", id=22},
		}
	    Menu.SetupMenu("jobcenter_menu","Job Center")
	    Menu.Switch(nil,"jobcenter_menu")
		for _, item in pairs(MenujobsList) do
		    Menu.addOption("jobcenter_menu", function()
		        if(Menu.Option(item.name))then
		        	metier_callSE(item.id)
		        end
		    end)
		end
	end

	function menuJobs()
		local MenujobsList = {
			{name="To Resign", id=1}
		}
	    Menu.SetupMenu("jobcenter_menu","Job Center")
	    Menu.Switch(nil,"jobcenter_menu")
		for _, item in pairs(MenujobsList) do
		    Menu.addOption("jobcenter_menu", function()
		        if(Menu.Option(item.name))then
		        	metier_callSE(item.id)
		        end
		    end)
		end
	end
	
	function IsNearPlaces()
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), 0)
		for _, item in pairs(job_blips) do
			if(GetDistanceBetweenCoords(item.x, item.y, item.z, playerCoords["x"], playerCoords["y"], playerCoords["z"], true) <= item.distanceBetweenCoords) then
				DrawMarker(27, item.x, item.y, item.z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
				return true
			end
		end
	end

	function DisplayHelpText(str)
		SetTextComponentFormat("STRING")
		AddTextComponentString(str)
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	end

	RegisterNetEvent('js:defineJobMenu')
	AddEventHandler('js:defineJobMenu', function(jobId)
		job_menu = not job_menu
		if jobId == 1 then
			menuJobsUnemployed()
		else  	
			menuJobs()
		end
	end)
	
	RegisterNetEvent('js:getmyjob')
	AddEventHandler('js:getmyjob', function(id)
		TriggerServerEvent("js:jobs", id)
	end)
	
	RegisterNetEvent('js:updateJob')
	AddEventHandler('js:updateJob', function(nameJob)
		local id = PlayerId()
		local playerName = GetPlayerName(id)
		local policerank = exports.policejob.getPoliceRank()
		local paramedicrank = exports.emsjob.getParamedicRank()
		SendNUIMessage({
			updateJob = true,
			job = nameJob,
			poporank = policerank,
			pararank = paramedicrank,
			player = playerName
		})
	end)
	
	Citizen.CreateThread( function()	
		for key, item in pairs(job_blips) do
			local blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(blip, item.id)
			SetBlipScale(blip, 0.8)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(key)
			EndTextCommandSetBlipName(blip)
		end
		while true do
			Citizen.Wait(2)	
			if (IsNearPlaces() == true) then				
				DisplayHelpText("Press ~INPUT_CONTEXT~ view jobs!")
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent('js:isUnemployed')
				end
		        if job_menu then
		        	brewer_menu = false
		        	farmer_menu = false
		        	fishing_menu = false
		        	lumberjack_menu = false
		        	miner_menu = false
		        	wine_menu = false
		            Menu.DisplayCurMenu()
		        end
			end
		end
	end)
	
    RegisterNetEvent("es_freeroam:notify")
    AddEventHandler("es_freeroam:notify", function(icon, type, sender, title, text)
      Citizen.CreateThread(function()
        Wait(1)
        SetNotificationTextEntry("STRING");
        AddTextComponentString(text);
        SetNotificationMessage(icon, icon, true, type, sender, title, text);
        DrawNotification(false, true);
      end)
    end)

RegisterNetEvent('js:pause')
AddEventHandler('js:pause', function(pause)
	if pause then
        SendNUIMessage({
            setDisplay = true,
            display = 0.0,
        })
    else
        SendNUIMessage({
            setDisplay = true,
            display = 1.0,
        })
    end
end)