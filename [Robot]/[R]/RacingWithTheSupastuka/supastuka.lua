addEventHandler("onClientRender", root, function()
	for i, v in pairs(getElementsByType("player")) do
		vehicle = getPedOccupiedVehicle(v)
		if (vehicle and getElementModel(vehicle) == 555) then
			setElementAlpha(vehicle, 0)
			setElementAlpha(v, 0)
		end
	end
end )