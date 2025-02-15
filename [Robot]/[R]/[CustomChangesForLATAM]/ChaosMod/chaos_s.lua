DATABASE = dbConnect("sqlite", ":/dataCollector.db")

MAX_EFFECTS = 210
DEBUG = false

-- General 
raceStarted = false
chaosTimer = nil
updateTimer = nil
effectsPool = {}
effectPointer = 1

-- Chat Voting
local enableChatVoting = false
local votedOptions = {
	{0, 0}, -- effect, voted
	{0, 0},
	{0, 0}
}
local votedPlayers = 0
local chaosState = 0 --(0 - voting, 1 - waiting)

-- Effect's specific variables
playersPos = {} -- Shuffle Players
trees = {} -- Custom Trees
pizzas = {} -- Pizzas
fpsTimer = nil
meow = false
meowTimer = nil
randosTimer = nil
randosEnabled = false
removePlayersEnabled = false
removePlayersTimer = nil
randomObjects = {}
colorDirection = {}
colorHue = {}
stack = {}
stackEnabled = false
ghostTeam = false

-- Player's effect
playerEffects = {}
playerSentEffect = {}

function serverEffect(effect)
	if DEBUG then outputDebugString(effectPointer.. ". Triggered effect: " ..effect.. "; Total: " ..#effectsPool.. "; next: " ..tostring(effectsPool[effectPointer+1])) end
	
	-- Pizza Time
	if effect == 27 then
		for i = 1, #pizzas do if isElement(pizzas[i]) then destroyElement(pizzas[i]) end end
	elseif effect == 107 then 
		for i, players in ipairs(getElementsByType("player")) do
			local x, y, z = getElementPosition(getPedOccupiedVehicle(players))
			local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(players))

			local radians = math.rad(rz - 90)
			local newX = x - 10 * math.cos(radians)
			local newY = y - 10 * math.sin(radians)
			
			local pizza = {
				createObject(1582, newX+0.2, newY+1, z, 0, 0, rz),
				createObject(1582, newX, newY, z-0.2, 0, 0, rz), 
				createObject(1582, newX-0.1, newY, z+0.2, 0, 0, rz)
			}
			
			setObjectBreakable(pizza[1], false)
			setObjectBreakable(pizza[2], false)
			setObjectBreakable(pizza[3], false)
			
			table.insert(pizzas, pizza[1])
			table.insert(pizzas, pizza[2])
			table.insert(pizzas, pizza[3])
		end
	-- Explode Random Player
	elseif effect == 115 then blowVehicle(getPedOccupiedVehicle(getRandomPlayer()))
	-- Shuffle Players
	elseif effect == 116 then
		-- Store player positions
		for i, players in ipairs(getElementsByType("player")) do
			local data = {}
			data[1], data[2], data[3] = getElementPosition(getPedOccupiedVehicle(players))
			data[4], data[5], data[6] = getElementRotation(getPedOccupiedVehicle(players))
			data[7], data[8], data[9] = getElementVelocity(getPedOccupiedVehicle(players))
			table.insert(playersPos, data)
		end
		
		-- Randomize Positions
		for i, players in ipairs(getElementsByType("player")) do
			local r = math.random(#playersPos)
			local data = playersPos[r]
			
			setElementPosition(getPedOccupiedVehicle(players), data[1], data[2], data[3])
			setElementRotation(getPedOccupiedVehicle(players), data[4], data[5], data[6])
			setElementVelocity(getPedOccupiedVehicle(players), data[7], data[8], data[9])
			
			table.remove(playersPos, r)
		end
		
		-- Clear Table
		for i = 1, #playersPos do
			table.remove(playersPos)
		end
		
	-- Change first and last player
	elseif effect == 117 then
		if getPlayerCount() > 1 then
			-- Get maximum rank
			local maxRank = 0
			for i, players in ipairs(getElementsByType("player")) do
				if tonumber(getElementData(players, "race rank")) > maxRank then
					maxRank = tonumber(getElementData(players, "race rank"))
				end
			end
			
			-- Store First Place
			for i, players in ipairs(getElementsByType("player")) do
				if tonumber(getElementData(players, "race rank")) == 1 then
					local data = {}
					data[1], data[2], data[3] = getElementPosition(getPedOccupiedVehicle(players))
					data[4], data[5], data[6] = getElementRotation(getPedOccupiedVehicle(players))
					data[7], data[8], data[9] = getElementVelocity(getPedOccupiedVehicle(players))
					table.insert(playersPos, data)
					break
				end
			end
			
			-- Store Last Place
			for i, players in ipairs(getElementsByType("player")) do
				if tonumber(getElementData(players, "race rank")) == maxRank then 
					local data = {}
					data[1], data[2], data[3] = getElementPosition(getPedOccupiedVehicle(players))
					data[4], data[5], data[6] = getElementRotation(getPedOccupiedVehicle(players))
					data[7], data[8], data[9] = getElementVelocity(getPedOccupiedVehicle(players))
					table.insert(playersPos, data)
					break
				end
			end
			
			-- Shuffle
			-- First to last
			for i, players in ipairs(getElementsByType("player")) do
				if tonumber(getElementData(players, "race rank")) == 1 then
					local data = playersPos[2]
					setElementPosition(getPedOccupiedVehicle(players), data[1], data[2], data[3])
					setElementRotation(getPedOccupiedVehicle(players), data[4], data[5], data[6])
					setElementVelocity(getPedOccupiedVehicle(players), data[7], data[8], data[9])
					break
				end
			end
			
			-- Last to first
			for i, players in ipairs(getElementsByType("player")) do
				if tonumber(getElementData(players, "race rank")) == maxRank then
					local data = playersPos[1]
					setElementPosition(getPedOccupiedVehicle(players), data[1], data[2], data[3])
					setElementRotation(getPedOccupiedVehicle(players), data[4], data[5], data[6])
					setElementVelocity(getPedOccupiedVehicle(players), data[7], data[8], data[9])
					break
				end
			end
			
			-- Clear Table
			for i = 1, #playersPos do
				table.remove(playersPos)
			end
		end
	-- Spawn Tree
	elseif effect == 119 then
		for i, players in ipairs(getElementsByType("player")) do
			local x, y, z = getElementPosition(getPedOccupiedVehicle(players))
			local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(players))

			local radians = math.rad(rz - 90)
			local newX = x - 20 * math.cos(radians)
			local newY = y - 20 * math.sin(radians)
			
			table.insert(trees, createObject(693, newX, newY, z-3, 0, 0, rz))
		end
	-- Destroy All Custom Trees
	elseif effect == 120 then
		for i = 1, #trees do destroyElement(trees[1]) end
	-- Rapid Fire
	elseif effect == 126 then
		effectPointer = effectPointer + 1
		for i = 1, 5 do chaos() end
	-- Random Skin
	elseif effect == 128 then
		for i, players in ipairs(getElementsByType("player")) do setElementModel(players, math.random(0, 250)) end
	-- Smooth Criminal
	elseif effect == 129 then
		setFPSLimit(60)
		if isTimer(fpsTimer) then killTimer(fpsTimer) end
		fpsTimer = setTimer(function() setFPSLimit(60) end, 30000, 1)
	-- Meow Bot
	elseif effect == 135 then 
		if isTimer(meowTimer) then killTimer(meowTimer) end
		meowTimer = setTimer(function() meow = false end, 60000, 1)
		meow = true
		outputChatBox("Chaos Mod: #E7D9B0meow", root, 255, 255, 255, true)
	-- Randos
	elseif effect == 140 then
		if isTimer(randosTimer) then killTimer(randosTimer) end
		randosTimer = setTimer(function() randosEnabled = false end, 30000, 1)
		randosEnabled = true
	-- No Tasks Allowed
	elseif effect == 145 then
		if isTimer(removePlayersTimer) then killTimer(removePlayersTimer) end
		removePlayersTimer = setTimer(function() 
			removePlayersEnabled = false 
		end, 5000, 1)
		removePlayersEnabled = true
		for i, players in ipairs(getElementsByType("player")) do 
			removePedFromVehicle(players)
		end
	-- 60 FPS Physics
	elseif effect == 169 then
		setFPSLimit(60)
		if isTimer(fpsTimer) then killTimer(fpsTimer) end
		fpsTimer = setTimer(function() setFPSLimit(60) end, 60000, 1)
	-- Randomize Effects
	elseif effect == 179 then randomizeEffects()
	-- Uncapped
	elseif effect == 183 then
		setFPSLimit(32767)
		if isTimer(fpsTimer) then killTimer(fpsTimer) end
		fpsTimer = setTimer(function() setFPSLimit(60) end, 30000, 1)
	-- Player Effect
	elseif effect == 185 then 
		playerEffectsTimer = setTimer(function()
			local effectsToTrigger = {}
			for i = 1, #playerEffects do
				if playerEffects[i][2] ~= 185 and playerEffects[i][2] ~= 126 then -- Not this again and not RapidFire
					if #effectsToTrigger == 0 then table.insert(effectsToTrigger, playerEffects[i])
					else
						local found = false
						for j = 1, #effectsToTrigger do
							if effectsToTrigger[j][2] == playerEffects[i][2] then
								found = true
								break
							end
						end
						
						if not found then table.insert(effectsToTrigger, playerEffects[i]) end
					end
				end
			end
			
			for k = 1, #effectsToTrigger do
				serverEffect(effectsToTrigger[k][2])
				triggerClientEvent(getRootElement(), "triggerEffect", getRootElement(), effectsToTrigger[k][2], effectsToTrigger[k][1])
			end
			
			playerEffects = {}
			playerSentEffect = {}
		end, 20000, 1)
	-- Switch Seats
	elseif effect == 188 then
		for _, players in ipairs(getElementsByType("player")) do
			warpPedIntoVehicle(players, getPedOccupiedVehicle(players), 1)
		end
	-- Oh, A Passenger!
	elseif effect == 189 then
		warpPedIntoVehicle(getRandomPlayer(), getPedOccupiedVehicle(getRandomPlayer()), 1)
	-- Attach Random Object
	elseif effect == 190 then
		for _, players in ipairs(getElementsByType("player")) do
			randomObjects[players] = createObject(math.random(500, 2500), 0, 0, 0)
			attachElements(randomObjects[players], getPedOccupiedVehicle(players), 0, 0, 1)
		end
		
		if isTimer(randomObjectsTimer) then killTimer(randomObjectsTimer) end
		randomObjectsTimer = setTimer(function()
			for _, players in ipairs(getElementsByType("player")) do
				if isElement(randomObjects[players]) then destroyElement(randomObjects[players]) end
			end
		end, 15000, 1)
	-- Random Colors
	elseif effect == 196 then
		for _, players in ipairs(getElementsByType("player")) do 
			setRandomColor(players)
		end
	-- Pride Cars
	elseif effect == 197 then
		for _, players in ipairs(getElementsByType("player")) do
			colorHue[players] = math.random(0, 360)
			colorDirection[players] = true
		end 
		
		colorsTimer = setTimer(function()
			for _, players in ipairs(getElementsByType("player")) do
				if getPedOccupiedVehicle(players) then
					local colors = {}
					colors[1], colors[2], colors[3], colors[4], colors[5], colors[6], colors[7], colors[8], colors[9], colors[10], colors[11], colors[12] = getVehicleColor(getPedOccupiedVehicle(players), true)
					
					if colorDirection[players] then
						colorHue[players] = colorHue[players] + 3.5
						if colorHue[players] > 360 then
							colorDirection[players] = false
							colorHue[players] = 360
						end
					else
						colorHue[players] = colorHue[players] - 3.5
						if colorHue[players] < 0 then
							colorDirection[players] = true
							colorHue[players] = 0
						end
					end
					
					colors[1], colors[2], colors[3] = hue2RGB(colorHue[players])
					
					setVehicleColor(getPedOccupiedVehicle(players), colors[1], colors[2], colors[3], colors[1], colors[2], colors[3], colors[1], colors[2], colors[3], colors[1], colors[2], colors[3])
				end
			end
		end, 1, 0)
		setTimer(function() killTimer(colorsTimer) end, 30000, 1)
	-- Stack
	elseif effect == 201 then
		local randomPlayingPlayer
		repeat
			randomPlayingPlayer = getRandomPlayer()
			local x, y, z = getElementPosition(randomPlayingPlayer)
		until getElementData(randomPlayingPlayer, "state") == "alive" and z < 20000
		
		-- Init stack
		stack = {randomPlayingPlayer}
		for _, players in ipairs(getElementsByType("player")) do
			local x, y, z = getElementPosition(players)
			
			if players ~= randomPlayingPlayer and getElementData(players, "state") == "alive" and z < 20000 then
				table.insert(stack, players)
			end
		end
			
		stackEnabled = true
		
		setTimer(function()
			stackEnabled = false
			for _, attach in ipairs(getAttachedElements(getPedOccupiedVehicle(stack[1]))) do
				if getElementType(attach) == "vehicle" then detachElements(attach) end
			end
			stack = {}
		end, 20000, 1)
	end
