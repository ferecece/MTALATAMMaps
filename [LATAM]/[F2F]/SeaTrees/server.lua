addEvent("onPlayerReachCheckpoint") 
addEventHandler("onPlayerReachCheckpoint", root,
function(checkpoint)
    if checkpoint == 19 then
        for i=6, 1, -1 do 
            outputChatBox(getPlayerName(source).."#FF0000 VA EN EL ULTIMO AUTO!!!!!!", root, 255, 255, 255, true)
        end
    end
    local pVeh = getPedOccupiedVehicle(source)
    fixVehicle(pVeh)
    disableCollisions(pVeh)
    setElementAlpha(pVeh, 100)

    setTimer(function()
        enableCollisions(pVeh)
        setElementAlpha(pVeh, 255)
    end, 5000, 1)
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