local isCop = true

function DrawText3d(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.34, 0.34)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent("np-jobmanager:playerBecameJob") -- These need changed
AddEventHandler("np-jobmanager:playerBecameJob", function(job, name, notify) -- These need changed
        if isParamedic and job == "ems" then isInService = false isInservice = false end
        if isCop and job == "police" then isInService = false isInService = false end
        if job == "police" then isCop = true isInService = true end
        if job == "ems" then isParamedic = true isInService = true end
    end)


Citizen.CreateThread(function()
    while true do
        for i = 1, #doorList do
            local playerCoords = GetEntityCoords( GetPlayerPed(-1) )
            local closeDoor = GetClosestObjectOfType(doorList[i]["x"], doorList[i]["y"], doorList[i]["z"], 1.0, GetHashKey(doorList[i]["objName"]), false, false, false)
            
            local objectCoordsDraw = GetEntityCoords( closeDoor )            
            local playerDistance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, doorList[i]["x"], doorList[i]["y"], doorList[i]["z"], true)
                        
            if(playerDistance < 1.4) then
                if exports.emsjob:isUseraParamedic() or exports.policejob:isUseraCop() then
                if doorList[i]["locked"] == true then
                    DrawText3d(doorList[i]["txtX"], doorList[i]["txtY"], doorList[i]["txtZ"], "Unlock")
                else
                    DrawText3d(doorList[i]["txtX"], doorList[i]["txtY"], doorList[i]["txtZ"], "Lock")
                end

                if IsControlJustPressed(1,51) and isCop then
                    if doorList[i]["locked"] == true then
                        if(i==10 or i==11) then
                            doorList[10]["locked"] = false
                            doorList[11]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",10)
							TriggerServerEvent("doorLock-Unlock",11)
                        elseif(i==12 or i==13) then
                            doorList[12]["locked"] = false
                            doorList[13]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",12)
							TriggerServerEvent("doorLock-Unlock",13)
                        elseif(i==14 or i==15) then
                            doorList[14]["locked"] = false
                            doorList[15]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",14)
							TriggerServerEvent("doorLock-Unlock",15)
                        elseif(i==16 or i==17) then
                            doorList[16]["locked"] = false
                            doorList[17]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",16)
							TriggerServerEvent("doorLock-Unlock",17)
                        elseif(i==18 or i==19) then
                            doorList[18]["locked"] = false
                            doorList[19]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",18)
							TriggerServerEvent("doorLock-Unlock",19)
                        elseif(i==20 or i==21) then
                            doorList[20]["locked"] = false
                            doorList[21]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",20)
							TriggerServerEvent("doorLock-Unlock",21)
                        elseif(i==22 or i==23) then
                            doorList[22]["locked"] = false
                            doorList[23]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",22)
							TriggerServerEvent("doorLock-Unlock",23)
                        elseif(i==24 or i==25) then
                            doorList[24]["locked"] = false
                            doorList[25]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",24)
							TriggerServerEvent("doorLock-Unlock",25)
                        elseif(i==26 or i==27) then
                            doorList[26]["locked"] = false
                            doorList[27]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",26)
							TriggerServerEvent("doorLock-Unlock",27)
                        elseif(i==28 or i==29) then
                            doorList[28]["locked"] = false
                            doorList[29]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",28)
							TriggerServerEvent("doorLock-Unlock",29)
                        elseif(i==30) then
                            doorList[30]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",30)
                        else
                            doorList[i]["locked"] = false
							TriggerServerEvent("doorLock-Unlock",i)
                        end
                    else
                        if(i==10 or i==11) then
                            doorList[10]["locked"] = true
                            doorList[11]["locked"] = true
							TriggerServerEvent("doorLock-Lock",10)
							TriggerServerEvent("doorLock-Lock",11)
                        elseif(i==12 or i==13) then
                            doorList[12]["locked"] = true
                            doorList[13]["locked"] = true
							TriggerServerEvent("doorLock-Lock",12)
							TriggerServerEvent("doorLock-Lock",13)
                        elseif(i==14 or i==15) then
                            doorList[14]["locked"] = true
                            doorList[15]["locked"] = true
							TriggerServerEvent("doorLock-Lock",14)
							TriggerServerEvent("doorLock-Lock",15)
                        elseif(i==16 or i==17) then
                            doorList[16]["locked"] = true
                            doorList[17]["locked"] = true
							TriggerServerEvent("doorLock-Lock",16)
							TriggerServerEvent("doorLock-Lock",17)
                        elseif(i==18 or i==19) then
                            doorList[18]["locked"] = true
                            doorList[19]["locked"] = true
							TriggerServerEvent("doorLock-Lock",18)
							TriggerServerEvent("doorLock-Lock",19)
                        elseif(i==20 or i==21) then
                            doorList[20]["locked"] = true
                            doorList[21]["locked"] = true
							TriggerServerEvent("doorLock-Lock",20)
							TriggerServerEvent("doorLock-Lock",21)
                        elseif(i==22 or i==23) then
                            doorList[22]["locked"] = true
                            doorList[23]["locked"] = true
							TriggerServerEvent("doorLock-Lock",22)
							TriggerServerEvent("doorLock-Lock",23)
                        elseif(i==24 or i==25) then
                            doorList[24]["locked"] = true
                            doorList[25]["locked"] = true
							TriggerServerEvent("doorLock-Lock",24)
							TriggerServerEvent("doorLock-Lock",25)
                        elseif(i==26 or i==27) then
                            doorList[26]["locked"] = true
                            doorList[27]["locked"] = true
							TriggerServerEvent("doorLock-Lock",26)
							TriggerServerEvent("doorLock-Lock",27)
                        elseif(i==28 or i==29) then
                            doorList[28]["locked"] = true
                            doorList[29]["locked"] = true
							TriggerServerEvent("doorLock-Lock",28)
							TriggerServerEvent("doorLock-Lock",29)
                        elseif(i==30) then
                            doorList[30]["locked"] = true
							TriggerServerEvent("doorLock-Lock",30)
                        else
                            doorList[i]["locked"] = true
							TriggerServerEvent("doorLock-Lock",i)
                        end
                    end
                end
            end
            
            else
                FreezeEntityPosition(closeDoor, doorList[i]["locked"])
            end
        end

        Citizen.Wait(0)
    end
