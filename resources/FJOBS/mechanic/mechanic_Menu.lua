--====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================

local Menu = {}
local itemMenuGeneral = {}
local itemMenuChoix = {}

local UrgenceMenu = {['Title'] = 'Current Missions',  ['SubMenu'] = {
    ['Title'] = 'Current Mission', ['Items'] = {
        {['Title'] = 'Return', ['ReturnBtn'] = true },
        {['Title'] = 'Close'},
}}}


function updateMenu(newUrgenceMenu)
    itemMenuGeneral.Items[1] = newUrgenceMenu
end

function openMenuGeneral() 
    Menu.item = itemMenuGeneral
    Menu.isOpen = true
    Menu.initMenu()
end

function openMenuChoixVehicle()
Citizen.Trace('open choix ceh')
    Menu.item = itemMenuChoix
    Menu.isOpen = true
     Menu.initMenu()
end

function openCustomMenu()

end

itemMenuGeneral = {
    ['Title'] = 'Mechanic',
    ['Items'] = {
        UrgenceMenu,
        {['Title'] = 'Vehicle Analysis', ['Function'] = getStatusVehicle, ['Close'] = false},
        {['Title'] = 'Quick Repair', ['Function'] = repareVehicle, ['Close'] = false},
        {['Title'] = 'Complete Repair', ['Function'] = fullRepareVehcile, ['Close'] = false},
        {['Title'] = 'Unlock the door', ['Function'] = unlockVehiculeForAll, ['Close'] = false},
        {['Title'] = 'Open the door', ['SubMenu'] = {
            ['Title'] = 'Open the door',  ['Items'] = {
                {['Title'] = 'Drivers door', ['Function'] = openVehicleDoorData, ['Porte'] = 0, ['Close'] = false},
                {['Title'] = 'Passenger door', ['Function'] = openVehicleDoorData, ['Porte'] = 1, ['Close'] = false},
                {['Title'] = 'Rear drivers door', ['Function'] = openVehicleDoorData, ['Porte'] = 2, ['Close'] = false},
                {['Title'] = 'Rear passenger door', ['Function'] = openVehicleDoorData, ['Porte'] = 3, ['Close'] = false},
                {['Title'] = 'Hood', ['Function'] = openVehicleDoorData, ['Porte'] = 4, ['Close'] = false},
                {['Title'] = 'Trunk', ['Function'] = openVehicleDoorData, ['Porte'] = 5, ['Close'] = false},
                {['Title'] = 'Driver truck door', ['Function'] = openVehicleDoorData, ['Porte'] = 6, ['Close'] = false},
                {['Title'] = 'Passenger truck door', ['Function'] = openVehicleDoorData, ['Porte'] = 7, ['Close'] = false},
                {['Title'] = 'All the doors', ['Function'] = openVehicleDoorData, ['Porte'] = -1, ['Close'] = false},
            }
        }},
        {['Title'] = 'Close Doors', ['SubMenu'] = {
            ['Title'] = 'Close Doors', ['Items'] = {
                {['Title'] = 'Drivers door', ['Function'] = closeVehicleDoorData, ['Porte'] = 0, ['Close'] = false},
                {['Title'] = 'Passenger door', ['Function'] = closeVehicleDoorData, ['Porte'] = 1, ['Close'] = false},
                {['Title'] = 'Rear drivers door', ['Function'] = closeVehicleDoorData, ['Porte'] = 2, ['Close'] = false},
                {['Title'] = 'Rear passenger door', ['Function'] = closeVehicleDoorData, ['Porte'] = 3, ['Close'] = false},
                {['Title'] = 'Hood', ['Function'] = closeVehicleDoorData, ['Porte'] = 4, ['Close'] = false},
                {['Title'] = 'Trunk', ['Function'] = closeVehicleDoorData, ['Porte'] = 5, ['Close'] = false},
                {['Title'] = 'Driver truck door', ['Function'] = closeVehicleDoorData, ['Porte'] = 6, ['Close'] = false},
                {['Title'] = 'Passenger truck door', ['Function'] = closeVehicleDoorData, ['Porte'] = 7, ['Close'] = false},
                {['Title'] = 'All the doors', ['Function'] = closeVehicleDoorData, ['Porte'] = -1, ['Close'] = false},
            }
        }},
		{['Title'] = 'Cleaning the Vehicle', ['Function'] = Mechanic_wash},
		{['Title'] = 'Remove Vehicle', ['Function'] = Mechanic_deleteVehicle},
		{['Title'] = 'Show / hide help', ['Function'] = toogleHelperLine, ['Close'] = false},
    }
}

