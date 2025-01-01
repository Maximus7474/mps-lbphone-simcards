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
            local identifier = Framework.GetIdentifier(source)

            if Config.SimCard.ReplaceSimCardNumber then
                Inventory.UpdateSimCardNumber(source, slot, currentNumber)
            end
            local success = false
            if Config.Item.Unique then
                if newNumber then
                    Inventory.SetNewNumber(source, Config.Item.Name, currentNumber, newNumber)
                    MySQL.insert.await('INSERT IGNORE INTO phone_phones (id, owner_id, phone_number) VALUES (?, ?, ?)', {
                        Utils.GenerateSerialNumber(5), identifier, newNumber
                    })
                else
                    Inventory.ClearCurrentNumber(source, Config.Item.Name, currentNumber)
                end

                MySQL.update.await('UPDATE phone_phones SET id = ? WHERE phone_number = ? AND id = ?', {currentNumber, currentNumber, identifier})

                local rows = MySQL.update.await('DELETE FROM phone_last_phone WHERE id = ?', {})
                success = rows == 1
            else
                local rows = MySQL.update.await('UPDATE phone_phones SET id = ? WHERE phone_number = ?', {currentNumber, currentNumber})
                success = rows == 1
            end

            if not success then return end

            local rows = MySQL.update.await('INSERT IGNORE INTO phone_last_phone (id, phone_number) VALUES (?, ?) ON DUPLICATE KEY UPDATE phone_number = VALUES(phone_number)', {identifier, newNumber})
            success = rows == 1

            if not success then return end

            lib.callback('lbphonesim:changingsimcard', source, function (response)
                if response == true then
                    if Config.SimCard.DeleteSimCard then
                        Inventory.RemoveItem(source, slot)
                    end
                    return
                end

                lib.print.error('Unable to change phone number for ' .. source .. ', failed with error:', response)
            end, newNumber or Utils.GenerateNewNumber())
        end
    )
elseif Framework.RegisterUsableItem then
    --[[ Wouldn't be used for unique items ]]
    Framework.RegisterUsableItem(
        function (source)
            local newNumber = Utils.GenerateNewNumber()
            local currentNumber = exports['lb-phone']:GetEquippedPhoneNumber(source)

            TriggerClientEvent('lbphonesim:changingsimcard', source, newNumber)

            local rows = MySQL.update.await('UPDATE phone_phones SET id = ? WHERE phone_number = ?', {currentNumber, currentNumber})
            local success = rows == 1

            if success then TriggerClientEvent('lbphonesim:changingsimcard', source, newNumber) end
        end
    )
end

lib.versionCheck('Maximus7474/lb-phone-simcards')