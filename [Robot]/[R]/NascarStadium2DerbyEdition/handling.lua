function handling()
    for _,veh in pairs(getElementsByType("vehicle")) do
        if getElementModel(veh) == 504 then
            setVehicleHandling(veh,"collisionDamageMultiplier",0.25)
            setVehicleHandling(veh,"engineAcceleration",15)
            setVehicleHandling(veh,"tractionMultiplier",0.9)
        end
    end     
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), handling)