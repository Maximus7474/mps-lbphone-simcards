local Utils = require ('server/functions/utils')

local Framework = Utils.GetFramework(Config.Framework) or {}
local Inventory = Utils.GetInventory(Config.Item.Inventory) or {}
if not Framework then
    return lib.print.error(('Unable to load framework (%s), this script will not work !'):format())
end

if Inventory.RegisterItemCB then
    print('Registering Usable Item to Inventory')
    Inventory.RegisterItemCB(
        function (source, newNumber, slot)
            if not newNumber then newNumber = Utils.GenerateNewNumber() end

            local currentNumber = exports['lb-phone']:GetEquippedPhoneNumber(source)

            if Config.SimCard.ReplaceSimCardNumber then
                Inventory.ReplaceSimCardNumber(source, slot, currentNumber)
            elseif Config.SimCard.DeleteSimCard then
                Inventory.RemoveItem(source, slot)
            end

            local success = false
            if Config.Item.Unique then
                Inventory.ClearCurrentNumber(source, Config.Item.Name, currentNumber, newNumber)
                MySQL.update.await('UPDATE phone_phones SET id = ? WHERE phone_number = ? AND id = ?', {currentNumber, currentNumber, Framework.GetIdentifier(source)})
                local rows = MySQL.update.await('DELETE FROM phone_last_phone WHERE id = ?', {Framework.GetIdentifier(source)})
                success = rows == 1
            else
                local rows = MySQL.update.await('UPDATE phone_phones SET id = ? WHERE phone_number = ?', {currentNumber, currentNumber})
                success = rows == 1
            end

            if success then TriggerClientEvent('lbphonesim:changingsimcard', source, newNumber) end
        end
    )
elseif Framework.RegisterUsableItem then
    print('Registering Usable Item to Framework')
    Framework.RegisterUsableItem(
        function (source)
            local newNumber = Utils.GenerateNewNumber()

            TriggerClientEvent('lbphonesim:changingsimcard', source, newNumber)

            if Config.Item.Unique then
                local currentNumber = exports['lb-phone']:GetEquippedPhoneNumber(source)
                Inventory.SetNewNumber(source, Config.Item.Name, currentNumber, newNumber)
            end
        end
    )
end