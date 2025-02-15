addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", getRootElement(), function(newState, oldState)
	if newState == "Running" then
		for i, players in ipairs(getElementsByType("player")) do
			triggerClientEvent(players, "startTimer", players)
		end
	end
end )

addEvent("onPlayerFinish", true)
addEventHandler("onPlayerFinish", getRootElement(), function(rank, time)
	triggerClientEvent(source, "playerFinished", source, time)
end )