end

function hue2RGB(h)
	h = h / 360
	local r, g, b

	local i = math.floor(h * 6);
	local f = h * 6 - i;
	local q = 1 - f;

	i = i % 6

	if i == 0 then r, g, b = 1, f, 0
	elseif i == 1 then r, g, b = q, 1, 0
	elseif i == 2 then r, g, b = 0, 1, f
	elseif i == 3 then r, g, b = 0, q, 1
	elseif i == 4 then r, g, b = f, 0, 1
	elseif i == 5 then r, g, b = 1, 0, q
	end

	return r * 255, g * 255, b * 255
end

function setRandomColor(players)
	local colors = {}
	for i = 1, 4 do
		local components = {255, 0, math.random(0, 255)}
		local saturation = math.random(99, 100) / 100
		local value = math.random(99, 100) / 100

		local indices = {1, 2, 3}
		local shuffledIndices = {}
		for i = #indices, 1, -1 do
			random = math.random(1,i)
			shuffledIndices[i] = indices[random]
			table.remove(indices, random)
		end

		for j, w in pairs(shuffledIndices) do
			local c = components[w]		
			c = c + ((255 - c) * (1 - saturation)) 
			c = c * value			
			c = c - (c % 1)			
			colors[j + (i - 1) * 3] = c
		end
	end

	setVehicleColor(getPedOccupiedVehicle(players), colors[1], colors[2], colors[3], colors[4], colors[5], colors[6], colors[7], colors[8], colors[9], colors[10], colors[11], colors[12])
