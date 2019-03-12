local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
sorryserver = Tunnel.getInterface("sorry")

contador = 0
sorry = {}
Tunnel.bindInterface("paramedico",sorry)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EQUIPAR PARAMEDICO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Paramedico:Equipar")
AddEventHandler("Paramedico:Equipar", function()
	TriggerServerEvent("Mensagem:DentroSamu")
end)

RegisterNetEvent("Paramedico:Sair")
AddEventHandler("Paramedico:Sair", function()
	TriggerServerEvent("Mensagem:ForaSamu")
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD PRINCIPAL
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local Coordenadas = GetEntityCoords(GetPlayerPed(-1))
		local Distancia = GetDistanceBetweenCoords(Coordenadas.x, Coordenadas.y, Coordenadas.z, 244.46919250488,-1382.3184814453,39.534374237061, true)
		if Distancia < 10.0 then
			Opacidade = math.floor(255 - (Distancia * 20))
			Texto3D(244.46919250488,-1382.3184814453,39.534374237061, "~g~[ F ] ~w~PARA INICIAR O EXPEDIENTE / ~r~[ Y ] ~w~PARA SAIR DO EXPEDIENTE", Opacidade)
			DrawMarker(27, 244.46919250488,-1382.3184814453,38.634374237061, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 255, 255, 255, Opacidade, 0, 0, 0, 0)
			if contador == 0 then
				Texto3D(244.46919250488,-1382.3184814453,39.334374237061, "VOCÊ ESTÁ PRONTO PARA ENTRAR EM SERVIÇO", Opacidade)
				if (IsControlJustPressed(1,49)) then
					TriggerServerEvent('Paramedico:Emprego')				
					contador = 60
					
		    	end
                
		    	if (IsControlJustPressed(1,246)) then
					TriggerServerEvent('Paramedico:ForaEmprego')				
					contador = 60
		    	end
			else
				Texto3D(244.46919250488,-1382.3184814453,39.334374237061, "AGUARDE ~r~".. contador .. " ~w~SEGUNDOS PARA TENTAR NOVAMENTE", Opacidade)
			end
		end
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTADOR
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if contador > 0 then
			contador = contador - 1
		end
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO 3D
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Texto3D(x,y,z, text, Opacidade)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())    
    if onScreen then
        SetTextScale(0.54, 0.54)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, Opacidade)
        SetTextDropshadow(0, 0, 0, 0, Opacidade)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end