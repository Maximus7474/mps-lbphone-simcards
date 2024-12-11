local lbphone = exports['lb-phone']

RegisterNetEvent('lbphonesim:changingsimcard', function (newNumber)
    if lbphone:IsOpen() then
        lbphone:ToggleOpen(false, false)
    end

    local status, err = pcall(function ()
        Wait(100)
        lbphone:SetPhone(newNumber, false)
    end)
    if not status then
        lib.print.error('Setting the new number failed !', err)
        return
    end

    lbphone:SendNotification({
        app = "Settings",
        title = "Sim Card Changed",
        content = ("Your phone number has changed to %s"):format(lbphone:FormatNumber(newNumber)),
    })
end)