function setHandling ( thePlayer, seat, jacked ) -- assign players to a team (if they are not already) and paint their vehicle accordingly
	--destroyAttachedElements(source) -- remove all attached objects from possible upgrades
	
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
	
	setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.3)
	setVehicleHandling(theVehicle, "maxVelocity", 300)
	setVehicleHandling(theVehicle, "engineAcceleration", 16)
	setVehicleHandling(theVehicle, "tractionMultiplier", 2)
	setVehicleHandling(theVehicle, "brakeDeceleration", 20.0)
	setVehicleHandling(theVehicle, "centerOfMass", {0.0, -0.0, -0.5})
	setVehicleHandling(theVehicle, "numberOfGears", 8)
	setVehicleHandling(theVehicle, "dragCoeff", 0.1 )
	--setVehicleHandling(theVehicle, "mass", 4000.0)
	setVehicleHandling(theVehicle, "steeringLock",  10.0 )
	setVehicleHandling(theVehicle, "suspensionUpperLimit", -0.15 )
	setVehicleHandling(theVehicle, "suspensionLowerLimit", -0.16 )
	setVehicleHandling(theVehicle, "driveType", "awd")
	setVehicleHandling(theVehicle, "brakeBias", 0.60)
	setVehicleHandling(theVehicle, "suspensionFrontRearBias", 0.51 )
	setVehicleHandling(theVehicle, "suspensionForceLevel", 0.85)
	setVehicleHandling(theVehicle, "suspensionDamping", 50 )
    --setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 1.0)
	setVehicleHandling(theVehicle, "tractionBias", 0.45)
	setVehicleHandling(theVehicle, "engineInertia", 25)
end
addEventHandler ( "onVehicleEnter", getRootElement(), setHandling )