end)

RegisterNetEvent("doorLock-setLock")
AddEventHandler("doorLock-setLock", function(i,locked)
    local closeDoor = GetClosestObjectOfType(doorList[i]["x"], doorList[i]["y"], doorList[i]["z"], 1.0, GetHashKey(doorList[i]["objName"]), false, false, false)
    FreezeEntityPosition(closeDoor, locked)
	
                        if(i==10 or i==11) then
                            doorList[10]["locked"] = locked
                            doorList[11]["locked"] = locked
                        elseif(i==12 or i==13) then
                            doorList[12]["locked"] = locked
                            doorList[13]["locked"] = locked
                        elseif(i==14 or i==15) then
                            doorList[14]["locked"] = locked
                            doorList[15]["locked"] = locked
                        elseif(i==16 or i==17) then
                            doorList[16]["locked"] = locked
                            doorList[17]["locked"] = locked
                        elseif(i==18 or i==19) then
                            doorList[18]["locked"] = locked
                            doorList[19]["locked"] = locked
                        elseif(i==20 or i==21) then
                            doorList[20]["locked"] = locked
                            doorList[21]["locked"] = locked
                        elseif(i==22 or i==23) then
                            doorList[22]["locked"] = locked
                            doorList[23]["locked"] = locked
                        elseif(i==24 or i==25) then
                            doorList[24]["locked"] = locked
                            doorList[25]["locked"] = locked
                        elseif(i==26 or i==27) then
                            doorList[26]["locked"] = locked
                            doorList[27]["locked"] = locked
                        elseif(i==28 or i==29) then
                            doorList[28]["locked"] = locked
                            doorList[29]["locked"] = locked
                        elseif(i==30) then
                            doorList[30]["locked"] = locked
                        else
                            doorList[i]["locked"] = locked
                        end
end)


