local INV = {}

local ox_inv = exports.ox_inventory

---@param cb function
function INV.RegisterItemCB(cb)
    exports('simcard', function (event, item, inventory, slot, data)
        -- lib.print.info('item', item)
        -- lib.print.info('slot', slot)
        -- lib.print.info('data', data)
        if event == 'usedItem' then
            cb(inventory.id, data?.lbPhoneNumber, slot)
        end
    end)
end

function INV.UpdateSimCardNumber(source, slot, number)
    ox_inv:SetMetadata(source, slot, {lbPhoneNumber = number})
end

function INV.RemoveItem(source, slot)
    ox_inv:RemoveItem(source, Config.SimCard.ItemName, 1, false, slot)
end

function INV.SetNewNumber(source, itemName, currentNumber, newNumber)

    local item = ox_inv:GetSlotWithItem(source, itemName, {lbPhoneNumber = currentNumber}, false)

    local metadata = item.metadata
    metadata.lbPhoneNumber = newNumber
    metadata.lbFormattedNumber = exports['lb-phone']:FormatNumber(newNumber)

    ox_inv:SetMetadata(source, item.slot, metadata)
end

function INV.ClearCurrentNumber(source, itemName, currentNumber)

    local item = ox_inv:GetSlotWithItem(source, itemName, {lbPhoneNumber = currentNumber}, false)

    ox_inv:SetMetadata(source, item.slot, {})
end

return INV