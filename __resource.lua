
resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"


version 'v2.0'

client_script {
	'@es_extended/locale.lua',
    'config.lua',
    'cl_cooking.lua',
   
}


server_scripts {
  '@es_extended/locale.lua',
  'config.lua',
  'server.lua'
  
}


dependencies {
	'es_extended',
	'esx_addonaccount',
	'skinchanger',
	'esx_skin'
}
