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
        lib.print.error(T('DEBUG.SETTING_NUMBER_FAILED'), err)
        return
    end

    lbphone:SendNotification({
        app = "Settings",
        title = T('NOTIFICATIONS.NUMBER_CHANGED.TITLE'),
        content = T('NOTIFICATIONS.NUMBER_CHANGED.DESCRIPTION', {number = lbphone:FormatNumber(newNumber)}),
    })
end)