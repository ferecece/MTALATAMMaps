g_FUGITIVE_PERK = {
	id = "fugitivePerkId",
	name = "Fugitive",
	maxAlpha = 255,
	minAlpha = 0,
	phaseOutTime = 500, -- ms
	phaseInTime = 3000, -- ms
	minSpeed = 0.2, -- total velocity
	description = "Slowly turn invisible with handbreak while driving."
}
g_MECHANIC_PERK = {
	id = "mechanicPerkId",
	name = "Mechanic",
	healRate = 10, -- per second
	description = "Stand still to slowly regain health."
}
g_HOTSHOT_PERK = {
	id = "hotshotPerkId",
	name = "Hotshot",
	velocityRate = 0.2, -- maxVelocity per missing hp
	accelRate = 0.01, -- engineAcceleration per missing hp
	description = "The lower your health, the higher your top speed."
}
g_PICKUP_JOB = {
	elementType = "pickup_job",
	type = "pickup job",
	detectionRadius = 250,
	zoneRadius = 5,
	blip = 52,
	color = { r = 10, g = 130, b = 0, a = 100 },
	jobWeight = 0.879,
	progressRate = 0.25 -- per second
}
g_DELIVERY_JOB = {
	elementType = "delivery_job_start",
	type = "delivery job",
	subtypes = {
		ELIMINATION = "elimination",
		DELIVERY = "delivery",
	},
	detectionRadius = 250,
	zoneRadius = 5,
	blip = 51,
	color = { r = 255, g = 0, b = 0, a = 100 },
	jobWeight = 1.213 -- and bonus
}
g_EXTORTION_JOB = {
	elementType = "extortion_job",
	type = "extortion job",
	detectionRadius = 250,
	zoneRadius = 5,
	blip = 55,
	color = { r = 0, g = 0, b = 160, a = 100 },
	jobWeight = 1.061,
	progressRate = 0.03, -- per interval
	decayRate = 0.05, -- per interval
	interval = 100 -- in ms, client side, unrelated to server ticks
}
g_GROUP_JOB = {
	elementType = "group_job",
	type = "group job",
	detectionRadius = 1000,
	zoneRadius = 22,
	blip = 6,
	color = { r = 255, g = 255, b = 255, a = 100 },
	jobWeight = 11.797,
	progressRate = 0.05, -- per second
	decayRate = 0.1, -- per second
	minPlayers = 3
}
g_HARVEST_JOB = {
	elementType = "invalid_element",
	type = "harvest job",
	detectionRadius = 165,
	zoneRadius = 5,
	blip = 21,
	color = { r = 160, g = 0, b = 210, a = 100 },
	healRate = 50, -- per organ clicked (6)
	jobWeight = 1.104 -- per organ clicked (6 organs), total should help with the dead players quota
}
g_JOBS_BY_TYPE = {
	[g_PICKUP_JOB.type] = g_PICKUP_JOB,
	[g_DELIVERY_JOB.type] = g_DELIVERY_JOB,
	[g_EXTORTION_JOB.type] = g_EXTORTION_JOB,
	[g_GROUP_JOB.type] = g_GROUP_JOB,
	[g_HARVEST_JOB.type] = g_HARVEST_JOB
}

g_SERVER_TICK_DELAY = 150 -- ms per tick
g_DEBUG_MODE = false

g_SECRET_ENDING_REQUIREMENT_MULTIPLIER = 1.5
g_AVAILABLE_JOBS_MULTIPLIER = 3
g_MAX_JOBS_AVAILABLE = 120
g_DELAY_BETWEEN_JOB_SPAWN = 500 -- ms
g_DELAY_BETWEEN_EXIT_SPAWN = 15000 -- ms
g_MAX_EXITS_AVAILABLE = 10
g_MAX_DELIVERY_BONUS = 2 -- compared to 1 for job
g_CRIME_REPORT_CHANCE = 0.75
g_CRIMINALS_PER_COP = 5 -- 1/6
g_MAX_COPS = 10
g_FIRST_EXIT_SPAWN_DELAY = 45000
g_MAX_COREGAME_LENGTH = 600000

g_POLICE_APPLICATION_DURATION = 5800
g_PERK_SELECTION_DURATION = 11800

g_PLAYER_APPLY_FOR_POLICE_EVENT = "onPlayerAskedForApplication"
g_PLAYER_ROLE_SELECTED_EVENT = "onPlayerRoleSelected" -- role

g_POLICE_ROLE = "PoliceRole"
g_CRIMINAL_ROLE = "CriminalRole"
g_POLICE_TEAM_NAME = "The Police"
g_PED_TEAM_NAME = "Innocent Bystanders"

g_SHOW_JOB_EVENT = "onShowJob" -- jobId, jobType, jobPos
g_HIDE_JOB_EVENT = "onHideJob" -- jobId
g_START_JOB_EVENT = "onStartJob" -- jobId, jobType
g_STOP_JOB_EVENT = "onStopJob" -- jobId, jobType
g_FINISH_JOB_EVENT = "onFinishJob" -- jobId (jobType) (reportedplayers) (client only)
g_JOB_STATUS_UPDATE_EVENT = "onJobStatusUpdate" -- jobId, jobType, data (depends on jobType)
g_JOB_ALREADY_IN_PROGRESS_EVENT = "onJobAlreadyInProgress"

g_PED_GAME_READY_EVENT = "onPedGameReady"
g_SPAWN_PLAYER_PED_EVENT = "onPlayerPedSpawned"
g_REQUEST_SPAWN_PED_EVENT = "onPedRequested"
g_PED_CONTROL_UPDATE_EVENT = "onPedControlUpdate"
g_PED_ANIMATION_EVENT = "onPedAnimation"
g_PED_MOVEMENT_EVENT = "onPedMovement"

g_MONEY_UPDATE_EVENT = "onMoneyUpdate"
g_GAME_STATE_UPDATE_EVENT = "onGameStateUpdate" -- state
g_ESCAPE_ROUTE_APPEARED = "onEscapeRouteAppeared"
g_PREGAME_STATE = "pregame"
g_COREGAME_STATE = "coregame"
g_ENDGAME_STATE = "endgame"
g_ENDENDGAME_STATE = "endendgame"
g_NO_CRIMS_STATE = "nocrimsgame"
