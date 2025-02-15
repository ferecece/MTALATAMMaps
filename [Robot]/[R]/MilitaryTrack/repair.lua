addEventHandler("onClientVehicleDamage", root, function()
    if source == getPedOccupiedVehicle(localPlayer) then
        fixVehicle ( source )
    end
end)