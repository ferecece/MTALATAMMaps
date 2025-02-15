MAPSBASE = dbConnect("sqlite", ":/procedurallyGeneratedRaceMaps.db")
MAPSRECORDS = dbConnect("sqlite", ":/procedurallyGeneratedRaceMapsRecords.db")

local races = {}
for i = 1, 9 do
	races[i] = {nil, nil}
end
local mapSelected = false
local votedPlayers = {}
skipEnabled = false
local mapname

function setUpPlayersVehicle()
	for _, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then			
			if getElementModel(players) ~= serverRace["pedID"] and serverRace["pedID"] ~= nil then
				setElementModel(players, serverRace["pedID"])
			end
			
			if serverVehicle["hydraulics"] == 6 and getVehicleUpgradeOnSlot(getPedOccupiedVehicle(players), 9) == 0 then
				addVehicleUpgrade(getPedOccupiedVehicle(players), 1087)
			end
			
			setVehiclePaintjob(getPedOccupiedVehicle(players), serverVehicle["paintjob"])
			
			if serverVehicle["lightsColorR"] ~= nil then
				setVehicleHeadLightColor(getPedOccupiedVehicle(players), serverVehicle["lightsColorR"], serverVehicle["lightsColorG"], serverVehicle["lightsColorB"])
				
				if getVehicleUpgradeOnSlot(getPedOccupiedVehicle(players), 8) ~= 1008 and serverVehicle["nitros"] == 3 then
					addVehicleUpgrade(getPedOccupiedVehicle(players), 1008) 
				end
			end
			
			if serverVehicle["wheels"] ~= nil then addVehicleUpgrade(getPedOccupiedVehicle(players), serverVehicle["wheels"]) end
			
			if serverVehicle["type"] == "Train" then
				-- Derailability Randomizer
				if serverVehicle["trainDerailable"] == 0 then 
					setTrainDerailable(getPedOccupiedVehicle(players), false)
				end 
				
				-- Direction Randomizer
				if serverVehicle["trainDirection"] == 0 then 
					setTrainDirection(getPedOccupiedVehicle(players), true)
				else
					setTrainDirection(getPedOccupiedVehicle(players), false)
				end
			end
			
			if serverVehicle["trailer"] ~= nil then
				if trailers[players] == nil then
					local x, y, z = getElementPosition(getPedOccupiedVehicle(players))
					trailers[players] = createVehicle(serverVehicle["trailer"], x, y, z, 0, 0, serverVehicle["trailerRot"])
					trailerTimers[players] = setTimer(attachTrailerToVehicle, 1500, 1, getPedOccupiedVehicle(players), trailers[players])
					if serverVehicle["wheels"] ~= nil then addserverVehicleUpgrade(trailers[players], serverVehicle["wheels"]) end
					setVehicleColor(trailers[players], math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255))
				else
					setElementHealth(trailers[players], 1000)
				end
			end
		end
	end
end

-- Reset Player's Vehicle Model
addEvent("resetVehicleModel", true)
addEventHandler("resetVehicleModel", getRootElement(), function()
	if not mapSelected then return end
	local playersVehicle = getPedOccupiedVehicle(source)
	
	if getElementModel(playersVehicle) ~= serverVehicle["model"] then
		setElementModel(playersVehicle, serverVehicle["model"])
	end
end )

function update()
	-- Update player's vehicle
	setUpPlayersVehicle()
	
	-- Send data and skip
	if mapSelected then
		for _, players in ipairs(getElementsByType("player")) do
			if getElementData(players, "gotdata") ~= 1 then
				votedPlayers[players] = false
				triggerClientEvent(players, "recieveMarkers", players, serverMarkers, serverVehicle, serverRace, serverEnvironment)
			end
			
			if skipEnabled and getElementData(players, "skipped") ~= 1 then
				triggerClientEvent(players, "setSkip", players, markerToSkip)
			end
		end
	end
end

function returnRaceName(index)
	if races[index][1] == nil then return false end
	
	local mapRating
	if races[index][3] == -1 then mapRating = "N/A"
	else
		local tmp = fromJSON(races[index][3])
		mapRating = math.floor(tmp[1]*10)/10 
	end
	
	return races[index][2].. " " .. "(ID: " ..races[index][1].. " | Rating: " ..mapRating.. ")"
end 

