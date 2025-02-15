currentMarker = {nil, nil, nil}
currentMarkerBlip = {nil, nil, nil}
respawnCheckpointTimer = {nil, nil, nil}

checkpointsAmount = 0
markerCounter = 0
checkpointForFinish = 10
shootingEnabled = 0
pollIsFinished = false

local checkCoords = {
	{-1324.2, 1022.1, 1027.7}, -- 1
	{-1337.6, 1025.3, 1026.5},
	{-1313, 1005.7998, 1027.1},
	{-1283.7, 992.59998, 1036.2},
	{-1335.0996, 1011.5, 1024.6},
	{-1336.5, 960.79999, 1026.8},
	{-1329.7002, 953.7998, 1031.3},
	{-1352.4, 954.79999, 1026.8},
	{-1307.8, 978.59998, 1028.2},
	{-1358.9004, 969.5, 1023.7},
	{-1435, 982.40002, 1023},
	{-1340.5, 976.7998, 1024},
	{-1435.5, 1005.8, 1023.4},
	{-1417.8, 997.09998, 1023.2},
	{-1414.2, 971.90002, 1023.2},
	{-1421.2, 945.59998, 1031.1},
	{-1437.1, 971.79999, 1028.3},
	{-1394.1, 963.40002, 1024},
	{-1395.4, 947, 1028.4},
	{-1411.6, 954.09998, 1026.1},
	{-1419.8, 1024.5, 1024.7},
	{-1463.3, 1008.2, 1024.7},
	{-1479.7, 974.29999, 1027.4},
	{-1450.1, 951.59998, 1028.4},
	{-1454.4, 1037.5, 1029.5},
	{-1483.7, 1018, 1028.9},
	{-1449.8, 997.59998, 1023.3},
	{-1395.3, 1033.7, 1029.5},
	{-1498, 993.29999, 1030.6},
	{-1379.3, 1016.7, 1023.7},
	{-1366.1, 994.79999, 1023.1},
	{-1399, 999.59998, 1023.2},
	{-1350.9, 1035.5, 1028},
	{-1418.5, 1058.2, 1037.6},
	{-1321.2, 1045.2, 1037.2},
	{-1303.8, 1017.5, 1032.1},
	{-1377.9, 974.5, 1023},
	{-1383.4, 989.79999, 1023},
	{-1398, 974.40002, 1023.1},
	{-1490.5, 955.29999, 1036},
	{-1433.3, 992.70001, 1023.2},
	{-1374.7, 1045.3, 1031.1},
	{-1390.9, 1057.1, 1037.5},
	{-1309.9, 962.20001, 1033.7},
	{-1292.8, 980.40002, 1035},
	{-1320.7, 943.09998, 1035.5},
	{-1325.2, 966.5, 1027.1},
	{-1353.7, 984.70001, 1022.9},
	{-1374.5, 945.5, 1029.7},
	{-1504.6, 1020, 1037.1},
	{-1487.7, 982.09998, 1031.6},
	{-1491.8, 1007.2, 1029},
	{-1439.8, 1019.6, 1024.5},
	{-1401.7, 1020, 1024.1},
	{-1357.7, 1014.4, 1023.8},
	{-1457.9, 970.5, 1024.7} -- 56
};

function math.randomDiff (start, finish)
	math.randomseed(getTickCount())
	
    if (start and finish) then
        if (math.floor(start) ~= start) or (math.floor(finish) ~= finish) then return false end
        if (start >= finish) then return false end
    end
    if not start then
        local rand = math.random()
        while (rand == lastRand) do
            rand = math.random()
        end
        lastRand = rand
        return rand
    end
    
    if not finish then
        finish = start
        start = 1
    end
    
    local rand = math.random(start, finish)
    while (rand == lastRand) do
        rand = math.random(start, finish)
    end
    lastRand = rand
    return rand
end

