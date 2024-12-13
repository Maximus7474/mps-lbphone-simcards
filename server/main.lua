local Utils = require ('server/functions/utils')

local Framework = Utils.GetFramework(Config.Framework) or {}
local Inventory = Utils.GetInventory(Config.Item.Inventory) or {}
if not Framework then
    return lib.print.error(('Unable to load framework (%s), this script will not work !'):format())
end

if Inventory.RegisterItemCB then
    Inventory.RegisterItemCB(
        function (source, newNumber, slot)
            local currentNumber = exports['lb-phone']:GetEquippedPhoneNumber(source)

            if Config.SimCard.ReplaceSimCardNumber then
                Inventory.UpdateSimCardNumber(source, slot, currentNumber)
            elseif Config.SimCard.DeleteSimCard then
                Inventory.RemoveItem(source, slot)
            end
            local success = false
            if Config.Item.Unique then
                if newNumber then
                    Inventory.SetNewNumber(source, Config.Item.Name, currentNumber, newNumber)
                    MySQL.insert.await('INSERT INTO phone_phones (id, owner_id, phone_number) VALUES (?, ?, ?)', {
                        Utils.GenerateSerialNumber(5), Framework.GetIdentifier(source), newNumber
                    })
                else
                    Inventory.ClearCurrentNumber(source, Config.Item.Name, currentNumber)
                end

                MySQL.update.await('UPDATE phone_phones SET id = ? WHERE phone_number = ? AND id = ?', {currentNumber, currentNumber, Framework.GetIdentifier(source)})

                local rows = MySQL.update.await('DELETE FROM phone_last_phone WHERE id = ?', {Framework.GetIdentifier(source)})
                success = rows == 1
            else
                local rows = MySQL.update.await('UPDATE phone_phones SET id = ? WHERE phone_number = ?', {currentNumber, currentNumber})
                success = rows == 1
            end

            if success then TriggerClientEvent('lbphonesim:changingsimcard', source, newNumber or Utils.GenerateNewNumber()) end
        end
    )
elseif Framework.RegisterUsableItem then
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

lib.versionCheck('Maximus7474/lb-phone-simcards')