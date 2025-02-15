function vhandling ( theVehicle )
    if getElementModel(theVehicle) == 445 then -------------- vehicle Id
        setVehicleHandling(theVehicle, "mass", 1600.0)
        setVehicleHandling(theVehicle, "turnMass", 4000)
        setVehicleHandling(theVehicle, "dragCoeff", 2.1 )
        setVehicleHandling(theVehicle, "centerOfMass", { 0.0,0.2,-0.35 } )
        setVehicleHandling(theVehicle, "percentSubmerged", 70)
        setVehicleHandling(theVehicle, "tractionMultiplier", 0.70)
        setVehicleHandling(theVehicle, "tractionLoss", 0.80)
        setVehicleHandling(theVehicle, "tractionBias", 0.50)
        setVehicleHandling(theVehicle, "numberOfGears", 3)
        setVehicleHandling(theVehicle, "maxVelocity", 160.0)
        setVehicleHandling(theVehicle, "engineAcceleration", 7.60 )
        setVehicleHandling(theVehicle, "engineInertia", 10.0)
        setVehicleHandling(theVehicle, "driveType", "fwd")
        setVehicleHandling(theVehicle, "engineType", "petrol")
        setVehicleHandling(theVehicle, "brakeDeceleration", 8.0)
        setVehicleHandling(theVehicle, "brakeBias", 0.80)
        -----abs----
        setVehicleHandling(theVehicle, "steeringLock",  30.0 )
        setVehicleHandling(theVehicle, "suspensionForceLevel", 1.1)
        setVehicleHandling(theVehicle, "suspensionDamping", 0.1 )
        setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 5.0)
        setVehicleHandling(theVehicle, "suspensionUpperLimit", 0.31 )
        setVehicleHandling(theVehicle, "suspensionLowerLimit", -0.18)
        setVehicleHandling(theVehicle, "suspensionFrontRearBias", 0.5 )
        setVehicleHandling(theVehicle, "suspensionAntiDiveMultiplier", 0.2)
        setVehicleHandling(theVehicle, "seatOffsetDistance", 0.26)
        setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.50)
        --setVehicleHandling(theVehicle, "monetary",  10000) This one is disabled for now
        setVehicleHandling(theVehicle, "modelFlags", 00000000)
        setVehicleHandling(theVehicle, "handlingFlags", 00000000)
        --setVehicleHandling(theVehicle, "headLight", 3) This one is disabled for now
        --setVehicleHandling(theVehicle, "tailLight", 2) This one is disabled for now
        --setVehicleHandling(theVehicle, "animGroup", 4) This one is disabled for now
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), vhandling )