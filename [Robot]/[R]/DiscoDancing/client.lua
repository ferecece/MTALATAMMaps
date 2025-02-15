function CollectCheckpoints()

    if (getElementData(localPlayer, "race.finished") == true) then
        return
    end
    
    local raceresource = getResourceFromName("race")
    local racedynamics = getResourceDynamicElementRoot(raceresource)
    
    local colshapes = getElementsByType("colshape", racedynamics)
    triggerEvent("onClientColShapeHit", colshapes[#colshapes],
        getPedOccupiedVehicle(localPlayer))

end
addEvent("collectCP",true)
addEventHandler("collectCP",root,CollectCheckpoints)