end

addEvent("getPlayerEffect", true)
addEventHandler("getPlayerEffect", getRootElement(), function(effect)
	if playerSentEffect[source] == nil then
		table.insert(playerEffects, {getPlayerName(source):gsub("#%x%x%x%x%x%x", ""), effect})
		playerSentEffect[source] = true
	end
end )

-- No Tasks Allowed
addEventHandler("onPlayerVehicleEnter", getRootElement(), function()
	if removePlayersEnabled then
		cancelEvent()
		removePedFromVehicle(source)
	end
end )

addEventHandler("onPlayerVehicleExit", getRootElement(), function()
	if removePlayersEnabled then cancelEvent() end
end )

addEventHandler("onPlayerChat", getRootElement(), function(messageText, messageType)
	if isTimer(playerEffectsTimer) and playerSentEffect[source] == nil then 
		triggerClientEvent(source, "checkEffect", source, messageText) 
	end
	
	if not meow then return end
	setTimer(function() outputChatBox("Chaos Mod: #E7D9B0meow", root, 255, 255, 255, true) end, 200, 1)
end )

function chaos()
	-- Trigger this effect
	if effectPointer > MAX_EFFECTS then randomizeEffects() end
	
	serverEffect(effectsPool[effectPointer])
	triggerClientEvent(getRootElement(), "triggerEffect", getRootElement(), effectsPool[effectPointer], nil)
	
	effectPointer = effectPointer + 1
