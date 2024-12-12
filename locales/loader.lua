local locale = {}

local localeKey = exports["lb-phone"]:GetConfig().DefaultLocale

local rawContent = LoadResourceFile(GetCurrentResourceName(), ('locales/%s.json'):format(localeKey))

if not rawContent then
    lib.print.warn(('Unable to load %s locale as it doesn\'t exist in @%s/locales/'):format(localeKey, GetCurrentResourceName()))
    lib.print.warn('Falling back to english locale.')
    rawContent = LoadResourceFile(GetCurrentResourceName(), 'locales/en.json')
end

locale = json.decode(rawContent)[IsDuplicityVersion() and 'SERVER' or 'CLIENT']

function T(key, args)
    local keys = {}
    for str in string.gmatch(key, "([^%.]+)") do
        keys[#keys+1] = str
    end

    local localizedString = locale
    for _, keyPart in ipairs(keys) do
        localizedString = locale[keyPart]
        if localizedString == nil then
            return key
        end
    end

    local formatedString = localizedString:gsub("%b{}", function(match)
        local key = match:sub(2, -2)
        return args[key] or ""
    end)

    return formatedString
end