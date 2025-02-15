-- global for debug purposes atm
local jobs = {}
local exits = {}
local playersByClient = {}
local players = {}

local lastJobId = 0
local availableJobs = 0
local lastSpawnedJobAt = 0
local totalMoneyHandicap = 0
local totalMoneyProgress = 0
local moneyEscapeQuota = 0
local lastExitId = 0
local exitsSpawned = 0
local lastSpawnedExitAt = 0
local gameState = g_PREGAME_STATE
local harvestJobCount = 0
local gameStartedAt = nil

local function runWithDelaysInBetween(...)
	local args = {...}
	-- initial delay for testing environment
	local totalDelay = 500
	-- there's probably some fancy way to nest timers but whatever
	for i = 1, #args, 2 do
		-- args[odd] is a fn
		-- args[even] is delay
		setTimer(args[i], totalDelay, 1)
		totalDelay = totalDelay + args[i + 1]
	end
end

local function updateMoney()
	totalMoneyHandicap = math.max(totalMoneyHandicap, 0)

	triggerClientEvent(getRootElement(), g_MONEY_UPDATE_EVENT, resourceRoot, {
		money = totalMoneyProgress,
		moneyHandicap = totalMoneyHandicap,
		moneyQuota = moneyEscapeQuota
	})
end

local function finishJob(job)
	job:finish()

	if job.type ~= g_HARVEST_JOB.type then
		availableJobs = availableJobs - 1
	end
	totalMoneyProgress = totalMoneyProgress + job:money()

	if gameState == g_ENDGAME_STATE then
		totalMoneyHandicap = totalMoneyHandicap - job:money()
	end

	updateMoney()
end

local function assignJob(job, player)
	job:assign(player)
end

local function unassignJob(job, player)
	job:unassign(player)
end

local function updateGameState(state)
	if state == g_COREGAME_STATE then
		g_CopWeaponId = 29 -- mp5
		-- remove blips?
		-- unbind criminal keys?
	elseif state == g_ENDGAME_STATE then
		g_CopWeaponId = 31 -- m4

		lastSpawnedExitAt = getRealTime().timestamp + (g_FIRST_EXIT_SPAWN_DELAY - g_DELAY_BETWEEN_EXIT_SPAWN) / 1000

		for _, criminal in ipairs(getPlayersInTeam(g_CriminalTeam)) do
			if getElementData(criminal, "state") == "alive" then
				createBlipAttachedTo(criminal, 0, 2, 150, 0, 200, 255, 6, 80085)
			end
		end

		setTimer(function ()
			for _, cop in ipairs(getPlayersInTeam(g_PoliceTeam)) do
				if getElementData(cop, "state") == "alive" then
					createBlipAttachedTo(cop, 0, 2, 30, 190, 240, 255, 6, 80085)
				end
			end
		end, g_FIRST_EXIT_SPAWN_DELAY, 1)
	elseif state == g_ENDENDGAME_STATE then
		for _, criminal in ipairs(getPlayersInTeam(g_CriminalTeam)) do
			bindKey(criminal, "vehicle_secondary_fire", "down", function()
				takeAllWeapons(criminal)
				giveWeapon(criminal, 30, 9999, true) -- ak47
				setPedDoingGangDriveby(criminal, not isPedDoingGangDriveby(criminal))
			end)
		end
	elseif state == g_NO_CRIMS_STATE then
		-- no criminals, so guess its ogre?
	end

	gameState = state
	triggerClientEvent(getRootElement(), g_GAME_STATE_UPDATE_EVENT, resourceRoot, state)
	triggerEvent(g_GAME_STATE_UPDATE_EVENT, resourceRoot, state)
end

local function maybeUpdateGameState()
	if gameState == g_COREGAME_STATE and totalMoneyProgress + totalMoneyHandicap >= moneyEscapeQuota then
		updateGameState(g_ENDGAME_STATE)
	elseif gameState == g_ENDGAME_STATE and totalMoneyProgress >= moneyEscapeQuota * g_SECRET_ENDING_REQUIREMENT_MULTIPLIER then
		updateGameState(g_ENDENDGAME_STATE)
	elseif gameState ~= g_NO_CRIMS_STATE then
		local criminals = getPlayersInTeam(g_CriminalTeam)
		for _, criminal in ipairs(criminals) do
			if getElementData(criminal, "state") == "alive" then
				return
			end
		end

		updateGameState(g_NO_CRIMS_STATE)
	end
end

local function spawnExitPoint(id)
	local exitPoint = exits[id]
	if not exitPoint.active then
		exitPoint:enable()
		lastSpawnedExitAt = getRealTime().timestamp
		exitsSpawned = exitsSpawned + 1
	end
end

