-- Skips
skipMarker = 30

addEvent("setSkip", true)
addEventHandler("setSkip", getRootElement(), function(markerID)
	if getElementData(localPlayer, "race.checkpoint") == markerID then
		
		local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
		if #colshapes ~= 0 then
			triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer))
		end
	end
	
	resetCheckpoints()
	setElementData(localPlayer, "skipped", 1)
	skipMarker = markerID
end )