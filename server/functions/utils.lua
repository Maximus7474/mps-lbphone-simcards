local Utils = {}

function Utils.GenerateNewNumber()
    local NumberConfig = exports["lb-phone"]:GetConfig().PhoneNumber

    local validNumber = false

    while not validNumber do
        local number = ""
        for i = 1, NumberConfig.Length do
            number = number .. tostring(math.random(0, 9))
        end

        local prefix = NumberConfig.Prefixes[math.random(1, #NumberConfig.Prefixes)]

        local r = MySQL.single.await('SELECT `id` FROM `phone_phones` WHERE `phone_number` = ?', {prefix .. number})

        if not r then validNumber = prefix .. number end
    end

    return validNumber
end

function Utils.GenerateSerialNumber(length)
    local charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
    if type(length) ~= 'number' then length = 6 end

    local serial = ''
    for i = 1, length do
        local r = math.random(1, #charset)
        serial = serial .. charset:sub(r, r)
    end

    return serial
end

--[[ INITIALISATION ]]

local frameworks = {
    'standalone',
    'esx',
    'qbox',
    'qb'
}

local function IsFrameworkCompatible(invName)
    local status, obj = pcall(function ()
        return require (('server/frameworks/%s'):format(invName))
    end)

    return status, obj
end

function Utils.GetFramework(rawEntry)
    if rawEntry ~= 'auto' then
        local status, obj = IsFrameworkCompatible(rawEntry)

        if not status then
            lib.print.error(('The configured framework (%s) is not supported by this script, please add it.'):format(rawEntry))
            return false
        else
            return obj
        end
    end

    for _, framework in pairs(frameworks) do
        local status, obj = IsFrameworkCompatible(framework)
        if status then
            return obj
        end
    end

    lib.print.error('No adapted framework was found !')

    return false
end

local inventories = {
    'ox_inventory'
}

local function IsInventoryCompatible(invName)
    local status, obj = pcall(function ()
        return require (('server/inventories/%s'):format(invName))
    end)

    return status, obj
end

function Utils.GetInventory(rawEntry)
    if rawEntry ~= 'auto' then
        local status, obj = IsInventoryCompatible(rawEntry)

        if not status then
            lib.print.error(('The configured inventory (%s) is not supported by this script, please add it.'):format(rawEntry))
            return false
        else
            return obj
        end
    end

    for _, inv in pairs(inventories) do
        local status, obj = IsInventoryCompatible(inv)
        if status then
            return obj
        end
    end

    return false
end

return Utils
