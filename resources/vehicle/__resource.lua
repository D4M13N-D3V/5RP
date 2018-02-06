resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Vehicle Stuff'

client_scripts {
	"luxart/client.lua",
	"indicators/indicators_client.lua",
	--"speedometer/speedometer.lua",
	--"speedometer/InteractSound.lua",
    "hud/config.lua",
	"hud/client.lua",
    "carhud/carhud.lua",
    --"timedate/timeAndDateDisplay_client.lua",
	"watermark/watermark.lua",
    "cruisecontrol/cl_cruisecontrol.lua", -- Using Y on your keybaord
    "brakelights/client.lua"
}

server_scripts {
	"luxart/server.lua",
	"indicators/indicators_server.lua",
	"watermark/watermark_sv.lua",
}

-- Wraith Radar System

ui_page "wk_wrs/nui/radar.html"

files {
	"wk_wrs/nui/digital-7.regular.ttf", 
	"wk_wrs/nui/radar.html",
	"wk_wrs/nui/radar.css",
	"wk_wrs/nui/radar.js"
}

client_script 'wk_wrs/cl_radar.lua'