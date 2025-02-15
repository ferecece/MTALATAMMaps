function handling()
    for _,veh in pairs(getElementsByType("vehicle")) do
        if getElementModel(veh) == 522 then
            setVehicleHandling(veh,"collisionDamageMultiplier",0.1)
        end
    end
end
addEventHandler("onPlayerVehicleEnter",getRootElement(),handling)
