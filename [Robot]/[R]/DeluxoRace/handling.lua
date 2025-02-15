function vhandling ( theVehicle )
    if getElementModel(theVehicle) == 402 then -------------- vehicle Id
        setVehicleHandling(theVehicle, "mass", 1600.0)
        setVehicleHandling(theVehicle, "turnMass", 4000.0)
        setVehicleHandling(theVehicle, "dragCoeff", 2.2 )
        --setVehicleHandling(theVehicle, "centerOfMass", { 0.0,0.0,0.2 } )
        setVehicleHandling(theVehicle, "percentSubmerged", 75)
        setVehicleHandling(theVehicle, "tractionMultiplier", 0.85)
        setVehicleHandling(theVehicle, "tractionLoss", 0.85)
        setVehicleHandling(theVehicle, "tractionBias", 0.50)
        setVehicleHandling(theVehicle, "numberOfGears", 5)
        setVehicleHandling(theVehicle, "maxVelocity", 200.0)
        setVehicleHandling(theVehicle, "engineAcceleration", 10.4 )
        setVehicleHandling(theVehicle, "engineInertia", 5.0)
        setVehicleHandling(theVehicle, "driveType", "awd")
        setVehicleHandling(theVehicle, "engineType", "petrol")
        setVehicleHandling(theVehicle, "brakeDeceleration", 10.0)
        setVehicleHandling(theVehicle, "brakeBias", 0.53)
        -----abs----
        setVehicleHandling(theVehicle, "steeringLock",  30.0 )
        setVehicleHandling(theVehicle, "suspensionForceLevel", 2.25)
        setVehicleHandling(theVehicle, "suspensionDamping", 0.16 )
        setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 0.0)
        setVehicleHandling(theVehicle, "suspensionUpperLimit", 0.27 )
        setVehicleHandling(theVehicle, "suspensionLowerLimit", -0.16)
        setVehicleHandling(theVehicle, "suspensionFrontRearBias", 0.5 )
        setVehicleHandling(theVehicle, "suspensionAntiDiveMultiplier", 0.35)
        setVehicleHandling(theVehicle, "seatOffsetDistance", 0.28)
        setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.52)
        --setVehicleHandling(theVehicle, "monetary",  10000) This one is disabled for now
        setVehicleHandling(theVehicle, "modelFlags", 0xC0002004)
        setVehicleHandling(theVehicle, "handlingFlags", 0x00C00002)
        --setVehicleHandling(theVehicle, "headLight", 3) This one is disabled for now
        --setVehicleHandling(theVehicle, "tailLight", 2) This one is disabled for now
        --setVehicleHandling(theVehicle, "animGroup", 4) This one is disabled for now
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), vhandling )