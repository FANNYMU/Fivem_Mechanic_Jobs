local QBCore = exports['qb-core']:GetCoreObject()

-- Command to pay for repair
RegisterServerEvent('mechanic_jobs:payForRepair')
AddEventHandler('mechanic_jobs:payForRepair', function()
    local src    = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney('cash', Config.RepairCost) then
        TriggerClientEvent('QBCore:Notify', src, 'You paid $' .. Config.RepairCost .. ' for the repair.', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money!', 'error')
    end
end)