local function maybeSpawnExitPoint()
	if (gameState == g_ENDGAME_STATE or gameState == g_ENDENDGAME_STATE) and
		(lastSpawnedExitAt < getRealTime().timestamp - (g_DELAY_BETWEEN_EXIT_SPAWN / 1000) and
		exitsSpawned < g_MAX_EXITS_AVAILABLE) then

		if totalMoneyHandicap > 0 then
			totalMoneyHandicap = totalMoneyHandicap - moneyEscapeQuota * (g_SECRET_ENDING_REQUIREMENT_MULTIPLIER - 1) * (g_SERVER_TICK_DELAY / g_FIRST_EXIT_SPAWN_DELAY)
			updateMoney()
			return
		end

		lastExitId = lastExitId + 1
		spawnExitPoint(lastExitId)
		if lastExitId == #exits then
			lastExitId = 0
		end
		lastExitId = lastExitId + 1
		spawnExitPoint(lastExitId)
		if lastExitId == #exits then
			lastExitId = 0
		end
	end
end

local function spawnJob(id)
	local job = jobs[id]
	if job:isComplete() then
		job:enable()
		availableJobs = availableJobs + 1
		lastSpawnedJobAt = getRealTime().timestamp
	end
end

local function maybeSpawnJob()
	-- note that the team number can change if people go ped
	if availableJobs < countPlayersInTeam(g_CriminalTeam) * g_AVAILABLE_JOBS_MULTIPLIER + 10 and
		availableJobs < g_MAX_JOBS_AVAILABLE and
		lastSpawnedJobAt < getRealTime().timestamp - (g_DELAY_BETWEEN_JOB_SPAWN / 1000) then
		lastJobId = lastJobId + 1
		spawnJob(lastJobId)
		if lastJobId == #jobs then
			lastJobId = 0
		end
	end
end

local function updatePerksStatus()
	for _, player in pairs(playersByClient) do
		player:checkPerk()
	end
end


local function updateJobProgress()
	for _, job in ipairs(jobs) do
		local completed = job:tick()

		if completed then
			finishJob(job)
		end
	end
end

local function checkCriminalPitySystem()
	if gameState == g_COREGAME_STATE then
		local elapsed = getRealTime().timestamp - gameStartedAt
		local curve = 1.005
		-- (0, 0)
		-- (g_MAX_COREGAME_LENGTH / 1000, moneyEscapeQuota)
		totalMoneyHandicap = moneyEscapeQuota * (math.pow(curve, elapsed) - 1) / (math.pow(curve, g_MAX_COREGAME_LENGTH / 1000) - 1)
		updateMoney()
	end
end

local function startGameLoop()
	updateGameState(g_COREGAME_STATE)
	gameStartedAt = getRealTime().timestamp

	setTimer(function()
		local start = getTickCount()
		maybeUpdateGameState()
		maybeSpawnExitPoint()
		maybeSpawnJob()
		updateJobProgress()
		updatePerksStatus()
		checkCriminalPitySystem()
		local stop = getTickCount()
		local over = math.floor((stop - start) - g_SERVER_TICK_DELAY)
		if over > 0 then
			-- things aren't updating as fast as expected
			outputDebugString("game tick delayed by " .. over .. "ms", 2)
		end
	end, g_SERVER_TICK_DELAY, 0)
end

local function spawnHarvestJob(player)
	if not playersByClient[player] then return end
	if playersByClient[player].died then return end

	playersByClient[player].died = true

	local x, y, z = getElementPosition(player)
	harvestJobCount = harvestJobCount + 1
	 -- using negatives so it doesnt interfere with other jobs
	local id = -harvestJobCount
	local job = HarvestJob:new(id, "harvest job", x, y, z)
	job:setup(player)
	job:enable()
	jobs[id] = job
end