function voteMap()
	-- Select 8 races from database
	dbExec(MAPSBASE, "CREATE TABLE IF NOT EXISTS MapsTable(id INTEGER, mapname TEXT, friendlyname TEXT, playername TEXT, checkpoints TEXT, vehicle TEXT, race TEXT, enviroment TEXT, timestamp INTEGER, ratings INTEGER, timesplayed INTEGER)")
	outputResults = dbPoll(dbQuery(MAPSBASE, "SELECT COUNT(*) as mapscount FROM MapsTable"), -1)
	local mapsFound = tonumber(outputResults[1]["mapscount"])
	
	if mapsFound == 0 then 
		outputChatBox("#FF0000NO MAPS FOUND IN THE DATABASE!", root, 0, 0, 0, true)
		return 
	end
	
	-- Select random 9 races
	local tbl = {}
	for i = 1, mapsFound do
		table.insert(tbl, i)
	end
	
	if mapsFound < 9 then k = mapsFound 
	elseif mapsFound >= 9 then k = 9 end
	
	for i = 1, k do
		local n = math.random(#tbl)
		getRes = dbPoll(dbQuery(MAPSBASE, "SELECT * FROM MapsTable WHERE id = ?", tbl[n]), -1)
		for b, data in pairs(getRes) do 
			table.insert(races[i], 1, data["id"])
			table.insert(races[i], 2, data["friendlyname"])
			table.insert(races[i], 3, data["ratings"])
		end 
		table.remove(tbl, n)
	end
	
	local pollData = {
		title = "Choose the race:",
		percentage = 100,
		timeout = 15,
		allowchange = true
	}
	
	local racesFound = 0
	for i = 1, 9 do
		if returnRaceName(i) then
			table.insert(pollData, i, {returnRaceName(i), "pollFinished", resourceRoot, 50 + i})
			racesFound = racesFound + 1
		end
	end
	
	exports.votemanager:stopPoll {}
	
	if racesFound > 9 then racesFound = 9 end
	if not exports.votemanager:startPoll(pollData) then applyPollResult(math.random(51, 50 + racesFound)) end
end

addEvent("pollFinished", true)
addEventHandler("pollFinished", resourceRoot, function(pollResult)
	if pollResult > 50 and pollResult < 60 then
		result = dbPoll(dbQuery(MAPSBASE, "SELECT * FROM MapsTable WHERE id = ?", races[pollResult - 50][1]), -1)
		
		local raceName = result[1]["friendlyname"]
		serverVehicle = fromJSON(result[1]["vehicle"])
		serverRace = fromJSON(result[1]["race"])
		serverEnvironment = fromJSON(result[1]["enviroment"])
		serverMarkers = fromJSON(result[1]["checkpoints"])
		
		serverRace["timestamp"] = result[1]["timestamp"]
		
		if result[1]["ratings"] == -1 then
			serverRace["rating"] = -1
			serverRace["timesRated"] = 0
		else
			local t = fromJSON(result[1]["ratings"])
			serverRace["rating"] = t[1]
			serverRace["timesRated"] = t[2]
		end
		
		mapname = result[1]["mapname"]
		serverRace["mapname"] = result[1]["friendlyname"]
		serverRace["generator"] = result[1]["playername"]
		mapSelected = true
		
		-- Set Weather
		setTime(serverEnvironment["hour"], serverEnvironment["min"])
		setWeather(serverEnvironment["weather"])
		setMoonSize(serverEnvironment["Moon"])
		
		setUpPlayersVehicle()
		setTimer(update, 500, 0)
	elseif pollResult == 80 then -- Yes
		markerToSkip = getElementData(votePlayer, "race.checkpoint")
		skipEnabled = true
	end
end )

addEventHandler("onResourceStart", resourceRoot, function(resource) voteMap() end )

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

function getRatingColor(rating)
	local r, g = -5.1*(rating^2) + 25.5*rating + 255, -5.1*(rating^2) + 76.5*rating
	r, g = r > 255 and 255 or math.floor(r+0.5), g > 255 and 255 or math.floor(g+0.5)
	return {r,g,0}
end

function getRatingColorAsHex(rating)
	local r, g = unpack(getRatingColor(rating))
	return "#"..string.format("%02X", r)..string.format("%02X", g).."00"
end

function rate(playerSource, commandName, arg)
	if not mapSelected then return end
	
	-- Process player rating
	local playerRating = tonumber(arg)
	if playerRating == nil then return outputChatBox("Use: /ratemap [0-10]", playerSource)
	elseif playerRating > 10 or playerRating < 0 then return outputChatBox("Use: /ratemap [0-10]", playerSource) end
	
	if MAPSRECORDS and MAPSBASE then
		local n = mapname.. "_ratings"
		dbExec(MAPSRECORDS, "CREATE TABLE IF NOT EXISTS " ..n.. "(playername TEXT, rating INTEGER)") 
		result = dbPoll(dbQuery(MAPSRECORDS, "SELECT * FROM " ..n.. " WHERE playername = ?", getPlayerName(playerSource)), -1)
		
		if result and #result > 0 then
			dbExec(MAPSRECORDS, "DELETE FROM " ..n.. " WHERE playername = ?", getPlayerName(playerSource))
			dbExec(MAPSRECORDS, "INSERT INTO " ..n.. "(playername, rating) VALUES (?,?)", getPlayerName(playerSource), playerRating)
			outputChatBox("Changed rating this map to " ..getRatingColorAsHex(playerRating).. "" ..playerRating.. "/10", playerSource, 255, 255, 255, true)
		else
			dbExec(MAPSRECORDS, "INSERT INTO " ..n.. "(playername, rating) VALUES (?,?)", getPlayerName(playerSource), playerRating)
			outputChatBox("You've rated this map " ..getRatingColorAsHex(playerRating).. "" ..playerRating.. "/10", playerSource, 255, 255, 255, true)
		end
		
		-- Updating race rating
		local sum = 0
		local tim = 0
		local req = dbPoll(dbQuery(MAPSRECORDS, "SELECT * FROM " ..n), -1)
		for _, data in pairs(req) do
			sum = sum + data["rating"]
			tim = tim + 1
		end  
		
		local actualRating = math.floor((sum / tim) * 10)/10
		dbExec(MAPSBASE, "UPDATE MapsTable SET ratings = ? WHERE mapname = ?", toJSON({actualRating, tim}), mapname)
		
		-- Delete map
		if actualRating < 2.5 and tim > 50 then
			dbExec(MAPSBASE, "DELETE FROM MapsTable WHERE mapname = ?", mapname)
			dbExec(MAPSRECORDS, "DROP TABLE " ..n)
		end
	end
end
addCommandHandler("ratemap", rate)

addEvent("onPlayerFinish", true)
addEventHandler("onPlayerFinish", getRootElement(), function(rank, time)
	if (MAPSRECORDS) then		
		dbExec(MAPSRECORDS, "CREATE TABLE IF NOT EXISTS " ..mapname.. "_records(playername TEXT, score INTEGER)")
		recordsQuery = dbQuery(MAPSRECORDS, "SELECT * FROM " ..mapname.. "_records WHERE playername = ?", getPlayerName(source):gsub("#%x%x%x%x%x%x", ""))
		recordsResults = dbPoll(recordsQuery, -1)		
		
		-- Updating Database
		if (recordsResults and #recordsResults > 0) then
			if (time < recordsResults[1]["score"]) then
				oldScore = recordsResults[1]["score"]
				dbExec(MAPSRECORDS, "UPDATE " ..mapname.. "_records SET score = ? WHERE playername = ?", time, getPlayerName(source):gsub("#%x%x%x%x%x%x", ""))
			end
		else
			oldScore = 0
			dbExec(MAPSRECORDS, "INSERT INTO " ..mapname.. "_records(playername, score) VALUES (?,?)", getPlayerName(source):gsub("#%x%x%x%x%x%x", ""), time)
		end
		
		-- Sort first 10 Records 
		sortQuery = dbQuery(MAPSRECORDS, "SELECT * FROM " ..mapname.. "_records ORDER BY score ASC LIMIT 10")		
		recordsResults = dbPoll(sortQuery, -1)
		
		-- Check for new top time
		for i, recordsData in pairs(recordsResults) do 
			if recordsData["playername"] == getPlayerName(source) and time == recordsData["score"] then
				if oldScore ~= 0 then
					local diff = oldScore - time
					outputChatBox("#00FF00New top time #" ..i.. ": " ..getPlayerName(source).. "#00FF00, " ..convertToRaceTime(time).. " (-" ..convertToRaceTime(diff).. ")", root, 255, 255, 255, true)
				else
					outputChatBox("#00FF00New top time #" ..i.. ": " ..getPlayerName(source).. "#00FF00, " ..convertToRaceTime(time), root, 255, 255, 255, true)
				end

				break
			end
			
			if i == 10 then break end
		end
	end
end )

-- Event called from client when player want to see stats, event returns data from database
addEvent("getStats", true)
addEventHandler("getStats", getRootElement(), function()
	if MAPSRECORDS and mapSelected then		
		dbExec(MAPSRECORDS, "CREATE TABLE IF NOT EXISTS " ..mapname.. "_records(playername TEXT, score INTEGER)")
		recordsQuery = dbQuery(MAPSRECORDS, "SELECT * FROM " ..mapname.. "_records ORDER BY score ASC LIMIT 10")
		recordsResults = dbPoll(recordsQuery, -1)		
		triggerClientEvent(source, "receiveStats", source, recordsResults)
	end
end )