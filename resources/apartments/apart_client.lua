local displayApartBlips = false --SET TO TRUE IF YOU WANT TO ADD BLIPS FOR APPARTMENTS

local interiors = {
    [1] = { ["price"] = 100000, ["xe"] = 1395.099, ["ye"] = 1141.742, ["ze"] = 114.8, ["he"] = 0.000, ["xo"] = 1397.330, ["yo"] = 1142.050, ["zo"] = 114.5, ["ho"] = 0.000, ["name"] = 'Ranch Main'},
    [2] = { ["price"] = 100000, ["xe"] = -1910.726, ["ye"] = -576.919, ["ze"] = 19.3, ["he"] = 0.00, ["xo"] = -1910.099, ["yo"] = -574.972, ["zo"] = 19.3, ["ho"] = 0.00, ["name"] = 'Beach Office 1'},
    [3] = { ["price"] = 100000, ["xe"] = -269.457, ["ye"] = -955.8555, ["ze"] = 31.5, ["he"] = 0.00, ["xo"] = -269.782, ["yo"] = -941.065, ["zo"] = 92.8, ["ho"] = 0.00, ["name"] = 'Condo Luxury 1'},
    [4] = { ["price"] = 100000, ["xe"] = -44.646, ["ye"] = -587.163, ["ze"] = 38.3, ["he"] = 0.00, ["xo"] = -30.817, ["yo"] = -595.315, ["zo"] = 80.3, ["ho"] = 0.00, ["name"] = 'Condo Luxury 2'},
    [5] = { ["price"] = 100000, ["xe"] = -43.931, ["ye"] = -584.379, ["ze"] = 38.3, ["he"] = 0.00, ["xo"] = -18.440, ["yo"] = -591.497, ["zo"] = 90.3, ["ho"] = 0.00, ["name"] = 'Condo Luxury 3'},
    [6] = { ["price"] = 100000, ["xe"] = -480.583, ["ye"] = -688.393, ["ze"] = 33.5, ["he"] = 0.00, ["xo"] = -467.465, ["yo"] = -708.712, ["zo"] = 77.3, ["ho"] = 0.00, ["name"] = 'Condo Luxury 4'},
    [7] = { ["price"] = 100000, ["xe"] = -770.619, ["ye"] = 318.839, ["ze"] = 85.8, ["he"] = 0.00, ["xo"] = -784.695, ["yo"] = 323.346, ["zo"] = 212.2, ["ho"] = 0.00, ["name"] = 'Condo Luxury 5'},
    [8] = { ["price"] = 100000, ["xe"] = 415.044, ["ye"] = -217.058, ["ze"] = 60.2, ["he"] = 0.00, ["xo"] = 476.898, ["yo"] = -195.184, ["zo"] = 71.4, ["ho"] = 0.00, ["name"] = 'Terrace Hotel'},
    [9] = { ["price"] = 100000, ["xe"] = -98.541, ["ye"] = 367.420, ["ze"] = 113.5, ["he"] = 0.00, ["xo"] = -101.874, ["yo"] = 372.153, ["zo"] = 142.8, ["ho"] = 0.00, ["name"] = 'Terrace C'},
    [10] = { ["price"] = 100000, ["xe"] = 119.249, ["ye"] = 564.305, ["ze"] = 184.2, ["he"] = 0.00, ["xo"] = 117.411, ["yo"] = 559.382, ["zo"] = 184.5, ["ho"] = 0.00, ["name"] = 'Premium House 1'},
    [11] = { ["price"] = 100000, ["xe"] = 373.699, ["ye"] = 427.730, ["ze"] = 145.8, ["he"] = 0.00, ["xo"] = 373.523, ["yo"] = 423.222, ["zo"] = 146.1, ["ho"] = 0.00, ["name"] = 'Premium House 2'},
    [12] = { ["price"] = 100000, ["xe"] = -174.951, ["ye"] = 502.270, ["ze"] = 137.6, ["he"] = 0.00, ["xo"] = -174.111, ["yo"] = 497.260, ["zo"] = 137.8, ["ho"] = 0.00, ["name"] = 'Premium House 3'},
    [13] = { ["price"] = 100000, ["xe"] = 346.895, ["ye"] = 440.671, ["ze"] = 147.9, ["he"] = 0.00, ["xo"] = 341.693, ["yo"] = 437.470, ["zo"] = 149.5, ["ho"] = 0.00, ["name"] = 'Premium House 4'},
    [14] = { ["price"] = 100000, ["xe"] = -635.626, ["ye"] = 44.295, ["ze"] = 42.8, ["he"] = 0.00, ["xo"] = -603.831, ["yo"] = 58.761, ["zo"] = 98.4, ["ho"] = 0.00, ["name"] = 'Condo Luxury 6'},
    [15] = { ["price"] = 100000, ["xe"] = -776.924, ["ye"] = 318.661, ["ze"] = 85.8, ["he"] = 0.00, ["xo"] = -781.812, ["yo"] = 326.140, ["zo"] = 177.0, ["ho"] = 0.00, ["name"] = 'Condo Luxury 7'},
    [16] = { ["price"] = 100000, ["xe"] = -1581.250, ["ye"] = -558.371, ["ze"] = 35.2, ["he"] = 0.00, ["xo"] = -1582.834, ["yo"] = -558.808, ["zo"] = 108.7, ["ho"] = 0.00, ["name"] = 'Mayors Office'},
    [17] = { ["price"] = 100000, ["xe"] = -1447.424, ["ye"] = -537.894, ["ze"] = 34.9, ["he"] = 0.00, ["xo"] = -1449.844, ["yo"] = -525.866, ["zo"] = 57.2, ["ho"] = 0.00, ["name"] = 'Condo Luxury 10'},
    [18] = { ["price"] = 100000, ["xe"] = -889.443, ["ye"] = -333.081, ["ze"] = 34.8, ["he"] = 0.00, ["xo"] = -912.898, ["yo"] = -365.340, ["zo"] = 114.4, ["ho"] = 0.00, ["name"] = 'Condo Luxury'},
    [19] = { ["price"] = 100000, ["xe"] = -901.707, ["ye"] = -339.162, ["ze"] = 34.8, ["he"] = 0.00, ["xo"] = -907.138, ["yo"] = -372.565, ["zo"] = 109.6, ["ho"] = 0.00, ["name"] = 'Condo Luxury 11'},
    [20] = { ["price"] = 100000, ["xe"] = -894.848, ["ye"] = -353.676, ["ze"] = 34.8, ["he"] = 0.00, ["xo"] = -922.912, ["yo"] = -378.570, ["zo"] = 85.6, ["ho"] = 0.00, ["name"] = 'Condo Luxury 12'},
    [21] = { ["price"] = 100000, ["xe"] = -844.549, ["ye"] = -391.217, ["ze"] = 31.6, ["he"] = 0.00, ["xo"] = -907.707, ["yo"] = -453.481, ["zo"] = 126.7, ["ho"] = 0.00, ["name"] = 'Condo Luxury 13'},
    [22] = { ["price"] = 100000, ["xe"] = -837.556, ["ye"] = -405.570, ["ze"] = 31.6, ["he"] = 0.00, ["xo"] = -890.781, ["yo"] = -452.866, ["zo"] = 95.6, ["ho"] = 0.00, ["name"] = 'Condo Luxury 14'},
    [23] = { ["price"] = 100000, ["xe"] = -3093.068, ["ye"] = 349.211, ["ze"] = 7.7, ["he"] = 0.00, ["xo"] = -3094.154, ["yo"] = 339.901, ["zo"] = 11.1, ["ho"] = 0.00, ["name"] = 'Beach apartment 1'},
    [24] = { ["price"] = 100000, ["xe"] = -3100.382, ["ye"] = 360.864, ["ze"] = 7.8, ["he"] = 0.00, ["xo"] = -3094.473, ["yo"] = 340.733, ["zo"] = 14.6, ["ho"] = 0.00, ["name"] = 'Beach apartment 2'},
	[25] = { ["price"] = 1000000, ["xe"] = -817.214, ["ye"] = 178.084, ["ze"] = 72.4, ["he"] = 0.00, ["xo"] = -814.913, ["yo"] = 178.959, ["zo"] = 72.4, ["ho"] = 0.00, ["name"] = 'Michaels Mansion'},
	[26] = { ["price"] = 1000000, ["xe"] = 8.692, ["ye"] = 540.461, ["ze"] = 176.3, ["he"] = 0.00, ["xo"] = 7.493, ["yo"] = 537.588, ["zo"] = 176.3, ["ho"] = 0.00, ["name"] = 'Franklin Mansion'},
	[27] = { ["price"] = 1000000, ["xe"] = -14.135, ["ye"] = -1442.271, ["ze"] = 31.4, ["he"] = 0.00, ["xo"] = -14.221, ["yo"] = -1439.709, ["zo"] = 31.4, ["ho"] = 0.00, ["name"] = 'Franklin House'},
	[28] = { ["price"] = 1000000, ["xe"] = 1973.747, ["ye"] = 3815.094, ["ze"] = 33.6, ["he"] = 0.00, ["xo"] = 1972.815, ["yo"] = 3816.431, ["zo"] = 33.6, ["ho"] = 0.00, ["name"] = 'Trevor Trash Trailor'},
	[29] = { ["price"] = 1000000, ["xe"] = 1274.836, ["ye"] = -1721.286, ["ze"] = 54.8, ["he"] = 0.00, ["xo"] = 1273.983, ["yo"] = -1719.372, ["zo"] = 54.9, ["ho"] = 0.00, ["name"] = 'Lesters Residence'},
}

