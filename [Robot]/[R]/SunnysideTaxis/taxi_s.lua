-- FUCK TUESDAY

poll_active = false -- State for poll at the race start
raceStarted = 0 -- Midrace fixes
pollEnded = 0 -- Midrace fixes
fares = 50 -- 25 or 50
city = 2
-- 1 Los Santos
-- 2 San Fierro
-- 3 Las Venturas
collectAllFaresMode = false
tram = {}
tramPos = {
	{-2006.4, 131.80, 29.0, 0, 0,    0},
    {-2006.4, 123.10, 29.0, 0, 0,    0},
    {-1567.0, 728.90, 8.50, 0, 0,  -90},
    {-1576.5, 728.90, 8.50, 0, 0,  -90},
    {-1991.1, 1308.0, 8.50, 0, 0,   90},
    {-1981.6, 1308.0, 8.50, 0, 0,   90},
    {-2342.5, 456.60, 34.2, 0, 0, -140},
    {-2348.1, 464.20, 34.2, 0, 0, -146}
};

-- Fares Amount 
faresAmount = {34, 27, 45}
-- Objects and collshapes
paynsprayDoors = {}
paynsprayColls = {}
paynsprayDoorState = {}
garageTimeout = {}

MAX_GARAGES = 11
-- Closed doors of garages (pX, pY, pZ, rX, rY, rZ) 
c_doorPos = {
	{1024.9844, -1029.3516, 33.19531, 0.0, -90.0, 0.0}, -- North Pay'N'Spray in LS
	{2071.4766, -1831.4219, 14.56250, 0.0, -90.0, 0.0}, -- laespraydoor1
	{488.28125, -1734.6953, 12.39063, 0.0,  90.0, 0.0}, -- spraydoor_LAw2
	{1041.4004, -1026.0000, 32.70001, 0.0, -90.0, 0.0},  -- transfenderLS
	{-1935.900,  239.39999, 35.35001, 0.0, -90.0, 0.0},  -- modshopdoor_SFSe
	{-1904.500,  277.79980, 43.10001, 0.0, -90.0, 0.0},  -- sprayshpdr2_SFSe
	{-2425.599,  1028.0996, 52.29999, 0.0, -90.0, 0.0},  -- spdr_sfw
	{-1786.799,  1209.4004, 25.80000, 0.0, -90.0, 0.0},  -- michdr
	{2386.7002,  1043.4004, 11.60000, 0.0, -90.0, 0.0},  -- cmdgrgdoor_lvs
	{2393.7998,  1483.4004, 12.70000, 0.0,  90.0, 0.0},  -- vgsEspdr01
	{1968.5000,  2162.5000, 12.10000, 0.0, -90.0, 0.0}   -- vgwspry1
};
-- Opened doors of garages (pX, pY, pZ, rX, rY, rZ) 
o_doorPos = {
	{1025.0000, -1028.5000, 34.90000, 0.0, 90.00, 0.0},
	{2070.5000, -1831.4000, 16.40000, 0.0, 90.00, 0.0},
	{488.29999, -1734.6953, 14.70000, 0.0, -90.0, 0.0},
	{1041.4000, -1025.2000, 34.10000, 0.0, 90.00, 0.0},
	{-1935.900,  239.80000, 37.20000, 0.0, 90.00, 0.0},
	{-1904.500,  279.79999, 45.70000, 0.0, 90.00, 0.0},
	{-2425.600,  1026.4000, 54.70000, 0.0, 90.00, 0.0},
	{-1786.800,  1210.3000, 27.30000, 0.0, 90.00, 0.0},
	{2386.7000,  1044.5000, 13.20000, 0.0, 90.00, 0.0},
	{2393.8000,  1485.4000, 15.20000, 0.0, -90.0, 0.0},
	{1969.6000,  2162.5000, 13.80000, 0.0, 90.00, 0.0}
};

