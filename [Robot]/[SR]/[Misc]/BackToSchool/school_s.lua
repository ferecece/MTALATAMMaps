-- Driving School Race by Discoordination Journey
-- All 12 tests from SP game, custom leaderboards, custom ghostmode
-- Final release: 07.08.2024
-- Update 08.01.2025
-- Version: 1.0.1

DATABASE = dbConnect("sqlite", ":/backToSchoolRecords.db")
mapPlayedTrigger = true

addEvent("onMapStarting", true)
addEventHandler("onMapStarting", resourceRoot, function()
	setTimer(updateCar, 1, 0)
	exports.scoreboard:scoreboardAddColumn("Test", getRootElement(), 120)
end)

addEventHandler("onResourceStop", resourceRoot, function() 
	exports.scoreboard:removeScoreboardColumn("Test")
end )

-- Function that changes vehicle model required by current test and changes weather and time
function updateCar()
	for _, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then
			if getElementModel(getPedOccupiedVehicle(players)) ~= getElementData(players, "carid") then
				setElementModel(getPedOccupiedVehicle(players), getElementData(players, "carid"))
				
				if getElementData(players, "carid") == 597 then
					setVehicleColor(getPedOccupiedVehicle(players), 0, 0, 0, 255, 255, 255)
				elseif getElementData(players, "carid") == 420 then
					setVehicleColor(getPedOccupiedVehicle(players), 215, 142, 16, 165, 138, 65)
				else
					local c = {0, 0, 0, 0}
					for i = 1, 4 do
						math.randomseed(getTickCount()+getTickCount()*math.random(i))
						c[i] = math.random(0, 126)
					end
					
					setVehicleColor(getPedOccupiedVehicle(players), c[1], c[2], c[3], c[4])
				end
			end
		end
		
		-- Dimension sets here!
		if getElementData(players, "dim") ~= nil and getElementData(players, "dim") ~= false then
			-- Set dimension for the player
			if getElementData(players, "dim") ~= getElementDimension(players) then
				setElementDimension(players, getElementData(players, "dim"))
			end
			
			-- Set dimension for the vehicle
			if getPedOccupiedVehicle(players) then
				if getElementDimension(getPedOccupiedVehicle(players)) ~= getElementData(players, "dim") then
					setElementDimension(getPedOccupiedVehicle(players), getElementData(players, "dim"))
				end
			end
		end
	end
	
	setWeather(6)
	local time = getRealTime()
	setTime(time.hour, time.minute)
end

-- Event sets up timer for updating players
addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", root, function(newState, oldState)
	if oldState == "GridCountdown" and newState == "Running" then
		updatePlayers()
		setTimer(updatePlayers, 100, 0)
	end
end )

-- Function update triggers Driving School start when joined and checks if player are logged
function updatePlayers()
	-- Send data back to clients
	for index, players in ipairs(getElementsByType("player")) do
		-- Trigger for loading first level
		if getElementData(players, "trigger") == 1 and getElementData(players, "state") ~= "spectating" then 
			setElementData(players, "trigger", 0)
			if not isGuestAccount(getPlayerAccount(players)) then setElementData(players, "logged", 1) end
		end
	end
end

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

