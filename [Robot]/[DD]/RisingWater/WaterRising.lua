local WaterLevel

function onRaceStart(newstate,oldstate)
	if (newstate == "Running" and oldstate == "GridCountdown") then -- If the race has started
		WaterLevel = 0
		setTimer(raiseWater, 20000, 1)
	end
end

addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), onRaceStart )

function raiseWater()
	if WaterLevel < 44.5 then
		WaterLevel = WaterLevel + 0.02
		setWaterLevel(WaterLevel)
		setTimer(raiseWater, 50, 1)
	end
end