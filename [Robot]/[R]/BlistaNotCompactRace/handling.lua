function vhandling ( theVehicle )
    if getElementModel(theVehicle) == 579 then -------------- vehicle Id
        setVehicleHandling(theVehicle, "mass", 1900.0)
        setVehicleHandling(theVehicle, "turnMass", 4712.5)
        setVehicleHandling(theVehicle, "dragCoeff", 2.0 )
        --setVehicleHandling(theVehicle, "centerOfMass", { 0.0,0.0,0.2 } )
        setVehicleHandling(theVehicle, "percentSubmerged", 70)
        setVehicleHandling(theVehicle, "tractionMultiplier", 0.60)
        setVehicleHandling(theVehicle, "tractionLoss", 0.85)
        setVehicleHandling(theVehicle, "tractionBias", 0.50)
        setVehicleHandling(theVehicle, "numberOfGears", 5)
        setVehicleHandling(theVehicle, "maxVelocity", 170.0)
        setVehicleHandling(theVehicle, "engineAcceleration", 8.0 )
        setVehicleHandling(theVehicle, "engineInertia", 15.0)
        setVehicleHandling(theVehicle, "driveType", "fwd")
        setVehicleHandling(theVehicle, "engineType", "petrol")
        setVehicleHandling(theVehicle, "brakeDeceleration", 7.0)
        setVehicleHandling(theVehicle, "brakeBias", 0.65)
        -----abs----
        setVehicleHandling(theVehicle, "steeringLock",  30.0 )
        setVehicleHandling(theVehicle, "suspensionForceLevel", 1.4)
        setVehicleHandling(theVehicle, "suspensionDamping", 0.11 )
        setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 0.0)
        setVehicleHandling(theVehicle, "suspensionUpperLimit", 0.25 )
        setVehicleHandling(theVehicle, "suspensionLowerLimit", -0.15)
        setVehicleHandling(theVehicle, "suspensionFrontRearBias", 0.5 )
        setVehicleHandling(theVehicle, "suspensionAntiDiveMultiplier", 0.0)
        setVehicleHandling(theVehicle, "seatOffsetDistance", 0.2)
        setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.8)
        --setVehicleHandling(theVehicle, "monetary",  20000) This one is disabled for now
        setVehicleHandling(theVehicle, "modelFlags", 0xC0000000)
        setVehicleHandling(theVehicle, "handlingFlags", 0x00C00000)
        --setVehicleHandling(theVehicle, "headLight", 3) This one is disabled for now
        --setVehicleHandling(theVehicle, "tailLight", 2) This one is disabled for now
        --setVehicleHandling(theVehicle, "animGroup", 4) This one is disabled for now
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), vhandling )