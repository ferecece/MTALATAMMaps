function handling()
    for _,veh in pairs(getElementsByType("vehicle")) do
        if getElementModel(veh) == 558 then
            setVehicleHandling(veh,"collisionDamageMultiplier",0.3)
        end
    end
end
addEventHandler("onPlayerVehicleEnter",getRootElement(),handling)