addEvent("onMapStarting", true)
addEventHandler("onMapStarting", resourceRoot, function()
	-- Random time at the start of a race
	math.randomseed(getTickCount())
	local h = math.random(23)
	math.randomseed(getTickCount())
	local m = math.random(59)
	setTime(h, m)
	
	-- Random weather
	local weatherRand = 0
	repeat
		math.randomseed(getTickCount())
		weatherRand = math.random(18)
	until weatherRand ~= 16 and weatherRand ~= 8 -- Exclude rain from race start
	setWeather(weatherRand)
	
	-- Special World Property
	setWorldSpecialPropertyEnabled("extraairresistance", false)
	
	-- PNS doors objects
	paynsprayDoors[1]  = createObject(5856,  1024.98440, -1029.3516, 33.19531, 0.0, 0.0,   90.0)
	paynsprayDoors[2]  = createObject(5422,  2071.47660, -1831.4219, 14.56250, 0.0, 0.0,  180.0) -- laespraydoor1
	paynsprayDoors[3]  = createObject(6400,  488.281250, -1734.6953, 12.39063, 0.0, 0.0,   80.0) -- spraydoor_LAw2
	paynsprayDoors[4]  = createObject(5779,  1041.40040, -1026.0000, 32.70001, 0.0, 0.0,   90.0) -- transfenderLS
	paynsprayDoors[5]  = createObject(11313, -1935.9000,  239.39999, 35.35001, 0.0, 0.0,   90.0) -- modshopdoor_SFSe
	paynsprayDoors[6]  = createObject(11319, -1904.5000,  277.79980, 43.10001, 0.0, 0.0,   90.0) -- sprayshpdr2_SFSe
	paynsprayDoors[7]  = createObject(9625,  -2425.5996,  1028.0996, 52.29999, 0.0, 0.0,  -90.0) -- spdr_sfw
	paynsprayDoors[8]  = createObject(10182, -1786.7998,  1209.4004, 25.80000, 0.0, 0.0,   90.0) -- michdr
	paynsprayDoors[9]  = createObject(9093,   2386.7002,  1043.4004, 11.60000, 0.0, 0.0,   90.0) -- cmdgrgdoor_lvs
	paynsprayDoors[10] = createObject(8957,   2393.7998,  1483.4004, 12.70000, 0.0, 0.0,  -90.0) -- vgsEspdr01
	paynsprayDoors[11] = createObject(7891,   1968.5000,  2162.5000, 12.10000, 0.0, 0.0,   00.0) -- vgwspry1
	
	paynsprayColls[1]  = createColSphere(1024.9844, -1029.3516, 33.19531, 15.0)
	paynsprayColls[2]  = createColSphere(2071.4766, -1831.4219, 14.56250, 15.0) 
	paynsprayColls[3]  = createColSphere(488.28125, -1734.6953, 12.39063, 15.0) 
	paynsprayColls[4]  = createColSphere(1041.4004, -1026.0000, 32.70001, 15.0) 
	paynsprayColls[5]  = createColSphere(-1935.900,  239.39999, 35.35001, 15.0) 
	paynsprayColls[6]  = createColSphere(-1904.500,  277.79980, 43.10001, 15.0) 
	paynsprayColls[7]  = createColSphere(-2425.5996, 1028.0996, 52.29999, 15.0) 
	paynsprayColls[8]  = createColSphere(-1786.7998, 1209.4004, 25.80000, 15.0) 
	paynsprayColls[9]  = createColSphere(2386.7002,  1043.4004, 11.60000, 15.0) 
	paynsprayColls[10] = createColSphere(2393.7998,  1483.4004, 12.70000, 15.0) 
	paynsprayColls[11] = createColSphere(1968.5000,  2162.5000, 12.10000, 15.0) 
end)

