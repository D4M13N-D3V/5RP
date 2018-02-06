K9_Config = {}
K9_Config = setmetatable(K9_Config, {})

K9_Config.DogModel = "A_C_Husky" -- Set dog model of your choice
K9_Config.VehicleRestricted = true -- [true means the dog can only get into police vehicles listed. false means he can enter any vehicle told to.]
K9_Config.GodmodeDog = true -- [true means the dog can NOT die. false means the dog CAN die.]
K9_Config.SearchSetting = "random" -- [random means it randomly generates items in the vehicle.]

K9_Config.Whitelist = {
	"steam:1100001071171b4",
	"steam:1100001028e95d3",
	"steam:11000010af394d6"
}

K9_Config.VehicleList = {
	"POLICET", -- 456714581
	"FBI", -- FBI
	"FBI2", -- FBI2
	"POLICE", -- Police
	"POLICE2", -- Police2
	"POLICE3", -- POlice3
	"POLICE4", -- Police4
	"PRANGER", -- Pranger
	"RIOT", -- Riot
	"SHERIFF", -- Sheriff
	"SHERIFF2", -- Sheriff2
	"cvpi1blue", -- multiskin cvpi
	"pstubby16",-- unmarked burban
	"cap94", -- 1994 caprice
	"cvpi2blue", -- mulitskin cvpi
	"pd4", -- explorer
	"pd5" -- explorer 2
}

K9_Config.Items = {
	illegal = {
		"Meth",
		"Marijuana",
		"Crack Cocaine",
		"Bath Salts",
		"Heroin"
	},
	suspicious = {
		"Open Alcahol Container(s)",
		"Marijuana Seed(s)",
		"Marijuana Stem(s)",
		"Large Wad of Cash",
        "Scale",
        "Small Baggies"
	},
	legal = {
		"Dirty Socks",
		"Bag(s) of candy",
		"Empty Food Wrapper(s)",
		"Empty Cup(s)",
		"Change"
    },
}