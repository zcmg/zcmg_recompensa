Config = {}

Config.ESXTrigger = 'esx:getSharedObject' -- Trigger ESX

Config.Steams = {  --Steam ids de quem pode gerar os codigos
	{id ="steam:11000010064f1d9"}, -- Steam ID zcmg
	{id ="steam:11000010067f1d8"}
}

Config.CarsVerification = true -- Activa/Desativa a verificação dos carros

--Carros que tem autorização para dar
Config.Cars = {  -- Nome de spawn dos carros
	{code ="deluxo"}, 
	{code ="panto"}
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

--Gerar as matriculas [Não mexer]
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true