addEvent("checkClientMarker", true)
addEventHandler("checkClientMarker", getRootElement(), function(marker)
	local i = 1
	while i <= checkpointsAmount do
		if marker == currentMarker[i] then
			-- spectate check
			local sx, sy, sz = getElementPosition(source)
			if getElementData(source, "state") == "spectating" or sz > 10000.0 then return end
			
			-- add health for player's vehicle
			if getElementHealth(getPedOccupiedVehicle(source)) < 600 then 
				if getElementHealth(getPedOccupiedVehicle(source)) < 250 then setElementHealth(getPedOccupiedVehicle(source), 350)
				else setElementHealth(getPedOccupiedVehicle(source), getElementHealth(getPedOccupiedVehicle(source)) + 100) end
			end
			
			local i = 1
			while i <= checkpointsAmount do
				if marker == currentMarker[i] then
					-- Destroy old CP and blip
					if isElement(currentMarker[i]) then destroyElement(currentMarker[i]) end
					if isElement(currentMarkerBlip[i]) then destroyElement(currentMarkerBlip[i]) end
					
					-- Make a new one
					local randNum = math.randomDiff(1, 56)
					currentMarker[i] = createMarker(checkCoords[randNum][1], checkCoords[randNum][2], checkCoords[randNum][3], "checkpoint", 5.0, 255, 0, 0 , 255)
					currentMarkerBlip[i] = createBlip(checkCoords[randNum][1], checkCoords[randNum][2], checkCoords[randNum][3], 0, 2, 255, 0, 0)
					
					-- Respawn Current Checkpoint (30s)
					if isTimer(respawnCheckpointTimer[i]) then
						killTimer(respawnCheckpointTimer[i])
					end
					respawnCheckpointTimer[i] = setTimer(respawnCheckpoint, 30000, 1, i)
			
					break
				end
				i = i + 1
			end
			
			-- ThunderStorm
			markerCounter = markerCounter + 1
			
			if math.floor(checkpointForFinish*0.8*getPlayerCount()) == markerCounter then 
				setWeather(16)
				outputChatBox("#00F6FFLooks like it's starting to rain!", root, 0, 246, 255, true)
			end
			
			triggerClientEvent(source, "onBloodMarkerHit", getRootElement(), marker)
			break
		end
		i = i + 1
	end
end )

addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", root, function(newState, oldState)
	if newState == "PreGridCountdown" then
		exports.votemanager:stopPoll {}
		pollIsFinished = false
		poll = exports.votemanager:startPoll 
		{
			title = "Choose amount of checkpoints:",
			percentage = 100,
			timeout = 15,
			allowchange = true,

			[1] = {"Getting Started [10]", "pollFinished" , resourceRoot, 10},		
			[2] = {"Full Experience [30]", "pollFinished" , resourceRoot, 30},		
		}
		
		if not poll then applyPollResult(30) end	
	elseif newState == "Running" and oldState == "GridCountdown" then
		outputChatBox("#FF0000Bloodbowl but without Blood and Bowl!", root, 255, 0, 0, true)
		
		local playersCount = getPlayerCount()
		if playersCount < 5 then 
			checkpointsAmount = 1
			shootingEnabled = 1
			
			outputChatBox("#FF0000Attention! #FFFFFFRockets have been enabled due to low player count.", root, 255, 0, 0, true)
			
			respawnCheckpointTimer[1] = setTimer(respawnCheckpoint, 30000, 1, 1)
		elseif playersCount >= 5 and playersCount <= 10 then 
			checkpointsAmount = 2
			shootingEnabled = 0
			
			outputChatBox("#FFFFFFRockets have been disabled due to high player count.", root, 255, 0, 0, true)
			outputChatBox("#FFFFFFAmount of checkpoints increased to#FF0000 2", root, 255, 0, 0, true)
			
			respawnCheckpointTimer[1] = setTimer(respawnCheckpoint, 30000, 1, 1)
			respawnCheckpointTimer[2] = setTimer(respawnCheckpoint, 30000, 1, 2)
		elseif playersCount > 10 then 
			checkpointsAmount = 3 
			shootingEnabled = 0
			
			outputChatBox("#FFFFFFRockets have been disabled due to high player count.", root, 255, 0, 0, true)
			outputChatBox("#FFFFFFAmount of checkpoints increased to#FF0000 3", root, 255, 0, 0, true)
			
			respawnCheckpointTimer[1] = setTimer(respawnCheckpoint, 30000, 1, 1)
			respawnCheckpointTimer[2] = setTimer(respawnCheckpoint, 30000, 1, 2)
			respawnCheckpointTimer[3] = setTimer(respawnCheckpoint, 30000, 1, 3)
		end
		
		updatePlayers()
		setTimer(updatePlayers, 1000, 0)
		
		-- Create random checkpoints and blips
		for i = 1, checkpointsAmount do
			local randNum = math.randomDiff(1, 56)
			currentMarker[i] = createMarker(checkCoords[randNum][1], checkCoords[randNum][2], checkCoords[randNum][3], "checkpoint", 5.0, 255, 0, 0 , 255)
			currentMarkerBlip[i] = createBlip(checkCoords[randNum][1], checkCoords[randNum][2], checkCoords[randNum][3], 0, 2, 255, 0, 0)
		end
	end
