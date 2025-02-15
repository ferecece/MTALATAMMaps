addEvent("disableCollisions", true)
addEventHandler("disableCollisions", localPlayer, 
function(pVeh)
    local veh = getPedOccupiedVehicle(localPlayer)
    setElementCollidableWith(pVeh, veh, false)
end)

addEvent("disableCollForPlayer", true)
addEventHandler("disableCollForPlayer", localPlayer, 
function(pVeh)
    for _, veh in ipairs(getElementsByType("vehicle")) do
        setElementCollidableWith(pVeh, veh, false)
    end
end)


addEvent("enableCollisions", true)
addEventHandler("enableCollisions", localPlayer, 
function(pVeh)
    local veh = getPedOccupiedVehicle(localPlayer)
    setElementCollidableWith(pVeh, veh, true)
end)

addEvent("enableCollForPlayer", true)
addEventHandler("enableCollForPlayer", localPlayer, 
function(pVeh)
    for _, veh in ipairs(getElementsByType("vehicle")) do
        setElementCollidableWith(pVeh, veh, true)
    end
end)