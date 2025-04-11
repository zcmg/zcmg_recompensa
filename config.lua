Config = {}

--Codigo para poder apagar os admins
Config.CODIGOADMIN = "zcmg"

--Logs Discord
Config.LogDebug = true --Aparece a log na consola do servidor
Config.Logs = {
	Gerar = {Webhook = 'webhook_aqui', Cor = '00FF00'},
	Apagar = {Webhook = 'webhook_aqui', Cor = '00FF00'},
	Utilizar = {Webhook = 'webhook_aqui', Cor = '00FF00'},
	ApagarAdmin = {Webhook = 'webhook_aqui', Cor = '00FF00'},
	Cheater = {Webhook = 'webhook_aqui', Cor = '00FF00'},
}

--Gerar as matriculas [Não mexer - A menos que a sua garagem seja diferente]
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

--Carros que aparecem na listagem
Config.Cars = {
	{name = "Zentorno", code ="zentorno", icon ='fa-car'}, 
	{name = "Panto", code ="panto", icon ='fa-car-side'},
	{name = "Sanchez", code ="sanchez", icon ='fa-person-biking'}
}

--Categoria Armas
Config.WeaponsCategory = { 
	{name="armasbrancas", description="Armas Brancas", icon ="fa-wrench"},
	{name="pistolas", description="Pistolas", icon="fa-gun"},
	{name="smg", description="Sub Metralhadoras (SMG)", icon="fa-gun"},
	{name="shotguns", description="ShotGuns", icon="fa-gun"},
	{name="rifles", description="Rifles", icon="fa-gun"},
	{name="mg", description="Metralhadoras Pesadas", icon="fa-gun"},
	{name="snipers", description="Snipers", icon="fa-gun"},
	{name="armasexplosivas", description="Armas Explosivas", icon="fa-explosion"},
	{name="granadas", description="Granadas", icon="fa-bomb"},
	{name="outros", description="Outros", icon="fa-box"}
}
-- Armas que se podem ser devolvidas
Config.Weapons = {
	--Armas Brancas
	{code ="WEAPON_DAGGER", category ="armasbrancas"}, 
	{code ="WEAPON_BAT", category ="armasbrancas"},
	{code ="WEAPON_BOTTLE", category ="armasbrancas"}, 
	{code ="WEAPON_CROWBAR", category ="armasbrancas"},
	{code ="WEAPON_FLASHLIGHT", category ="armasbrancas"}, 
	{code ="WEAPON_GOLFCLUB", category ="armasbrancas"},
	{code ="WEAPON_HAMMER", category ="armasbrancas"}, 
	{code ="WEAPON_HATCHET", category ="armasbrancas"},
	{code ="WEAPON_KNUCKLE", category ="armasbrancas"}, 
	{code ="WEAPON_KNIFE", category ="armasbrancas"},
	{code ="WEAPON_MACHETE", category ="armasbrancas"}, 
	{code ="WEAPON_SWITCHBLADE", category ="armasbrancas"},
	{code ="WEAPON_NIGHTSTICK", category ="armasbrancas"}, 
	{code ="WEAPON_WRENCH", category ="armasbrancas"},
	{code ="WEAPON_BATTLEAXE", category ="armasbrancas"}, 
	{code ="WEAPON_POOLCUE", category ="armasbrancas"},
	{code ="WEAPON_STONE_HATCHET", category ="armasbrancas"}, 
	{code ="WEAPON_PISTOL", category ="pistolas"},
	{code ="WEAPON_PISTOL_MK2", category ="pistolas"}, 
	{code ="WEAPON_COMBATPISTOL", category ="pistolas"}, 
	--Pistolas
	{code ="WEAPON_APPISTOL", category ="pistolas"},
	{code ="WEAPON_STUNGUN", category ="pistolas"}, 
	{code ="WEAPON_PISTOL50", category ="pistolas"},
	{code ="WEAPON_SNSPISTOL", category ="pistolas"}, 
	{code ="WEAPON_SNSPISTOL_MK2", category ="pistolas"},
	{code ="WEAPON_HEAVYPISTOL", category ="pistolas"}, 
	{code ="WEAPON_VINTAGEPISTOL", category ="pistolas"},
	{code ="WEAPON_FLAREGUN", category ="pistolas"}, 
	{code ="WEAPON_MARKSMANPISTOL", category ="pistolas"},
	{code ="WEAPON_REVOLVER", category ="pistolas"}, 
	{code ="WEAPON_REVOLVER_MK2", category ="pistolas"},
	{code ="WEAPON_DOUBLEACTION", category ="pistolas"},
	{code ="WEAPON_RAYPISTOL", category ="pistolas"}, 
	{code ="WEAPON_CERAMICPISTOL", category ="pistolas"},
	{code ="WEAPON_NAVYREVOLVER", category ="pistolas"}, 
	{code ="WEAPON_GADGETPISTOL", category ="pistolas"},
	{code ="WEAPON_STUNGUN_MP", category ="pistolas"},
	--SMG
	{code ="WEAPON_MICROSMG", category ="smg"}, 
	{code ="WEAPON_SMG", category ="smg"},
	{code ="WEAPON_SMG_MK2", category ="smg"}, 
	{code ="WEAPON_ASSAULTSMG", category ="smg"},
	{code ="WEAPON_COMBATPDW", category ="smg"}, 
	{code ="WEAPON_MACHINEPISTOL", category ="smg"},
	{code ="WEAPON_MINISMG", category ="smg"}, 
	{code ="WEAPON_RAYCARBINE", category ="smg"},
	--ShotGuns
	{code ="WEAPON_PUMPSHOTGUN", category ="shotguns"},
	{code ="WEAPON_PUMPSHOTGUN_MK2", category ="shotguns"}, 
	{code ="WEAPON_SAWNOFFSHOTGUN", category ="shotguns"},
	{code ="WEAPON_ASSAULTSHOTGUN", category ="shotguns"}, 
	{code ="WEAPON_BULLPUPSHOTGUN", category ="shotguns"},
	{code ="WEAPON_MUSKET", category ="shotguns"}, 
	{code ="WEAPON_HEAVYSHOTGUN", category ="shotguns"},
	{code ="WEAPON_DBSHOTGUN", category ="shotguns"}, 
	{code ="WEAPON_AUTOSHOTGUN", category ="shotguns"}, 
	{code ="WEAPON_COMBATSHOTGUN", category ="shotguns"},
	--Rifles
	{code ="WEAPON_ASSAULTRIFLE", category ="rifles"}, 
	{code ="WEAPON_ASSAULTRIFLE_MK2", category ="rifles"},
	{code ="WEAPON_CARBINERIFLE", category ="rifles"},
	{code ="WEAPON_CARBINERIFLE_MK2", category ="rifles"}, 
	{code ="WEAPON_ADVANCEDRIFLE", category ="rifles"},
	{code ="WEAPON_SPECIALCARBINE", category ="rifles"},
	{code ="WEAPON_SPECIALCARBINE_MK2", category ="rifles"}, 
	{code ="WEAPON_BULLPUPRIFLE", category ="rifles"},
	{code ="WEAPON_BULLPUPRIFLE_MK2", category ="rifles"}, 
	{code ="WEAPON_COMPACTRIFLE", category ="rifles"},
	{code ="WEAPON_MILITARYRIFLE", category ="rifles"}, 
	{code ="WEAPON_HEAVYRIFLE", category ="rifles"}, 
	{code ="WEAPON_TACTICALRIFLE", category ="rifles"},
	--Metralhadoras Pesadas
	{code ="WEAPON_MG", category ="mg"},
	{code ="WEAPON_COMBATMG", category ="mg"}, 
	{code ="WEAPON_COMBATMG_MK2", category ="mg"},
	{code ="WEAPON_GUSENBERG", category ="mg"},
	--Snipers
	{code ="WEAPON_SNIPERRIFLE", category ="snipers"},
	{code ="WEAPON_HEAVYSNIPER", category ="snipers"}, 
	{code ="WEAPON_HEAVYSNIPER_MK2", category ="snipers"},
	{code ="WEAPON_MARKSMANRIFLE", category ="snipers"},
	{code ="WEAPON_MARKSMANRIFLE_MK2", category ="snipers"},
	{code ="WEAPON_PRECISIONRIFLE", category ="snipers"},
	--Armas Explosivas
	{code ="WEAPON_RPG", category ="armasexplosivas"}, 
	{code ="WEAPON_GRENADELAUNCHER", category ="armasexplosivas"},
	{code ="WEAPON_GRENADELAUNCHER_SMOKE", category ="armasexplosivas"}, 
	{code ="WEAPON_MINIGUN", category ="armasexplosivas"},
	{code ="WEAPON_FIREWORK", category ="armasexplosivas"},
	{code ="WEAPON_RAILGUN", category ="armasexplosivas"},
	{code ="WEAPON_HOMINGLAUNCHER", category ="armasexplosivas"}, 
	{code ="WEAPON_COMPACTLAUNCHER", category ="armasexplosivas"},
	{code ="WEAPON_RAYMINIGUN", category ="armasexplosivas"},
	{code ="WEAPON_EMPLAUNCHER", category ="armasexplosivas"},
	--Granadas
	{code ="WEAPON_GRENADE", category ="granadas"},
	{code ="WEAPON_BZGAS", category ="granadas"},
	{code ="WEAPON_MOLOTOV", category ="granadas"},
	{code ="WEAPON_STICKYBOMB", category ="granadas"},
	{code ="WEAPON_PROXMINE", category ="granadas"}, 
	{code ="WEAPON_SNOWBALL", category ="granadas"},
	{code ="WEAPON_PIPEBOMB", category ="granadas"}, 
	{code ="WEAPON_BALL", category ="granadas"},
	{code ="WEAPON_SMOKEGRENADE", category ="granadas"},
	{code ="WEAPON_FLARE", category ="granadas"},
	--Outros
	{code ="WEAPON_PETROLCAN", category ="outros"},
	{code ="GADGET_PARACHUTE", category ="outros"},
	{code ="WEAPON_FIREEXTINGUISHER", category ="outros"},
	{code ="WEAPON_HAZARDCAN", category ="outros"},
	{code ="WEAPON_FERTILIZERCAN", category ="outros"}
}