end )

addEvent("pollFinished", true)
addEventHandler("pollFinished", resourceRoot, function(pollResult) 
	checkpointForFinish = pollResult
	pollIsFinished = true
	
	-- Use separate leaderboard for Full Experience
	if checkpointForFinish == 30 then 
		local customMapName = getMapName()
		customMapName = customMapName .. " (Full Experience)"
		setMapName(customMapName)
	
		local timesManager = getResourceRootElement(getResourceFromName("race_toptimes2"))
		local raceResRoot = getResourceRootElement(getResourceFromName("race"))
		local raceInfo = raceResRoot and getElementData(raceResRoot, "info")
		
		local stuff = {}
		stuff.modename = raceInfo.mapInfo.modename
		stuff.name = customMapName
		stuff.statsKey = nil

		if raceInfo and timesManager then
			triggerEvent("onMapStarting", timesManager, stuff, stuff, stuff)
		end
	end
end )

addEventHandler("onResourceStart", getRootElement(), function()
	setInteriors()
	setTimer(setInteriors, 1000, 0)
end )

-- Function that respawn CP if nobody has picked it up (attached to timer)
function respawnCheckpoint(index)
	if isElement(currentMarker[index]) then destroyElement(currentMarker[index]) end
	if isElement(currentMarkerBlip[index]) then destroyElement(currentMarkerBlip[index]) end
	
	-- Create new random checkpoint
	local randNum = math.randomDiff(1, 56)
	currentMarker[index] = createMarker(checkCoords[randNum][1], checkCoords[randNum][2], checkCoords[randNum][3], "checkpoint", 5.0, 255, 0, 0, 255)
	currentMarkerBlip[index] = createBlip(checkCoords[randNum][1], checkCoords[randNum][2], checkCoords[randNum][3], 0, 2, 255, 0, 0)
	
	-- Start a new timer
	respawnCheckpointTimer[index] = setTimer(respawnCheckpoint, 30000, 1, index)
end

function updatePlayers()
	if pollIsFinished then
		-- Send data back to clients
		for index, players in ipairs(getElementsByType("player")) do
			if getElementData(players, "trigger") == 1 then 
				triggerClientEvent(players, "postVoteStuff", getRootElement(), checkpointForFinish, shootingEnabled)
				setElementData(players, "trigger", 0)
			end
		end
	end
end

-- function that sets interior property for all race elements
function setInteriors()
	for index, players in ipairs(getElementsByType("player")) do
		setElementInterior(players, 15)
	end
	for index, markers in ipairs(getElementsByType("marker")) do
		setElementInterior(markers, 15)
	end
	for index, vehicles in ipairs(getElementsByType("vehicle")) do
		setElementInterior(vehicles, 15)
	end
	for index, spawnpoints in ipairs(getElementsByType("spawnpoint")) do
		setElementInterior(spawnpoints, 15)
	end
end