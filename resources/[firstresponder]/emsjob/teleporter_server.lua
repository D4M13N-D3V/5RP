local interiors = {
  [1] = { 
    ["xo"] = 307.5690612793,
    ["yo"] = -1433.5883789063, 
    ["zo"] = 30.3, 
    ["ho"] = 150.10, 
    ["xe"] = 334.98007202148, 
    ["ye"] = -1432.265625, 
    ["ze"] = 46.8,
    ["he"] = 234.62, 
    ["name"] = 'Hospital Helipad'
  },
  [2] = { 
    ["xo"] = 355.76040649414, 
    ["yo"] = -596.33624267578, 
    ["zo"] = 29.2, 
    ["ho"] = 150.10, 
    ["xe"] = 338.76507568359, 
    ["ye"] = -583.93139648438, 
    ["ze"] = 74.6,
    ["he"] = 234.62, 
    ["name"] = 'Hospital Helipad'
  },
  [3] = { 
    ["xo"] = 1842.1669921875,
    ["yo"] = 3674.6079101563,
    ["zo"] = 34.5, 
    ["ho"] = 150.10, 
    ["xe"] = 1785.2305908203, 
    ["ye"] = 3233.646484375, 
    ["ze"] = 42.8,
    ["he"] = 234.62, 
    ["name"] = 'Hospital Helipad'
  },
  [4] = { 
    ["xo"] = -248.58085632324, 
    ["yo"] = 6331.0200195313, 
    ["zo"] = 32.42618560791, 
    ["ho"] = 150.10, 
    ["xe"] = -479.25231933594, 
    ["ye"] = 6010.533203125, 
    ["ze"] = 31.296033859253,
    ["he"] = 234.62, 
    ["name"] = 'Hospital Helipad'
  },
  [5] = { 
    ["xo"] = 1150.9127197266, 
    ["yo"] = -1529.7994384766, 
    ["zo"] = 35.8, 
    ["ho"] = 150.10, 
    ["xe"] = 275.19876098633, 
    ["ye"] = -1361.0004882813, 
    ["ze"] = 24.8,
    ["he"] = 24.5, 
    ["name"] = 'Hospital'
  },
}

RegisterServerEvent("paramedic:getinteriors")
AddEventHandler("paramedic:getinteriors", function()
    TriggerClientEvent("paramedic:receivinginteriors", source, interiors)
end)