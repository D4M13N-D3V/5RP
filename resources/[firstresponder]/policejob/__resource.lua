-- Manifest
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

ui_page 'html/ui.html'

files {
  'html/ui.html',
  'html/background.png',
  'html/styles.css',
  'html/scripts.js',
  'html/debounce.min.js',
}

-- General
client_scripts {
  'main_client.lua',
  'functions_client.lua',
  'gui.lua',
  'menu.lua',
  'garage_menus.lua',
  'armoury_menu.lua',
  'mission_client.lua',
  'customisation.lua',
  'customisation_config.lua',
  'mdt_client.lua',
}

server_scripts {
  'main_server.lua',
  'functions_server.lua',
  'mission_server.lua',
  'mdt_server.lua',
  '@mysql-async/lib/MySQL.lua',
}

export 'getIsInService'
export 'getIsCuffed'
export 'getPoliceRank'
export 'isUseraCop'