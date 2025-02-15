function handling (  )
    for _,veh in pairs(getElementsByType("vehicle")) do
        if getElementModel(veh) == 541 then
            setVehicleHandling(veh,"collisionDamageMultiplier",0.15)
            --setVehicleHandling(veh,"drag",0.5)
            --setVehicleHandling(veh,"engineAcceleration",13)
            setVehicleHandling(veh,"tractionMultiplier",0.85)
            setVehicleHandling(veh,"headLight",long)  
            --setVehicleHandling(veh,"tractionLoss",100)
            --setVehicleHandling(veh,"steeringLock",50)           
            end
        end
     
    end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), handling )








  





