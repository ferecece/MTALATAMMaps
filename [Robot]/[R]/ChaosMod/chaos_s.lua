MAX_EFFECTS = 150

-- General 
raceStarted = false
chaosTimer = nil
updateTimer = nil
availableEffects = {}

-- Effect's specific variables
playersPos = {} -- Shuffle Players
trees = {} -- Custom Trees
fpsTimer = nil
meow = false
meowTimer = nil
randosTimer = nil
randosEnabled = false
removePlayersEnabled = false
removePlayersTimer = nil

function serverEffect(effect)
	-- Explode Random Player
	if effect == 115 then blowVehicle(getPedOccupiedVehicle(getRandomPlayer()))
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
		for i = 1, 5 do 
			local r = 0
			repeat 
				r = math.random(MAX_EFFECTS)
			until r ~= 126
			chaos(r)
		end
	-- Random Skin
	elseif effect == 128 then
		local r = math.random(0, 250)
		for i, players in ipairs(getElementsByType("player")) do
			setElementModel(players, r)
		end
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
		removePlayersTimer = setTimer(function() removePlayersEnabled = false end, 5000, 1)
		removePlayersEnabled = true
		for i, players in ipairs(getElementsByType("player")) do removePedFromVehicle(players) end
	end
end

-- No Tasks Allowed
addEventHandler("onPlayerVehicleEnter", getRootElement(), function()
	if removePlayersEnabled then
		for i, players in ipairs(getElementsByType("player")) do removePedFromVehicle(players) end
		cancelEvent()	
	end
end )

addEventHandler("onPlayerChat", getRootElement(), function(messageText, messageType)
	if not meow then return end
	setTimer(function() outputChatBox("Chaos Mod: #E7D9B0meow", root, 255, 255, 255, true) end, 200, 1)
end )

function chaos()
	-- Choose random number of available effects
	local r = math.random(#availableEffects) 
	
	-- Trigger this effect
	serverEffect(availableEffects[r])
	triggerClientEvent(getRootElement(), "triggerEffect", getRootElement(), availableEffects[r])
	
	-- Remove that effect from available effects
	table.remove(availableEffects, r)
end

function update()
	for _, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then
			if getElementData(players, "changecar") ~= nil and getElementData(players, "changecar") ~= false and getElementData(players, "changecar") ~= 0 then 
				if getElementModel(getPedOccupiedVehicle(players)) ~= tonumber(getElementData(players, "changecar")) then
					local x, y, z = getElementPosition(getPedOccupiedVehicle(players))
					setElementPosition(getPedOccupiedVehicle(players), x, y, z + 2)
					
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
end

-- Midrace Check
addEvent("isRaceStarted", true)
addEventHandler("isRaceStarted", getRootElement(), function()
	if not raceStarted then return end
	triggerClientEvent(source, "raceInit", getRootElement())
end )

addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", getRootElement(), function(newState, oldState)
	if oldState == "GridCountdown" and newState == "Running" then 
		raceStarted = true
		
		-- Start chaos timer
		if isTimer(chaosTimer) then killTimer(chaosTimer) end
		chaosTimer = setTimer(chaos, 10000, 0)
		
		triggerClientEvent(getRootElement(), "raceInit", getRootElement())
	end
end )

-- Activate Effect (debug)
function effect(player, commandName, num)
	--serverEffect(tonumber(num)) 
	--triggerClientEvent(getRootElement(), "triggerEffect", getRootElement(), tonumber(num))
end
addCommandHandler("trig", effect)

-- Everybody Love Randos
addEvent("onPlayerReachCheckpoint") 
addEventHandler("onPlayerReachCheckpoint", getRootElement(), function(checkpoint)
	if not randosEnabled then return end
	
	local x, y, z = getElementPosition(getPedOccupiedVehicle(source))
	local r = math.random(400, 609)
	
	setElementPosition(getPedOccupiedVehicle(source), x, y, z+1)
	setElementModel(getPedOccupiedVehicle(source), r)
end ) 

-- Initialize
addEvent("onMapStarting", true)
addEventHandler("onMapStarting", resourceRoot, function()
	if isTimer(updateTimer) then killTimer(updateTimer) end
	updateTimer = setTimer(update, 50, 0)
	
	setTime(math.random(24), math.random(59))
	setWeather(math.random(15))
	
	-- Initialize Available Effects
	for i = 1, MAX_EFFECTS do
		table.insert(availableEffects, i)
	end
end )

-- FPS fix
addEventHandler("onResourceStop", resourceRoot, function(resource)
    setFPSLimit(60)
end )