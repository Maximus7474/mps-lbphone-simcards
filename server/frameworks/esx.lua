local FW = {}
local ESX = exports.es_extended:getSharedObject()

function FW.GetIdentifier(source)
    return ESX.GetPlayerFromId(source)?.getIdentifier() or false
end

function FW.RegisterUsableItem(func)
    ESX.RegisterUsableItem(Config.SimCard.ItemName, function (source)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(Config.SimCard.ItemName, 1)
        func(source)
    end)
end

return FW