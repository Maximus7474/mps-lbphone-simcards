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

return Utils