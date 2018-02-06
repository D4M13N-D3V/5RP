---------------------------------- COORDINATES ----------------------------------
local casino = {
 --{name="Casino", colour=75, id=431, x=930.19866943359, y=43.349021911621, z=81.09400177002}, -- Laundering Coords
 {name="Launderer", colour=75, id=431, x=-54.454170227051, y=-2522.8227539063, z=7.4011726379395}
}

---------------------------------- FUNCTIONS ----------------------------------

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

---------------------------------- CITIZEN ----------------------------------
pressed = false
incircle = false
Citizen.CreateThread(function()
    --[[
    for _, item in pairs(casino) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, item.colour)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
    --]]
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(casino) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.0001, 0, 0, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to clean your money!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                      TriggerServerEvent("dm:check")
                      pressed = true
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                end
                if pressed then
                  if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 5.0)then
                    pressed = false
                    TriggerServerEvent("dm:cancel")
                  end
                end
            end
        end
    end
end)

RegisterNetEvent('dm:status')
AddEventHandler("dm:status", function(status)
  if status == "p" then
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString("~g~Cleaning in progress...")
    DrawSubtitleTimed(90000, 1)
  elseif status == "n" then
    SetTextEntry_2("STRING")
    AddTextComponentString('At least two officers must be online!')
    DrawSubtitleTimed(800, 1)
  elseif status == "nm" then
    SetTextEntry_2("STRING")
    AddTextComponentString("You don't have any money to clean!")
    DrawSubtitleTimed(800, 1)
  elseif status == "cc" then
    SetTextEntry_2("STRING")
    AddTextComponentString("You went to far and the cleaning was cancelled!")
    DrawSubtitleTimed(3000, 1)
  end
end)

