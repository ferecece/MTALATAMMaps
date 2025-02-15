local oldCP = 0

addEventHandler("onClientRender", root, function()
	if not getPedOccupiedVehicle(localPlayer) or not getCameraTarget() then return end

	local u, w, v = getElementPosition(localPlayer)
	local playerCP

	if v > 20000 and getElementType(getCameraTarget()) == "vehicle" then playerCP = tonumber(getElementData(getVehicleOccupant(getCameraTarget()), "race.checkpoint"))
	else playerCP = tonumber(getElementData(localPlayer, "race.checkpoint")) end

	-- Events
	if playerCP then
		-- Teleport to Planning Department
		if playerCP == 13 and oldCP ~= playerCP and v < 20000 then
			setElementInterior(getPedOccupiedVehicle(localPlayer), 3)
			setElementPosition(getPedOccupiedVehicle(localPlayer), 383.361, 173.629, 1008.047)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, 90)
			setElementVelocity(getPedOccupiedVehicle(localPlayer), 0, 0, 0)

			oldCP = playerCP
		end

		-- Interior bullshitery
		if playerCP >= 13 then
			for index, players in ipairs(getElementsByType("player")) do setElementInterior(players, 3) end
			for index, markers in ipairs(getElementsByType("marker")) do setElementInterior(markers, 3) end
			for index, vehicles in ipairs(getElementsByType("vehicle")) do setElementInterior(vehicles, 3) end
			for index, pickups in ipairs(getElementsByType("pickup")) do setElementInterior(pickups, 3) end
			for index, spawnpoints in ipairs(getElementsByType("spawnpoint")) do setElementInterior(spawnpoints, 3) end
			for index, peds in ipairs(getElementsByType("ped")) do setElementInterior(peds, 3) end
		else
			for index, players in ipairs(getElementsByType("player")) do setElementInterior(players, 0) end
			for index, markers in ipairs(getElementsByType("marker")) do setElementInterior(markers, 0) end
			for index, vehicles in ipairs(getElementsByType("vehicle")) do setElementInterior(vehicles, 0) end
			for index, pickups in ipairs(getElementsByType("pickup")) do setElementInterior(pickups, 0) end
			for index, spawnpoints in ipairs(getElementsByType("spawnpoint")) do setElementInterior(spawnpoints, 0) end
			for index, peds in ipairs(getElementsByType("ped")) do setElementInterior(peds, 0) end
		end
	end
end )

addEventHandler( "onClientResourceStop", getRootElement( ),
	function ( resetInteriorID )
		for index, players in ipairs(getElementsByType("player")) do setElementInterior(players, 0) end
		for index, markers in ipairs(getElementsByType("marker")) do setElementInterior(markers, 0) end
		for index, vehicles in ipairs(getElementsByType("vehicle")) do setElementInterior(vehicles, 0) end
		for index, pickups in ipairs(getElementsByType("pickup")) do setElementInterior(pickups, 0) end
		for index, spawnpoints in ipairs(getElementsByType("spawnpoint")) do setElementInterior(spawnpoints, 0) end
		for index, peds in ipairs(getElementsByType("ped")) do setElementInterior(peds, 0) end
	end
);
