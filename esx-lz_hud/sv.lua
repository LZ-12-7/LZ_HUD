local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('lz_hud:getPlayerinfo', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()
    local bank = xPlayer.getAccount('bank').money
    local black_money = xPlayer.getAccount('black_money').money
    local name = xPlayer.getName()
    cb(money, bank, black_money, name)
end)