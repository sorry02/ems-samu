-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS LOCAIS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
sorry = {}
Tunnel.bindInterface("paramedico",sorry)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ATIVADO QUANDO PRESSIONA E
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Paramedico:Emprego')
AddEventHandler('Paramedico:Emprego', function()
	local source = source
	local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if vRP.hasPermission(user_id,"Equipar.Paramedico") then
      	TriggerClientEvent('Paramedico:Equipar', source)
      	vRP.giveInventoryItem(user_id,"kit medico",25,true) -- 10 É IGUAL A QUANTIDADE DE KIT QUE IRÁ PARA O INVENTARIO
	else
      	TriggerClientEvent("pNotify:SendNotification", user_id, {
			text = "Você não é um paramedico",
			type = "error",progressBar = false,timeout = 3000,layout = "sorry",queue = "left",
			animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
		})
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ATIVADO QUANDO PRESSIONA Y
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Paramedico:ForaEmprego')
AddEventHandler('Paramedico:ForaEmprego', function()
	local source = source
	local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if vRP.hasPermission(user_id,"Equipar.Paramedico") then
		TriggerClientEvent('Paramedico:Sair', source)
    else
    	TriggerClientEvent("pNotify:SendNotification", user_id, {
			text = "Você não é um paramedico",
			type = "error",progressBar = false,timeout = 3000,layout = "sorry",queue = "left",
			animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
		})
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MENSAGEM QUE ENTROU EM SERVIÇO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Mensagem:DentroSamu')
AddEventHandler('Mensagem:DentroSamu', function()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(tonumber(user_id))
	TriggerClientEvent('chatMessage', -1, 'SAMU', {255, 0, 0},"O paramedico ^1".. identity.firstname .. " " .. identity.name .. " ^7iniciou seu expediente.")
	TriggerClientEvent("pNotify:SendNotification", user_id, {
		text = "Você bateu o ponto, vá trabalhar",
		type = "success",progressBar = false,timeout = 3000,layout = "sorry",queue = "left",
		animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
	})
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MENSAGEM QUE SAIU DE SERVIÇO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Mensagem:ForaSamu')
AddEventHandler('Mensagem:ForaSamu', function()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(tonumber(user_id))
	TriggerClientEvent('chatMessage', -1, 'SAMU', {255, 0, 0},"O paramedico ^1".. identity.firstname .. " " .. identity.name .. " ^7terminou seu expediente.")
	TriggerClientEvent("pNotify:SendNotification", user_id, {
		text = "Você finalizou seu expediente",
		type = "success",progressBar = false,timeout = 3000,layout = "sorry",queue = "left",
		animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
	})
end)