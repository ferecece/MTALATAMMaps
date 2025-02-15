function handling()
    for _,veh in pairs(getElementsByType("vehicle")) do
        if getElementModel(veh) == 416 then
            setVehicleHandling(veh, "maxVelocity", 200)          
        end
    end
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), handling)
