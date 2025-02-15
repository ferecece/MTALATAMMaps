-- typical sit and wait job for 1 person
Job = {}

function Job:new(id, type, x, y, z)
	local o = {}
	setmetatable(o, self)

	self.__index = self
	o.id = id
	o.type = type
	o.pos = { x = x, y = y, z = z }
	o.progress = 1
	o.players = {}

	return o
end

function Job:setup()
	self:addCollisionChecks()
end

function Job:addCollisionChecks()
	local col = createColCircle(self.pos.x, self.pos.y, g_JOBS_BY_TYPE[self.type].zoneRadius)
	addEventHandler("onColShapeHit", col, function(element)
		local player, vehicle = toPlayer(element)
		if not player then return end
		if not vehicle then return end -- in case of spectator?
		if getPlayerTeam(player.player) ~= g_CriminalTeam then return end

		local _, _, z2 = getElementPosition(vehicle)
		if math.abs(z2 - self.pos.z) > 5 then return end

		if not self:isAvailable() then return end

		self:assign(player)
	end)
	addEventHandler("onColShapeLeave", col, function(element)
		local player = toPlayer(element)
		if not player then return end
		if not self:isAssignedTo(player) then return end
		-- can't check Z but don't care?

		self:unassign(player)
	end)
end

function Job:money()
	return g_JOBS_BY_TYPE[self.type].jobWeight + (self.bonus or 0)
end

function Job:isComplete()
	return self.progress == 1
end

function Job:isAvailable()
	return self.progress ~= 1 and #self:activePlayers() == 0
end

function Job:assign(player)
	self.players[player.player] = true

	self:disable()
	triggerClientEvent(player.player, g_START_JOB_EVENT, resourceRoot, self.id, self.type)
end

function Job:isAssignedTo(player)
	return self.players[player.player]
end

function Job:unassign(player)
	self.players[player.player] = false

	self.progress = 0
	triggerClientEvent(player.player, g_STOP_JOB_EVENT, resourceRoot, self.id, self.type)
	self:enable()
end

function Job:enable()
	self.progress = 0
	triggerClientEvent(getPlayersInTeam(g_CriminalTeam), g_SHOW_JOB_EVENT, resourceRoot, self.id, self.type, self.pos)
end

function Job:disable()
	triggerClientEvent(getPlayersInTeam(g_CriminalTeam), g_HIDE_JOB_EVENT, resourceRoot, self.id)
end

