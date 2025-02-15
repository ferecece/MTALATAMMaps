addEventHandler("onClientRender", getRootElement(), function()
	-- Spectate check
	if not getPedOccupiedVehicle(localPlayer) then return end
	
	local x, y, z = getElementPosition(localPlayer)
	if z > 1000 or getElementData(localPlayer, "state") == "spectating" then return end
	
	local vehicle = getPedOccupiedVehicle(localPlayer)
	attachElements(getCamera(), vehicle, -0.5, -0.3, 0.75)
end)