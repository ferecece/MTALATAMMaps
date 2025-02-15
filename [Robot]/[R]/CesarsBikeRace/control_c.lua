addEventHandler("onClientRender", getRootElement(), function()
	if getPedOccupiedVehicle(localPlayer) then
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionMultiplier", 10.0)
		setElementRotation(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, getPedCameraRotation(localPlayer)*(-1))
	end
end )