function vhandling ( theVehicle )
    if getElementModel(theVehicle) == 405 then -------------- vehicle Id
        setVehicleHandling(theVehicle, "mass", 1700.0)
        --setVehicleHandling(theVehicle, "turnMass", 4000)
        --setVehicleHandling(theVehicle, "dragCoeff", 2.2 )
        setVehicleHandling(theVehicle, "centerOfMass", { 0.0,0.0,-0.2 } )
        --setVehicleHandling(theVehicle, "percentSubmerged", 75)
        --setVehicleHandling(theVehicle, "tractionMultiplier", 0.95)
        --setVehicleHandling(theVehicle, "tractionLoss", 0.80)
        --setVehicleHandling(theVehicle, "tractionBias", 0.55)
        --setVehicleHandling(theVehicle, "numberOfGears", 5)
        setVehicleHandling(theVehicle, "maxVelocity", 200.0)
        --setVehicleHandling(theVehicle, "engineAcceleration", 9.6 )
        --setVehicleHandling(theVehicle, "engineInertia", 10.0)
        --setVehicleHandling(theVehicle, "driveType", "rwd")
        --setVehicleHandling(theVehicle, "engineType", "petrol")
        --setVehicleHandling(theVehicle, "brakeDeceleration", 10.0)
        setVehicleHandling(theVehicle, "brakeBias", 0.53)
        -----abs----
        setVehicleHandling(theVehicle, "steeringLock",  30.0 )
        --setVehicleHandling(theVehicle, "suspensionForceLevel", 2.20)
        --setVehicleHandling(theVehicle, "suspensionDamping", 0.13 )
        --setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 0.0)
        --setVehicleHandling(theVehicle, "suspensionUpperLimit", 0.17 )
        --setVehicleHandling(theVehicle, "suspensionLowerLimit", -0.11)
        --setVehicleHandling(theVehicle, "suspensionFrontRearBias", 0.5 )
        --setVehicleHandling(theVehicle, "suspensionAntiDiveMultiplier", 0.5)
        --setVehicleHandling(theVehicle, "seatOffsetDistance", 0.2)
        setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.65)
        --setVehicleHandling(theVehicle, "monetary",  10000) This one is disabled for now
        setVehicleHandling(theVehicle, "modelFlags", 0x00000000)
        setVehicleHandling(theVehicle, "handlingFlags", 0x00400000)
        --setVehicleHandling(theVehicle, "headLight", 3) This one is disabled for now
        --setVehicleHandling(theVehicle, "tailLight", 2) This one is disabled for now
        --setVehicleHandling(theVehicle, "animGroup", 4) This one is disabled for now
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), vhandling )