function Job:finish()
	self.progress = 1

	local players = self:activePlayers()
	local reportedPlayers = {}
	for _, player in ipairs(players) do
		givePlayerMoney(player, self:money() * 10)
		setElementData(player, "money", getPlayerMoney(player) .. "k")
		if math.random() > g_CRIME_REPORT_CHANCE then
			reportedPlayers[#reportedPlayers + 1] = player
		end
	end

	triggerClientEvent(players, g_FINISH_JOB_EVENT, resourceRoot, self.id, self.type, reportedPlayers)
	triggerClientEvent(getPlayersInTeam(g_PoliceTeam), g_FINISH_JOB_EVENT, resourceRoot, self.id, self.type, reportedPlayers)

	self:disable()
	self.players = {}
end

function Job:activePlayers()
	local players = {}

	for player, doing in pairs(self.players) do
		if doing then
			players[#players + 1] = player
		end
	end

	return players
end

function Job:tick()
	local players = self:activePlayers()

	if self:isComplete() then return false end
	if #players == 0 then
		self.progress = 0 -- fully reset progress if no one is working on it
		return false
	end

	-- these take 10 intervals of sitting still
	self.progress = math.min(self.progress + g_JOBS_BY_TYPE[self.type].progressRate * g_SERVER_TICK_DELAY / 1000, 1)
	triggerClientEvent(players, g_JOB_STATUS_UPDATE_EVENT, resourceRoot, self.id, self.type, { progress = self.progress })

	return self.progress == 1
end

-- a job with "2" stages that can only be accepted with 1 person
DeliveryJob = Job:new()

function DeliveryJob:assign(player)
	if player.delivering then
		triggerClientEvent(player.player, g_JOB_ALREADY_IN_PROGRESS_EVENT, resourceRoot)
		return
	end

	self.deliverer = player
	self.deliverer.delivering = true
	self.players[player.player] = true

	local endpoints = getElementsByType("delivery_job_end", mapRoot)
	local endpoint = endpoints[math.random(#endpoints)]

	local x, y, z = getElementPosition(endpoint)
	local rx = getElementData(endpoint, "rotX")
	local ry = getElementData(endpoint, "rotY")
	local rz = getElementData(endpoint, "rotZ")

	self.bonus = math.min(g_MAX_DELIVERY_BONUS, getDistanceBetweenPoints3D(self.pos.x, self.pos.y, self.pos.z, x, y, z) / 1200)

	triggerClientEvent(player.player, g_START_JOB_EVENT, resourceRoot, self.id, self.type)

	local subtype = g_JOBS_BY_TYPE[self.type].subtypes.DELIVERY
	if math.random() > 0.5 then
		subtype = g_JOBS_BY_TYPE[self.type].subtypes.ELIMINATION
		self.bonus = self.bonus * 2
	end
	triggerClientEvent(player, g_JOB_STATUS_UPDATE_EVENT, resourceRoot, self.id, self.type, {
		pos = { x = x, y = y, z = z },
		rot = { x = rx, y = ry, z = rz },
		subtype = subtype
	})

	self:disable()
end

function DeliveryJob:unassign(player)
	-- you can't be unassigned from a destination job
end

function DeliveryJob:tick()
	-- does nothing since we just need the player to reach a destination
	return false
end

function DeliveryJob:finish()
	self.progress = 1
	self.deliverer.delivering = false

	local players = self:activePlayers()
	local reportedPlayers = {}
	for _, player in ipairs(players) do
		givePlayerMoney(player, self:money() * 10)
		setElementData(player, "money", getPlayerMoney(player) .. "k")
		if math.random() > g_CRIME_REPORT_CHANCE then
			reportedPlayers[#reportedPlayers + 1] = player
		end
	end

	triggerClientEvent(players, g_FINISH_JOB_EVENT, resourceRoot, self.id, self.type, reportedPlayers)
	triggerClientEvent(getPlayersInTeam(g_PoliceTeam), g_FINISH_JOB_EVENT, resourceRoot, self.id, self.type, reportedPlayers)

	self:disable()
	self.players = {}
end

HarvestJob = DeliveryJob:new()

function HarvestJob:enable()
	self.progress = 0
	triggerClientEvent(getPlayersInTeam(g_CriminalTeam), g_SHOW_JOB_EVENT, resourceRoot, self.id, self.type, self.pos, self.forPlayer)
end

function HarvestJob:setup(player)
	self:addCollisionChecks()
	self.forPlayer = getPlayerName(player) or "Someone"
	self.ped = createPed(111, self.pos.x, self.pos.y, self.pos.z + 0.2)
	setElementHealth(self.ped, 0)
end

function HarvestJob:assign(player)
	if player.delivering then
		triggerClientEvent(player.player, g_JOB_ALREADY_IN_PROGRESS_EVENT, resourceRoot)
		return
	end

	destroyElement(self.ped)

	self.deliverer = player
	self.deliverer.delivering = true
	self.players[player.player] = true

	-- set to closest end
	local endpoints = getElementsByType("harvest_job_end", mapRoot)
	local minDistance = 999999 -- probably fine
	local endpoint = nil
	local px, py, pz = getElementPosition(player.player)
	for _, possibleEndpoint in ipairs(endpoints) do
		local nx, ny, nz = getElementPosition(possibleEndpoint)
		local newDistance = getDistanceBetweenPoints3D(nx, ny, nz, px, py, pz)
		if newDistance < minDistance then
			endpoint = possibleEndpoint
			minDistance = newDistance
		end
	end

	local x, y, z = getElementPosition(endpoint)

	triggerClientEvent(player.player, g_START_JOB_EVENT, resourceRoot, self.id, self.type)

	triggerClientEvent(player, g_JOB_STATUS_UPDATE_EVENT, resourceRoot, self.id, self.type, {
		pos = { x = x, y = y, z = z },
		rot = { x = 0, y = 0, z = 0 }
	})

	self:disable()
end

function HarvestJob:finish()
	self.progress = 1
	self.deliverer.delivering = false

	local players = self:activePlayers()
	local reportedPlayers = {}
	for _, player in ipairs(players) do
		givePlayerMoney(player, self:money() * 10)
		setElementData(player, "money", getPlayerMoney(player) .. "k")
		if math.random() > g_CRIME_REPORT_CHANCE then
			reportedPlayers[#reportedPlayers + 1] = player
		end
	end

	self.deliverer:heal(g_JOBS_BY_TYPE[self.type].healRate)

	triggerClientEvent(players, g_FINISH_JOB_EVENT, resourceRoot, self.id, self.type, reportedPlayers)
	triggerClientEvent(getPlayersInTeam(g_PoliceTeam), g_FINISH_JOB_EVENT, resourceRoot, self.id, self.type, reportedPlayers)

	self:disable()
	self.players = {}
end

-- sit and wait... in a group job
GroupJob = Job:new()

function GroupJob:assign(player)
	self.players[player.player] = true

	triggerClientEvent(player.player, g_START_JOB_EVENT, resourceRoot, self.id, self.type)
end

function GroupJob:unassign(player)
	self.players[player.player] = false

	triggerClientEvent(player.player, g_STOP_JOB_EVENT, resourceRoot, self.id, self.type)
end

function GroupJob:tick()
	local players = self:activePlayers()

	if self:isComplete() then return false end
	if #players == 0 then
		self.progress = math.max(self.progress - g_JOBS_BY_TYPE[self.type].decayRate * g_SERVER_TICK_DELAY / 1000, 0) -- decay
		return false
	end

	-- slower than normal job but scales with players, needs certain amount of players to progress
	local advance = g_JOBS_BY_TYPE[self.type].progressRate  * g_SERVER_TICK_DELAY / 1000
	self.progress = math.min(self.progress + math.max(advance * (#players + 1 - g_JOBS_BY_TYPE[self.type].minPlayers), 0), 1)
	triggerClientEvent(players, g_JOB_STATUS_UPDATE_EVENT, resourceRoot, self.id, self.type, { progress = self.progress, playerCount = #players })

	return self.progress == 1
end

function GroupJob:isAvailable()
	return self.progress ~= 1
end

-- also 2 stages but 2nd stage is honking at same location
ExtortionJob = Job:new()

function ExtortionJob:assign(player)
	self.players[player.player] = true

	triggerClientEvent(player.player, g_START_JOB_EVENT, resourceRoot, self.id, self.type)
	triggerClientEvent(player, g_JOB_STATUS_UPDATE_EVENT, resourceRoot, self.id, self.type, { pos = { x = x, y = y, z = z } })
	self:disable()
end

function ExtortionJob:tick()
	return false
end