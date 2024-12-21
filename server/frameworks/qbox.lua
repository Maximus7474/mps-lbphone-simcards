local FW = {}
local QB = exports["qb-core"]:GetCoreObject()

function FW.GetIdentifier(source)
    return QB.Functions.GetPlayer(source)?.PlayerData.citizenid
end

return FW