doorList = {
    -- Mission Row To locker room & roof
    [1] = { ["objName"] = "v_ilev_ph_gendoor004", ["x"]= 449.69815063477, ["y"]= -986.46911621094,["z"]= 30.689594268799,["locked"]= true,["txtX"]=450.1,["txtY"]=-986.9,["txtZ"]=30.689},
    -- Mission Row Armory
    [2] = { ["objName"] = "v_ilev_arm_secdoor", ["x"]= 452.61877441406, ["y"]= -982.7021484375,["z"]= 30.689598083496,["locked"]= true,["txtX"]=453.0,["txtY"]=-982.1,["txtZ"]=31.0},
    -- Mission Row Captain Office
    [3] = { ["objName"] = "v_ilev_ph_gendoor002", ["x"]= 447.23818969727, ["y"]= -980.63006591797,["z"]= 30.689598083496,["locked"]= true,["txtX"]=447.7,["txtY"]=-980.1,["txtZ"]=30.689},
    -- Mission Row To downstairs right
    [4] = { ["objName"] = "v_ilev_ph_gendoor005", ["x"]= 443.97, ["y"]= -989.033,["z"]= 30.6896,["locked"]= true,},
    -- Mission Row To downstairs left
    [5] = { ["objName"] = "v_ilev_ph_gendoor005", ["x"]= 445.37, ["y"]= -988.705,["z"]= 30.6896,["locked"]= true,["txtX"]=444.708,["txtY"]=-989.5,["txtZ"]=30.8},
    -- Mission Row Main cells
    [6] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 464.0, ["y"]= -992.265,["z"]= 24.9149,["locked"]= true,["txtX"]=463.465,["txtY"]=-992.664,["txtZ"]=25.064},
    -- Mission Row Cell 1
    [7] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 462.381, ["y"]= -993.651,["z"]= 24.9149,["locked"]= true,["txtX"]=461.806,["txtY"]=-993.308,["txtZ"]=25.064},
    -- Mission Row Cell 2
    [8] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 462.331, ["y"]= -998.152,["z"]= 24.9149,["locked"]= true,["txtX"]=461.806,["txtY"]=-998.800,["txtZ"]=25.064},
    -- Mission Row Cell 3
    [9] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 462.704, ["y"]= -1001.92,["z"]= 24.9149,["locked"]= true,["txtX"]=461.806,["txtY"]=-1002.450,["txtZ"]=25.064},
    -- Mission Row Backdoor in
    [10] = { ["objName"] = "v_ilev_gtdoor", ["x"]= 464.126, ["y"]= -1002.78,["z"]= 24.9149,["locked"]= true,["txtX"]=464.6,["txtY"]=-1003.538,["txtZ"]=25.0},
    -- Mission Row Backdoor out
    [11] = { ["objName"] = "v_ilev_gtdoor", ["x"]= 464.18, ["y"]= -1004.31,["z"]= 24.9152,["locked"]= true,["txtX"]=464.6,["txtY"]=-1003.538,["txtZ"]=25.0},
    -- Sheriff Cell door 1
    [12] = { ["objName"] = "prop_ld_jail_door", ["x"]= 718.824, ["y"]= 5294.807,["z"]= -120.849,["locked"]= true,["txtX"]=718.150,["txtY"]=5294.3,["txtZ"]=-120.849},
    -- Sheriff Cell door 2
    [13] = { ["objName"] = "prop_ld_jail_door", ["x"]= 722.455, ["y"]= 5294.132,["z"]= -120.849,["locked"]= true,["txtX"]=721.6,["txtY"]=5294.3,["txtZ"]=-120.849},
    -- Sheriff Cell door 3
    [14] = { ["objName"] = "prop_ld_jail_door", ["x"]= 725.731, ["y"]= 5294.135,["z"]= -120.849,["locked"]= true,["txtX"]=725.2,["txtY"]=5294.3,["txtZ"]=-120.849},
    -- Sheriff Security Door
    [15] = { ["objName"] = "v_ilev_cd_entrydoor", ["x"]= 734.141, ["y"]= 5293.795,["z"]= -120.849,["locked"]= true,["txtX"]=734.5,["txtY"]=5293.2,["txtZ"]=-120.4},
    -- Sheriff Door Sandy Shores
    [16] = { ["objName"] = "v_ilev_shrfdoor", ["x"]= 1855.263, ["y"]= 3683.315,["z"]= 34.267,["locked"]= true,["txtX"]=1854.8,["txtY"]=3683.3,["txtZ"]=34.267},
    -- Sheriff Door Paleto right
    [17] = { ["objName"] = "v_ilev_shrf2door", ["x"]= -443.817, ["y"]= 6015.945,["z"]= 31.716,["locked"]= true,["txtX"]=-443.8,["txtY"]=6015.945,["txtZ"]=31.716},
    -- Sheriff Door Paleto left
    [18] = { ["objName"] = "v_ilev_shrf2door", ["x"]= -442.937, ["y"]= 6015.933,["z"]= 31.716,["locked"]= true,["txtX"]=-443.8,["txtY"]=6015.945,["txtZ"]=31.716},
    -- Jail Security Door
    [19] = { ["objName"] = "v_ilev_cd_entrydoor", ["x"]= 1745.934, ["y"]= 2645.832,["z"]= -120.849,["locked"]= true,["txtX"]=1744.85,["txtY"]=2644.8,["txtZ"]=-120.4},
    -- Franklins Ans House
    [20] = { ["objName"] = "v_ilev_fa_frontdoor", ["x"]= -14.262, ["y"]= -1441.685,["z"]= 31.101,["locked"]= true,["txtX"]=-14.262,["txtY"]=-1441.685,["txtZ"]=-110},
    -- Franklins Mansion
    [21] = { ["objName"] = "v_ilev_fh_frontdoor", ["x"]= 8.321, ["y"]= 539.575,["z"]= 176.028,["locked"]= true,["txtX"]=8.321,["txtY"]=539.575,["txtZ"]=-110},
    -- Michaels Mansion Front left
    [22] = { ["objName"] = "v_ilev_mm_doorm_l", ["x"]= -816.097, ["y"]= 178.422,["z"]= 72.153,["locked"]= true,["txtX"]=-816.097,["txtY"]=178.422,["txtZ"]=-110},
    -- Michaels Mansion Front right
    [23] = { ["objName"] = "v_ilev_mm_doorm_r", ["x"]= -816.097, ["y"]= 178.422,["z"]= 72.153,["locked"]= true,["txtX"]=-816.097,["txtY"]=178.422,["txtZ"]=-110},
    -- Michaels Mansion Garage
    [24] = { ["objName"] = "v_ilev_mm_door", ["x"]= -806.959, ["y"]= 186.155,["z"]= 72.475,["locked"]= true,["txtX"]=-806.959,["txtY"]=186.155,["txtZ"]=-110},
    -- Michaels Mansion Back left
    [25] = { ["objName"] = "prop_bh1_48_backdoor_l", ["x"]= -793.600, ["y"]= 181.627,["z"]= 72.835,["locked"]= true,["txtX"]=-793.600,["txtY"]=181.627,["txtZ"]=-110},
    -- Michaels Mansion Back right
    [26] = { ["objName"] = "prop_bh1_48_backdoor_r", ["x"]= -793.600, ["y"]= 181.627,["z"]= 72.835,["locked"]= true,["txtX"]=-793.600,["txtY"]=181.627,["txtZ"]=-110},
    -- Michaels Mansion Back side left
    [27] = { ["objName"] = "prop_bh1_48_backdoor_l", ["x"]= -795.486, ["y"]= 177.432,["z"]= 72.835,["locked"]= true,["txtX"]=-795.486,["txtY"]=177.432,["txtZ"]=-110},
    -- Michaels Mansion Back side right
    [28] = { ["objName"] = "prop_bh1_48_backdoor_r", ["x"]= -795.486, ["y"]= 177.432,["z"]= 72.835,["locked"]= true,["txtX"]=-795.486,["txtY"]=177.432,["txtZ"]=-110},
    -- Trevers Trailer
    [29] = { ["objName"] = "v_ilev_trevtraildr", ["x"]= 1973.497, ["y"]= 3815.419,["z"]= 33.425,["locked"]= true,["txtX"]=1973.497,["txtY"]=3815.419,["txtZ"]=-110},
    -- Lesters House
    [30] = { ["objName"] = "v_ilev_lester_doorfront", ["x"]= 1274.465, ["y"]= -1720.716,["z"]= 54.680,["locked"]= true,["txtX"]=1274.465,["txtY"]=1720.716,["txtZ"]=-110},
}