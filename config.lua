Config = exports["lb-phone"]:GetConfig()

Config.SimCard = {

    ItemName = 'simcard',

    --[[
        If set to true, it will put the phone's number back to the simcard
        If set to false, it will consume/delete the simcard item
    ]]
    ReplaceSimCardNumber = false,

    --[[ 
        Delete the simcard item after use, only used if ReplaceSimCardNumber is set to false
    ]]
    DeleteSimCard = false,
}