end

function update()
	for _, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then
			if getElementData(players, "changecar") ~= nil and getElementData(players, "changecar") ~= false and getElementData(players, "changecar") ~= 0 then 
				if getElementModel(getPedOccupiedVehicle(players)) ~= tonumber(getElementData(players, "changecar")) then
					setElementModel(getPedOccupiedVehicle(players), tonumber(getElementData(players, "changecar")))
					setElementData(players, "changecar", 0)
				end
			end
			
			if getElementData(players, "giveweapon") ~= nil and getElementData(players, "giveweapon") ~= false and getElementData(players, "giveweapon") ~= 0 then 
				giveWeapon(players, 28, 10000, true)
				setPedWeaponSlot(players, 4)
				setPedDoingGangDriveby(players, true)
				setElementData(players, "giveweapon", 0)
			end
			
			if getElementData(players, "changeskin") ~= nil and getElementData(players, "changeskin") ~= false and getElementData(players, "changeskin") ~= 0 then 
				setElementModel(players, tonumber(getElementData(players, "changeskin")))
				setElementData(players, "changeskin", 0)
			end
		end
	end
	
	-- Stack 
	if stackEnabled then
		-- Check if "head" is connected
		if not isElement(stack[1]) or not getPedOccupiedVehicle(stack[1]) then
			stack = {}
			stack[1] = randomPlayingPlayer
			
			for _, players in ipairs(getElementsByType("player")) do
				local x, y, z = getElementPosition(players)
				
				if players ~= randomPlayingPlayer and getElementData(players, "state") == "alive" and z < 20000 and getPedOccupiedVehicle(players) then
					table.insert(stack, players)
				end
			end
		end
		
		for i = 2, 1 + #stack do
			if isElement(stack[i]) and getPedOccupiedVehicle(stack[i]) then
				attachElements(getPedOccupiedVehicle(stack[i]), getPedOccupiedVehicle(stack[1]), 0, 0, 2*i - 2)
			end
		end
	end