addEvent("onRaceStateChanging", true)
addEventHandler("onRaceStateChanging", getRootElement(), function(newState, oldState)
	if     newState == "GridCountdown"    then setTimer(stuffTimer, 50, 0)
	elseif newState == "Running"          then raceStarted = 1
	elseif newState == "PreGridCountdown" then
		exports.scoreboard:scoreboardAddColumn("Fares", getRootElement(), 40)
		exports.scoreboard:scoreboardAddColumn("Money", getRootElement(), 50)
		exports.scoreboard:scoreboardAddColumn("Car", getRootElement(), 60)
		exports.scoreboard:scoreboardAddColumn("Destination", getRootElement(), 185)
		
		exports.votemanager:stopPoll {}
		poll = exports.votemanager:startPoll 
		{
			title = "Choose the number of fares:",
			percentage = 100,
			timeout = 15,
			allowchange = true,

			[1] = {"Quick taxi in Los Santos (25 fares, ~15 mins)", "pollFinished" , resourceRoot, 1},
			[2] = {"Quick taxi in San Fierro", "pollFinished" , resourceRoot, 3},
			[3] = {"Quick taxi in Las Venturas", "pollFinished" , resourceRoot, 5},			
			[4] = {"Full experience in Los Santos (50 fares, ~30 mins)", "pollFinished" , resourceRoot, 2},			
			[5] = {"Full experience in San Fierro", "pollFinished" , resourceRoot, 4},			
			[6] = {"Full experience in Las Venturas", "pollFinished" , resourceRoot, 6},		
			[7] = {"Collecting All Fares", "pollFinished" , resourceRoot, 7},		
			--[8] = {"Taxi in custom city", "pollFinished" , resourceRoot, 8},		
			[8] = {"Extreme taxi (1000 fares, ~10 hours)", "pollFinished" , resourceRoot, 8},		
		}
		
		math.randomseed(getTickCount())
		local randomMode = math.random(7)
		if not poll then applyPollResult(randomMode) end
	end
end )

addEventHandler("onResourceStop", resourceRoot, function() 
	exports.scoreboard:removeScoreboardColumn("Money")
	exports.scoreboard:removeScoreboardColumn("Fares")
	exports.scoreboard:removeScoreboardColumn("Car")
	exports.scoreboard:removeScoreboardColumn("Destination")
end )

addEvent("isRaceStarted", true)
addEventHandler("isRaceStarted", getRootElement(), function()
	if raceStarted == 0 then return end
	if pollEnded == 1 then 
		triggerClientEvent(source, "postVoteStuff", getRootElement(), fares, city)
		setElementModel(source, math.random(261, 262))
	end
end )

addEvent("pollFinished", true)
addEventHandler("pollFinished", resourceRoot, function(pollResult)
	local customMapName = getMapName()
	
	-- Default modes from 1 to 6
	
	-- Choose city
	if pollResult == 1 or pollResult == 2 then
		city = 1
	elseif pollResult == 3 or pollResult == 4 then
		city = 2
		setTimer(tramSpeed, 50, 0)
		customMapName = customMapName .. " in San Fierro"
	elseif pollResult == 5 or pollResult == 6 then
		city = 3
		customMapName = customMapName .. " in Las Venturas"
	end
	
	-- Choose amount of fares
	if pollResult == 1 or pollResult == 3 or pollResult == 5 then
		fares = 25
		customMapName = customMapName .. " (Quick Taxi)"
		setTimer(randWeather, 160000, 0) -- in about 2.5 minutes (160000)
	else
		fares = 50
		customMapName = customMapName .. " (Full Experience)"
		setTimer(randWeather, 240000, 0) -- in about 4 minutes
	end
	
	-- Custom Modes 
	if pollResult == 7 then -- All Fares%
		-- Select city and fares amount
		math.randomseed(math.floor(os.time()/getTickCount()*math.random(1, getTickCount())))
		city = math.random(3)
		fares = faresAmount[city]
		collectAllFaresMode = true
		
		-- Select map name
		if city == 1 then customMapName = customMapName.. " in Los Santos (All Fares)"
		elseif city == 2 then customMapName = customMapName.. " in San Fierro (All Fares)"
		elseif city == 3 then customMapName = customMapName.. " in Las Venturas (All Fares)" end
		
		-- Launch weather timer
		setTimer(randWeather, 240000, 0) 
	elseif pollResult == 8 then -- 1000 Fares
		-- Select city and fares amount
		city = 0
		fares = 1000
		
		-- Select map name
		customMapName = customMapName.. " in San Andreas (1000 Fares)"
		setTimer(randWeather, 960000, 0) 
	end
	
	setMapName(customMapName)
	pollEnded = 1
	
	-- The default top times manager does not respond to the above. So send it an event so it does
	-- It appears that the leguaan server has their own thing for this, idk what. Strip this out for them
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
end )