itemMenuChoix = {
    ['Title'] = 'Mechanic - Vehicle selection',
    ['Items'] = {
        {['Title'] = 'TowTruck', ['Function'] = invokeVehicle, type = 1},
        {['Title'] = 'FlatBed', ['Function'] = invokeVehicle, type = 2},
    }
}
--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 52, 73, 94, 196 }
Menu.backgroundColorActive = {192, 57, 43, 255}
Menu.tileTextColor = {192, 57, 43, 255}
Menu.tileBackgroundColor = { 255,255,255, 255 }
Menu.textColor = { 255,255,255,255 }
Menu.textColorActive = { 255,255,255, 255 }

Menu.keyOpenMenu = 170 -- N+
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe 
Menu.keyRight =	175 -- PhoneRigth || Not use next release Maybe 
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel
Menu.IgnoreNextKey = false
Menu.posX = 0.75
Menu.posY = 0.20

Menu.ItemWidth = 0.20
Menu.ItemHeight = 0.03

Menu.isOpen = false   -- /!\ Ne pas toucher
Menu.currentPos = {1} -- /!\ Ne pas toucher

--====================================================================================
--  Menu System
--====================================================================================

function Menu.drawRect(posX, posY, width, heigh, color)
    DrawRect(posX + width / 2, posY + heigh / 2, width, heigh, color[1], color[2], color[3], color[4])
end

function Menu.initText(textColor, font, scale)
    font = font or 0
    scale = scale or 0.35
    SetTextFont(font)
    SetTextScale(0.0,scale)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextEntry("STRING")
end

function Menu.draw() 
    -- Draw Rect
    local pos = 0
    local menu = Menu.getCurrentMenu()
    local selectValue = Menu.currentPos[#Menu.currentPos]
    local nbItem = #menu.Items
    -- draw background title & title
    Menu.drawRect(Menu.posX, Menu.posY , Menu.ItemWidth, Menu.ItemHeight * 2, Menu.tileBackgroundColor)    
    Menu.initText(Menu.tileTextColor, 4, 0.7)
    AddTextComponentString(menu.Title)
    DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY)

    -- draw bakcground items
    Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * 2, Menu.ItemWidth, Menu.ItemHeight + (nbItem-1)*Menu.ItemHeight, Menu.backgroundColor)
    -- draw all items
    for pos, value in pairs(menu.Items) do
        if pos == selectValue then
            Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * (1+pos), Menu.ItemWidth, Menu.ItemHeight, Menu.backgroundColorActive)
            Menu.initText(Menu.textColorActive)
        else
            Menu.initText(value.TextColor or Menu.textColor)
        end
        AddTextComponentString(value.Title)
        DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY + Menu.ItemHeight * (pos+1))
    end
    
end

function Menu.getCurrentMenu()
    local currentMenu = Menu.item
    for i=1, #Menu.currentPos - 1 do
        local val = Menu.currentPos[i]
        currentMenu = currentMenu.Items[val].SubMenu
    end
    return currentMenu
end

function Menu.initMenu()
    Menu.currentPos = {1}
    Menu.IgnoreNextKey = true 
end

function Menu.keyControl()
    if Menu.IgnoreNextKey == true then
        Menu.IgnoreNextKey = false 
        return
    end
    if IsControlJustPressed(1, Menu.keyDown) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = (Menu.currentPos[slcp] % size) + 1

    elseif IsControlJustPressed(1, Menu.keyUp) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = ((Menu.currentPos[slcp] - 2 + size) % size) + 1

    elseif IsControlJustPressed(1, Menu.KeyCancel) then 
        table.remove(Menu.currentPos)
        if #Menu.currentPos == 0 then
            Menu.isOpen = false 
        end

    elseif IsControlJustPressed(1, Menu.keySelect)  then
        local cSelect = Menu.currentPos[#Menu.currentPos]
        local cMenu = Menu.getCurrentMenu()
        if cMenu.Items[cSelect].SubMenu ~= nil then
            Menu.currentPos[#Menu.currentPos + 1] = 1
        else
            if cMenu.Items[cSelect].ReturnBtn == true then
                table.remove(Menu.currentPos)
                if #Menu.currentPos == 0 then
                    Menu.isOpen = false 
                end
            else
                if cMenu.Items[cSelect].Function ~= nil then
                    cMenu.Items[cSelect].Function(cMenu.Items[cSelect])
                end
                if cMenu.Items[cSelect].Event ~= nil then
                    TriggerEvent(cMenu.Items[cSelect].Event, cMenu.Items[cSelect])
                end
                if cMenu.Items[cSelect].Close == nil or cMenu.Items[cSelect].Close == true then
                    Menu.isOpen = false
                end
            end
        end
    end

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        if IsControlJustPressed(1, Menu.keyOpenMenu) then
            Menu.isOpen = false
        end
        if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
        end
	end
end)
