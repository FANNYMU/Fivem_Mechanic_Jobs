local QBCore          = exports['qb-core']:GetCoreObject()
local isInMechanicJob = false

-- Function to open the NUI
local function openNUI()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open' })
end

-- Function to close the NUI
local function closeNUI()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
end

-- Handle NUI callback for repairing vehicle
RegisterNUICallback('repairVehicle', function(data, cb)
    local playerPed = PlayerPedId()
    local vehicle   = GetVehiclePedIsIn(playerPed, false)

    if vehicle and vehicle ~ = 0 then
        if GetVehicleEngineHealth(vehicle) < 800 then
            -- Call server to handle payment
            TriggerServerEvent('mechanic_jobs:payForRepair')
            -- Repair the vehicle
            SetVehicleFixed(vehicle)
            SetVehicleDirtLevel(vehicle, 0)
            cb({ message = 'Vehicle repaired!' })
        else
            cb({ message = 'Vehicle is not damaged!' })
        end
    else
        cb({ message = 'You need to be in a vehicle!' })
    end
end)

-- Display mechanic job locations
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed    = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, loc in pairs(Config.Locations) do
            local distance = #(playerCoords - loc.coords)

            if distance < 10.0 then
                DrawMarker(1, loc.coords.x, loc.coords.y, loc.coords.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 255, 0, 150, false, true, 2, false, false, false, false, false, false, false)
                
                if distance < 1.0 then
                    QBCore.Functions.DrawText3D(loc.coords.x, loc.coords.y, loc.coords.z, loc.label)
                    if IsControlJustReleased(0, 38) then -- E key
                        openNUI()
                    end
                end
            end
        end
    end
end)
