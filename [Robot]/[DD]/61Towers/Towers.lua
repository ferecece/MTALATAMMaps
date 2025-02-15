Towers = {}
Towers.boundaries = {}
Towers.marker = nil
Towers.markerBlip = nil
Towers.showBlip = true
Towers.leftZoneTimers = {}
Towers.levelBoundary = nil

-- All vehicles (includinga aircraft and dangerous vehicles) that are usable for this
Towers.vehicleIds = { 602, 545, 496, 517, 401, 410, 518, 600, 527, 436, 589, 580, 419, 439, 533, 549, 526, 491, 474, 445, 467, 604, 426, 507, 547, 585,
405, 587, 409, 466, 550, 492, 566, 546, 540, 551, 421, 516, 529, 488, 511, 497, 563, 512, 476, 593, 447, 425, 519, 520, 
417, 469, 487, 513, 581, 510, 509, 522, 481, 461, 462, 448, 521, 468, 463, 586, 485, 552, 431, 
438, 437, 574, 420, 525, 408, 416, 596, 433, 597, 427, 599, 490, 432, 528, 601, 407, 428, 544, 523, 470, 598, 499, 588, 609, 403, 498, 514, 524, 
423, 532, 414, 578, 443, 486, 515, 406, 531, 573, 456, 455, 459, 543, 422, 583, 482, 478, 605, 554, 530, 418, 572, 582, 413, 440, 536, 575, 534, 
567, 535, 576, 412, 402, 542, 603, 475, 441, 464, 501, 465, 564, 568, 557, 424, 471, 504, 495, 457, 539, 483, 508, 571, 500, 
444, 556, 429, 411, 541, 559, 415, 561, 480, 560, 562, 506, 565, 451, 434, 558, 494, 555, 502, 477, 503, 579, 400, 404, 489, 505, 479, 442, 458 
}

-- All Aircraft that are usable for this
Towers.aircraft = { 488, 511, 497, 563, 512, 476, 593, 447, 425, 519, 520, 417, 469, 487, 513 }

-- Dangerous vehicles include all that have weapons
Towers.dangerousVehicles = { 520, 447, 432, 464, 425, 476 }

-- ##########################################################
-- ### Functions that can be called by user of this class ###

--[[
-- Creates a new instance
-- ]]
function Towers:new()
	local object = {}
	setmetatable(object,self)
	self.__index = self
	return object
end

--[[
-- Sets the chance of getting an aircraft, if someone else is already
-- in a dangerous vehicle.
--
-- @param float chance 1 means 100% chance, 0.1 means 10% chance
-- ]]
function Towers:setIncreasedAircraftChance(chance)
	self.increasedAircraftChance = chance
end