local lang = 'en'

local txt = {
  ['fr'] = {
        ['fermermenu'] = 'Fermer le menu',
        ['sonner'] = 'Sonner a la porte',
        ['gohome'] = 'Rentrer chez moi',
        ['vendre'] = 'Revendre l\'appartement',
        ['acheter'] = 'Acheter l\'appartement',
        ['visiter'] = 'Visiter l\'appartement',
        ['menu'] = 'Appuyez sur ~g~E~s~ pour ouvrir le menu',
        ['soon'] = 'Cette fonctionnalite arrivera bientot',
        ['exit'] = 'Sortir',
        ['retirerargent'] = 'Retirer de l\'argent propre',
        ['retirersale'] = 'Retirer de l\'argent sale',
        ['deposerargent'] = 'Deposer de l\'argent propre',
        ['deposersale'] = 'Deposer de l\'argent sale'
  },

    ['en'] = {
        ['fermermenu'] = 'Close menu',
        --['sonner'] = 'Ring the doorbell',
        --['gohome'] = 'Go to home',
        --['vendre'] = 'Sell apartment',
        --['acheter'] = 'Buy apartment',
        ['visiter'] = 'Break into this place',
        ['menu'] = 'Press ~r~E~s~ to open menu!',
        --['soon'] = 'This functionality will come soon',
        ['exit'] = 'Leave this place',
        --['retirerargent'] = 'Withdraw clean money',
        --['retirersale'] = 'Withdraw dirty money',
        --['deposerargent'] = 'Deposit clean money',
        --['deposersale'] = 'Deposit dirty money'
    }
}

