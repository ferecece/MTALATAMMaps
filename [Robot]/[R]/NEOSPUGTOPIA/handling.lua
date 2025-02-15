function handling()
    for _,veh in pairs(getElementsByType("vehicle")) do
        if getElementModel(veh) == 496 then
            --setVehicleHandling(veh,"mass",1000)
            --setVehicleHandling(veh,"turnMass",2000)
            setVehicleHandling(veh,"collisionDamageMultiplier",0.2)
            --setVehicleHandling(veh,"steeringLock",25)
            --setVehicleHandling(veh,"drag",0.0)
            setVehicleHandling(veh,"engineAcceleration",12)
            setVehicleHandling(veh,"maxVelocity",240)
            setVehicleHandling(veh,"tractionMultiplier",1.0)
            setVehicleHandling(veh,"headLight",long)       
            setVehicleHandling(veh,"brakeDeceleration",20)
            --setVehicleHandling(veh,"suspensionDamping",0.20)  
            --setVehicleHandling(veh,"suspensionHighSpeedDamping",10)            
            end
        end
     
    end
    addEventHandler("onPlayerVehicleEnter", getRootElement(), handling)