local function preGameSetup(callback)
	-- attempt to remove player blips
	for _, blip in pairs(getElementsByType("blip")) do
		destroyElement(blip)
	end

	-- set up exit points and shuffle
	for _, group in ipairs(getElementsByType("exit_group", mapRoot)) do
		-- not sure what the duplicates are
		exits[#exits + 1] = Exit:new(group)
	end

	shuffle(exits)

	-- shuffle jobs into order they will spawn in
	local jobElements = {}
	for _, job in ipairs({
		g_PICKUP_JOB,
		g_GROUP_JOB,
		g_DELIVERY_JOB,
		g_EXTORTION_JOB
	}) do
		for _, element in ipairs(getElementsByType(job.elementType, mapRoot)) do
			jobElements[#jobElements + 1] = { element = element, job = job }
		end
	end

	shuffle(jobElements)

	for id, element in ipairs(jobElements) do
		local job = nil
		if element.job == g_DELIVERY_JOB then
			job = DeliveryJob:new(id, element.job.type, getElementPosition(element.element))
		elseif element.job == g_GROUP_JOB then
			job = GroupJob:new(id, element.job.type, getElementPosition(element.element))
		elseif element.job == g_EXTORTION_JOB then
			job = ExtortionJob:new(id, element.job.type, getElementPosition(element.element))
		else
			job = Job:new(id, element.job.type, getElementPosition(element.element))
		end

		jobs[#jobs + 1] = job
		job:setup()
	end

	-- start listening for client side completion of jobs (honk job, delivery job)
	addEvent(g_FINISH_JOB_EVENT, true)
	addEventHandler(g_FINISH_JOB_EVENT, getRootElement(), function(id)
		finishJob(jobs[id])
	end)

	-- set up player objects, this will give them a chance to select cop preference
	for _, player in pairs(getElementsByType("player")) do
		playersByClient[player] = Player:new(player)
		players[#players + 1] = playersByClient[player]

		-- should toggle internal boolean to hide race nametags
		triggerClientEvent(player, "onClientScreenFadedOut", resourceRoot)
	end
end

local function playerSetup()
	shuffle(players)

	local policeCount = math.min(g_MAX_COPS, math.ceil(#players / g_CRIMINALS_PER_COP))
	if #players == 1 then
		policeCount = 0
	end

	-- assign police roles to people who want them
	for _, player in ipairs(players) do
		if policeCount == 0 then break end
		if player.wantPolice then
			local success = player:setRole(g_POLICE_ROLE)
			if not success then break end
			policeCount = policeCount - 1
		end
	end

	-- if not enough police, start assigning and ignore preferences
	if policeCount > 0 then
		for _, player in ipairs(players) do
			if policeCount == 0 then break end
			if player.role == nil then
				local success = player:setRole(g_POLICE_ROLE) -- may not succeed if not enough spawn points
				if not success then break end
				policeCount = policeCount - 1
			end
		end
	end

	-- set everyone who doesn't have a role yet to criminal
	for _, player in ipairs(players) do
		if player.role == nil then
			player:setRole(g_CRIMINAL_ROLE)
		end
	end

	-- remove remaining invisible cop vehicle placeholders
	for _, copCar in pairs(getElementsByType("vehicle", mapRoot)) do
		if getElementModel(copCar) == 596 and not next(getVehicleOccupants(copCar)) then
			destroyElement(copCar)
		end
	end

	-- set up player based limits
	moneyEscapeQuota = countPlayersInTeam(g_CriminalTeam) * 10
	updateMoney()

	-- harvest jobs spawn whenever anyone disappears no matter what team
	addEventHandler("onPlayerQuit", getRootElement(), function()
		spawnHarvestJob(source)
	end)
	addEventHandler("onPlayerWasted", getRootElement(), function()
		spawnHarvestJob(source)
		triggerClientEvent(source, "onClientScreenFadedIn", resourceRoot)
	end)
end

addEvent("onRaceStateChanging")
addEventHandler("onRaceStateChanging", getRootElement(), function(state)
	if state == "GridCountdown" then
		local forceFreezeTimer = nil

		runWithDelaysInBetween(
			function()
				-- freeze players
				forceFreezeTimer = setTimer(function()
					for _, player in ipairs(getElementsByType("player")) do
						toggleControl(player, "accelerate", false)
						toggleControl(player, "brake_reverse", false)
					end
				end, 10, 0)

				call(getResourceFromName("scoreboard"), "addScoreboardColumn", "money")
			end,
			500, -- random delay
			preGameSetup,
			-- extra ms to prevent police app ui cleanup
			-- from messing with perk selection ui
			g_POLICE_APPLICATION_DURATION + 300,
			playerSetup,
			g_PERK_SELECTION_DURATION,
			function()
				-- unfreeze players
				killTimer(forceFreezeTimer)
				for _, player in ipairs(getElementsByType("player")) do
					toggleControl(player, "accelerate", true)
					toggleControl(player, "brake_reverse", true)
				end
				-- start game
				startGameLoop()
			end,
			0
		)
	end
end)

if g_DEBUG_MODE then
	addCommandHandler("ugs", function(ply, arg, s)
		print(arg, s)
		updateGameState(s)
	end)

	addCommandHandler("sep", function(ply, arg, id)
		print(arg, id)
		spawnExitPoint(tonumber(id))
	end)

	addCommandHandler("sj", function(ply, arg, id)
		print(arg, id)
		spawnJob(tonumber(id))
	end)

	addCommandHandler("shj", function(ply, arg, id)
		spawnHarvestJob(ply)
		playersByClient[ply].died = false
	end)

	addCommandHandler("fj", function(ply, arg, id)
		print(arg, id)
		finishJob(jobs[tonumber(id)])
	end)

	addCommandHandler("aj", function(ply, arg, id)
		print(arg, id)
		assignJob(jobs[tonumber(id)], playersByClient[ply])
	end)

	addCommandHandler("uj", function(ply, arg, id)
		print(arg, id)
		unassignJob(jobs[tonumber(id)], playersByClient[ply])
	end)

	addCommandHandler("sr", function(ply, arg, r)
		print(arg, r)
		playersByClient[ply]:setRole(r)
	end)

	addCommandHandler("eee", function(ply, arg, ...)
		print(...)
		loadstring(...)()
	end)
end

function shuffle(a)
	for i = #a, 2, -1 do
		local j = math.random(i)
		a[i], a[j] = a[j], a[i]
	end
end

function toPlayer(element)
	if getElementType(element) ~= "vehicle" then return false end
	return playersByClient[getVehicleOccupant(element)], element
end