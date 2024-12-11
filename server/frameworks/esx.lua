local FW = {}
local ESX = exports.es_extended:getSharedObject()

function FW.GetIdentifier(source)
    return ESX.GetPlayerFromId(source)?.getIdentifier() or false
end

function FW.RegisterUsableItem()
end

return FW