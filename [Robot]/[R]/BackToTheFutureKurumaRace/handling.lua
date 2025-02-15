function vhandling ( theVehicle )
    if getElementModel(theVehicle) == 445 then -------------- vehicle Id
        setVehicleHandling(theVehicle, "mass", 1500.0)
        setVehicleHandling(theVehicle, "turnMass", 4000)
        setVehicleHandling(theVehicle, "dragCoeff", 2.0 )
        setVehicleHandling(theVehicle, "centerOfMass", { 0.0,0.0,-0.35 } )
        setVehicleHandling(theVehicle, "percentSubmerged", 75)
        setVehicleHandling(theVehicle, "tractionMultiplier", 0.87)
        setVehicleHandling(theVehicle, "tractionLoss", 0.85)
        setVehicleHandling(theVehicle, "tractionBias", 0.48)
        setVehicleHandling(theVehicle, "numberOfGears", 5)
        setVehicleHandling(theVehicle, "maxVelocity", 180.0)
        setVehicleHandling(theVehicle, "engineAcceleration", 6.80 )
        setVehicleHandling(theVehicle, "engineInertia", 10.0)
        setVehicleHandling(theVehicle, "driveType", "fwd")
        setVehicleHandling(theVehicle, "engineType", "petrol")
        setVehicleHandling(theVehicle, "brakeDeceleration", 7.17)
        setVehicleHandling(theVehicle, "brakeBias", 0.55)
        -----abs----
        setVehicleHandling(theVehicle, "steeringLock",  30.0 )
        setVehicleHandling(theVehicle, "suspensionForceLevel", 1.6)
        setVehicleHandling(theVehicle, "suspensionDamping", 0.1 )
        setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 0.0)
        setVehicleHandling(theVehicle, "suspensionUpperLimit", 0.27 )
        setVehicleHandling(theVehicle, "suspensionLowerLimit", -0.13)
        setVehicleHandling(theVehicle, "suspensionFrontRearBias", 0.5 )
        setVehicleHandling(theVehicle, "suspensionAntiDiveMultiplier", 0.3)
        setVehicleHandling(theVehicle, "seatOffsetDistance", 0.24)
        setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.80)
        --setVehicleHandling(theVehicle, "monetary",  10000) This one is disabled for now
        setVehicleHandling(theVehicle, "modelFlags", 0x00000000)
        setVehicleHandling(theVehicle, "handlingFlags", 0x00000000)
        --setVehicleHandling(theVehicle, "headLight", 3) This one is disabled for now
        --setVehicleHandling(theVehicle, "tailLight", 2) This one is disabled for now
        --setVehicleHandling(theVehicle, "animGroup", 4) This one is disabled for now
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), vhandling )