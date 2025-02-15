DATABASE = dbConnect("sqlite", ":/dataCollector.db")
currentVehicleModel = nil

function update()
	for i, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then
			if getElementModel(getPedOccupiedVehicle(players)) ~= currentVehicleModel and currentVehicleModel ~= nil then
				setElementModel(getPedOccupiedVehicle(players), currentVehicleModel)
			end
		end
	end
end 

addEventHandler("onResourceStart", resourceRoot, function()		
	-- Choose vehicle for this race
	repeat
		currentVehicleModel = math.random(400, 609)
	until getVehicleType(currentVehicleModel) ~= "Plane" and getVehicleType(currentVehicleModel) ~= "Train" and getVehicleType(currentVehicleModel) ~= "Helicopter" and getVehicleType(currentVehicleModel) ~= "Boat" and getVehicleType(currentVehicleModel) ~= "Trailer"
	
	-- Table management
	dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS SanFierroTable(playername TEXT, vehiclename TEXT, score INTEGER)")
	sortQuery = dbQuery(DATABASE, "SELECT * FROM SanFierroTable WHERE vehiclename = ? ORDER BY score", getVehicleNameFromModel(currentVehicleModel))		
	recordsResults = dbPoll(sortQuery, -1)
	
	for i, recordsData in pairs(recordsResults) do 
		outputChatBox("Current record with " ..tostring(recordsData["vehiclename"]).. " is " ..convertToRaceTime(recordsData["score"]).. " by " ..tostring(recordsData["playername"]:gsub("#%x%x%x%x%x%x", "")).. ".")
	end
	
	-- Start update timer
	if isTimer(updateTimer) then killTimer(updateTimer) end
	updateTimer = setTimer(update, 60, 0)
end )
