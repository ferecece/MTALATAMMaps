function vhandling ( theVehicle )
    if getElementModel(theVehicle) == 535 then -------------- vehicle Id
        setVehicleHandling(theVehicle, "mass", 1500.0)
        setVehicleHandling(theVehicle, "turnMass", 3921.3)
        setVehicleHandling(theVehicle, "dragCoeff", 2.0 )
        setVehicleHandling(theVehicle, "centerOfMass", { 0.0,0.0,-0.25 } )
        --setVehicleHandling(theVehicle, "percentSubmerged", 70)
        setVehicleHandling(theVehicle, "tractionMultiplier", 0.90)
        setVehicleHandling(theVehicle, "tractionLoss", 0.80)
        setVehicleHandling(theVehicle, "tractionBias", 0.53)
        --setVehicleHandling(theVehicle, "numberOfGears", 5)
        setVehicleHandling(theVehicle, "maxVelocity", 180.0)
        setVehicleHandling(theVehicle, "engineAcceleration", 12.0 )
        setVehicleHandling(theVehicle, "engineInertia", 5.0)
        setVehicleHandling(theVehicle, "driveType", "rwd")
        setVehicleHandling(theVehicle, "engineType", "petrol")
        setVehicleHandling(theVehicle, "brakeDeceleration", 6.1)
        setVehicleHandling(theVehicle, "brakeBias", 0.52)
        -----abs----
        setVehicleHandling(theVehicle, "steeringLock",  30.0 )
        setVehicleHandling(theVehicle, "suspensionForceLevel", 1.20)
        setVehicleHandling(theVehicle, "suspensionDamping", 0.1 )
        setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 0.0)
        setVehicleHandling(theVehicle, "suspensionUpperLimit", 0.30 )
        setVehicleHandling(theVehicle, "suspensionLowerLimit", -0.20)
        setVehicleHandling(theVehicle, "suspensionFrontRearBias", 0.5 )
        setVehicleHandling(theVehicle, "suspensionAntiDiveMultiplier", 0.0)
        setVehicleHandling(theVehicle, "seatOffsetDistance", 0.3)
        setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.65)
        --setVehicleHandling(theVehicle, "monetary",  45000) This one is disabled for now
        setVehicleHandling(theVehicle, "modelFlags", 0x00002800)
        setVehicleHandling(theVehicle, "handlingFlags", 0x00000004)
        --setVehicleHandling(theVehicle, "headLight", 3) This one is disabled for now
        --setVehicleHandling(theVehicle, "tailLight", 2) This one is disabled for now
        --setVehicleHandling(theVehicle, "animGroup", 4) This one is disabled for now
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), vhandling )