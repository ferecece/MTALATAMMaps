function vhandling ( theVehicle )
    if getElementModel(theVehicle) == 545 then -------------- vehicle Id
        setVehicleHandling(theVehicle, "mass", 1800.0)
        setVehicleHandling(theVehicle, "turnMass", 4000.0)
        setVehicleHandling(theVehicle, "dragCoeff", 2.0 )
        setVehicleHandling(theVehicle, "centerOfMass", { 0.0,0.1,-0.1 } )
        setVehicleHandling(theVehicle, "percentSubmerged", 85)
        setVehicleHandling(theVehicle, "tractionMultiplier", 0.70)
        setVehicleHandling(theVehicle, "tractionLoss", 0.90)
        setVehicleHandling(theVehicle, "tractionBias", 0.50)
        setVehicleHandling(theVehicle, "numberOfGears", 5)
        setVehicleHandling(theVehicle, "maxVelocity", 180.0)
        setVehicleHandling(theVehicle, "engineAcceleration", 12.8 )
        setVehicleHandling(theVehicle, "engineInertia", 5.0)
        setVehicleHandling(theVehicle, "driveType", "rwd")
        setVehicleHandling(theVehicle, "engineType", "petrol")
        setVehicleHandling(theVehicle, "brakeDeceleration", 11.0)
        setVehicleHandling(theVehicle, "brakeBias", 0.45)
        -----abs----
        setVehicleHandling(theVehicle, "steeringLock",  30.0 )
        setVehicleHandling(theVehicle, "suspensionForceLevel", 1.2)
        setVehicleHandling(theVehicle, "suspensionDamping", 0.12 )
        setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 0.0)
        setVehicleHandling(theVehicle, "suspensionUpperLimit", 0.28 )
        setVehicleHandling(theVehicle, "suspensionLowerLimit", -0.24)
        setVehicleHandling(theVehicle, "suspensionFrontRearBias", 0.5 )
        setVehicleHandling(theVehicle, "suspensionAntiDiveMultiplier", 0.4)
        setVehicleHandling(theVehicle, "seatOffsetDistance", 0.25)
        setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.55)
        --setVehicleHandling(theVehicle, "monetary",  10000) This one is disabled for now
        setVehicleHandling(theVehicle, "modelFlags", 0x00002800)
        setVehicleHandling(theVehicle, "handlingFlags", 0x10200000)
        --setVehicleHandling(theVehicle, "headLight", 3) This one is disabled for now
        --setVehicleHandling(theVehicle, "tailLight", 2) This one is disabled for now
        --setVehicleHandling(theVehicle, "animGroup", 4) This one is disabled for now
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), vhandling )