function vhandling ( theVehicle )
    if getElementModel(theVehicle) == 415 then -------------- vehicle Id
        setVehicleHandling(theVehicle, "mass", 1150.0)
        setVehicleHandling(theVehicle, "turnMass", 2500.0)
        setVehicleHandling(theVehicle, "dragCoeff", 2.0 )
        setVehicleHandling(theVehicle, "centerOfMass", { 0.0,-0.2,-0.2 } )
        setVehicleHandling(theVehicle, "percentSubmerged", 70)
        setVehicleHandling(theVehicle, "tractionMultiplier", 0.79)
        setVehicleHandling(theVehicle, "tractionLoss", 0.90)
        setVehicleHandling(theVehicle, "tractionBias", 0.50)
        setVehicleHandling(theVehicle, "numberOfGears", 5)
        setVehicleHandling(theVehicle, "maxVelocity", 230.0)
        setVehicleHandling(theVehicle, "engineAcceleration", 12.80 )
        setVehicleHandling(theVehicle, "engineInertia", 10.0)
        setVehicleHandling(theVehicle, "driveType", "rwd")
        setVehicleHandling(theVehicle, "engineType", "petrol")
        setVehicleHandling(theVehicle, "brakeDeceleration", 10.10)
        setVehicleHandling(theVehicle, "brakeBias", 0.48)
        -----abs----
        setVehicleHandling(theVehicle, "steeringLock",  35.0 )
        setVehicleHandling(theVehicle, "suspensionForceLevel", 0.8)
        setVehicleHandling(theVehicle, "suspensionDamping", 0.2 )
        setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 0.0)
        setVehicleHandling(theVehicle, "suspensionUpperLimit", 0.10 )
        setVehicleHandling(theVehicle, "suspensionLowerLimit", -0.15)
        setVehicleHandling(theVehicle, "suspensionFrontRearBias", 0.5 )
        setVehicleHandling(theVehicle, "suspensionAntiDiveMultiplier", 0.6)
        setVehicleHandling(theVehicle, "seatOffsetDistance", 0.40)
        setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.54)
        --setVehicleHandling(theVehicle, "monetary",  10000) This one is disabled for now
        --setVehicleHandling(theVehicle, "modelFlags", c0002004)
        --setVehicleHandling(theVehicle, "handlingFlags", 208000)
        --setVehicleHandling(theVehicle, "headLight", 3) This one is disabled for now
        --setVehicleHandling(theVehicle, "tailLight", 2) This one is disabled for now
        --setVehicleHandling(theVehicle, "animGroup", 4) This one is disabled for now
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), vhandling )