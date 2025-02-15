function handling()
    for _,veh in pairs(getElementsByType("vehicle")) do
        if getElementModel(veh) == 457 then
            setVehicleHandling(veh,"collisionDamageMultiplier",0.0)
            -- setVehicleHandling(veh,"dragCoeff",0.0)
            -- setVehicleHandling(veh,"engineAcceleration",20)
            -- setVehicleHandling(veh,"tractionMultiplier",2.5)
            -- setVehicleHandling(veh,"headLight",long)  
            -- setVehicleHandling(veh,"tractionLoss",5)
            -- setVehicleHandling(veh,"steeringLock",40)
            -- setVehicleHandling(veh,"maxVelocity",80)
            -- setVehicleHandling(veh,"suspensionForceLevel",60)
            -- setVehicleHandling(veh,"seatOffsetDistance",0)
            -- setVehicleHandling(veh,"suspensionDamping",5)
            -- setVehicleHandling(veh,"modelFlags",28)
            -- setVehicleHandling(veh,"mass",3000)
        end
    end
end
addEventHandler("onPlayerVehicleEnter",getRootElement(),handling)

function fasterSpeed()
    setGameSpeed(1)
end
addEventHandler("onMapStarting",getRootElement(),fasterSpeed)

function changeDistance()
    for i,object in pairs(getElementsByType("object")) do
        if isElement(object) then
            local elementID = getElementModel(object )
            engineSetModelLODDistance(elementID,1000)
        end
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),changeDistance)
