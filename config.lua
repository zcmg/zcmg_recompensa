Config = {}

Config.ESXTrigger = 'esx:getSharedObject' --Trigger ESX

Config.ESX12 = false --Para esx 1.2 legacy etc

--Admins preencher conforme a versão do seu ESX
--Caso Config.ESX12 false - ESX 1.1
Config.Steams = {  --Steam ids de quem pode gerar os codigos
	{id ="steam:11000010064f1d9"}, -- Steam Hex zcmg
	{id ="steam:11000010067f1d8"}
}
--Caso Config.ESX12 true - ESX 1.2
Config.Identifier = {  --Steam ids de quem pode gerar os codigos
	{id ="license:03518966a677e56f26f71e9d05c051106ffa1af6"}, -- Licença zcmg
	{id ="license:03518966a677e56f26f71e9d05c051106ffa1af5"}
}


Config.CarsVerification = false -- Activa/Desativa a verificação dos carros

--Carros que tem autorização para dar
Config.Cars = {  -- Nome de spawn dos carros
	{code ="deluxo"}, 
	{code ="panto"}
}

Config.Weapons = {  -- Armas que se podem ser devolvidas
	{code ="WEAPON_DAGGER"}, 
	{code ="WEAPON_BAT"},
	{code ="WEAPON_BOTTLE"}, 
	{code ="WEAPON_CROWBAR"},
	{code ="WEAPON_FLASHLIGHT"}, 
	{code ="WEAPON_GOLFCLUB"},
	{code ="WEAPON_HAMMER"}, 
	{code ="WEAPON_HATCHET"},
	{code ="WEAPON_KNUCKLE"}, 
	{code ="WEAPON_KNIFE"},
	{code ="WEAPON_MACHETE"}, 
	{code ="WEAPON_SWITCHBLADE"},
	{code ="WEAPON_NIGHTSTICK"}, 
	{code ="WEAPON_WRENCH"},
	{code ="WEAPON_BATTLEAXE"}, 
	{code ="WEAPON_POOLCUE"},
	{code ="WEAPON_STONE_HATCHET"}, 
	{code ="WEAPON_PISTOL"},
	{code ="WEAPON_PISTOL_MK2"}, 
	{code ="WEAPON_COMBATPISTOL"}, 
	{code ="WEAPON_APPISTOL"},
	{code ="WEAPON_STUNGUN"}, 
	{code ="WEAPON_PISTOL50"},
	{code ="WEAPON_SNSPISTOL"}, 
	{code ="WEAPON_SNSPISTOL_MK2"},
	{code ="WEAPON_HEAVYPISTOL"}, 
	{code ="WEAPON_VINTAGEPISTOL"},
	{code ="WEAPON_FLAREGUN"}, 
	{code ="WEAPON_MARKSMANPISTOL"},
	{code ="WEAPON_REVOLVER"}, 
	{code ="WEAPON_REVOLVER_MK2"},
	{code ="WEAPON_DOUBLEACTION"},
	{code ="WEAPON_RAYPISTOL"}, 
	{code ="WEAPON_CERAMICPISTOL"},
	{code ="WEAPON_NAVYREVOLVER"}, 
	{code ="WEAPON_GADGETPISTOL"},
	{code ="WEAPON_MICROSMG"}, 
	{code ="WEAPON_SMG"},
	{code ="WEAPON_SMG_MK2"}, 
	{code ="WEAPON_ASSAULTSMG"},
	{code ="WEAPON_COMBATPDW"}, 
	{code ="WEAPON_MACHINEPISTOL"},
	{code ="WEAPON_MINISMG"}, 
	{code ="WEAPON_PUMPSHOTGUN"},
	{code ="WEAPON_RAYCARBINE"},
	{code ="WEAPON_PUMPSHOTGUN_MK2"}, 
	{code ="WEAPON_SAWNOFFSHOTGUN"},
	{code ="WEAPON_ASSAULTSHOTGUN"}, 
	{code ="WEAPON_BULLPUPSHOTGUN"},
	{code ="WEAPON_MUSKET"}, 
	{code ="WEAPON_HEAVYSHOTGUN"},
	{code ="WEAPON_DBSHOTGUN"}, 
	{code ="WEAPON_AUTOSHOTGUN"}, 
	{code ="WEAPON_COMBATSHOTGUN"},
	{code ="WEAPON_ASSAULTRIFLE"}, 
	{code ="WEAPON_ASSAULTRIFLE_MK2"},
	{code ="WEAPON_CARBINERIFLE"},
	{code ="WEAPON_CARBINERIFLE_MK2"}, 
	{code ="WEAPON_ADVANCEDRIFLE"},
	{code ="WEAPON_SPECIALCARBINE"},
	{code ="WEAPON_SPECIALCARBINE_MK2"}, 
	{code ="WEAPON_BULLPUPRIFLE"},
	{code ="WEAPON_BULLPUPRIFLE_MK2"}, 
	{code ="WEAPON_COMPACTRIFLE"},
	{code ="WEAPON_MILITARYRIFLE"}, 
	{code ="WEAPON_MG"},
	{code ="WEAPON_COMBATMG"}, 
	{code ="WEAPON_COMBATMG_MK2"},
	{code ="WEAPON_GUSENBERG"}, 
	{code ="WEAPON_SNIPERRIFLE"},
	{code ="WEAPON_HEAVYSNIPER"}, 
	{code ="WEAPON_HEAVYSNIPER_MK2"},
	{code ="WEAPON_MARKSMANRIFLE"},
	{code ="WEAPON_MARKSMANRIFLE_MK2"},
	{code ="WEAPON_RPG"}, 
	{code ="WEAPON_GRENADELAUNCHER"},
	{code ="WEAPON_GRENADELAUNCHER_SMOKE"}, 
	{code ="WEAPON_MINIGUN"},
	{code ="WEAPON_FIREWORK"},
	{code ="WEAPON_RAILGUN"},
	{code ="WEAPON_HOMINGLAUNCHER"}, 
	{code ="WEAPON_COMPACTLAUNCHER"},
	{code ="WEAPON_RAYMINIGUN"}, 
	{code ="WEAPON_GRENADE"},
	{code ="WEAPON_BZGAS"},
	{code ="WEAPON_MOLOTOV"},
	{code ="WEAPON_STICKYBOMB"},
	{code ="WEAPON_PROXMINE"}, 
	{code ="WEAPON_SNOWBALL"},
	{code ="WEAPON_PIPEBOMB"}, 
	{code ="WEAPON_BALL"},
	{code ="WEAPON_SMOKEGRENADE"},
	{code ="WEAPON_FLARE"},
	{code ="WEAPON_PETROLCAN"},
	{code ="GADGET_PARACHUTE"},
	{code ="WEAPON_FIREEXTINGUISHER"},
	{code ="WEAPON_HAZARDCAN"}
}

--Bots Discord Logs--
--Gerar codigo
Config.BotG = 'webhook_aqui'
Config.BotG_Cor = '#00FF00'
--Apagar codigo
Config.BotA = 'webhook_aqui'
Config.BotA_Cor = '#FF0000'
--Utilizar codigo
Config.BotU = 'webhook_aqui'
Config.BotU_Cor = '#0000FF'

--Gerar as matriculas [Não mexer - A menos que a sua garagem seija diferente]
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true
