local signal100Running = false
local signal100Thread = nil
local repeatIntervalMs = 30000

local function playSignal100()
    TriggerEvent('chat:addMessage', {
        color = {255, 0, 0},
        multiline = true,
        args = {'Dispatch', 'Signal 100 in effect. Radio traffic is restricted to emergency traffic only.'}
    })

    SendNUIMessage({
        action = 'play'
    })
end

local function stopSignal100Audio()
    SendNUIMessage({
        action = 'stop'
    })

    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {'Dispatch', 'Signal 100 has been cleared.'}
    })
end

RegisterNetEvent('signal100:start', function()
    if signal100Running then
        return
    end

    signal100Running = true
    playSignal100()

    signal100Thread = CreateThread(function()
        while signal100Running do
            Wait(repeatIntervalMs)

            if signal100Running then
                playSignal100()
            end
        end
    end)
end)

RegisterNetEvent('signal100:stop', function()
    signal100Running = false
    stopSignal100Audio()
end)
