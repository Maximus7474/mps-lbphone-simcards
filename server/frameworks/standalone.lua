local FW = {}

function FW.GetIdentifier(source)
    return GetPlayerIdentifierByType(source, 'license')
end

function FW.RegisterUsableItem()
end

return FW