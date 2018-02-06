local itembool = false
function itemshop(cat)
    if cat ~= "b" then
        Menu.SetupMenu("item_shop_menu","24/7 Store")
        Menu.Switch(nil,"item_shop_menu")
    else
        Menu.SetupMenu("item_shop_menu","Blackmarket")
        Menu.Switch(nil,"item_shop_menu")
    end
    for ind, value in pairs(items[cat]) do
        Menu.addOption("item_shop_menu", function()
            if(Menu.Bool(tostring(value[1]), itembool,"~g~$~w~"..value[2].price,"~g~$~w~"..value[2].price,function(cb)   itembool = cb end))then
                if itembool then
                    buyitem(value[2], cat)
                else
                	buyitem(value[2], cat)
                end
            end
        end)
    end
end

items = {
    ["a"] = {
        {"Burger",{name="Burger", id=40, price=12}},
        {"Water",{name="Water", id=6, price=6}},
        {"Vodka",{name="Vodka", id=41, price=30}},
        {"Medkit",{name="Medkit", id=34, price=1000}},
        {"Repair kit",{name="Repair kit", id=37, price=1500}},
    },
    ["b"] = {
        {"Medkit",{name="Cheap Medkit", id=35, price=500}},
        {"Repair kit",{name="Cheap Repair kit", id=38, price=750}},
        {"Lockpick",{name="Lockpick", id=36, price=400}},
        {"Body armour",{name="Body armour", id=39, price=10000}},
    }
}

function buyitem(item, cat)
    TriggerServerEvent("is:checkMoney", item, cat)
end

RegisterNetEvent("is:giveitem")
AddEventHandler("is:giveitem", function(item)
    TriggerEvent('inventory:addQty', item.id, 1)
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Press E to open/close menu in the red marker
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
shop_emplacement = {
    {name="Item store", id=52, x=1961.114, y=3741.449,z=33.0 },
    {name="Item store", id=52, x=1392.412, y=3604.472, z=35.4 },
    {name="Item store", id=52, x=546.989, y=2670.317, z=42.6 },
    {name="Item store", id=52, x=2556.253, y=382.876, z=109.2 },
    {name="Item store", id=52, x=-1821.954, y=792.401, z=138.7 },
    {name="Item store", id=52, x=-1223.669, y=-906.675, z=12.8 },
    {name="Item store", id=52, x=-708.192, y=-914.652, z=19.8 },
    {name="Item store", id=52, x=26.419, y=-1347.580, z=30.2 },
    {name="Item store", id=52, x=1135.67, y=-982.177, z=46.8 },
    {name="Item store", id=52, x=-47.124, y=-1756.52, z=30.0 },
    {name="Item store", id=52, x=-1487.48, y=-378.918, z=40.5},
    {name="Item store", id=52, x=374.208, y=328.134, z=104.0 },
    {name="Item store", id=52, x=2676.99, y=3281.37, z=55.6 },
    {name="Item store", id=52, x=-2967.86, y=391.037, z=15.5 },
    {name="Item store", id=52, x=1699.154, y=4924.373, z=42.6 },
    {name="Item store", id=52, x=1163.173, y=-323.013, z=69.7 },
    {name="Item store", id=52, x=1729.290, y=6414.190, z=35.5 },
    {name="Item store", id=52, x=1166.191, y=2708.744, z=38.5 },
}
shop_emplacement_grove = {
    {name="Blackmarket", id=52, colour=1,x=1464.1540527344,y=6547.431640425, z=14.2014650606689},
}
item_menu = false
incircle = false
Citizen.CreateThread(function()
    for _, item in pairs(shop_emplacement) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, item.colour)
      SetBlipScale(item.blip, 0.7)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(shop_emplacement) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(27, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 0.5001, 1555, 255, 255,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to buy items!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                        GUI.maxVisOptions = 20
                        titleTextSize = {0.85, 0.65} ------------ {p1, Size}                                      --
                        titleRectSize = {0.16, 0.085} ----------- {Width, Height}                                 --
                        optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      --
                        optionRectSize = {0.16, 0.035} ---------- {Width, Height}    
						menuX = 0.75 ----------------------------- X position of the menu                          --
						menuXOption = 0.075 --------------------- X postiion of Menu.Option text                  --
						menuXOtherOption = 0.055 ---------------- X position of Bools, Arrays etc text            --
						menuYModify = 0.3000 -------------------- Default: 0.1174   ------ Top bar                --
						menuYOptionDiv = 8.56 ------------------ Default: 3.56   ------ Distance between buttons --
						menuYOptionAdd = 0.36 ------------------ Default: 0.142  ------ Move buttons up and down --
                    	itemshop("a")
                    	item_menu = not item_menu
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    item_menu = false
                end
            end
        end
        for k,v in ipairs(shop_emplacement_grove) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 2.0001, 2.0001, 0.5001, 1555, 10, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to buy items!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                        GUI.maxVisOptions = 20
                        titleTextSize = {0.85, 0.65} ------------ {p1, Size}                                      --
                        titleRectSize = {0.16, 0.085} ----------- {Width, Height}                                 --
                        optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      --
                        optionRectSize = {0.16, 0.035} ---------- {Width, Height}    
                    	menuX = 0.75 ----------------------------- X position of the menu                          --
						menuXOption = 0.075 --------------------- X postiion of Menu.Option text                  --
						menuXOtherOption = 0.055 ---------------- X position of Bools, Arrays etc text            --
						menuYModify = 0.3000 -------------------- Default: 0.1174   ------ Top bar                --
						menuYOptionDiv = 8.56 ------------------ Default: 3.56   ------ Distance between buttons --
						menuYOptionAdd = 0.36 ------------------ Default: 0.142  ------ Move buttons up and down --
                    	itemshop("b")
                    	item_menu = not item_menu
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    item_menu = false
                end
            end
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Help messages
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------