-- TODO:
-- Runway indicators on map
-- Hide boat icon if not in boat
-- Move transparency code client side
-- Add pedestrians as spectators as some sort of endurance reward. Make them no collision. Maybe other decorations as well.
-- None of this crap about it into a LEFT PLAYERS table, just index with player serials everywhere
-- Crane one really likes to make 350 degree turns, but doesn't affect the actual deliveries. Only visual.
-- Add options for no planes, boats, etc
-- you could inform the client of the required_cp_count and do the collectCP *before* communicating with the server
-- nth: Output to text

-- Test: Tropic bridge behavior
-- Test: Heli blade collisions (others and yours)
-- Flying a plane kamikaze into the marker can trigger a succesful delivery. Don't

CHECKPOINT = {}
CHECKPOINTS = getElementsByType("checkpoint")
RACE_STARTED = false
RACE_FINISHED = false

REQUIRED_CHECKPOINTS = -1
POLL_ACTIVE = false
OLD_AUTOSAVE_ERASED = false

MARKER_START = getElementByID("_MARKER_GAME_START")

CUTSCENE_LENGTH_IN_SECONDS = 29

CHOSEN_CARS = {}
SHUFFLED_INDICES_PER_PLAYER = {}
PLAYER_TARGETS = {}

PLAYERS_WHO_JOINED_DURING_CUTSCENE = {}

LEFT_PLAYERS_TARGETS = {}
LEFT_PLAYERS_SHUFFLED_CARS = {}

VEHICLES_WITH_GUNS = {
	[425] = true, -- hunter
	[430] = true, -- predator
	[447] = true, -- seaspar
	[464] = true, -- rcbaron
	[476] = true  -- rustler
} -- do not delete

-- BOATS = {
-- 	[430] = true, -- predator
-- 	[446] = true, -- squalo
-- 	[452] = true, -- speeder
-- 	[453] = true, -- reefer
-- 	[454] = true, -- tropic
-- 	[472] = true, -- coastg
-- 	[473] = true, -- dinghy
-- 	[484] = true, -- marquis
-- 	[493] = true, -- jetmax
-- 	[595] = true, -- launch
	
-- 	[435] = true, -- artict1
-- 	[450] = true, -- artict2
-- 	[584] = true, -- petrotr
-- 	[591] = true, -- artict3
-- 	[608] = true, -- tugstair
-- 	[610] = true, -- farmtr1
	
-- 	[449] = true, -- tram
-- 	[537] = true, -- freight
-- 	[538] = true, -- streak
-- 	[569] = true, -- freiflat
-- 	[570] = true, -- streakc
-- 	[590] = true  -- freibox
-- }

TRAINS = {
	[449] = true, -- tram
	[537] = true, -- freight
	[538] = true, -- streak
	[569] = true, -- freiflat
	[570] = true, -- streakc
	[590] = true  -- freibox
} -- do not delete

DATABASE = dbConnect("sqlite", ":/mapSuperFleischbergAutos.db")

function ensureDatabaseExists()
	if DATABASE then
		dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS progressTable (serial TEXT PRIMARY KEY, progress INTEGER, indices TEXT)")
	end
end

ensureDatabaseExists()

------------------------------------------------------ Start of race ------------------------------------------------------