end

-- Midrace Check
addEvent("isRaceStarted", true)
addEventHandler("isRaceStarted", getRootElement(), function()
	if not raceStarted then return end
	triggerClientEvent(source, "raceInit", getRootElement())
	
	if getPedOccupiedVehicle(source) then
		-- Force Hustler at the start
		setElementModel(getPedOccupiedVehicle(source), 545)
	end
end )

addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", getRootElement(), function(newState, oldState)
	if oldState == "GridCountdown" and newState == "Running" then 
		raceStarted = true
		
		-- Start chaos timer
		if enableChatVoting then
			startVoting()
		else
			if isTimer(chaosTimer) then killTimer(chaosTimer) end
			chaosTimer = setTimer(chaos, 10000, 0)
		end
		
		triggerClientEvent(getRootElement(), "raceInit", getRootElement())
	end
end )

function finishChaosVote()
	votedPlayers = 0
	if isTimer(chaosTimer) then killTimer(chaosTimer) end
	
	local winVote
	local maxVoters = -1
	if votedOptions[1][2] == votedOptions[2][2] and votedOptions[1][2] == votedOptions[3][2] then
		-- 1 = 2 = 3
		winVote = math.random(3)
	elseif votedOptions[1][2] == votedOptions[2][2] and votedOptions[1][2] > votedOptions[3][2] then
		-- 1 = 2 > 3
		winVote = math.random(2)
	elseif votedOptions[1][2] == votedOptions[3][2] and votedOptions[1][2] > votedOptions[2][2] then
		-- 1 = 3 > 2
		local rng = math.random(2, 3)
		if rng == 2 then winVote = 1
		else winVote = 3 end
	else
		for i = 1, 3 do
			if votedOptions[i][2] > maxVoters then 
				maxVoters = votedOptions[i][2]
				winVote = i
			end
		end
	end
	
	for i = 1, #effectsPool do
		if effectsPool[i] == votedOptions[winVote][1] then
			table.remove(effectsPool, effectsPool[i])
		end
	end
	
	serverEffect(votedOptions[winVote][1])
	triggerClientEvent(getRootElement(), "triggerEffect", getRootElement(), votedOptions[winVote][1], nil)
	
	for i = 1, 3 do votedOptions[i][2] = 0 end
	
	chaosState = 1
	triggerClientEvent(getRootElement(), "stopVoting", getRootElement(), chaosState)
	
	if isTimer(chaosTimer) then killTimer(chaosTimer) end
	chaosTimer = setTimer(startVoting, 10000, 1)
end

