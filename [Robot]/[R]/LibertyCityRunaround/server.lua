function setInteriors ( )
	for index, players in ipairs(getElementsByType("player")) do
		setElementInterior(players, 1)
		playerX, playerY, playerZ = getElementPosition(players)
		if playerZ < 1320 and getVehicleName(getPedOccupiedVehicle(players)) ~= "Shamal" then
			killPed(players)
		end
	end
	for index, markers in ipairs(getElementsByType("marker")) do
		setElementInterior(markers, 1)
	end
	for index, vehicles in ipairs(getElementsByType("vehicle")) do
		setElementInterior(vehicles, 1)
	end
	for index, pickups in ipairs(getElementsByType("pickup")) do
		setElementInterior(pickups, 1)
	end
	for index, spawnpoints in ipairs(getElementsByType("spawnpoint")) do
		setElementInterior(spawnpoints, 1)
	end
	setTimer(setInteriors, 1000, 1)
end
addEventHandler ( "onResourceStart", getRootElement(), setInteriors )

function setHandling ( thePlayer, seat, jacked )
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
	
	setVehicleHandling (theVehicle, "centerOfMass", { 0.0,0.0,-0.25 })
	setVehicleHandling (theVehicle, "tractionMultiplier", 1.3)
	setVehicleHandling (theVehicle, "tractionLoss", 0.84)
	setVehicleHandling (theVehicle, "tractionBias", 0.53)
	setVehicleHandling (theVehicle, "brakeDeceleration", 11.1)
	setVehicleHandling (theVehicle, "steeringLock", 30.0)
	setVehicleHandling (theVehicle, "suspensionForceLevel", 2.0)
	setVehicleHandling (theVehicle, "suspensionDamping", 0.13)
	setVehicleHandling (theVehicle, "collisionDamageMultiplier", 0.7)
	setVehicleHandling (theVehicle, "suspensionUpperLimit", 0.25)
	setVehicleHandling (theVehicle, "suspensionLowerLimit", -0.18)
end
addEventHandler ( "onVehicleEnter", getRootElement(), setHandling )

function EndingSequence ( )
	triggerClientEvent (source, "PlayEndSequence", getRootElement())
end
addEvent("onPlayerFinish")
addEventHandler("onPlayerFinish", root, EndingSequence)