-- Event called from client when player finished the race
addEvent("setPlayerFinish", true)
addEventHandler("setPlayerFinish", getRootElement(), function(data)
	local time = exports.race:getTimePassed()
	local rank = exports.race:getPlayerRank(source)
	local won = 0
	local mapPlayed = 0
	
	local cutTime = data["golds"] * 11500
	local newtime = 0
	if time - cutTime > 0 then 
		newtime = time - cutTime
	else
		newtime = time - 1000
	end
	
	if rank == 1 and getPlayerCount() > 1 then won = 1 end
		
	if mapPlayedTrigger then
		mapPlayed = 1
		mapPlayedTrigger = false
	end
	
	triggerEvent("onPlayerFinish", source, rank, newtime)
	
	if data["golds"] == 1 then 
		outputChatBox("#E7D9B0" ..getPlayerName(source).. " #E7D9B0finished the Driving School in #00A000" ..convertToRaceTime(newtime).. " #E7D9B0with #BDA402" ..data["golds"].. " #E7D9B0gold medal and a #00A000"..(cutTime/1000).. " #E7D9B0seconds advantage.", root, 255, 255, 255, true)
	elseif data["golds"] == 6 then
		outputChatBox("#E7D9B0" ..getPlayerName(source).. " #E7D9B0finished the Driving School in #00A000" ..convertToRaceTime(newtime).. " #E7D9B0with #BDA402" ..data["golds"].. " #E7D9B0gold medals and a #00A000"..(cutTime/1000).. " #E7D9B0seconds advantage. Nice.", root, 255, 255, 255, true)
	else
		outputChatBox("#E7D9B0" ..getPlayerName(source).. " #E7D9B0finished the Driving School in #00A000" ..convertToRaceTime(newtime).. " #E7D9B0with #BDA402" ..data["golds"].. " #E7D9B0gold medals and a #00A000"..(cutTime/1000).. " #E7D9B0seconds advantage.", root, 255, 255, 255, true)
	end
	
	if (DATABASE) then
		-- Create all tables
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS PlayersTable(playername TEXT, cones INTEGER, passed INTEGER, attempts INTEGER, won INTEGER, playing INTEGER, golds INTEGER, silvers INTEGER, bronzes INTEGER)")
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS AllGoldsTable(playername TEXT, score INTEGER)")
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS MiscTable(cones INTEGER, played INTEGER)")
		
		-- Select data
		PlayerQuery = dbQuery(DATABASE, "SELECT * FROM PlayersTable WHERE playername = ?", getAccountName(getPlayerAccount(source)))
		AllGoldsQuery = dbQuery(DATABASE, "SELECT * FROM AllGoldsTable WHERE playername = ?", getAccountName(getPlayerAccount(source)))
		MiscQuery = dbQuery(DATABASE, "SELECT * FROM MiscTable")
		
		-- Get data
		PlayerResults = dbPoll(PlayerQuery, -1)		
		AllGoldsResults = dbPoll(AllGoldsQuery, -1)		
		MiscResults = dbPoll(MiscQuery, -1)	
		
		-- Update player's data
		if not isGuestAccount(getPlayerAccount(source)) then
			if (PlayerResults and #PlayerResults > 0) then
				dbExec(DATABASE, "UPDATE PlayersTable SET cones = ?, passed = ?, attempts = ?, won = ?, playing = ?, golds = ?, silvers = ?, bronzes = ? WHERE playername = ?", PlayerResults[1]["cones"] + data["cones"], PlayerResults[1]["passed"] + 12, PlayerResults[1]["attempts"] + data["attempts"], PlayerResults[1]["won"] + won, PlayerResults[1]["playing"] + time, PlayerResults[1]["golds"] + data["golds"], PlayerResults[1]["silvers"] + data["silvers"], PlayerResults[1]["bronzes"] + data["bronzes"], getAccountName(getPlayerAccount(source)))
			else
				dbExec(DATABASE, "INSERT INTO PlayersTable(playername, cones, passed, attempts, won, playing, golds, silvers, bronzes) VALUES (?,?,?,?,?,?,?,?,?)", getAccountName(getPlayerAccount(source)), data["cones"], 12, data["attempts"], won, newtime, data["golds"], data["silvers"], data["bronzes"])
			end
		
			-- Update all golds records
			if data["golds"] == 12 then
				if (AllGoldsResults and #AllGoldsResults > 0) then
					if (newtime < AllGoldsResults[1]["score"]) then
						dbExec(DATABASE, "UPDATE AllGoldsTable SET score = ? WHERE playername = ?", newtime, getAccountName(getPlayerAccount(source)))
					end
				else
					dbExec(DATABASE, "INSERT INTO AllGoldsTable(playername, score) VALUES (?,?)", getAccountName(getPlayerAccount(source)), newtime)
					sortQuery = dbQuery(DATABASE, "SELECT * FROM AllGoldsTable ORDER BY score ASC LIMIT 11")		
					goldsResults = dbPoll(sortQuery, -1)
					
					for i, goldsData in pairs(goldsResults) do 
						if goldsData["playername"] == getAccountName(getPlayerAccount(source)) and newtime == goldsData["score"] then
							outputChatBox("#BDA402[All Golds] New top time #" ..i.. ": " ..getAccountName(getPlayerAccount(source)).. "#BDA402, " ..convertToRaceTime(newtime), root, 255, 255, 255, true)
							break
						end
						
						if i == 10 then break end
					end
				end
			end
		end
		
		-- Update misc stats
		if (MiscResults and #MiscResults > 0) then
			dbExec(DATABASE, "UPDATE MiscTable SET cones = ?, played = ?", MiscResults[1]["cones"] + data["cones"], MiscResults[1]["played"] + mapPlayed)
		else
			dbExec(DATABASE, "INSERT INTO MiscTable(cones, played) VALUES (?,?)", data["cones"], mapPlayed)
		end
	end
end )

-- Event that updates "Burn and Lap" test best times
addEvent("updateBurnAndLapRecords", true)
addEventHandler("updateBurnAndLapRecords", getRootElement(), function(time)
	local oldBurnAndLapScore = 0
	
	if (DATABASE) then
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS BurnAndLapTable(playername TEXT, score INTEGER)")
		BurnAndLapQuery = dbQuery(DATABASE, "SELECT * FROM BurnAndLapTable WHERE playername = ?", getPlayerName(source))
		BurnAndLapResults = dbPoll(BurnAndLapQuery, -1)

		-- Updating Database
		if (BurnAndLapResults and #BurnAndLapResults > 0) then
			if (time < BurnAndLapResults[1]["score"]) then
				oldBurnAndLapScore = BurnAndLapResults[1]["score"]
				dbExec(DATABASE, "UPDATE BurnAndLapTable SET score = ? WHERE playername = ?", time, getPlayerName(source))
			end
		else
			oldBurnAndLapScore = 0
			dbExec(DATABASE, "INSERT INTO BurnAndLapTable(playername, score) VALUES (?,?)", getPlayerName(source), time)
		end
		
		-- Sort first 10 Records 
		sortQuery = dbQuery(DATABASE, "SELECT * FROM BurnAndLapTable ORDER BY score ASC LIMIT 11")		
		BurnAndLapResults = dbPoll(sortQuery, -1)
		
		-- Check for new top time
		for i, BurnAndLapData in pairs(BurnAndLapResults) do 
			if BurnAndLapData["playername"] == getPlayerName(source) and time == BurnAndLapData["score"] then
				if oldBurnAndLapScore ~= 0 then
					local diff = oldBurnAndLapScore - time
					outputChatBox("#00FF00[Burn and Lap] New top time #" ..i.. ": " ..getPlayerName(source).. "#00FF00, " ..convertToRaceTime(time).. " (-" ..convertToRaceTime(diff).. ")", root, 255, 255, 255, true)
				else
					outputChatBox("#00FF00[Burn and Lap] New top time #" ..i.. ": " ..getPlayerName(source).. "#00FF00, " ..convertToRaceTime(time), root, 255, 255, 255, true)
				end

				break
			end
			
			if i == 10 then break end
		end
	end
end )

-- Event that updates "City Slicking" test best times
addEvent("updateCitySlickingRecords", true)
addEventHandler("updateCitySlickingRecords", getRootElement(), function(time)
	local oldCityScore = 0
	
	if (DATABASE) then
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS CitySlickingTable(playername TEXT, score INTEGER)")
		CitySlickingQuery = dbQuery(DATABASE, "SELECT * FROM CitySlickingTable WHERE playername = ?", getPlayerName(source))
		CitySlickingResults = dbPoll(CitySlickingQuery, -1)

		if (CitySlickingResults and #CitySlickingResults > 0) then
			if (time < CitySlickingResults[1]["score"]) then
				oldCityScore = CitySlickingResults[1]["score"]
				dbExec(DATABASE, "UPDATE CitySlickingTable SET score = ? WHERE playername = ?", time, getPlayerName(source))
			end
		else
			oldCityScore = 0
			dbExec(DATABASE, "INSERT INTO CitySlickingTable(playername, score) VALUES (?,?)", getPlayerName(source), time)
		end
		
		sortQuery = dbQuery(DATABASE, "SELECT * FROM CitySlickingTable ORDER BY score ASC LIMIT 11")		
		CitySlickingResults = dbPoll(sortQuery, -1)
		
		for i, CitySlickingData in pairs(CitySlickingResults) do 
			if CitySlickingData["playername"] == getPlayerName(source) and time == CitySlickingData["score"] then
				if oldCityScore ~= 0 then
					local diff = oldCityScore - time
					outputChatBox("#00FF00[City Slicking] New top time #" ..i.. ": " ..getPlayerName(source).. "#00FF00, " ..convertToRaceTime(time).. " (-" ..convertToRaceTime(diff).. ")", root, 255, 255, 255, true)
				else
					outputChatBox("#00FF00[City Slicking] New top time #" ..i.. ": " ..getPlayerName(source).. "#00FF00, " ..convertToRaceTime(time), root, 255, 255, 255, true)
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
	if DATABASE then
		-- Create all tables
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS PlayersTable(playername TEXT, cones INTEGER, passed INTEGER, attempts INTEGER, won INTEGER, playing INTEGER, golds INTEGER, silvers INTEGER, bronzes INTEGER)")
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS AllGoldsTable(playername TEXT, score INTEGER)")
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS MiscTable(cones INTEGER, played INTEGER)")
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS BurnAndLapTable(playername TEXT, score INTEGER)")
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS CitySlickingTable(playername TEXT, score INTEGER)")
		
		-- Select data
		PlayerQuery = dbQuery(DATABASE, "SELECT * FROM PlayersTable WHERE playername = ?", getAccountName(getPlayerAccount(source)))
		MiscQuery = dbQuery(DATABASE, "SELECT * FROM MiscTable")
		AllGoldsQuery = dbQuery(DATABASE, "SELECT * FROM AllGoldsTable ORDER BY score ASC LIMIT 11")
		BurnAndLapQuery = dbQuery(DATABASE, "SELECT * FROM BurnAndLapTable ORDER BY score ASC LIMIT 11")
		CitySlickingQuery = dbQuery(DATABASE, "SELECT * FROM CitySlickingTable ORDER BY score ASC LIMIT 11")
		
		PBBurnQuery = dbQuery(DATABASE, "SELECT * FROM BurnAndLapTable WHERE playername = ?", getPlayerName(source))
		PBCityQuery = dbQuery(DATABASE, "SELECT * FROM CitySlickingTable WHERE playername = ?", getPlayerName(source))
		GoldQuery = dbQuery(DATABASE, "SELECT * FROM AllGoldsTable WHERE playername = ?", getAccountName(getPlayerAccount(source)))
		
		-- Get data
		PlayerResults = dbPoll(PlayerQuery, -1)		
		AllGoldsResults = dbPoll(AllGoldsQuery, -1)		
		MiscResults = dbPoll(MiscQuery, -1)	
		BurnAndLapResults = dbPoll(BurnAndLapQuery, -1)
		CitySlickingResults = dbPoll(CitySlickingQuery, -1)
		
		-- Get player's record
		local rowBurnAndLap = dbPoll(dbQuery(DATABASE, "SELECT *, ROWID AS id FROM BurnAndLapTable WHERE playername = ? ORDER BY score ASC", getPlayerName(source)), -1)
		local rowCitySlicking = dbPoll(dbQuery(DATABASE, "SELECT *, ROWID AS id FROM CitySlickingTable WHERE playername = ? ORDER BY score ASC", getPlayerName(source)), -1)
		local rowAllGolds = dbPoll(dbQuery(DATABASE, "SELECT *, ROWID AS id FROM AllGoldsTable WHERE playername = ? ORDER BY score ASC", getPlayerName(source)), -1)
		
		
		if #rowBurnAndLap > 0 then 
			if rowBurnAndLap[1]["id"] ~= nil then
				if rowBurnAndLap[1]["id"] > 11 then 
					table.remove(BurnAndLapResults, 11)
					table.insert(BurnAndLapResults, 11, rowBurnAndLap[1])
				end
			end
		end
		
		if #rowCitySlicking > 0 then 
			if rowCitySlicking[1]["id"] ~= nil then
				if rowCitySlicking[1]["id"] > 11 then 
					table.remove(CitySlickingResults, 11)
					table.insert(CitySlickingResults, 11, rowCitySlicking[1])
				end
			end
		end
		
		if #rowAllGolds > 0 then 
			if rowAllGolds[1]["id"] ~= nil then
				if rowAllGolds[1]["id"] > 11 then 
					table.remove(AllGoldsResults, 11)
					table.insert(AllGoldsResults, 11, rowAllGolds[1])
				end
			end
		end
		
		-- Init player's data
		if (PlayerResults and #PlayerResults < 1) then
			dbExec(DATABASE, "INSERT INTO PlayersTable(playername, cones, passed, attempts, won, playing, golds, silvers, bronzes) VALUES (?,?,?,?,?,?,?,?,?)", getAccountName(getPlayerAccount(source)), 0, 0, 0, 0, 0, 0, 0, 0)
		end
		
		-- INIT miscTable
		if (MiscResults and #MiscResults < 1) then
			dbExec(DATABASE, "INSERT INTO MiscTable(cones, played) VALUES (?,?)", 0, 0)
			MiscQuery = dbQuery(DATABASE, "SELECT * FROM MiscTable")
			MiscResults = dbPoll(MiscQuery, -1)	
		end
		
		PlayerQuery = dbQuery(DATABASE, "SELECT * FROM PlayersTable WHERE playername = ?", getAccountName(getPlayerAccount(source)))
		PlayerResults = dbPoll(PlayerQuery, -1)

		PBBurnResults = dbPoll(PBBurnQuery, -1)
		PBCityResults = dbPoll(PBCityQuery, -1)
		GoldResults = dbPoll(GoldQuery, -1)
		
		triggerClientEvent(source, "receiveStats", source, PlayerResults, AllGoldsResults, MiscResults, BurnAndLapResults, CitySlickingResults, PBBurnResults, PBCityResults, GoldResults)
	end
end )