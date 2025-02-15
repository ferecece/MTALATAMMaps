function finishRace()
	target = 100
	local checkpoint = getElementData(localPlayer, "race.checkpoint")
    if not checkpoint then 
        return
    end
    if (checkpoint > target) then 
        return 
    end
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if (isElementFrozen(vehicle)) then 
        return 
    end
    for i=checkpoint, target do
        local raceresource = getResourceFromName("race")
        local racedynamics = getResourceDynamicElementRoot(raceresource)
        local colshapes = getElementsByType("colshape", racedynamics)
        if (#colshapes == 0) then
            break
        end
        triggerEvent("onClientColShapeHit", colshapes[#colshapes], vehicle)
    end

end
addEvent ( "coastFinish", true )
addEventHandler ("coastFinish", getRootElement(), finishRace )

setDevelopmentMode(true)