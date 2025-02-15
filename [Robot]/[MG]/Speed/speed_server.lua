function raceState(newstate,oldstate)

	if (newstate == "GridCountdown") then
		outputChatBox("There's a bomb on a bus. Once the bus goes 50 mph the bomb is armed.", root, 255, 0, 0, true)
		outputChatBox("If it drops below #ff790050#ff0000 it blows up. What do you do?", root, 255, 0, 0, true)
	end


	if (newstate == "Running" and oldstate == "GridCountdown") then

	end

end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), raceState )