function setInteriors()
	for index, players in ipairs(getElementsByType("player")) do
		setElementInterior(players, 15)
	end
	for index, markers in ipairs(getElementsByType("marker")) do
		setElementInterior(markers, 15)
	end
	for index, vehicles in ipairs(getElementsByType("vehicle")) do
		setElementInterior(vehicles, 15)
	end
	for index, pickups in ipairs(getElementsByType("pickup")) do
		setElementInterior(pickups, 15)
	end
	for index, spawnpoints in ipairs(getElementsByType("spawnpoint")) do
		setElementInterior(spawnpoints, 15)
	end
	for index, peds in ipairs(getElementsByType("ped")) do
		setElementInterior(peds, 15)
	end
	setTimer(setInteriors, 1000, 1)
end
addEventHandler("onResourceStart", getRootElement(), setInteriors)