function tramSpeed()
	for i = 1, 8, 2 do
		if not isElement(tram[i]) then
			tram[i] = createVehicle(449, tramPos[i][1], tramPos[i][2], tramPos[i][3])
			tram[i+1] = createVehicle(449, tramPos[i+1][1], tramPos[i+1][2], tramPos[i+1][3])
		
			setTrainDerailable(tram[i], false)
			setTrainDerailable(tram[i+1], false)
		
			setTrainDirection(tram[i], true)
			attachTrailerToVehicle(tram[i], tram[i+1])
		end
		setTrainSpeed(tram[i], 0.4)
	end
end

function randWeather()
	local weatherRand = 0

	repeat
		math.randomseed(getTickCount())
		weatherRand = math.random(18)
	until weatherRand ~= 16 and weatherRand ~= getWeather()
	
	if weatherRand == 8 then outputChatBox("#00F6FFWeather Report: rain is expected soon", root, 0, 246, 255, true) end	
	setWeatherBlended(weatherRand)
end

function stuffTimer()
	-- vehicle colors
	for index, players in ipairs(getElementsByType("player")) do
		local x, y, z = getElementPosition(players)
		if z < 1000 or getElementData(players, "state") ~= "spectating" then
			local taxi = getPedOccupiedVehicle(players)
			if taxi then
				local model = getElementData(players, "Car") 
				if model == "Taxi" then -- cabbie, taxi
					if getElementModel(taxi) ~= 420 then setElementModel(taxi, 420) end	
					
					setVehicleColor(taxi, 215, 142, 16, 165, 138, 65) -- color #6
					setVehicleTaxiLightOn(taxi, true) 
				elseif model == "Cabbie" then
					setVehicleColor(taxi, 215, 142, 16, 165, 138, 65) -- color #6
					setVehicleTaxiLightOn(taxi, true) 
					
					local hasNitro = false
					if getVehicleUpgradeOnSlot(taxi, 8) == 1010 then hasNitro = true end
					
					if getElementModel(taxi) ~= 438 then 
						setElementModel(taxi, 438)
						
						if hasNitro then
							addVehicleUpgrade(taxi, 1010)
							hasNitro = false
						end
					end	
				elseif model == "Zebra Cab" then
					setVehicleColor(taxi, 255, 255, 255, 255, 255, 255) -- white
					
					local hasNitro = false
					if getVehicleUpgradeOnSlot(taxi, 8) == 1010 then hasNitro = true end
					
					setVehicleHandling(taxi, "mass", 1750.0)
					setVehicleHandling(taxi, "turnMass", 4351.7)
					setVehicleHandling(taxi, "dragCoeff", 2.9)
					setVehicleHandling(taxi, "centerOfMass", {0.0, 0.1, -0.15})
					setVehicleHandling(taxi, "percentSubmerged", 75)
					setVehicleHandling(taxi, "tractionMultiplier", 0.75)
					setVehicleHandling(taxi, "tractionLoss", 0.85)
					setVehicleHandling(taxi, "tractionBias", 0.51)
					setVehicleHandling(taxi, "numberOfGears", 4)
					setVehicleHandling(taxi, "maxVelocity", 180.0)
					setVehicleHandling(taxi, "engineAcceleration", 12.0 )
					setVehicleHandling(taxi, "engineInertia", 6.0)
					setVehicleHandling(taxi, "driveType", "rwd")
					setVehicleHandling(taxi, "engineType", "petrol")
					setVehicleHandling(taxi, "brakeDeceleration", 7.0)
					setVehicleHandling(taxi, "brakeBias", 0.44)
					setVehicleHandling(taxi, "steeringLock",  40.0)
					setVehicleHandling(taxi, "suspensionForceLevel", 0.7)
					setVehicleHandling(taxi, "suspensionDamping", 0.06)
					setVehicleHandling(taxi, "suspensionUpperLimit", 0.25)
					setVehicleHandling(taxi, "suspensionLowerLimit", -0.3)
					setVehicleHandling(taxi, "suspensionFrontRearBias", 0.5)
					setVehicleHandling(taxi, "suspensionAntiDiveMultiplier", 0.5)
					setVehicleHandling(taxi, "seatOffsetDistance", 0.2)
					setVehicleHandling(taxi, "collisionDamageMultiplier", 0.4)
					setVehicleHandling(taxi, "modelFlags", 0)
					setVehicleHandling(taxi, "handlingFlags", 0)
					
					if getElementModel(taxi) ~= 474 then 
						setElementModel(taxi, 474)
						
						if hasNitro then
							addVehicleUpgrade(taxi, 1010)
							hasNitro = false
						end
					end
				elseif model == "Sultan" then
					setVehicleColor(taxi, 255, 255, 255)
					if getElementModel(taxi) ~= 560 then 
						setElementModel(taxi, 560)
						
						addVehicleUpgrade(taxi, 1010) -- nitro
						addVehicleUpgrade(taxi, 1075)
						addVehicleUpgrade(taxi, 1158)
						addVehicleUpgrade(taxi, 1081) -- wheels
						addVehicleUpgrade(taxi, 1141)
						addVehicleUpgrade(taxi, 1169)
						addVehicleUpgrade(taxi, 1028)
						addVehicleUpgrade(taxi, 1032) -- roof
					end
				elseif model == "Crazy Taxi" then
					setVehicleColor(taxi, 215, 142, 16, 165, 138, 65) -- color #6
					
					setVehicleHandling(taxi, "engineInertia", 4.0)
					setVehicleHandling(taxi, "collisionDamageMultiplier", 0.4)
					setVehicleHandling(taxi, "turnMass", 3000.0)
					setVehicleHandling(taxi, "brakeBias", 0.52)
					setVehicleHandling(taxi, "centerOfMass", {0.0, 0.0, -0.3})
					setVehicleHandling(taxi, "tractionLoss", 1.2)
					setVehicleHandling(taxi, "tractionBias", 0.53)
					setVehicleHandling(taxi, "tractionMultiplier", 0.85)
					setVehicleHandling(taxi, "maxVelocity", 300.0)
					setVehicleHandling(taxi, "engineAcceleration", 20.0)
					setVehicleHandling(taxi, "mass", 2500.0)
					setVehicleHandling(taxi, "brakeDeceleration", 12.0)
						
					if getElementModel(taxi) ~= 567 then 
						setElementModel(taxi, 567)
						addVehicleUpgrade(taxi, 1010) -- nitro
					end
				end
			end
		end
	end
