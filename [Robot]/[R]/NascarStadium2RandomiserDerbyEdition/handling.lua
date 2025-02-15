function handling()
    for _,veh in pairs(getElementsByType("vehicle")) do
        if getElementModel(veh) == 504 then
            setVehicleHandling(veh,"engineAcceleration",11)
            setVehicleHandling(veh,"tractionMultiplier",0.8)
        end
    end     
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), handling)