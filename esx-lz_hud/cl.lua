local ESX = exports['es_extended']:getSharedObject()
local opened = false
local steam = GetPlayerName(PlayerId())

CreateThread(function()
    local _s = 1500
    while true do
        
        TriggerEvent('esx_status:getStatus', 'hunger', function(status) 
            hunger = status.val / 10000 
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status) 
            thirst = status.val / 10000 
        end)

        SendNUIMessage({
            action   = "updateHUD",
            hunger   = hunger,
            thirst   = thirst,
            health   = (GetEntityHealth(PlayerPedId()) -100),
            armor    = GetPedArmour(PlayerPedId()),
            uselogo  = cfg.uselogo,
            logolink = cfg.logolink,
        })

        -- Hide Radar?
        if (cfg.HideRadar) then
            if IsPedInAnyVehicle(ped, false) then
                DisplayRadar(true)
                SendNUIMessage({ movehud = true })
            else
                DisplayRadar(false)
                SendNUIMessage({ movehud = false })
            end
        else
            DisplayRadar(true)
            SendNUIMessage({ movehud = true })
        end
        -- break

        if IsPauseMenuActive() then
            SendNUIMessage({action = "hide"})
        else
            SendNUIMessage({action = "show"})
        end

        Wait(_s)
    end
end)

CreateThread(function()
    local _s = 2000 -- variable para loops
    while true do
        if IsPedInAnyVehicle(PlayerPedId(), false) then -- Si hay un jugador dentro de un vehículo entonces...
            _s = 100 -- loop cada 100 ms
            SendNUIMessage({ -- Enviar mensaje a js
                action = "InVeh"; -- acción: estas en un vehículo, en js sale todo lo que hace la función
                fuel   = GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(), false)); -- obtener gasolina
                kmh    = (GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 3.6); -- Obtener velocidad en kmh
                gear   = GetVehicleCurrentGear(GetVehiclePedIsIn(PlayerPedId(), false)); -- Obtener Marcha  
            })
        elseif not IsPedInAnyVehicle(PlayerPedId()) then -- pero si no hay un jugador en un vehiculo entonces...
            SendNUIMessage({ action = "outVeh"; }) -- mandar accion en js, hace que oculte el carhud
        end -- fin

        if IsPedInAnyVehicle(PlayerPedId(), false) and IsPauseMenuActive() then -- si hay un jugador en un vehiculo y tiene el menu pausa activo entonces...
            SendNUIMessage({ action = "outVeh"; }) -- accion ocultar carhud
        end -- fin

        Wait(_s) -- loop cada 2 segundos
    end -- fin
end) -- fin

RegisterCommand('infopj', function()
    ESX.TriggerServerCallback('lz_hud:getPlayerinfo', function(money, bank, black_money, name)

        if money ~= nil then
            money = money
        else
            money = 0
        end
        if bank ~= nil then
            bank = bank
        else
            bank = 0
        end
        if black_money ~= nil then
            black_money = black_money
        else
            black_money = 0
        end

        if not opened then
            opened = true
            SendNUIMessage({ 
                action = "updatepj", 
                PlayerId = GetPlayerServerId(PlayerId()), 
                name = name,
                open = true,
                money = money,
                bank = bank,
                black_money = black_money,
                job = ESX.GetPlayerData().job.label,
                grade = ESX.GetPlayerData().job.grade_label,
                salary = ESX.GetPlayerData().job.grade_salary,
            })
            SetNuiFocus(true, true)
        elseif opened then
            opened = false
            SendNUIMessage({ open = false })
            SetNuiFocus(false, false)
        end
    end)
end)

RegisterNUICallback('close', function(data, cb)
    opened = false
    SetNuiFocus(false, false)
end)