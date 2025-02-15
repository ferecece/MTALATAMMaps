updateTimer = nil

function update()
	for _, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then
			if getElementData(players, "changecar") ~= nil and getElementData(players, "changecar") ~= false and getElementData(players, "changecar") ~= 0 then 
				if getElementModel(getPedOccupiedVehicle(players)) ~= tonumber(getElementData(players, "changecar")) then
					local x, y, z = getElementPosition(getPedOccupiedVehicle(players))
					setElementPosition(getPedOccupiedVehicle(players), x, y, z + 2)
					
					setElementModel(getPedOccupiedVehicle(players), tonumber(getElementData(players, "changecar")))
					setElementData(players, "changecar", 0)
				end
			end
		end
	end
end

addEvent("onMapStarting", true)
addEventHandler("onMapStarting", resourceRoot, function()
	if isTimer(updateTimer) then killTimer(updateTimer) end
	updateTimer = setTimer(update, 50, 0)
	
	outputChatBox("#00FF00Enter #FF0000cheat codes #00FF00from original game to win the #FF0000race#00FF00!", root, 0, 246, 255, true)
	outputChatBox("#00FF00Chat is only available while spectating, enter spectate mode with #FF0000IWANTTOSPECTATE #00FF00cheat and press #FF0000B", root, 0, 246, 255, true)
	
	setTime(math.random(24), math.random(59))
	setWeather(math.random(15))
end )