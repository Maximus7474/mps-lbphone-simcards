# LB Sim Cards

> ToDo:
> - [x] ~~Locale integration~~
> - [ ] Add Other Frameworks
> - [ ] Add Other Inventories

> [!NOTE]
> This resource is still in beta phase, breaking changes can occur without notice.

If you want to contribute please refer to the [Contributing Guidelines](https://github.com/Maximus7474/lb-phone-simcards/blob/main/CONTRIBUTING.md) before opening an issue or pull-request.

## Setup

1. Download and install [ox_lib](https://github.com/overextended/ox_lib/releases)

2. Add the following code into `@lb-phone/client/custom/functions/functions.lua` at the end of the file:
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
        consume = 0,
        server = { export = "lb-phone-simcards.simcard" },
        client = {image = 'simcard.png'}
    }
```
add simcard.png into ox_inventory/web/images
> ESX:
```sql
INSERT INTO `esx-scripting-server`.`items` (`name`, `label`) VALUES ('simcard', 'Sim Card');
```
