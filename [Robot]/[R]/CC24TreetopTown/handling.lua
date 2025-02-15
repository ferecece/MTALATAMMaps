function handling()
    for _,veh in pairs(getElementsByType("vehicle")) do
        if getElementModel(veh) == 558 then
            setVehicleHandling(veh,"collisionDamageMultiplier",0.3)
        end
    end
end
addEventHandler("onPlayerVehicleEnter",getRootElement(),handling)

function onStart()
    setCloudsEnabled(false)
    setFogDistance(10)
    setFarClipDistance(300)
end
addEventHandler("onResourceStart", resourceRoot, onStart)