local entrer = false
local isBuy = 0
local money = 0
local dirtymoney = 0
local depositcash = false
local depositdirtycash = false
local depositapart = ""


distance = 50.5999 -- distance to draw
timer = 0
current_int = 0
 
-- AddEventHandler("playerSpawned", function()
--   TriggerServerEvent("apart:sendData_s")
-- end)
 
-- -- Active this when you restart resource. If you don't want to close the server
-- TriggerServerEvent("apart:sendData_s")
 
-- RegisterNetEvent("apart:f_sendData")
-- AddEventHandler("apart:f_sendData", function(t1)
--     -- Tyler1 my boy
--   interiors = t1
-- end)
 
RegisterNetEvent("apart:isBuy")
AddEventHandler("apart:isBuy", function()
  isBuy = 1
end)
 
RegisterNetEvent("apart:isNotBuy")
AddEventHandler("apart:isNotBuy", function()
  isBuy = 0
end)

RegisterNetEvent("apart:isMine")
AddEventHandler("apart:isMine", function()
  isBuy = 2
end)

RegisterNetEvent("apart:getCash")
AddEventHandler("apart:getCash", function(moneyparm, dirtymoneyparm)
  money = moneyparm
  dirtymoney = dirtymoneyparm
end)

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
        N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end

function SetBlipTrade(id, text, color, x, y, z)
  local Blip = AddBlipForCoord(x, y, z)

  SetBlipSprite(Blip, id)
  SetBlipColour(Blip, color)
  SetBlipAsShortRange(Blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(Blip)
end
 
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

function MenuInsideAppartement()
	ped = GetPlayerPed(-1);
    MenuTitle = "Homes"
    ClearMenu()
 
    for i=1, #interiors do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xo,interiors[i].yo,interiors[i].zo, true) < 1.599 then
            TriggerServerEvent("apart:getCash", interiors[i].name)
            Wait(250)
            if isBuy == 2 then
            	print(money)
            	print(dirtymoney)
                Menu.addButton("Argent propre: " .. money .. " $","privetimuseless",nil)
                Menu.addButton("Argent sale: " .. dirtymoney .." $","privetimuseless",nil)
                Menu.addButton(txt[lang]['deposerargent'],"deposerargent",interiors[i].name)
                Menu.addButton(txt[lang]['deposersale'],"deposersale",interiors[i].name)
                Menu.addButton(txt[lang]['retirerargent'],"retirerargent",interiors[i].name)
                Menu.addButton(txt[lang]['retirersale'],"retirersale",interiors[i].name)
                Menu.addButton(txt[lang]['exit'],"Exit",nil)
            else
                Menu.addButton(txt[lang]['exit'],"Exit",nil)
            end
            Menu.addButton(txt[lang]['fermermenu'],"CloseMenu",nil)
        end
    end
end
function privetimuseless() 
end

function deposerargent(apart)
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
       	Wait(0);
    end
	if (GetOnscreenKeyboardResult()) then
		local txt = GetOnscreenKeyboardResult()
		if (string.len(txt) > 0) then
			TriggerServerEvent("apart:depositcash", txt, apart)
			CloseMenu()
		end
	end
end

function deposersale(apart)
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
       	Wait(0);
    end
	if (GetOnscreenKeyboardResult()) then
		local txt = GetOnscreenKeyboardResult()
		if (string.len(txt) > 0) then
			TriggerServerEvent("apart:depositdirtycash", txt, apart)
			CloseMenu()
		end
	end
end

function retirerargent(apart)
	print("coucou")
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
       	Wait(0);
    end
	if (GetOnscreenKeyboardResult()) then
		local txt = GetOnscreenKeyboardResult()
		if (string.len(txt) > 0) then
			print("ok c bon")
			TriggerServerEvent("apart:takecash", txt, apart)
			CloseMenu()
		end
	end
end

function retirersale(apart)
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
       	Wait(0);
    end
	if (GetOnscreenKeyboardResult()) then
		local txt = GetOnscreenKeyboardResult()
		if (string.len(txt) > 0) then
			TriggerServerEvent("apart:takedirtycash", txt, apart)
			CloseMenu()
		end
	end
end

function Exit()
	for i=1, #interiors do
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xo,interiors[i].yo,interiors[i].zo, true) < 1.599 then
			if timer == 0 then
			    DoScreenFadeOut(1000)
			    while IsScreenFadingOut() do Citizen.Wait(0) end
			    NetworkFadeOutEntity(GetPlayerPed(-1), true, false)
			    Wait(1000)
			    SetEntityCoords(GetPlayerPed(-1), interiors[i].xe,interiors[i].ye,interiors[i].ze)
			    SetEntityHeading(GetPlayerPed(-1), interiors[i].ho)
			    NetworkFadeInEntity(GetPlayerPed(-1), 0)
			    Wait(1000)
			    current_int = i
			    timer = 5
			    SimulatePlayerInputGait(PlayerId(), 1.0, 100, 1.0, 1, 0)
			    DoScreenFadeIn(1000)
			    Menu.hidden = true
			    while IsScreenFadingIn() do Citizen.Wait(0) end
			end
		end
	end