--[[
-- Adds a boundary for marker spawning to the table
-- ]]
function Towers:addBoundary(x1,x2,y1,y2,height)
	self.boundaries[#boundaries + 1] = {{x1,x2},{y1,y2},height}
end

--[[
-- Directly set a table of boundaries, which must be in the following format:
-- newBoundaries = {
--	{
--		{x1,x2},
--		{y1,y2},
--		z
--	},
--	{
--		..
--	},
--	..
-- }
--]]
function Towers:setBoundaries(newBoundaries)
	self.boundaries = newBoundaries
end

--[[
-- This sets the level boundary, which is not for spawning
-- markers, but for containing the players in an area.
-- If players move out of this area, their vehicle will eventually
-- be destroyed.
-- ]]
function Towers:setLevelBoundary(x,y,radius)
	self.levelBoundary = createColCircle(x,y,radius)
end

--[[
-- Sets whether the current marker should appear as a blip
-- on the player's map
--
-- @param boolean newSetting
-- ]]
function Towers:setShowBlip(newSetting)
	self.showBlip = newSetting
end

--[[
-- Must be called to actually start the Towers script, register Event Handlers,
-- place the first marker, etc.
-- ]]
function Towers:start()
	self.leftZoneWarning = textCreateDisplay()
	textDisplayAddText(self.leftZoneWarning,textCreateTextItem("Get back to the battle zone or die!", 0.5, 0.3,"medium",255,0,0,255,2,"center"))

	addEventHandler("onMarkerHit",getRootElement(),function(element) self:markerHit(source,element) end)
	addEventHandler("onColShapeHit",getRootElement(),function(element) self:colShapeAction(true,source,element) end)
	addEventHandler("onColShapeLeave",getRootElement(),function(element) self:colShapeAction(false,source,element) end)
	addEventHandler("onPlayerWasted",getRootElement(),function() self:playerDied(source) end)
	addEventHandler("onPlayerQuit",getRootElement(),function() self:playerQuit(source) end)

	self:addMarker(true)
	self.startTime = getTickCount()

	
end

-- ##########################
-- ### Internal functions ###

-- ### Random vehicle selection ###

--[[
-- Returns a random vehicle id
-- ]]
function Towers:getRandomVehicleId()
	if self.increasedAircraftChance ~= nil and self:isSomeoneInADangerousVehicle() then
		local upper = 1/self.increasedAircraftChance
		if upper >= 1 and math.random(1,upper) == 1 then
			local randomKey = math.random(1,#self.aircraft)
			return self.aircraft[randomKey]
		end
	end
	local randomKey = math.random(1,#self.vehicleIds)
	return self.vehicleIds[randomKey]
end

--[[
-- Loops through all alive players and checks if they are
-- in a dangerous vehicle
-- ]]
function Towers:isSomeoneInADangerousVehicle()
	for _,player in pairs(getAlivePlayers()) do
		local vehicle = getPedOccupiedVehicle(player)
		if vehicle and self:isDangerousVehicle(getElementModel(vehicle)) then
			return true
		end
	end
	return false
end

--[[
-- Checks whether the given vehicleId is ín the table
-- of dangerous vehicles.
-- ]]
function Towers:isDangerousVehicle(vehicleId)
	for _,id in pairs(self.dangerousVehicles) do
		if vehicleId == id then
			return true
		end
	end
	return false
end



--[[
-- Gets a random number in the interval of the numbers
-- in the given table: {a,b}
-- ]]
function Towers:getRandomInBetween(data)
	local a = data[1]
	local b = data[2]
	if a > b then
		return math.random(b,a)
	else
		return math.random(a,b)
	end
end

--[[
-- Adds a marker to the map, at a random position, except for the first
-- marker, which is always somewhere in the first area (first in the table).
-- This can be used to prevent the marker from appearing over a player
-- spawn.
-- ]]
function Towers:addMarker(firstMarker)
	local partKey = math.random(1,#self.boundaries)
	if firstMarker then
		partKey = 1
	end

	local partBoundaries = self.boundaries[partKey]


	local x = self:getRandomInBetween(partBoundaries[1])
	local y = self:getRandomInBetween(partBoundaries[2])
	local z = partBoundaries[3]
	
	self.marker = createMarker(x,y,z,"checkpoint",3)
	if self.showBlip then
		self.markerBlip = createBlip(x,y,z,0,2,0,0,255)
	end
end

--[[
-- Handler function for when a marker is hit, changes the vehicle model, fixes
-- the vehicle and adds a new marker after destroying the current one.
-- ]]
function Towers:markerHit(marker,vehicle)
	if marker == self.marker and getElementType(vehicle) == "vehicle" then
		setElementModel(vehicle,self:getRandomVehicleId())
		fixVehicle(vehicle)
		destroyElement(marker)
		if self.markerBlip ~= nil then
			destroyElement(self.markerBlip)
		end

		self:addMarker()
	end
end


-- ### Level Boundary ###
-- These functions manage the level boundary, which prevents the player
-- from going outside a certain area for too long.

--[[
-- This is the event handler when a colshape is hit or left.
-- ]]
function Towers:colShapeAction(hit, colShape, vehicle)
	if colShape == self.levelBoundary and getElementType(vehicle) == "vehicle" then
		player = getVehicleOccupant(vehicle)
		if not player then
			return
		end
		if hit then
			self:enteredZone(player)
		else
			self:leftZone(player)
		end
	end
end

--[[
-- Shows the warning text to the player and starts the timer, which
-- will slowly decrease the vehicle's health.
-- ]]
function Towers:leftZone(player)
	textDisplayAddObserver(self.leftZoneWarning,player)
	self:killLeftZoneTimer(player)
	self.leftZoneTimers[player] = setTimer(self.leftZoneAction, 100, 0, self, player)
end

--[[
-- Removes the warning text and stops the timer.
-- ]]
function Towers:enteredZone(player)
	textDisplayRemoveObserver(self.leftZoneWarning, player)
	self:killLeftZoneTimer(player)
end

--[[
-- Stops the timer for the given player, used when it is no longer needed.
-- ]]
function Towers:killLeftZoneTimer(player)
	if isTimer(self.leftZoneTimers[player]) then
		killTimer(self.leftZoneTimers[player])
	end
end

--[[
-- This is called by the timer and decreases the vehicle's health.
-- ]]
function Towers:leftZoneAction(player)
	local vehicle = getPedOccupiedVehicle(player)
	if not vehicle then
		return
	end
	if isElementWithinColShape(vehicle,self.levelBoundary) then
		self:enteredZone(player)
		return
	end
	local currentHealth = getElementHealth(vehicle)
	setElementHealth(vehicle,currentHealth - currentHealth*0.001 - 1)
end

function Towers:playerDied(player)
	self:enteredZone(player)
end

function Towers:playerQuit(player)
	self:killLeftZoneTimer(player)
end
