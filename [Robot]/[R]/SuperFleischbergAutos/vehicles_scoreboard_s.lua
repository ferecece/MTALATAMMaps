RECORDS_DATABASE = dbConnect("sqlite", ":/mapSuperFleischbergAutosRecords.db")
CHEATING_THRESHOLD = 7000

addEvent("onPlayerDeliverVehicle", true)
addEventHandler("onPlayerDeliverVehicle", getRootElement(), function(time, vehicleModel)
	local isCheated = (vehicleModel ~= 610 and vehicleModel ~= 611) and time < CHEATING_THRESHOLD -- Farm & Street Clean trailer

	if (RECORDS_DATABASE and not CHEATS_ENABLED and not isCheated) then
		dbExec(RECORDS_DATABASE, "CREATE TABLE IF NOT EXISTS Table" ..vehicleModel.. "(playername TEXT, score INTEGER)")
		recordsQuery = dbQuery(RECORDS_DATABASE, "SELECT * FROM Table" ..vehicleModel.. " WHERE playername = ?", getPlayerName(source))
		recordsResults = dbPoll(recordsQuery, -1)		
		
		-- Updating RECORDS_DATABASE
		if (recordsResults and #recordsResults > 0) then
			if (time < recordsResults[1]["score"]) then
				oldScore = recordsResults[1]["score"]
				dbExec(RECORDS_DATABASE, "UPDATE Table" ..vehicleModel.. " SET score = ? WHERE playername = ?", time, getPlayerName(source))
			end
		else
			oldScore = 0
			dbExec(RECORDS_DATABASE, "INSERT INTO Table" ..vehicleModel.. "(playername, score) VALUES (?,?)", getPlayerName(source), time)
		end
		
		-- Sort first 11 Records 
		sortQuery = dbQuery(RECORDS_DATABASE, "SELECT * FROM Table" ..vehicleModel.. " ORDER BY score ASC LIMIT 11")		
		recordsResults = dbPoll(sortQuery, -1)
		
		-- Check for new top time
		for i, recordsData in pairs(recordsResults) do 
			if recordsData["playername"] == getPlayerName(source) and time == recordsData["score"] then
				local rankColor = "#00CC00"
				if (i == 1) then
					rankColor = "#CCCC00"
				elseif (i == 2) then
					rankColor = "#CCCCCC"
				elseif (i == 3) then
					rankColor = "#CC4400"
				end
				local chatScoreNotificationText = "#88CC88[#00CC00"
				chatScoreNotificationText = chatScoreNotificationText .. VEHICLE_NAMES[getElementModel(getPedOccupiedVehicle(source))]
				chatScoreNotificationText = chatScoreNotificationText .. "#88CC88] New top time #"
				chatScoreNotificationText = chatScoreNotificationText .. rankColor .. i
				chatScoreNotificationText = chatScoreNotificationText .. "#88CC88: #00CC00"
				chatScoreNotificationText = chatScoreNotificationText .. getPlayerName(source)
				chatScoreNotificationText = chatScoreNotificationText .. "#88CC88, "
				chatScoreNotificationText = chatScoreNotificationText .. convertToRaceTime(time)
				if oldScore ~= 0 then
					local diff = oldScore - time
					chatScoreNotificationText = chatScoreNotificationText .. " (-" ..convertToRaceTime(diff).. ")"
				end
				outputChatBox(chatScoreNotificationText, root, 255, 255, 255, true)

				break
			end
			
			if i == 11 then break end
		end
	end
end )

-- Event called from client when player want to see stats, event returns data from RECORDS_DATABASE
addEvent("getStats", true)
addEventHandler("getStats", getRootElement(), function(vehicleModel)
	if RECORDS_DATABASE then
		dbExec(RECORDS_DATABASE, "CREATE TABLE IF NOT EXISTS Table" ..vehicleModel.. "(playername TEXT, score INTEGER)")
		recordsQuery = dbQuery(RECORDS_DATABASE, "SELECT * FROM Table" ..vehicleModel.. " ORDER BY score ASC LIMIT 11")
		recordsResults = dbPoll(recordsQuery, -1)		
		triggerClientEvent(source, "receiveStats", source, recordsResults)
	end
end )