addEvent("chaosVoted", true)
addEventHandler("chaosVoted", getRootElement(), function(option)
	votedOptions[option][2] = votedOptions[option][2] + 1
	votedPlayers = votedPlayers + 1
	setElementData(resourceRoot, "voted" ..option, getElementData(resourceRoot, "voted" ..option) + 1)
	
	-- Finish chaos voting if everybody has voted
	if votedPlayers == getPlayerCount() then finishChaosVote() end
end )

-- Activate Effect (debug)
function effect(player, commandName, num)
	--serverEffect(tonumber(num)) 
	--triggerClientEvent(getRootElement(), "triggerEffect", getRootElement(), tonumber(num), getPlayerName(player):gsub("#%x%x%x%x%x%x", ""))
end
addCommandHandler("trig", effect)

-- Everybody Love Randos
addEvent("onPlayerReachCheckpoint") 
addEventHandler("onPlayerReachCheckpoint", getRootElement(), function(checkpoint)
	if not randosEnabled then return end
	setElementModel(getPedOccupiedVehicle(source), math.random(400, 609))
end ) 

function randomizeEffects()
	-- Initialize Available Effects
	effectsPool = {}
	local availableEffects = {}
	for i = 1, MAX_EFFECTS do
		table.insert(availableEffects, i)
	end
	
	-- Randomize order
	for i = 1, #availableEffects do
		local rng = math.random(#availableEffects)
		table.insert(effectsPool, availableEffects[rng])
		table.remove(availableEffects, rng)
	end
	
	-- Special
	for i = 1, #effectsPool do
		if effectsPool[i] == 136 and i < 25 then
			local rng = math.random(-5, 5)
			
			if DEBUG then outputChatBox("moved from " ..i.. " to " ..(25 + rng)) end
			
			table.remove(effectsPool, i)
			table.insert(effectsPool, 25 + math.random(-5, 5), 136)
			break
		end
	end
	
	effectPointer = 1
end

function startVoting()
	if chaosState == 0 then 
		setElementData(resourceRoot, "voted1", 0)
		setElementData(resourceRoot, "voted2", 0)
		setElementData(resourceRoot, "voted3", 0)
		
		-- Select effects
		local pool = effectsPool
		for i = 1, 3 do
			local rng = math.random(#pool)
			votedOptions[i][1] = pool[rng]
			setElementData(resourceRoot, "effect" ..i, pool[rng])
			table.remove(pool, rng)
		end
		
		-- send data
		triggerClientEvent(getRootElement(), "startVoting", getRootElement())
		
		chaosState = 1
		
		if isTimer(chaosTimer) then killTimer(chaosTimer) end
		chaosTimer = setTimer(finishChaosVote, 10000, 1)
	else
		chaosState = 0
		triggerClientEvent(getRootElement(), "triggerEffect", getRootElement(), 0, nil)
		startVoting()
	end
end 

-- Initialize
addEvent("onMapStarting", true)
addEventHandler("onMapStarting", resourceRoot, function()
	if isTimer(updateTimer) then killTimer(updateTimer) end
	updateTimer = setTimer(update, 50, 0)
	
	-- Table management
	dbExec(DATABASE, "CREATE TABLE IF NOT EXISTS ChaosPercentWinners(playername TEXT, score INTEGER, timestamp INTEGER)")
	
	setTime(math.random(24), math.random(59))
	setWeather(math.random(15))
	
	randomizeEffects()
	
	if getPlayerCount() > 1 and math.random(0, 1) == 1 then
		outputChatBox("Chat voting enabled!")
		-- Chat Voting
		enableChatVoting = true
		
		setElementData(resourceRoot, "voted1", 0)
		setElementData(resourceRoot, "voted2", 0)
		setElementData(resourceRoot, "voted3", 0)
		
		local customMapName = getMapName().. " (voting)"
		setMapName(customMapName)
		
		local timesManager = getResourceRootElement(getResourceFromName("race_toptimes"))
		if not (timesManager) then
			timesManager = getResourceRootElement(getResourceFromName("race_toptimes2"))
		end

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

-- FPS fix
addEventHandler("onResourceStop", resourceRoot, function(resource)
    setFPSLimit(60)
	
	for _, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then setElementModel(getPedOccupiedVehicle(players), 545) end
	end
end )