end

addEventHandler("onElementModelChange", root, function(oldModel, newModel)
	if getElementType(source) ~= "vehicle" then return end
	
	-- car model fixes
	local health = getElementHealth(source)
	fixVehicle(source)
	setElementHealth(source, health)
end )

addEvent("onPlayerPickUpRacePickup", true)
addEventHandler("onPlayerPickUpRacePickup", getRootElement(), function(pickupID, pickupType, vehicleModel)
	local taxi = getPedOccupiedVehicle(source)
	
	if pickupType == "repair" then
		setElementData(source, "Money", getElementData(source, "Money")-100)
	elseif pickupType == "nitro" then
		if getElementData(source, "Money") < 500 then 
			outputChatBox("You don't have enough money to buy that nitro! ($500)", source)
			removeVehicleUpgrade(taxi, 1010)
		else setElementData(source, "Money", getElementData(source, "Money")-500) end
	end
end )

addEventHandler("onColShapeHit", root, function(theElement, matchingDimension)
	if getElementType(theElement) ~= "player" then return end
	
	for c_index = 1, MAX_GARAGES do
		if source == paynsprayColls[c_index] then 
			if not paynsprayDoorState[c_index] then
				-- Kill timeout timer
				if isTimer(garageTimeout[c_index]) then killTimer(garageTimeout[c_index]) end
				
				-- Open the door
				moveObject(paynsprayDoors[c_index], 750.0, o_doorPos[c_index][1], o_doorPos[c_index][2], o_doorPos[c_index][3], o_doorPos[c_index][4], o_doorPos[c_index][5], o_doorPos[c_index][6]) 
				
				-- Play the sound
				triggerClientEvent(theElement, "playClientSFX", theElement, "genrl", 44, 2, false)
				triggerClientEvent(theElement, "playClientSFX", theElement, "genrl", 44, 0, true)
				
				-- Stop sounds and change state
				setTimer(function() 
					paynsprayDoorState[c_index] = true
					triggerClientEvent(theElement, "playClientSFX", theElement, "genrl", 44, 2, false)
					
					if isTimer(garageTimeout[c_index]) then killTimer(garageTimeout[c_index]) end
					garageTimeout[c_index] = setTimer(function() closeGarageByTimeout(c_index) end, 5000, 1)
				end, 750, 1)
				
				break
			end
		end
	end
end )

