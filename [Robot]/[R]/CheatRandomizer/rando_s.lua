updateTimer = nil
cheatTimer = nil

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

function typeCheat()
	local c = math.random(91)
	triggerClientEvent("newCheatHandler", getRootElement(), c)
end

addEvent("onMapStarting", true)
addEventHandler("onMapStarting", resourceRoot, function()
	if isTimer(updateTimer) then killTimer(updateTimer) end
	updateTimer = setTimer(update, 50, 0)
	
	if isTimer(cheatTimer) then killTimer(cheatTimer) end
	cheatTimer = setTimer(typeCheat, 10000, 0)
	
	setTime(math.random(24), math.random(59))
	setWeather(math.random(15))
end )