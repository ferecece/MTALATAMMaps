function raceStateChanged(newState, oldState)
	if (newState == "Running" and oldState == "GridCountdown") then
		triggerClientEvent(root, "onRaceHasBegun", resourceRoot)
		RACE_ONGOING = true
		RACE_DURATION = 0
	elseif (newState == "GridCountdown") then
		setTimer(moveMarker, TICK_RATE, 0)
	end
end
addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", root, raceStateChanged)