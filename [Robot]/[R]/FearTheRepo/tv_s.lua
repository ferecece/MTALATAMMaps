addEvent("onPlayerReachCheckpoint", true)
addEventHandler("onPlayerReachCheckpoint", root, function(checkpoint, time)
	if checkpoint == 3 then 
		local x, y, z = getElementVelocity(getPedOccupiedVehicle(source))
		setElementVelocity(getPedOccupiedVehicle(source), x*1.5, y*1.5, z*1.5)
		triggerClientEvent(source, "brakesFail", source)
	elseif checkpoint == 35 then
		setVehicleWheelStates(getPedOccupiedVehicle(source), -1, -1, -1, 2)
	elseif checkpoint == 20 then
		triggerClientEvent(source, "launchTrain", source)
	end
end )

addEvent("onPlayerFinish", true)
addEventHandler("onPlayerFinish", getRootElement(), function(rank, time)
	triggerClientEvent(source, "playerFinished", source, time)
end )