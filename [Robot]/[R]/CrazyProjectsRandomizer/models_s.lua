local models = {491, 496, 566, 409, 536, 539, 540, 427, 529, 551, 585, 444, 434, 424, 420, 504, 598, 441, 474, 560, 567, 582, 499, 489, 556, 418}

addEvent("onPlayerReachCheckpoint") 
addEventHandler("onPlayerReachCheckpoint", getRootElement(), function(checkpoint)
	if not getPedOccupiedVehicle(source) then return end
	setElementModel(getPedOccupiedVehicle(source), models[math.random(#models)])
	
	if checkpoint == 8 then triggerClientEvent(source, "triggerSlowmo", getRootElement()) end
end )

addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", getRootElement(), function(newState, oldState)
	if newState == "GridCountdown" then
		for _, players in ipairs(getElementsByType("player")) do
			if getPedOccupiedVehicle(players) then
				setElementModel(getPedOccupiedVehicle(players), models[math.random(#models)])
			end
		end
	end
end )