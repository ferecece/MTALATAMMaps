addEventHandler("onClientResourceStart", resourceRoot, function()
	engineImportTXD(engineLoadTXD("monster.txd"), 444)
	engineReplaceModel(engineLoadDFF("monster.dff"), 444)

	setVehicleModelWheelSize(444, "all_wheels", 3)
end )

addEventHandler("onClientRender", root, function()
	-- Set local's player handling
	if getPedOccupiedVehicle(localPlayer) then
		if getElementModel(getPedOccupiedVehicle(localPlayer)) == 444 and getVehicleHandling(getPedOccupiedVehicle(localPlayer), "turnMass") ~= 1000000.0 then
			setVehicleHandling(getPedOccupiedVehicle(localPlayer), "mass", 40000.0)
			setVehicleHandling(getPedOccupiedVehicle(localPlayer), "turnMass", 1000000.0)
			setVehicleHandling(getPedOccupiedVehicle(localPlayer), "maxVelocity", 200.0)
			setWeatherBlended(2)
		end
	end
	
	-- Set vehicle's wheels scale
	for _, vehicles in ipairs(getElementsByType("vehicle")) do
		if getElementModel(vehicles) == 444 and getVehicleWheelScale(vehicles) ~= 2.3 then setVehicleWheelScale(vehicles, 2.3)
		elseif getElementModel(vehicles) ~= 444 and getVehicleWheelScale(vehicles) ~= 1 then setVehicleWheelScale(vehicles, 1) end
	end
end )