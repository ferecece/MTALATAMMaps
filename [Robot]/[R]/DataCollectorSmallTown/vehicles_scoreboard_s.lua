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
	if rank ~= 1 then return end
	if (DATABASE) then
		if getPedOccupiedVehicle(source) then
			recordsQuery = dbQuery(DATABASE, "SELECT * FROM FuckedupTownTable WHERE vehiclename = ?", getVehicleNameFromModel(currentVehicleModel))
			recordsResults = dbPoll(recordsQuery, -1)		
			
			-- Updating Database
			if (recordsResults and #recordsResults > 0) then
				if recordsResults[1]["score"] > time then 
					dbExec(DATABASE, "UPDATE FuckedupTownTable SET score = ?, playername = ? WHERE vehiclename = ?", time, getPlayerName(source), getVehicleNameFromModel(currentVehicleModel))
				end
			else
				dbExec(DATABASE, "INSERT INTO FuckedupTownTable(playername, vehiclename, score) VALUES (?,?,?)", getPlayerName(source), getVehicleNameFromModel(currentVehicleModel), time)
			end
			
			-- Sort first 128 Records 
			sortQuery = dbQuery(DATABASE, "SELECT * FROM FuckedupTownTable ORDER BY score ASC LIMIT 128")		
			recordsResults = dbPoll(sortQuery, -1)
		end
	end
end )

-- Event called from client when player want to see stats, event returns data from database
addEvent("getStats", true)
addEventHandler("getStats", getRootElement(), function()
	if DATABASE then
		local data = {}
		recordsQuery = dbQuery(DATABASE, "SELECT * FROM FuckedupTownTable ORDER BY score ASC LIMIT 128")
		data = dbPoll(recordsQuery, -1)
		triggerClientEvent(source, "receiveStats", source, data)
	end
end )
