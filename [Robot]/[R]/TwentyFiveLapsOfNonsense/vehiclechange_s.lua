DATABASE = dbConnect("sqlite", ":/dataCollector.db")

local playerCars = {}
local carsAlreadyRandomized = false
local cars = {}
local times = {}
local recordModel = {}

-- Function converts time in milliseconds into time in format MM:SS.MS
function convertToRaceTime(time)
	if time ~= nil then
		local m = math.floor(time / 1000 / 60)
		local s = math.floor((time / 1000) - m*60)
		local ms = math.floor(time - (m*60+s)*1000)
		
		if m < 1 then m = ""
		else m = m.. ":" end
		if s < 10 and m ~= "" then s = "0" ..s end
		if ms < 10 then ms = "00" ..ms
		elseif ms < 100 and ms > 9 then ms = "0" ..ms end
		
		return m.. "" ..s.. "." ..ms
	end
end

-- Force player's vehicle model
function updateModels()
	for _, players in ipairs(getElementsByType("player")) do
		local checkpoint = getElementData(players, "race.checkpoint")
		
		if checkpoint and getPedOccupiedVehicle(players) and playerCars[players] then
			checkpoint = checkpoint - 1
			local c = (checkpoint - (checkpoint % 4))/4 + 1
			
			if getElementModel(getPedOccupiedVehicle(players)) ~= playerCars[players][c] and getElementModel(getPedOccupiedVehicle(players)) ~= 488 then
				setElementModel(getPedOccupiedVehicle(players), playerCars[players][c])
			end
		end
	end
end

function updateRecord(player)
	if (DATABASE) then
		time = getTickCount() - times[player]
		if getPedOccupiedVehicle(player) then
			recordsQuery = dbQuery(DATABASE, "SELECT * FROM CustomLapsMapTable WHERE vehiclename = ?", getVehicleNameFromModel(getElementModel(getPedOccupiedVehicle(player))))
			recordsResults = dbPoll(recordsQuery, -1)		
			
			-- Updating Database
			local newRecord = false
			if (recordsResults and #recordsResults > 0) then
				if recordsResults[1]["score"] > time then 
					dbExec(DATABASE, "UPDATE CustomLapsMapTable SET score = ?, playername = ? WHERE vehiclename = ?", time, getPlayerName(player), getVehicleNameFromModel(getElementModel(getPedOccupiedVehicle(player))))
					newRecord = true
				end
			else
				dbExec(DATABASE, "INSERT INTO CustomLapsMapTable(playername, vehiclename, score) VALUES (?,?,?)", getPlayerName(player), getVehicleNameFromModel(getElementModel(getPedOccupiedVehicle(player))), time)
				newRecord = true
			end
			
			if newRecord then
				outputChatBox("#00FF00[" ..getVehicleNameFromModel(getElementModel(getPedOccupiedVehicle(player))).. "] New top time: " ..getPlayerName(player).. "#00FF00, " ..convertToRaceTime(time), root, 255, 255, 255, true)
			end
			
			-- Sort first 163 Records 
			sortQuery = dbQuery(DATABASE, "SELECT * FROM CustomLapsMapTable ORDER BY score ASC LIMIT 163")		
			recordsResults = dbPoll(sortQuery, -1)
		end
	end
end 

-- Event called from client when player want to see stats, event returns data from database
addEvent("getStats", true)
addEventHandler("getStats", getRootElement(), function()
	if DATABASE then
		local data = {}
		recordsQuery = dbQuery(DATABASE, "SELECT * FROM CustomLapsMapTable ORDER BY score ASC LIMIT 163")
		data = dbPoll(recordsQuery, -1)
		triggerClientEvent(source, "receiveStats", source, data)
	end
end )

addEvent("sendCars", true) 
addEventHandler("sendCars", getRootElement(), function(clientCars)
	playerCars[source] = clientCars
	setElementModel(getPedOccupiedVehicle(source), playerCars[source][1])
	
	times[source] = getTickCount()
	recordModel[source] = getElementModel(getPedOccupiedVehicle(source))
end )

addEvent("requestAllowedCars", true) 
addEventHandler("requestAllowedCars", getRootElement(), function()
	local availableCars = {}
	for i = 400, 609 do
		if getVehicleType(i) == "Automobile" or getVehicleType(i) == "Bike" or getVehicleType(i) == "BMX" or getVehicleType(i) == "Monster Truck" or getVehicleType(i) == "Quad" then
			table.insert(availableCars, i)
		end
	end
	
	if not carsAlreadyRandomized then
		for i = 1, #availableCars do
			-- Select random vehicle
			local r = math.random(#availableCars)
			
			-- Insert this vehicle into list
			table.insert(cars, availableCars[r])
			table.remove(availableCars, r)
			
			if i == 24 then break end
		end
		
		carsAlreadyRandomized = true
	end
	
	triggerClientEvent(source, "randomizeCars", source, cars)
end )

addEvent("onPlayerReachCheckpoint") 
addEventHandler("onPlayerReachCheckpoint", getRootElement(), function(checkpoint)
	if checkpoint % 4 == 0 then 
		if getElementModel(getPedOccupiedVehicle(source)) == recordModel[source] then
			updateRecord(source)
		end
		
		setElementModel(getPedOccupiedVehicle(source), playerCars[source][(checkpoint / 4) + 1])
		fixVehicle(getPedOccupiedVehicle(source))
		
		times[source] = getTickCount()
		recordModel[source] = playerCars[source][(checkpoint / 4) + 1]
	end
	
	local c = (checkpoint - (checkpoint % 4))/4 + 1	
	if getElementModel(getPedOccupiedVehicle(source)) ~= playerCars[source][c] then
		setElementModel(getPedOccupiedVehicle(source), playerCars[source][c])
	end
end )

addEvent("onPlayerFinish") 
addEventHandler("onPlayerFinish", getRootElement(), function(rank, time)
	updateRecord(source)
end )

addEventHandler("onResourceStart", resourceRoot, function()	
	-- Table management
	dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS CustomLapsMapTable(playername TEXT, vehiclename TEXT, score INTEGER)")
	
	-- Vehicle model force timer
	setTimer(updateModels, 200, 0)
end )