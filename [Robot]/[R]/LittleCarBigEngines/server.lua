function addEngine ( thePlayer, seat, jacked ) -- assign players to a team (if they are not already) and paint their vehicle accordingly
	--destroyAttachedElements(source) -- remove all attached objects from possible upgrades
	
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
	local x,y,z = getElementPosition(theVehicle)
	
	local jetEngineRight = createObject(1305,x,y,z)
	setElementCollisionsEnabled(jetEngineRight, false)
	attachElements(jetEngineRight,theVehicle,1,0,0)
	
	local jetEngineLeft = createObject(1304,x,y,z)
	setElementCollisionsEnabled(jetEngineLeft, false)
	attachElements(jetEngineLeft,theVehicle,-1,0,0)
	
	setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.2)
	setVehicleHandling(theVehicle, "maxVelocity", 500)
	setVehicleHandling(theVehicle, "engineAcceleration", 2)
	setVehicleHandling(theVehicle, "tractionMultiplier", 1.2)
	--setVehicleHandling(theVehicle, "brakeDeceleration", 20.0)
	setVehicleHandling(theVehicle, "centerOfMass", {0.0, 0.0, -0.4})
	--setVehicleHandling(theVehicle, "mass", 1000.0)
end
addEventHandler ( "onVehicleEnter", getRootElement(), addEngine )