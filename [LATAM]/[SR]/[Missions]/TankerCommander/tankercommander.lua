local trailerID = 584

function onGastationCheckpoint(checkpoint, time) 
    if (checkpoint == 1) then
        local veh = getPedOccupiedVehicle(source)
        local trailer = createVehicle(trailerID, 0, 0, 4)
        setVehicleDamageProof(trailer, true)
        setElementModel (veh, 514)
        setTruckPosition(veh)
        attachTrailerToVehicle(veh, trailer)
    end
end 

function setTruckPosition(theTruck)
    setElementPosition(theTruck, 659, -594, 17)
    setElementRotation(theTruck, 0, 0, 160)
    setElementVelocity(theTruck, 0, 0, 0)
end

function onDettach(theTruck)
    if (getElementModel(theTruck) == 514) then
        setTruckPosition(theTruck)
        attachTrailerToVehicle(theTruck, source)
    else 
        destroyElement(source)
    end
end

function onSpawn()
        setTimer(respawnPlayer, 100, 1, source)
end

function respawnPlayer(player)
    local veh = getPedOccupiedVehicle(player)
    if (getElementData(player, "race.checkpoint")==2) then
        setTruckPosition(veh)
        setElementModel(veh, 514)
    else
        detachTrailerFromVehicle(veh)
    end
end


addEvent('onPlayerReachCheckpoint')
addEventHandler('onPlayerReachCheckpoint', getRootElement(), onGastationCheckpoint) 
addEventHandler('onTrailerDetach', getRootElement(), onDettach)
addEventHandler("onPlayerSpawn", getRootElement(), onSpawn)