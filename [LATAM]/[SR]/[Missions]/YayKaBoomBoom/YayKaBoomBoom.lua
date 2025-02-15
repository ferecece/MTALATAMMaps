function checkCheckpoint(checkpoint, time) 
    local veh = getPedOccupiedVehicle(source)
    if (checkpoint == 2) then
        onTampa(veh)
    end
    if (checkpoint == 5) then
        onBike(veh)
    end
end 

function onTampa(veh) 
    setElementModel(veh, 549)
    setElementPosition(veh, -1699, 1036, 46)
    setElementRotation(veh, 0, 0, 180)
    setElementVelocity(veh, 0, 0, 0)
end

function onBike(veh)
    setElementModel(veh, 509)
    setElementPosition(veh, -2180, -262, 37)
    setElementRotation(veh, 0, 0, 270)
    setElementVelocity(veh, 0, 0, 0)
end

addEvent('onPlayerReachCheckpoint') 
addEventHandler('onPlayerReachCheckpoint', getRootElement(), checkCheckpoint) 