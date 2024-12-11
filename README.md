# LB Sim Cards

## Setup

Add the following code into `@lb-phone/client/custom/functions/functions.lua` at the end of the file:
```lua
CreateThread(function ()
    local timeout = 50
    while SetPhone == nil and timeout > 0 do
        Wait(5)
        timeout = timeout - 1
    end
    if timeout <= 0 then return print('^1ERROR^7 Unable to create ^5SetPhone^7 export') end
    exports('SetPhone', SetPhone)
end)
```

## Item Setup:
> Ox Inventory Item:
```lua
    ['simcard'] = {
        label = 'Sim Card',
        weight = 50,
        stack = false,
        close = true,
        server = { export = "lb-phone-simcards.simcard" },
    }
```
