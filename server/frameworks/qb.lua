local FW = {}
local QB = exports["qb-core"]:GetCoreObject()

function FW.GetIdentifier(source)
    return QB.Functions.GetPlayer(source)?.PlayerData.citizenid
end

function FW.RegisterUsableItem(func)
    QB.Functions.CreateUseableItem(Config.SimCard.ItemName, function (source)
    	local Player = QB.Functions.GetPlayer(source)
        exports['qb-inventory']:RemoveItem(Player.PlayerData.citizenid, Config.SimCard.ItemName, 1)
        func(source)
    end)
end

return FW