addEventHandler("onColShapeLeave", root, function(theElement, matchingDimension)
	if getElementType(theElement) ~= "player" then return end
	
	for c_index = 1, MAX_GARAGES do 
		if source == paynsprayColls[c_index] then 
			if paynsprayDoorState[c_index] then
				-- check if nobody near garage
				for _, players in ipairs(getElementsByType("player")) do
					if isElementWithinColShape(players, paynsprayColls[c_index]) then
						return
					end
				end
				
				-- Close the door
				moveObject(paynsprayDoors[c_index], 750.0, c_doorPos[c_index][1], c_doorPos[c_index][2], c_doorPos[c_index][3], c_doorPos[c_index][4], c_doorPos[c_index][5], c_doorPos[c_index][6]) 
				
				-- Play the sound
				triggerClientEvent(theElement, "playClientSFX", theElement, "genrl", 44, 2, false)
				triggerClientEvent(theElement, "playClientSFX", theElement, "genrl", 44, 0, true)
				
				-- Stop sounds and change state
				setTimer(function() 
					paynsprayDoorState[c_index] = false
					triggerClientEvent(theElement, "playClientSFX", theElement, "genrl", 44, 2, false)
					
					if isTimer(garageTimeout[c_index]) then killTimer(garageTimeout[c_index]) end
				end, 750, 1)
				
				break
			end
		end
	end
end )

function closeGarageByTimeout(c_index)
	-- Check for players near garage door
	for _, players in ipairs(getElementsByType("player")) do
		if isElementWithinColShape(players, paynsprayColls[c_index]) then
			return
		end
	end
	
	-- Close the garage door
	--local x, y, z = getElementPosition(paynsprayDoors[c_index])
	--local rx, ry, rz = getElementRotation(paynsprayDoors[c_index])
	
	--if x == c_doorPos[c_index][1] and y == paynsprayDoors[c_index][2] and z == paynsprayDoors[c_index][3] then
	--	if rx == 
	--end
	
	if paynsprayDoorState[c_index] then
		--getElement
		-- Close the door
		moveObject(paynsprayDoors[c_index], 750.0, c_doorPos[c_index][1], c_doorPos[c_index][2], c_doorPos[c_index][3], c_doorPos[c_index][4], c_doorPos[c_index][5], c_doorPos[c_index][6]) 
		-- Stop sounds and change state
		setTimer(function() paynsprayDoorState[c_index] = false end, 750, 1)
	end
end