end
 
function MenuAppartement()
    ped = GetPlayerPed(-1);
    MenuTitle = "Homes"
    ClearMenu()
 
    for i=1, #interiors do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < 1.599 then
            TriggerServerEvent("apart:getAppart", interiors[i].name)
            Wait(250)
            if isBuy == 1 then
                --3
				Menu.addButton(txt[lang]['sonner'],"Sonner",nil)
            elseif isBuy == 2 then
                Menu.addButton(txt[lang]['gohome'],"Visiter",nil)
                --Menu.addButton(txt[lang]['vendre'],"Vendre",nil)
            else
                --Menu.addButton(txt[lang]['acheter'],"Acheter",nil)
                Menu.addButton(txt[lang]['visiter'],"Visiter",nil)
            end
            Menu.addButton(txt[lang]['fermermenu'],"CloseMenu",nil)
        end
    end
end
 
function CloseMenu()
    Menu.hidden = true    
end

function Sonner()
    exports.pNotify:SendNotification({text = txt[lang]['soon'], type = "error", timeout = 5000, layouts = "bottomCenter"})
end

function Vendre()
    for i=1, #interiors do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < 1.599 then
            TriggerServerEvent("apart:sellAppart", interiors[i].name, interiors[i].price)
            CloseMenu()
        end
    end
