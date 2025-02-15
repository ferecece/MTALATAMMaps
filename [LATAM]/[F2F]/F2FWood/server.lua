addEvent("onPlayerReachCheckpoint") 
addEventHandler("onPlayerReachCheckpoint", root,
function(checkpoint)
    local pVeh = getPedOccupiedVehicle(source)
    disableCollisions(pVeh)
    setElementAlpha(pVeh, 100)

    setTimer(function()
        enableCollisions(pVeh)
        setElementAlpha(pVeh, 255)
    end, 3000, 1)
end)

function disableCollisions(pVeh)
    local vPlayer = getVehicleOccupant(pVeh)
    if vPlayer then
        triggerClientEvent(vPlayer, "disableCollForPlayer", vPlayer, pVeh)

        for _, player in ipairs(getElementsByType("player")) do
            if player ~= vPlayer then
                triggerClientEvent(player, "disableCollisions", player, pVeh)
            end
        end
    end
end

function enableCollisions(pVeh)
    local vPlayer = getVehicleOccupant(pVeh)
    if vPlayer then
        triggerClientEvent(vPlayer, "enableCollForPlayer", vPlayer, pVeh)

        for _, player in ipairs(getElementsByType("player")) do
            if player ~= vPlayer then
                triggerClientEvent(player, "enableCollisions", player, pVeh)
            end
        end
    end
end