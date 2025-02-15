DATABASE = dbConnect("sqlite", ":/infernusVsNRG500DragRecords.db")

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

addEvent("onPlayerFinish", true)
addEventHandler("onPlayerFinish", getRootElement(), function(rank, time)
	if (DATABASE) then
		if getPedOccupiedVehicle(source) then
			local vehicleModel = getElementModel(getPedOccupiedVehicle(source))
			
			dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS Table" ..vehicleModel.. "(playername TEXT, score INTEGER)")
			recordsQuery = dbQuery(DATABASE, "SELECT * FROM Table" ..vehicleModel.. " WHERE playername = ?", getPlayerName(source))
			recordsResults = dbPoll(recordsQuery, -1)		
			
			-- Updating Database
			if (recordsResults and #recordsResults > 0) then
				if (time < recordsResults[1]["score"]) then
					oldScore = recordsResults[1]["score"]
					dbExec(DATABASE, "UPDATE Table" ..vehicleModel.. " SET score = ? WHERE playername = ?", time, getPlayerName(source))
				end
			else
				oldScore = 0
				dbExec(DATABASE, "INSERT INTO Table" ..vehicleModel.. "(playername, score) VALUES (?,?)", getPlayerName(source), time)
			end
			
			-- Sort first 10 Records 
			sortQuery = dbQuery(DATABASE, "SELECT * FROM Table" ..vehicleModel.. " ORDER BY score ASC LIMIT 10")		
			recordsResults = dbPoll(sortQuery, -1)
			
			-- Check for new top time
			for i, recordsData in pairs(recordsResults) do 
				if recordsData["playername"] == getPlayerName(source) and time == recordsData["score"] then
					if oldScore ~= 0 then
						local diff = oldScore - time
						outputChatBox("#00FF00[" ..getVehicleName(getPedOccupiedVehicle(source)).. "] New top time #" ..i.. ": " ..getPlayerName(source).. "#00FF00, " ..convertToRaceTime(time).. " (-" ..convertToRaceTime(diff).. ")", root, 255, 255, 255, true)
					else
						outputChatBox("#00FF00[" ..getVehicleName(getPedOccupiedVehicle(source)).. "] New top time #" ..i.. ": " ..getPlayerName(source).. "#00FF00, " ..convertToRaceTime(time), root, 255, 255, 255, true)
					end

					break
				end
				
				if i == 10 then break end
			end
		end
	end
end )

-- Event called from client when player want to see stats, event returns data from database
addEvent("getStats", true)
addEventHandler("getStats", getRootElement(), function()
	if DATABASE then
		local data = {}
		
		for i = 1, 8 do
			if i == 1 then vehicleModel = 522 
			elseif i == 2 then vehicleModel = 411
			elseif i == 3 then vehicleModel = 520
			elseif i == 4 then vehicleModel = 583 
			elseif i == 5 then vehicleModel = 481 
			elseif i == 6 then vehicleModel = 509
			elseif i == 7 then vehicleModel = 510 
			elseif i == 8 then vehicleModel = 572 end
			
			dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS Table" ..vehicleModel.. "(playername TEXT, score INTEGER)")
			recordsQuery = dbQuery(DATABASE, "SELECT * FROM Table" ..vehicleModel.. " ORDER BY score ASC LIMIT 10")
			data[i] = dbPoll(recordsQuery, -1)
		end
		
		triggerClientEvent(source, "receiveStats", source, data)
	end
end )

addEventHandler("onResourceStart", resourceRoot, function()
	setWorldSpecialPropertyEnabled("roadsignstext", false)
end )

addEventHandler("onResourceStop", resourceRoot, function()
	setWorldSpecialPropertyEnabled("roadsignstext", true)
end )