function vhandling ( theVehicle )
    if getElementModel(theVehicle) == 480 then -------------- vehicle Id
        setVehicleHandling(theVehicle, "mass", 1500.0)
        setVehicleHandling(theVehicle, "turnMass", 3000.0)
        setVehicleHandling(theVehicle, "dragCoeff", 1.8 )
        setVehicleHandling(theVehicle, "centerOfMass", { 0.0,0.0,-0.2 } )
        setVehicleHandling(theVehicle, "percentSubmerged", 70)
        setVehicleHandling(theVehicle, "tractionMultiplier", 0.75)
        setVehicleHandling(theVehicle, "tractionLoss", 0.90)
        setVehicleHandling(theVehicle, "tractionBias", 0.48)
        setVehicleHandling(theVehicle, "numberOfGears", 5)
        setVehicleHandling(theVehicle, "maxVelocity", 200.0)
        setVehicleHandling(theVehicle, "engineAcceleration", 12.4 )
        setVehicleHandling(theVehicle, "engineInertia", 10.0)
        setVehicleHandling(theVehicle, "driveType", "rwd")
        setVehicleHandling(theVehicle, "engineType", "petrol")
        setVehicleHandling(theVehicle, "brakeDeceleration", 8.0)
        setVehicleHandling(theVehicle, "brakeBias", 0.58)
        -----abs----
        setVehicleHandling(theVehicle, "steeringLock",  30.0 )
        setVehicleHandling(theVehicle, "suspensionForceLevel", 1.0)
        setVehicleHandling(theVehicle, "suspensionDamping", 0.13 )
        setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 5.0)
        setVehicleHandling(theVehicle, "suspensionUpperLimit", 0.25 )
        setVehicleHandling(theVehicle, "suspensionLowerLimit", -0.10)
        setVehicleHandling(theVehicle, "suspensionFrontRearBias", 0.45 )
        setVehicleHandling(theVehicle, "suspensionAntiDiveMultiplier", 0.3)
        setVehicleHandling(theVehicle, "seatOffsetDistance", 0.15)
        setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.54)
        --setVehicleHandling(theVehicle, "monetary",  10000) This one is disabled for now
        setVehicleHandling(theVehicle, "modelFlags", 0xC0002004)
        setVehicleHandling(theVehicle, "handlingFlags", 0x1040C002)
        --setVehicleHandling(theVehicle, "headLight", 3) This one is disabled for now
        --setVehicleHandling(theVehicle, "tailLight", 2) This one is disabled for now
        --setVehicleHandling(theVehicle, "animGroup", 4) This one is disabled for now
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), vhandling )