function selectCars()
	local cars = getElementsByType("exportable")
	-- Select cars for every player
	if (#CHOSEN_CARS == 0) then
		if (REQUIRED_CHECKPOINTS == #cars) then
			CHOSEN_CARS = cars
		else
			for i = #cars, #cars - REQUIRED_CHECKPOINTS + 1, -1 do
				randomIndex = math.random(1,i)
				table.insert(CHOSEN_CARS, cars[randomIndex])
				table.remove(cars, randomIndex)
			end
		end
	end
	-- Shuffle the cars for each player
	for i, v in pairs(getElementsByType("player")) do
		shuffleCarsPerPlayer(v)
	end
end

function shuffleCarsPerPlayer(whose)
	if (#CHOSEN_CARS == 0) then
		-- Race hasn't started yet
		return
	end

	local sipp = SHUFFLED_INDICES_PER_PLAYER[whose]
	if (sipp ~= nil and #sipp > 0) then
		-- This player is not new, teleport to next
		teleportPlayerToVehicle(PLAYER_TARGETS[whose], whose)
		triggerClientEvent(whose, "updateTarget", whose, PLAYER_TARGETS[whose])
		return
	end

	local serial = getPlayerSerial(whose)
	if (LEFT_PLAYERS_TARGETS[serial]) then
		-- This player is new, but was here before and has progress stored. Load it.
		PLAYER_TARGETS[whose] = LEFT_PLAYERS_TARGETS[serial]
		SHUFFLED_INDICES_PER_PLAYER[whose] = LEFT_PLAYERS_SHUFFLED_CARS[serial]
		teleportPlayerToVehicle(PLAYER_TARGETS[whose], whose)
		triggerClientEvent(whose, "updateTarget", whose, PLAYER_TARGETS[whose])
	else	
		-- This player is new. Actually shuffle cars and send them the list.
		local intsTable = {}
		SHUFFLED_INDICES_PER_PLAYER[whose] = {}
		for i = #CHOSEN_CARS, 1, -1 do
			table.insert(intsTable, i)
		end
		for i = #intsTable, 1, -1 do
			randomIndex = math.random(1,i)
			table.insert(SHUFFLED_INDICES_PER_PLAYER[whose], intsTable[randomIndex])
			table.remove(intsTable, randomIndex)
		end
		PLAYER_TARGETS[whose] = 1
		teleportPlayerToVehicle(1, whose)
		triggerClientEvent(whose, "postCutsceneGameStart", whose, REQUIRED_CHECKPOINTS)
	end
	colorGenerator(whose)
end

function newJoineeMarkerHit(markerHit, matchingDimension, dumpVariable)
	if (markerHit ~= MARKER_START) then
		return
	end
	if (getElementType(source) ~= "player") then
		return
	end



	-- do nothing if game hasnt started yet
	if (REQUIRED_CHECKPOINTS == -1) then
		return
	end
	if (#CHOSEN_CARS == 0) then
		return
	end
	local sipp = SHUFFLED_INDICES_PER_PLAYER[source]
	if (sipp == nil or #sipp == 0) then
		-- This player is new and hasn't received their list of cars yet. (eg. during intro cutscene)
		triggerClientEvent ( source, "gridCountdownStarted", resourceRoot )
		setTimer(function(whom)
			shuffleCarsPerPlayer(whom)
		end, (CUTSCENE_LENGTH_IN_SECONDS+0.5)*1000, 1, source)
		return
	end
	colorGenerator(source)
	teleportPlayerToVehicle(PLAYER_TARGETS[source], source)
	triggerClientEvent(source, "updateTarget", source, PLAYER_TARGETS[source])
end
addEventHandler("onPlayerMarkerHit", root, newJoineeMarkerHit)

function teleportPlayerToVehicle(target, player)
	-- get our destination
	element = CHOSEN_CARS[SHUFFLED_INDICES_PER_PLAYER[player][target]]
	x = getElementData(element, "posX")
	y = getElementData(element, "posY")
	z = getElementData(element, "posZ")
	rX = getElementData(element, "rotX")
	rY = getElementData(element, "rotY")
	rZ = getElementData(element, "rotZ")
	model = getElementData(element, "model")
	model = tonumber(model)
	-- go there
	local vehicle = getPedOccupiedVehicle(player)
	if (not vehicle) then
		return
	end
	setElementModel(vehicle, model)
	if (TRAINS[model]) then
		setTrainDerailed(vehicle, true)
	end

	if (VEHICLES_WITH_GUNS[model]) then
		toggleControl(player, 'vehicle_secondary_fire', false)
		if (model == 430) then -- predator
			toggleControl(player, 'vehicle_fire', false)
		end
	else
		toggleControl(player, 'vehicle_fire', true)
		toggleControl(player, 'vehicle_secondary_fire', true)
	end

	-- setElementFrozen(vehicle, true)
	setMovementControls(player, false)
	setElementPosition(vehicle, x, y, z)
	setElementAngularVelocity(vehicle, 0, 0, 0)
	setElementVelocity(vehicle, 0, 0, 0)
	setElementRotation(vehicle, rX, rY, rZ)
	fixVehicle(vehicle)
	setElementAlpha ( vehicle, 0 ) 
	setCameraTarget ( player, player )

	if (target == 1 and model == 581) then
		iprint("[FleischBerg Autos] BF START. DEBUG PLS ", getPlayerName(player))
		setTimer( function(vehiclee, xx, yy, zz, rrX, rrY, rrZ)
			-- setElementFrozen(vehicle, true)
			setElementPosition(vehiclee, xx, yy, zz)
			setElementAngularVelocity(vehiclee, 0, 0, 0)
			setElementVelocity(vehiclee, 0, 0, 0)
			setElementRotation(vehiclee, rrX, rrY, rrZ)
			fixVehicle(vehiclee)
		end, 1500, 1, vehicle, x, y, z, rX, rY, rZ)
	end

	setTimer( function(vehicle)
		if (not isElement(vehicle)) then
			return
		end
		setElementAlpha(vehicle, math.min(255, getElementAlpha(vehicle) + 17))
	end, 100, 16, vehicle)

	setTimer ( function(player)
		if (not isElement(player)) then
			-- player left
			return
		end
		setElementAlpha ( vehicle, 255 ) 
		setMovementControls(player, true)
		triggerClientEvent(player, "playGoSound", resourceRoot)
	end, 2000, 1, player)
end

function incrementTarget(oldTarget)
	newTarget = oldTarget + 1
	if (getElementData(client, "race.finished")) then
		return
	end

	if (newTarget > REQUIRED_CHECKPOINTS) then
		-- The target CP is greater than required checkpoints. This means most recent CP == required. Finish the race.
		PLAYER_TARGETS[client] = #getElementsByType("checkpoint")
		triggerClientEvent(client, "finishRace", client)

		-- A player has finished the race, set RACE_FINISHED to true
		RACE_FINISHED = true
	else
		-- Set and TP player to their new target vehicle
		PLAYER_TARGETS[client] = newTarget
		teleportPlayerToVehicle(newTarget, client)
		triggerClientEvent(client, "updateTarget", client, newTarget)
	end

end
addEvent("incrementTarget", true)
addEventHandler("incrementTarget", resourceRoot, incrementTarget)

function playerRespawn(theVehicle, seat, jacked)
	-- do nothing if game hasnt started yet
	if (REQUIRED_CHECKPOINTS == -1) then
		return
	end
	if (#CHOSEN_CARS == 0) then
		return
	end
	local sipp = SHUFFLED_INDICES_PER_PLAYER[source]
	if (sipp == nil or #sipp == 0) then
		-- This player is new and hasn't received their list of cars yet. (eg. during intro cutscene)
		return
	end
	colorGenerator(source)
	teleportPlayerToVehicle(PLAYER_TARGETS[source], source)
	triggerClientEvent(source, "updateTarget", source, PLAYER_TARGETS[source])
end
addEventHandler("onPlayerVehicleEnter", root, playerRespawn)

function raceStateChanged(newState, oldState)
	if (newState ~= "GridCountdown") then
		return
	end
	triggerClientEvent ( root, "gridCountdownStarted", resourceRoot )
	startRacePoll()
	setTimer(startGame, (CUTSCENE_LENGTH_IN_SECONDS+0.5)*1000, 1)

	-- -- This might become obsolete
	-- for i, v in pairs(getElementsByType("player")) do
		-- if (getPedOccupiedVehicle(v) == 522) then
			-- killTimer(timerPoll)
			-- shuffleCars()
		-- end
	-- end
end
addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", root, raceStateChanged)

function configureGame(pollResult)
	REQUIRED_CHECKPOINTS = pollResult
end

function startGame()
	POLL_ACTIVE = false
	RACE_STARTED = true
	selectCars()
	exports.scoreboard:scoreboardAddColumn("Vehicle")
	exports.scoreboard:scoreboardAddColumn("Money_IE", root, 70, "Money")
end

function colorGenerator(player)
	colors = {}
	for i = 1, 4, 1 do
		-- since MTA wants colors in RGB, we won't bother calculating hue. Instead, we pretend S & V are both 100% to calculate a RGB values and apply SV on them later.
		-- When both S and V are 100%, the color in RGB will always have one component of 255, one of 0, and one in between.
		components = {}
		components[1] = 255
		components[2] = 0
		components[3] = math.random(0, 255)
		saturation = math.random(99, 100) / 100
		value = math.random(99, 100) / 100

		-- this block of code determines which RGB component will be min, which max, and which the other by shuffling them.
		indices = {1, 2, 3}
		shuffledIndices = {}
		for i = #indices, 1, -1 do
			random = math.random(1,i)
			shuffledIndices[i] = indices[random]
			table.remove(indices, random)
		end

		-- now we take the min/maxed RGB components and do the saturation & value calculations on them based on the shuffled indices
		for j,w in pairs(shuffledIndices) do
			c = components[w]		
			c = c + ((255 - c) * (1 - saturation)) 
			c = c * value			
			c = c - (c % 1)			
			colors[j + (i - 1) * 3] = c	
		end
	end
	-- apply our 4 generated colors the vehicle
	vehicle = getPedOccupiedVehicle(player)
	setVehicleColor(vehicle, colors[1], colors[2], colors[3], colors[4], colors[5], colors[6], colors[7], colors[8], colors[9], colors[10], colors[11], colors[12])
end

function setMovementControls(player, enabled)
	toggleControl(player, 'vehicle_left', enabled)
	toggleControl(player, 'vehicle_right', enabled)
	toggleControl(player, 'steer_forward', enabled)
	toggleControl(player, 'steer_back', enabled)
	toggleControl(player, 'brake_reverse', enabled)
	toggleControl(player, 'accelerate', enabled)
	toggleControl(player, 'special_control_up', enabled)
	toggleControl(player, 'special_control_down', enabled)
	toggleControl(player, 'vehicle_look_left', enabled)
	toggleControl(player, 'vehicle_look_right', enabled)
end

---------------------------------
---------------------------------

function cleanup(stoppedResource)
	for i, v in ipairs(getElementsByType("player")) do
		toggleControl(v, 'vehicle_fire', true)
		toggleControl(v, 'vehicle_secondary_fire', true)
		toggleControl(v, 'vehicle_left', true)
		toggleControl(v, 'vehicle_right', true)
		toggleControl(v, 'steer_forward', true)
		toggleControl(v, 'steer_back', true)
		toggleControl(v, 'brake_reverse', true)
		toggleControl(v, 'accelerate', true)
		toggleControl(v, 'special_control_up', true)
		toggleControl(v, 'special_control_down', true)
		toggleControl(v, 'vehicle_look_left', true)
		toggleControl(v, 'vehicle_look_right', true)
	end
	exports.scoreboard:scoreboardRemoveColumn("Vehicle")
	exports.scoreboard:scoreboardRemoveColumn ("Money_IE")
end
addEventHandler( "onResourceStop", resourceRoot, cleanup)

function loadGameFromDatabase()
	outputChatBox("Loading game from database...", root, 255, 128, 0)

	if (DATABASE) then
		ensureDatabaseExists()

		local query = dbQuery(DATABASE, "SELECT * FROM progressTable")
		local results = dbPoll(query, -1)

		for _, row in pairs(results) do
			local serial = row["serial"]
			local progress = row["progress"]
			local indices = fromJSON(row["indices"])

			LEFT_PLAYERS_TARGETS[serial] = progress
			LEFT_PLAYERS_SHUFFLED_CARS[serial] = indices

			local player = getPlayerFromSerial(serial)
			if player then
				PLAYER_TARGETS[player] = LEFT_PLAYERS_TARGETS[serial]
				SHUFFLED_INDICES_PER_PLAYER[player] = LEFT_PLAYERS_SHUFFLED_CARS[serial]
			end
		end

		applyPollResult(212, (getMapName() .. " (Full Experience, loaded from save)"))
	end
end

function clearGameFromDatabase()
	if (DATABASE) then
		ensureDatabaseExists()

		dbExec(DATABASE, "DROP TABLE IF EXISTS progressTable")
		iprint("[FleischBerg Autos] All game progress has been cleared from the database.")
	end
end

function savePlayerToDatabase(player)
	if REQUIRED_CHECKPOINTS ~= 212 then
		-- Don't save player to the database if it's not the full experience
		return
	end

	if (SHUFFLED_INDICES_PER_PLAYER[player]) then
		local serial = getPlayerSerial(player)
		local json = toJSON(SHUFFLED_INDICES_PER_PLAYER[player])

		dbExec(DATABASE,
		       "INSERT INTO progressTable (serial, progress, indices) VALUES (?, ?, ?) ON CONFLICT(serial) DO UPDATE SET progress = excluded.progress, indices = excluded.indices",
		       serial, PLAYER_TARGETS[player], json)
	end
end

function autoSave(force)
	force = force == true

	if exports.race:getTimePassed() < 600000 and not force then
		-- Don't save if we're not at least 10 minutes in
		return
	end

	if REQUIRED_CHECKPOINTS ~= 212 then
		-- Don't save to the database if it's not the full experience
		return
	end

	if (#CHOSEN_CARS == 0 or RACE_FINISHED) then
		-- Race hasn't started yet or has ended
		return
	end

	if (not OLD_AUTOSAVE_ERASED) then
		clearGameFromDatabase()
		OLD_AUTOSAVE_ERASED = true
	end

	iprint("[FleischBerg Autos] Autosaving...")
	if (DATABASE) then
		for i, player in ipairs(getElementsByType("player")) do
			savePlayerToDatabase(player)
		end
	end
	iprint("[FleischBerg Autos] Autosaving complete")
end
setTimer(autoSave, 60000, 0) -- autosave every 1 minutes

function manualSaveGame(playerSource, commandName)
	if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Admin")) then
		autoSave(true)
	end
end
addCommandHandler("ie_saveGame", manualSaveGame, false, false)

function playerLeaving(quitType)
	if (#CHOSEN_CARS == 0) then
		-- Race hasn't started yet
		return
	end
	if (getElementData(source, "race.finished")) then
		return
	end
	if (PLAYER_TARGETS[source] == nil or PLAYER_TARGETS[source] < 2) then
		return
	end
	local serial = getPlayerSerial(source)
	LEFT_PLAYERS_TARGETS[serial] = PLAYER_TARGETS[source]
	LEFT_PLAYERS_SHUFFLED_CARS[serial] = SHUFFLED_INDICES_PER_PLAYER[source]

	ensureDatabaseExists()
	savePlayerToDatabase(source)
end
addEventHandler( "onPlayerQuit", root, playerLeaving)

function playerJoining(loadedResource)
	if (loadedResource ~= resource) then
		return
	end
	didWeStartYet = 0
	if (#CHOSEN_CARS > 0) then
		didWeStartYet = 2
	end
	if (POLL_ACTIVE == true) then
		didWeStartYet = 1
		PLAYERS_WHO_JOINED_DURING_CUTSCENE[source] = true
	end
	triggerClientEvent(source, "didWeStartYet", source, didWeStartYet)
	
	local serial = getPlayerSerial(source)
	if serial and LEFT_PLAYERS_TARGETS[serial] then
		PLAYER_TARGETS[source] = LEFT_PLAYERS_TARGETS[serial]
		SHUFFLED_INDICES_PER_PLAYER[source] = LEFT_PLAYERS_SHUFFLED_CARS[serial]

		triggerClientEvent(source, "updateTarget", source, PLAYER_TARGETS[source] or 1)
	end
end
addEventHandler("onPlayerResourceStart", root, playerJoining)

function loadGame(playerSource, commandName)
	if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Admin")) then
		if RACE_STARTED then
			iprint("[FleischBerg Autos] Can't load because the game is already ongoing")
			return
		end
		exports.votemanager:stopPoll{}
		loadGameFromDatabase()
	end
end
addCommandHandler("ie_loadGame", loadGame, false, false)