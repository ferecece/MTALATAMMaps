local vehicleModel

function update()
	if vehicleModel == nil then return end
	
	local alivePlayers = {}
	for i, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then
			if getElementModel(getPedOccupiedVehicle(players)) ~= vehicleModel then setElementModel(getPedOccupiedVehicle(players), vehicleModel) end
		end
		
		local x, y, z = getElementPosition(players)
		if getElementHealth(players) > 10 and z < 20000 then 
			table.insert(alivePlayers, players)
		end
	end
	
	if #alivePlayers == 1 then 
		setElementData(resourceRoot, "survivor", alivePlayers[1])
		setElementHealth(alivePlayers[1], 0)
	end
end

addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", getRootElement(), function(newState, oldState)
	if newState == "GridCountdown" then
		local vehicleType
		repeat 
			vehicleModel = math.random(400, 611)
			vehicleType = getVehicleType(vehicleModel)
		until vehicleType == "Automobile" or vehicleType == "Bike" or vehicleType == "BMX" or vehicleType == "Monster Truck"
		
		for i, players in ipairs(getElementsByType("player")) do
			triggerClientEvent(players, "spawn", players) 
		end
		
		setTimer(update, 500, 0)
	end
end )