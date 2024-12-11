# LB Sim Cards

## Setup

Add the following code into `@lb-phone/client/custom/functions/functions.lua` at the end of the file:
```lua
exports('SetPhone', SetPhone)
```

## Item Setup:
> Ox Inventory Item:
> ```lua
    ['simcard'] = {
        label = 'Sim Card',
        weight = 50,
        stack = false,
        close = true,
        server = { export = "lb-phone-simcards.simcard" },
    }
```