end

function Acheter()
    for i=1, #interiors do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < 1.599 then
            TriggerServerEvent("apart:buyAppart", interiors[i].name, interiors[i].price)
            CloseMenu()
        end
    end
end
 
function Visiter(i)
    for i=1, #interiors do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < 1.599 then
            if timer == 0 then
                DoScreenFadeOut(1000)
                while IsScreenFadingOut() do Citizen.Wait(0) end
                NetworkFadeOutEntity(GetPlayerPed(-1), true, false)
                Wait(1000)
                SetEntityCoords(GetPlayerPed(-1), interiors[i].xo,interiors[i].yo,interiors[i].zo)
                SetEntityHeading(GetPlayerPed(-1), interiors[i].ho)
                NetworkFadeInEntity(GetPlayerPed(-1), 0)
                Wait(1000)
                current_int = i
                timer = 5
                SimulatePlayerInputGait(PlayerId(), 1.0, 100, 1.0, 1, 0)
                DoScreenFadeIn(1000)
                Menu.hidden = true
                while IsScreenFadingIn() do Citizen.Wait(0) end
            end
        end
    end
end
 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if timer > 0 and current_int > 0 then DrawAdvancedText(0.707, 0.77, 0.005, 0.0028, 1.89, "~b~"..interiors[current_int].name, 255, 255, 255, 255, 1, 1) end
            for i=1, #interiors do
                if not IsEntityDead(PlayerPedId()) then
                    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < distance then
                        DrawMarker(27,interiors[i].xe,interiors[i].ye,interiors[i].ze-1.0001, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 105, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < 1.599 then
                            drawTxt(txt[lang]['menu'],0,1,0.5,0.8,0.6,255,255,255,255)
                            if IsControlJustPressed(1, 86) then
                                MenuAppartement()
                                Menu.hidden = not Menu.hidden
                            end
                            Menu.renderGUI()
                        end
                    end
                    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xo,interiors[i].yo,interiors[i].zo, true) < distance then
                        DrawMarker(27,interiors[i].xo,interiors[i].yo,interiors[i].zo-1.0001, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 105, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xo,interiors[i].yo,interiors[i].zo, true) < 1.599 then
                            drawTxt(txt[lang]['menu'],0,1,0.5,0.8,0.6,255,255,255,255)
                            if IsControlJustPressed(1, 86) then
                                MenuInsideAppartement()
                                Menu.hidden = not Menu.hidden
                            end
                            Menu.renderGUI()
                        end
                    end
                end
            end
    end
end)
 
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if timer > 0 then
            timer=timer-1
            if timer == 0 then current_int = 0 end
        end
    end
end)

Citizen.CreateThread(function()
    if displayApartBlips == false then
        for _, item in pairs(interiors) do
          item.blip = AddBlipForCoord(item.xe, item.ye, item.ze)
          SetBlipSprite(item.blip, 375)
          SetBlipAsShortRange(item.blip, true)
          BeginTextCommandSetBlipName("STRING")
          SetBlipColour(item.blip, 3)
          SetBlipScale(item.blip, 0.6)
          AddTextComponentString("Homes")
          EndTextCommandSetBlipName(item.blip)
        end
    end
end)