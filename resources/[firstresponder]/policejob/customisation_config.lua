policeskins = {}
clothing_menu = false

if settings.force == "AST" then
	--AST
	policeskins = {
		's_m_y_cop_01',   --  <----- POLICE
		's_f_y_cop_01',    --  <----- POLICE
		's_m_y_ranger_01', --highway cop
		's_m_y_sheriff_01', -- sheriff 
		's_m_y_hwaycop_01',
		's_m_m_ciasec_01', -- police ranger
		'mp_m_freemode_01', -- police male freemode
		'mp_f_freemode_01', -- police female freemode
		's_m_y_swat_01',
		's_m_m_dick_01',
	}
elseif settings.force == "LAPD" then
	--LAPD
	policeskins = {
		's_m_y_cop_01',   --  <----- POLICE
		's_f_y_cop_01',    --  <----- POLICE
		's_m_y_ranger_01', --highway cop
		's_m_y_sheriff_01', -- sheriff 
		's_m_y_hwaycop_01',
		's_m_m_ciasec_01', -- police ranger
		'mp_m_freemode_01', -- police male freemode
		'mp_f_freemode_01', -- police female freemode
		's_m_y_swat_01',
		's_m_m_dick_01',
	}
elseif settings.force == "NYPD" then
	--NYPD
	policeskins = {
		's_m_y_cop_01',   --  <----- POLICE
		's_f_y_cop_01',    --  <----- POLICE
		's_m_y_ranger_01', --highway cop
		's_m_y_sheriff_01', -- sheriff 
		's_m_y_hwaycop_01',
		's_m_m_ciasec_01', -- police ranger
		'mp_m_freemode_01', -- police male freemode
		'mp_f_freemode_01', -- police female freemode
		's_m_y_swat_01',
		's_m_m_dick_01',
	}
end

local policeclothing_emplacement = {
    {name="Police Clothing", id=365, x=454.365753173828, y=-989.097778320313, z=30.9}, -- Mission row
    {name="Police Clothing", id=365, x=-448.16, y=6008.04, z=31.72}, -- Paleto Bay
    {name="Police Clothing", id=365, x=1848.685, y=3689.812, z=34.27}, -- Sandy Shores
    {name="Police Clothing", id=365, x=-557.43, y=-129.10, z=37.98}, -- Rockford Hills
}

menu_options = {
    {name = "Clothing", f = customise, param = nil},
    {name = "Accessories", f = accessories, param = nil},
    {name = "Face", f = overlays, param = nil},
    {name = "Models", f = listModels, param = policeskins},
}
player_data  = {
    model = GetHashKey("mp_m_freemode_01"),
    new = true,
    clothing = {
        drawables = {},
        textures = {
            1,1,1
        },
        palette = {},
    },
    props = {
        drawables = {},
        textures = {},
    },
    overlays = {
        drawables = {},
        opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0},
        colours = {
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
        },
    },
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isCop then
        	if isInService then
		        local pos = GetEntityCoords(GetPlayerPed(-1), true)
		        for k,v in ipairs(policeclothing_emplacement) do
		            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
		                DrawMarker(27, v.x, v.y, v.z -1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 128, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
		                    DisplayHelpText("Press ~INPUT_CONTEXT~ to customise your officer.")
		                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
		                        GUI.maxVisOptions = 20; titleTextSize = {0.85, 0.80}; titleRectSize = {0.23, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.23, 0.035}; menuX = 0.745; menuXOption = 0.11; menuXOtherOption = 0.06; menuYModify = 0.1500; menuYOptionDiv = 4.285; menuYOptionAdd = 0.21
		                        clothing_menu = not clothing_menu
		                        OpenClothes()
		                    end
		                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
		                    incircle = false
		                    if clothing_menu then
		                        save()
		                    end
		                    clothing_menu = false
		                end
		            end
		        end
		        if clothing_menu then
		        	menuX = 0.745
		        	car_menu = false
		        	heli_menu = false
		        	armoury_menu = false
		        	cop_menu = false
		            Menu.DisplayCurMenu()
		        end
		    end
		end
    end
end)

function ClothingBlips()
    for _, item in pairs(policeclothing_emplacement) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, 39)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
end

function RemoveClothingBlips()
    for _, item in pairs(policeclothing_emplacement) do
        RemoveBlip(item.blip)
    end
end