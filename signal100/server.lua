local signal100Active = false

local function notify(src, msg)
    if src == 0 then
        print(msg)
    else
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 80, 80},
            multiline = true,
            args = {'Signal100', msg}
        })
    end
end

RegisterCommand('signal100', function(source, args, rawCommand)
    if signal100Active then
        notify(source, 'Signal 100 is already active.')
        return
    end

    signal100Active = true
    TriggerClientEvent('signal100:start', -1)

    local starter = source == 0 and 'Console' or ('Player ID ' .. source)
    print(('[Signal100] Activated by %s'):format(starter))
    notify(source, 'Signal 100 activated. Emergency traffic only.')
end, false)

RegisterCommand('signal100stop', function(source, args, rawCommand)
    if not signal100Active then
        notify(source, 'Signal 100 is not active.')
        return
    end

    signal100Active = false
    TriggerClientEvent('signal100:stop', -1)

    local stopper = source == 0 and 'Console' or ('Player ID ' .. source)
    print(('[Signal100] Deactivated by %s'):format(stopper))
    notify(source, 'Signal 100 stopped.')
end, false)

AddEventHandler('playerJoining', function()
    local src = source
    if signal100Active then
        TriggerClientEvent('signal100:start', src)
    end
end)
