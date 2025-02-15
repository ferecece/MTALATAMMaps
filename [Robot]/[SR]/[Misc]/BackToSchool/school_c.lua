-- Driving School Race by Discoordination Journey
-- All 12 tests from SP game, custom leaderboards, custom ghostmode
-- Final release: 07.08.2024
-- Version: 1.0

debug = false
MAX_LEVEL = 12

-- Dimensions
DEFAULT_DIMENSION = 0
HIDE_DIMENSION = 500
FADE_DIMENSION = 509

-- Default variables
level = 1
levelMedal = 0
levelUnlocked = 1
levelObj = 0
playersTimer = 0
playerState = "not ready"
pitDim = 0

-- Timers
startLevelTimer = nil
oneSecondTimer = nil
wastedTimer = nil
displayHelpTextTimer = nil
alleyOopTimer = nil
antiBtimer = nil
spawnTimer = nil
fadeTimer = nil
hideCarTimer = nil
miscTimer = nil

-- States 
levelLoaded = false
carStartedToMove = false
timerPaused = true
displayHelpText = false
newRecord = false
schoolFinished = false
fadeIsHappening = false

-- Camera
cameraAngle = 0
oldCamera = {}

-- Stats 
totalConesBroken = 0
citySlickingTime = 0
burnAndLapTime = 0
testAttempts = 0
displayStats = false
statsInited = false
statsAlpha = 0
statsPage = 0 -- 0 is player, 1 is burn and lap, 2 is city slicking, 3 is all golds
displayedStats = {}
displayedGolds = {}
displayedCity = {}
displayedBurn = {}

-- init tables
for i = 1, 11 do
	displayedGolds[i] = {}
	displayedGolds[i]["playername"] = ""
	displayedGolds[i]["time"] = 0
	
	displayedCity[i] = {}
	displayedCity[i]["playername"] = ""
	displayedCity[i]["time"] = 0
	
	displayedBurn[i] = {}
	displayedBurn[i]["playername"] = ""
	displayedBurn[i]["time"] = 0
end
-- Level materials
triggerCol = nil
triggerCol2 = nil
limitCol = nil 
finishMarker = nil
levelObject = nil
levelObject2 = nil
levelVehicle = {nil, nil}
blip = nil
theme = nil
policeCar = nil
policePed = nil

-- Level Results
results = {0.0, 0.0, 0.0, 0.0}
levelRecords = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
levelMedals  = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

-- Level settings
trafficCones = {}
maxCones = { 15,  23,  46,  37,  42,  30,   0,     0,  31,     0,   0,   0}
levelCar = {411, 496, 429, 597, 429, 429, 429,   429, 420,   597, 429, 506}
timer =    { 10,  10,   5,   5,   0,  10,   5,   nil,   5,   nil,   5,   0}

levelPerfectHeading = {180.0, 0.0, 270.0, 180.0, nil, 0.0, 270.0, 180.0, 180.0, 0.0, 180.0, nil}

levelPerfectPosition = {
	{-2050.6, -130.0},
	{-2049.0, -154.8},
	{-2028.9, -191.8},
	{-2050.8, -234.3},
	{-2050.2, -135.4}, 
	{-2050.6, -130.0},
	{-2050.4, -205.0},
	{-2050.3, -225.0},
	{-2044.1, -169.8},
	{0.0, 0.0},
	{-2050.2, -245.6},
	{0.0, 0.0}
};

levelNames = {
	"The 360",
	"The 180",
	"Whip and terminate",
	"Pop and Control",
	"Burn and Lap",
	"Cone coil",
	"The '90'",
	"Wheelie Weave",
	"Spin and Go",
	"P. I. T. Maneuver",
	"Alley Oop",
	"City Slicking"
};

levelTexts = {
    "Use the rear wheel drive car to do a burnout donut.",
    "To do a 180, accelerate to top speed, press SPACE to handbrake\n around the cone and then return.",
    "Powerslide around a tight corner and stop in the allocated area.",
    "Drive to the end of the track, a tire will blow out half way there.\n For extra control, release the accelerator.",
    "Do 5 laps in as quick a time as possible.\n Target time is under 40 seconds.",
    "Weave through the cones quickly and then\n return to the start position.",
    "To do a 90, slide the car sideways into the parking space\n within five seconds.",
    "Keep the car on two wheels until the end of the track.",
    "Use the front wheel drive car to reverse then quickly spin around 180 degrees.\n Press Q and E together to look behind.",
	"Perform a P.I.T. Maneuver to spin the other car\n around with minimum damage.\n Finish as close to the other car as possible.",
    "Do a barrel roll in mid air and land it perfectly.\n While in the air, release the accelerate button\n and use UP and DOWN to adjust the car's pitch.",
    "Drive to the other side of the city and back\n without damaging the car.\n The target time is UNDER 110 seconds."
};

levelTexts2 = {
    "Press and hold W and S to begin.",
    "Press S to begin.",
    "Press and hold W to begin."
};

boxTexts = {
	"SPACE",
	"SHIFT",
	"Press ALT for stats menu"
};

levelPosition = {
	{-2050.6, -130.0, 35.036, 180.0}, -- The 360
	{-2049.0, -154.8, 35.000, 180.0}, -- The 180
	{-2069.0, -154.8, 35.000, 180.0}, -- Whip and terminate  
	{-2050.6, -130.0, 35.000, 180.0}, -- Pop and Control 
	{-2050.6, -130.0, 35.000, 180.0}, -- Burn and lap
	{-2050.6, -130.0, 35.000, 180.0}, -- Cone coil
	{-2050.6, -130.0, 35.000, 180.0}, -- The '90'
	{-2050.6, -130.0, 35.000, 180.0}, -- Wheelie Weave
	{-2050.6, -130.0, 35.000, 0.000}, -- Spin and Go
	{-2050.6, -130.0, 35.000, 180.0}, -- P. I. T. Maneuver
	{-2050.6, -110.0, 35.000, 180.0}, -- Alley Oop
	{-2046.7, -90.20, 34.850, 0.000}  -- City Slicking
};

levelCols = {
	{0.0, 0.0, 10.0},
	{-2048.9, -246.0, 8.0},
	{-2068.1, -188.8, 6.0},
	{-2050.8, -167.0, 1.5},
	{-2046.3, -182.5, 8.0, -2046.3, -123.5, 8.0},
	{-2050.6, -218.8, 8.0}, 
	{0.0, 0.0, 0.0},
	{-2050.3, -175.0, 8.0},
	{-2044.8, -156.3, 10.0},
	{1.0, 0.0, 0.0},
	{0.0, 0.0, 0.0},
	{0.0, 0.0, 0.0}
};

levelMarker = {
	{0.0, 0.0},
	{-2049.0, -154.8}, 
	{-2028.9, -191.8},
	{-2050.8, -234.3},
	{-2050.5, -135.5, 3.6}, 
	{-2050.6, -130.0},
	{-2050.4, -205.0},
	{-2050.3, -225.0},
	{-2044.1, -169.8},
	{-2050.2, -245.6}, 
	{0.0, 0.0}, 
	
	{-1724.3, 1294.0, 6.00},
	{-2046.7, -90.20, 33.9}
};

levelObjects = { -- ID, x, y, z, rotZ
	{0, 0.0, 0.0, 0.0, 0.0},
	{0, 0.0, 0.0, 0.0, 0.0},
	{0, 0.0, 0.0, 0.0, 0.0},
	{2899, -2050.8, -167.0, 34.6, 90.0},
	{3078, -2050.5, -135.5, 34.35, 0.0},
	{3076, -2051.1, -172.5, 34.35, 180.0},
	{0, 0.0, 0.0, 0.0, 0.0},
	{1894, -2049.6, -155.0, 34.3, 270.0},
	{0, 0.0, 0.0, 0.0, 0.0},
	{3079, -2045.0, -177.5, 34.35, 180.0, -2057.0, -177.5, 34.35, 0.0},
	{3080, -2050.6, -185.0, 35.5, 180.0},
	{0, 0.0, 0.0, 0.0, 0.0}
};

levelCars = {
	{-2044.6, -205.0},
	{-2056.6, -205.0},
	{-2050.2, -205.0},
	{-2050.2, -210.0}
};

trafficConesPos = {
	{ -- The 360 (15)
		{-2050.6, -125.0},
		{-2048.2, -125.5},
		{-2046.1, -127.0},
		{-2044.9, -129.1},
		{-2044.6, -131.6},
		{-2045.4, -134.0},
		{-2047.0, -135.9},
		{-2049.3, -136.9},
		{-2051.8, -136.9},
		{-2054.1, -135.9},
		{-2055.8, -134.0},
		{-2056.6, -131.6},
		{-2056.3, -129.2},
		{-2055.1, -127.0},
		{-2053.0, -125.5}
	},
	{ -- The 180 (23)
		{-2055.9, -228.8},
		{-2041.9, -228.8},
		{-2055.9, -232.8},
		{-2041.9, -232.8},
		{-2055.9, -236.8},
		{-2041.9, -236.8},
		{-2055.9, -240.8},
		{-2041.9, -240.8},
		{-2048.9, -236.8},
		{-2051.9, -158.8},
		{-2045.9, -158.8},
		{-2051.9, -154.8},
		{-2045.9, -154.8},
		{-2051.9, -150.8},
		{-2045.9, -150.8},
		{-2048.9, -150.8},
		{-2048.9, -228.8},
		{-2048.9, -232.8},
		{-2048.9, -246.0},
		{-2053.9, -243.1},
		{-2045.8, -245.3},
		{-2051.6, -245.0},
		{-2043.7, -243.7}
	},
	{ -- Whip and terminate (46)
		{-2073, -158.8},
		{-2065, -158.8},
		{-2073, -154.8},
		{-2065, -154.8},
		{-2073, -150.8},
		{-2065, -150.8},
		{-2069, -150.8},
		{-2073, -162.8},
		{-2065, -162.8},
		{-2073, -166.8},
		{-2065, -166.8},
		{-2073, -170.8},
		{-2065, -170.8},
		{-2073, -174.8},
		{-2065, -174.8},
		{-2073, -178.8},
		{-2065, -178.8},
		{-2073, -182.8},
		{-2065, -182.8},
		{-2073, -186.8},
		{-2065, -186.8}, -- 21
		
		{-2061, -194.8},
		{-2061, -186.8},
		{-2057, -194.8},
		{-2057, -186.8},
		{-2053, -194.8},
		{-2053, -186.8},
		{-2049, -194.8},
		{-2049, -187.8},
		{-2045, -194.8},
		{-2045, -187.8},
		{-2041, -194.8},
		{-2041, -188.8},
		{-2037, -194.8},
		{-2037, -188.8},
		{-2033, -193.8},
		{-2033, -189.8},
		{-2029, -193.8},
		{-2029, -189.8},
		{-2025, -193.8},
		{-2025, -189.8},
		{-2025, -191.8},
		
		{-2065.0, -193.6},
		{-2067.7, -193.2},
		{-2070.2, -191.9},
		{-2072.1, -190.0}
	},
	{ -- Pop and Control (37)
		{-2048.8, -170},
		{-2052.8, -170},
		{-2047.8, -174},
		{-2053.8, -174},
		{-2047.8, -178},
		{-2053.8, -178},
		{-2047.8, -182},
		{-2053.8, -182},
		{-2047.8, -186},
		{-2053.8, -186},
		{-2046.8, -190},
		{-2052.8, -190},
		{-2045.8, -194},
		{-2051.8, -194},
		{-2044.8, -198},
		{-2050.8, -198},
		{-2044.8, -202},
		{-2050.8, -202},
		{-2044.8, -206},
		{-2050.8, -206},
		{-2044.8, -210},
		{-2050.8, -210},
		{-2045.8, -214},
		{-2051.8, -214},
		{-2046.8, -218},
		{-2052.8, -218},
		{-2047.8, -222},
		{-2053.8, -222},
		{-2047.8, -226},
		{-2053.8, -226},
		{-2047.8, -230},
		{-2053.8, -230},
		{-2047.8, -234},
		{-2053.8, -234},
		{-2047.8, -238},
		{-2053.8, -238},
		{-2050.8, -238}
	},
	{ -- Burn and lap (42)
		{-2054.6, -138},
		{-2046.6, -138},
		{-2054.6, -132},
		{-2046.6, -132},
		{-2054.6, -126},
		{-2054.6, -144},
		{-2046.6, -144},
		{-2054.6, -150},
		{-2046.6, -150},
		{-2054.6, -156},
		{-2046.6, -156},
		{-2054.6, -162},
		{-2046.6, -162},
		{-2054.6, -168},
		{-2046.6, -168},
		{-2054.6, -174},
		{-2046.6, -174},
		{-2054.6, -180},
		{-2038.6, -138},
		{-2038.6, -132},
		{-2038.6, -126},
		{-2038.6, -144},
		{-2038.6, -150},
		{-2038.6, -156},
		{-2038.6, -162},
		{-2038.6, -168},
		{-2038.6, -174},
		{-2038.6, -180},
		{-2039.5, -185.2},
		{-2041.4, -187.1},
		{-2043.9, -188.4},
		{-2046.6, -188.8},
		{-2049.3, -188.4},
		{-2051.8, -187.1},
		{-2053.7, -185.2},
		{-2053.7, -120.8},
		{-2051.8, -118.9},
		{-2049.3, -117.6},
		{-2046.6, -117.2},
		{-2043.9, -117.6},
		{-2041.4, -118.9},
		{-2039.5, -120.8}
	},
	{ -- Cone coil (30)
		{-2058.6, -150},
		{-2056.6, -150},
		{-2054.6, -150},
		{-2052.6, -150},
		{-2050.6, -150},
		{-2043.6, -170},
		{-2045.6, -170},
		{-2047.6, -170},
		{-2049.6, -170},
		{-2051.6, -170},
		{-2058.6, -190},
		{-2056.6, -190},
		{-2054.6, -190},
		{-2052.6, -190},
		{-2050.6, -190},
		{-2043.1, -211},
		{-2044.2, -215},
		{-2047.1, -218},
		{-2051.1, -219},
		{-2055.1, -218},
		{-2058.1, -215},
		{-2059.1, -211},
		{-2050.6, -210},
		{-2053.6, -134},
		{-2047.6, -126},
		{-2053.6, -130},
		{-2047.6, -130},
		{-2053.6, -126},
		{-2047.6, -134},
		{-2050.6, -126}
	},
	{ -- The '90' (0)
		{0.0, 0.0}
	},
	{ -- Wheelie Weave (0)
		{0.0, 0.0}
	},
	{ -- Spin and Go (31)
		{-2050.6, -126},
		{-2053.6, -126},
		{-2047.6, -126},
		{-2053.6, -130},
		{-2047.6, -130},
		{-2053.6, -134},
		{-2047.6, -134},
		{-2053.6, -138},
		{-2047.6, -138},
		{-2053.6, -142},
		{-2047.6, -142},
		{-2053.6, -146},
		{-2047.6, -146},
		{-2053.6, -150},
		{-2047.6, -150},
		{-2053.6, -154},
		{-2044.6, -152},
		{-2050.6, -158},
		{-2042.6, -154},
		{-2047.6, -160},
		{-2040.6, -156},
		{-2046.6, -162},
		{-2040.6, -160},
		{-2041.6, -98},
		{-2046.6, -166},
		{-2041.6, -166},
		{-2046.6, -170},
		{-2041.6, -170},
		{-2046.6, -174},
		{-2041.6, -174},
		{-2044.1, -174} 
	},
	{ -- P. I. T. Maneuver (0)
		{0.0, 0.0}
	},
	{ -- Alley Oop (0)
		{0.0, 0.0}
	},
	{ -- City Slicking (0)
		{0.0, 0.0}
	}
};

-- Screen stuff
screenX, screenY = guiGetScreenSize()
screenAspect = math.floor((screenX / screenY)*10)/10

-- 16:9 screen ratio
if screenAspect >= 1.7 then 
	-- GUI 
	offsets = {0.8, 0.92} 
	messageSize = 1.2
	textSize = 3
	
	-- Info box
	b_offsets = {0.25, 0.4, 0.5, 0.35} -- X-left, Y-top, width, height for a box
	t_offsets = {0.27, 0.5, 0.63, screenX/1200} -- X-left, Y1, Y2, textsize
	i_size = {0.2, 0.207}
	
	-- Stats box
	s_offsets = {0.25, 0.25, 0.5, 0.6} -- X-left, Y-top, width, height for a box
	st_offsets = {0.27, 0.20, 0.63, screenX/1745, screenX/1920} -- X-left, Y1, Y2, textsize
 -- 4:3 and others screens
else 
	-- GUI
	offsets = {0.72, 0.9}
	messageSize = 1
	textSize = 2
	
	-- Info box
	b_offsets = {0.25, 0.4, 0.5, 0.35} -- X-left, Y-top, width, height for a box
	t_offsets = {0.27, 0.5, 0.63, screenX/1200} -- X-left, Y1, Y2, textsize
	i_size = {0.27, 0.207}
	
	-- Stats box
	s_offsets = {0.25, 0.25, 0.5, 0.6} -- X-left, Y-top, width, height for a box
	st_offsets = {0.27, 0.20, 0.63, screenX/1745, screenX/1920} -- X-left, Y1, Y2, textsize
end

medalTexture = {dxCreateTexture('txd/bronze.png'), dxCreateTexture('txd/silver.png'), dxCreateTexture('txd/gold.png')}
arrowTexture = dxCreateTexture('txd/arrows.png')

showLevelResults = false
newTestAvailable = false
drawAlpha = 0

-- Function updates objectives and checks for completing the level
function update()
	-- Update level
	if getElementData(localPlayer, "level") ~= level then
		setElementData(localPlayer, "level", level)
		setElementData(localPlayer, "Test", levelNames[level])
	end
	
	-- Player State Checks
	local newPlayerState = getElementData(localPlayer, "state")
	if newPlayerState ~= playerState then		
		-- Player spawned first time
		if playerState == "not ready" and newPlayerState == "alive" then
			if isTimer(startLevelTimer) then killTimer(startLevelTimer) end
			startLevelTimer = setTimer(function() setElementData(localPlayer, "trigger", 1) end, 400, 1)
		elseif playerState == "alive" and newPlayerState == "not ready" then
			if isTimer(startLevelTimer) then killTimer(startLevelTimer) end
			
		-- Player respawned from spectate mode or was dead
		elseif newPlayerState == "alive" then
			showLevelResults = false
			--finishLevel()
		end
		
		playerState = newPlayerState
	end
	
	if getElementData(localPlayer, "trigger") == 0 then
		setElementDimension(localPlayer, FADE_DIMENSION)
		setElementDimension(getPedOccupiedVehicle(localPlayer), FADE_DIMENSION)
		
		--startLevel()
		--fadeCamera(false)
		finishLevel()
		setElementData(localPlayer, "trigger", 2)
		
		setTimer(function() 
			outputChatBox(boxTexts[3])
			if getElementData(localPlayer, "logged") == 0 then outputChatBox("Player stats does not update until you're logged in") end
		end, 1000, 1)
	end
	
	if not levelLoaded or showLevelResults then return end
	
	-- Level Specific Conditions
	if level == 1 then -- The 360
		local rX, rY, rZ = getElementRotation(getPedOccupiedVehicle(localPlayer))
		local vX, vY, vZ = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		local speed = vX*vX + vY*vY + vZ*vZ
		
		-- Fail Condition
		if speed > 0.01 then pauseLevel() end
		
		-- Objective Condition
		if (rZ > 350 or rZ < 10) and levelObj == 0 then 
			levelObj = 1
		end
	elseif level == 5 and levelObj == 10 and isElementWithinColShape(getPedOccupiedVehicle(localPlayer), finishMarker) then
		pauseLevel() -- Finish Condition
	elseif level == 6 and carStartedToMove and not isElementWithinColShape(getPedOccupiedVehicle(localPlayer), limitCol) then
		pauseLevel() -- Fail Condition
	elseif level == 8 then
		-- Fail Condition
		if levelObj == 1 and (isVehicleWheelOnGround(getPedOccupiedVehicle(localPlayer), "front_left") or isVehicleWheelOnGround(getPedOccupiedVehicle(localPlayer), "rear_left")) then
			pauseLevel()
		end
	elseif level == 9 then
		for accelerateKey, state in pairs(getBoundKeys("accelerate")) do
			-- Fail Condition
			if levelObj == 0 and getKeyState(accelerateKey) then pauseLevel() end
		end
	elseif level == 10 then
		local rx, ry, rz = getElementRotation(policeCar)
		if not isElementWithinColShape(getPedOccupiedVehicle(localPlayer), limitCol) or not isElementWithinColShape(policeCar, limitCol) or rz > 340.0 or rz < 20.0 then
			pauseLevel()
			setElementFrozen(policeCar, true)
			setPedAnalogControlState(policePed, "accelerate", 0)
		end
	elseif level == 11 then
		if isVehicleMoving(getPedOccupiedVehicle(localPlayer)) and isVehicleUpsideDown(getPedOccupiedVehicle(localPlayer)) then
			-- Objective Condition
			if levelObj == 0 then 
				levelObj = 1
				setElementHealth(getPedOccupiedVehicle(localPlayer), 1000.0)
			end 
		end
		
		local vHealth = getElementHealth(getPedOccupiedVehicle(localPlayer))
		fixVehicle(getPedOccupiedVehicle(localPlayer))
		setElementHealth(getPedOccupiedVehicle(localPlayer), vHealth)
	elseif level == 12 then
		if isElement(finishMarker) then
			if isElementWithinMarker(getPedOccupiedVehicle(localPlayer), finishMarker) then 
				if levelObj == 0 then
					destroyElement(finishMarker)
					destroyElement(blip)
					
					finishMarker = createMarker(levelPosition[level][1], levelPosition[level][2], 34.6, "checkpoint", 7.0, 255, 0, 0, 150)
					blip = createBlip(levelPosition[level][1], levelPosition[level][2], 0.0, 0, 2, 204, 171, 92, 255)
					setMarkerIcon(finishMarker, "finish")
					
					levelObj = 1
					playSoundFrontEnd(43)
				else
					levelObj = 2
					pauseLevel()
				end
			end
		end
	end
	
	-- Genegal fail condition 
	if isVehicleMoving(getPedOccupiedVehicle(localPlayer)) and not carStartedToMove then
		carStartedToMove = true
		timerPaused = false

		if level == 5 then burnAndLapTime = getTickCount()
		elseif level == 12 then citySlickingTime = getTickCount()
		elseif level == 10 then 
			--setPedAnalogControlState(policePed, "accelerate", 0.65) 
			setPedAnalogControlState(policePed, "accelerate", 0.82) 
			setElementVelocity(policeCar, 0.0, -0.01, 0.0) -- 0.03
		end
		
		if isTimer(displayHelpTextTimer) then killTimer(displayHelpTextTimer) end
		displayHelpTextTimer = setTimer(function() displayHelpText = false end, 1500, 1)
		
	elseif carStartedToMove and not isVehicleMoving(getPedOccupiedVehicle(localPlayer)) then
		pauseLevel()
		
		if level == 10 then
			setElementFrozen(policeCar, true)
			setPedAnalogControlState(policePed, "accelerate", 0)
		end
	end
end

-- Function checks player's vehicle velocity and return true if vehicle is moving
function isVehicleMoving(vehicle)
	if not isElement(vehicle) then return false end
	local vX, vY, vZ = getElementVelocity(vehicle)
	
	if vX*vX + vY*vY + vZ*vZ > 0.0005 then 
		return true
	elseif vX*vX + vY*vY + vZ*vZ < 0.0001 then
		return false 
	end
end

-- Function loads current level
function startLevel()
	if debug then outputDebugString("start level") end
	
	-- Spectate Checks
	if isLocalPlayerSpectating() or schoolFinished then 
		fadeCamera(true)
		return 
	end
	
	-- Load Player's Vehicle
	setElementData(localPlayer, "carid", levelCar[level])
	--setElementModel(getPedOccupiedVehicle(localPlayer), levelCar[level])
	fixVehicle(getPedOccupiedVehicle(localPlayer))	
	
	-- Load ColShapes
	if levelCols[level][1] ~= 0 then
		triggerCol = createColSphere(levelCols[level][1], levelCols[level][2], 34.6, levelCols[level][3])
		if level == 5 then -- Burn and Lap
			triggerCol2 = createColSphere(levelCols[level][4], levelCols[level][5], 34.6, levelCols[level][6])
		elseif level == 6 then -- Cone coil
			limitCol = createColPolygon(-2051.1, -172.5, -2058, -222, -2044.5, -222, -2044.5, -126.6, -2058, -126.6)
		elseif level == 10 then -- PIT
			limitCol = createColPolygon(-2051.1, -172.5, -2063, -126.6, -2063, -229.5, -2038.8, -229.5, -2038.8, -126.6)
		end
	end
	
	-- Load Finish Marker
	if levelMarker[level][1] ~= 0 then
		if level == 5 then
			finishMarker = createColSphere(levelMarker[level][1], levelMarker[level][2], 34.6, levelMarker[level][3])
		-- City Slicking
		elseif level == 12 then
			finishMarker = createMarker(levelMarker[level][1], levelMarker[level][2], levelMarker[level][3], "checkpoint", 7.0, 255, 0, 0, 150)
			blip = createBlip(levelMarker[level][1], levelMarker[level][2], 0.0, 0, 2, 204, 171, 92, 255)
			setMarkerIcon(finishMarker, "arrow")
			setMarkerTarget(finishMarker, levelPosition[12][1], levelPosition[12][2], 34.6)
		-- Alley Oop
		elseif level == 11 then
			finishMarker = createMarker(levelMarker[level][1], levelMarker[level][2], levelPosition[level][3], "cylinder", 10.0, 255, 0, 0, 150)
			setElementDimension(finishMarker, HIDE_DIMENSION)
		-- Every other test
		else
			finishMarker = createMarker(levelMarker[level][1], levelMarker[level][2], 34.6, "cylinder", 5.0, 255, 0, 0, 150)
			if level ~= 8 then setElementDimension(finishMarker, HIDE_DIMENSION) end
		end
	end
	
	-- Load Level Object
	if levelObjects[level][1] ~= 0 then
		levelObject = createObject(levelObjects[level][1], levelObjects[level][2], levelObjects[level][3], levelObjects[level][4], 0.0, 0.0, levelObjects[level][5])
		
		if level == 10 then
			levelObject2 = createObject(levelObjects[level][1], levelObjects[level][6], levelObjects[level][7], levelObjects[level][8], 0.0, 0.0, levelObjects[level][9])
			
			-- Randomize player dimension
			math.randomseed(math.floor(getTickCount()/math.random(69)*os.clock()))
			pitDim = math.random(13, 65000)
		
			setElementDimension(levelObject, pitDim)
			setElementDimension(levelObject2, pitDim)
		end
	end
	
	-- Load Level's Specific Materials
	if level == 7 or level == 11 then
		if level == 7 then
			levelVehicle[1] = createVehicle(429, levelCars[1][1], levelCars[1][2], 35.0, 0.0, 0.0, 270.0)
			levelVehicle[2] = createVehicle(429, levelCars[2][1], levelCars[2][2], 35.0, 0.0, 0.0, 270.0)
		elseif level == 11 then
			levelVehicle[1] = createVehicle(411, levelCars[3][1], levelCars[3][2], 35.0, 0.0, 0.0, 270.0)
			levelVehicle[2] = createVehicle(411, levelCars[4][1], levelCars[4][2], 35.0, 0.0, 0.0, 270.0)
		end
		
		for i=1, 2 do
			setElementData(levelVehicle[i], 'race.collideothers', 1)
			setElementFrozen(levelVehicle[i], true)
		end
	elseif level == 10 then
		-- Vehicle 
		policeCar = createVehicle(597, -2050.6, -140.0, 35.000, 0.0, 0.0, 180.0)
		setElementDimension(policeCar, pitDim)
		setVehicleColor(policeCar, 0, 0, 0, 255, 255, 255)
		setElementData(policeCar, 'race.collideothers', 1)
		
		-- Ped
		policePed = createPed(281, 0.0, 0.0, 0.0)
		setElementDimension(policePed, pitDim)
		warpPedIntoVehicle(policePed, policeCar, 0)
		
		setElementData(localPlayer, "dim", pitDim)
	end
	
	-- Load Cones
	if maxCones[level] ~= 0 then
		for i = 1, maxCones[level] do		
			trafficCones[i] = createObject(1238, trafficConesPos[level][i][1], trafficConesPos[level][i][2], 34.6)
			
			for index, players in ipairs(getElementsByType("player")) do
				if not getPedOccupiedVehicle(players) then break end
				setElementCollidableWith(getPedOccupiedVehicle(players), trafficCones[i], false)
			end 
			
			if not getPedOccupiedVehicle(localPlayer) then break end
			setElementCollidableWith(getPedOccupiedVehicle(localPlayer), trafficCones[i], true)
		end
	end
	
	if isTimer(fadeTimer) then killTimer(fadeTimer) end
	fadeTimer = setTimer(function() 
		fadeCamera(true) 
		if debug then outputDebugString("fade in") end
		
		if level ~= 10 then 
			setElementDimension(localPlayer, DEFAULT_DIMENSION)
			setElementDimension(getPedOccupiedVehicle(localPlayer), DEFAULT_DIMENSION)
		end
		setElementPosition(getPedOccupiedVehicle(localPlayer), levelPosition[level][1], levelPosition[level][2], levelPosition[level][3])
		setElementRotation(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, levelPosition[level][4])
		setElementVelocity(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, 0.0)
		setCameraTarget(localPlayer)
		setElementFrozen(getPedOccupiedVehicle(localPlayer), false) 
	end, 1000, 1)
	
	-- Toggle Player's Controls
	setTimer(function()
		toggleControl("accelerate", true)
		toggleControl("brake_reverse", true)
		timerPaused = true
		playersTimer = timer[level]
		resetPlayersTimer()
		levelLoaded = true
		testAttempts = testAttempts + 1
		fadeIsHappening = false
	end, 2000, 1)
	
	-- Reset Level State
	levelObj = 0
	levelMedal = 0
	carStartedToMove = false
	if level >= levelUnlocked then
		newTestAvailable = false
	end
	newRecord = false
	
	results[1] = 0
	results[2] = 0
	results[3] = 0
	results[4] = 0
	
	if level == 7 then levelObj = 1 end
	
	-- Visuals
	--fadeCamera(false)
	--fadeCamera(true)
	setPlayerHudComponentVisible("radar", true)
	
	if isTimer(displayHelpTextTimer) then killTimer(displayHelpTextTimer) end
	displayHelpText = true
	oldCamera[1] = 0
	if isElement(theme) then stopSound(theme) end
end

-- Function freezes player and shows level's results
function pauseLevel()
	if debug then outputDebugString("pause level") end
	
	if isTimer(alleyOopTimer) then killTimer(alleyOopTimer) end
	if showLevelResults or isLocalPlayerSpectating() then return end
	timerPaused = true
	
	-- Calculate level's score
	-- Prefect heading
	local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
	if level == 10 then
		rx, ry, rz = getElementRotation(policeCar)
	end

	if levelPerfectHeading[level] ~= nil then
		if levelPerfectHeading[level] == 0.0 then
			if rz == 0 or rz == 360 or (rz > 0 and rz < 5) or (rz > 354 and rz < 360) then 
				results[1] = 100 
			elseif rz > 179 and rz < 355 then 
				results[1] = (rz - 180)*0.62
			elseif rz > 4 and rz < 180 then 
				results[1] = 100 - rz*0.62 
			end
			
		-- 180.0
		elseif levelPerfectHeading[level] == 180.0 then
			if rz == 0 or rz == 360 then 
				results[1] = 0
			elseif rz == 180 or (rz > 174 and rz < 186) then 
				results[1] = 100
			elseif rz > 0 and rz < 175 then
				results[1] = rz*0.56
			elseif rz > 185 and rz < 360 then 
				results[1] = 100 - (rz - 180)*0.56
			end
			
		-- 270.0
		elseif levelPerfectHeading[level] == 270.0 then
			if rz == 0 and rz == 360 then
				results[1] = 0
			elseif rz == 270 or (rz > 264 and rz < 276) then
				results[1] = 100
			elseif rz > 0 and rz < 265 then
				results[1] = rz*0.37	  
			elseif rz > 275 and rz < 360 then
				results[1] = 100 - (rz - 270)*1.16
			end
		end
		
		if results[1] < 0 then results[1] = 0
		elseif results[1] > 99 then results[1] = 100 end
		results[1] = math.floor(results[1]*10)/10
	
	else -- Overall time
		if level == 5 then
			burnAndLapTime = getTickCount() - burnAndLapTime
			local s = math.floor(burnAndLapTime / 1000)
			local ms = math.floor(burnAndLapTime % 1000 / 10)
			results[1] = s.. "." ..ms.. "S"
		elseif level == 12 then
			citySlickingTime = getTickCount() - citySlickingTime
			
			local m = math.floor(citySlickingTime / 1000 / 60)
			local s = math.floor((citySlickingTime / 1000) - m*60)
			local ms = math.floor(citySlickingTime - (m*60+s)*1000)
			
			if s < 10 then s = "0" ..s end
			if ms < 10 then ms = "00" ..ms
			elseif ms < 100 and ms > 9 then ms = "0" ..ms end
			
			results[1] = m.. ":" ..s.. "S"
		end
	end
	
	-- Perfect position
	if level ~= 12 and level ~= 5 and level ~= 10 then 
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local distance = getDistanceBetweenPoints2D(x, y, levelPerfectPosition[level][1], levelPerfectPosition[level][2])
		
		if level == 11 then
			if distance > 5 then
				if distance < 20.0 then 
					results[2] = 100 - (distance - 5)*1.042
				else results[2] = 0 end
			else results[2] = 100 end
		elseif level == 8 then
			if distance > 2.5 then
				if distance < 10.0 then 
					results[2] = 100 - (distance - 2.5)*2.084
				else results[2] = 0 end
			else results[2] = 100 end
		else
			if distance > 0.5 then
				if distance < 10.0 then results[2] = 100 - (distance - 0.5)*10.42
				else results[2] = 0 end
			else results[2] = 100 end
		end
		
		if levelObj == 0 and level ~= 12 then results[2] = 0
		elseif levelObj ~= 1 and level == 12 then results[2] = 0 end
	elseif level == 5 or level == 12 then
		local limits = {}
		if level == 5 then limits = {45, 40, 36, 7.5, 13.8}
		else limits = {120, 100, 80, 1.5, 3.5} end -- 140, 120, 100
		
		if playersTimer < limits[3] then
			results[2] = 100
		elseif playersTimer >= limits[3] and playersTimer < limits[2] then
			results[2] = 100 - (playersTimer - limits[3])*limits[4]
		elseif playersTimer >= limits[2] and playersTimer < limits[1] then
			results[2] = 70 - (playersTimer - limits[2])*limits[5]
		elseif playersTimer >= limits[1] then
			results[2] = 0
		end
		
		if level == 5 and (levelObj ~= 10 or not (rz < 270 and rz > 90)) then results[2] = 0
		elseif level == 12 and levelObj < 2 then results[2] = 0 end
	elseif level == 10 then -- PIT
		local px, py, pz = getElementPosition(policeCar)
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local distance = getDistanceBetweenPoints2D(px, py, x, y)
		
		if distance > 4.0 then
			if distance < 11.0 then results[2] = 100 - (distance - 4.0)*14.14
			else results[2] = 0 end
		else results[2] = 100 end
	end
	
	if results[2] < 0 then results[2] = 0
	elseif results[2] > 99 then results[2] = 100 end
	results[2] = math.floor(results[2]*10)/10
		
	-- Damage
	if level ~= 12 then
		results[3] = 0 - checkCones()*10.0 - (500 - getElementHealth(getPedOccupiedVehicle(localPlayer))/2)
		
		if level == 7 then -- the 90
			if getElementHealth(getPedOccupiedVehicle(localPlayer)) < 1000.0 then
				results[3] = -100
			end
		elseif (level == 10 or level == 8) and getElementHealth(getPedOccupiedVehicle(localPlayer)) > 998.5 then -- PIT and wheelie
			results[3] = 0
		end
	else
		results[3] = results[3] - (200 - getElementHealth(getPedOccupiedVehicle(localPlayer))/5)
	end
	if results[3] < -100.0 then results[3] = -100.0 end
	results[3] = math.floor(results[3]*10)/10
	
	-- Overall
	if level ~= 5 and level ~= 12 then 
		--results[4] = (results[1] + results[2])/2 + results[3]
		results[4] = results[1] + results[2] - 100 + results[3]
	else
		results[4] = 100 - (100 - results[2]) + results[3]
	end
	if results[4] < 0 then results[4] = 0
	elseif results[4] > 100.0 then results[4] = 100.0 end
	results[4] = math.floor(results[4]*10)/10
	
	-- Code for updating global records in database
	if results[4] > levelRecords[level] or results[4] == 100 then
		if level == 5 then
			triggerServerEvent("updateBurnAndLapRecords", getLocalPlayer(), burnAndLapTime)
		elseif level == 12 then
			triggerServerEvent("updateCitySlickingRecords", getLocalPlayer(), citySlickingTime)
		end
	end
	
	-- Updating local records and medals
	if results[4] > levelRecords[level] then
		if results[4] > 69 and results[4] < 85 then levelMedal = 1
		elseif results[4] > 84 and results[4] < 100 then levelMedal = 2
		elseif results[4] == 100 then levelMedal = 3
		else levelMedal = 0 end
		
		if levelMedal > levelMedals[level] then levelMedals[level] = levelMedal	
		else levelMedal = 0 end
		
		newRecord = true
		levelRecords[level] = results[4]
	end
	
	-- Displaying stuff and unlock new level
	showLevelResults = true
	displayStats = false
	if levelRecords[level] > 69 then
		newTestAvailable = true
		
		if level == levelUnlocked then
			levelUnlocked = levelUnlocked + 1 
		end
	end
	
	-- Visuals 
	setPlayerHudComponentVisible("radar", false)
	
	-- Stop player's vehicle
	setElementVelocity(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, 0.0)
	setElementAngularVelocity(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, 0.0)
	
	-- Music
	if levelMedal ~= 0 then 
		if isElement(theme) then stopSound(theme) end
		theme = playSound("mp3/theme.mp3", true)
		setSoundVolume(theme, 1.2) -- set the sound volume to 50%
	end
end

-- Function unloads current level
function finishLevel()
	if debug then outputDebugString("finish level") end
	
	-- Visuals
	setElementDimension(localPlayer, FADE_DIMENSION)
	if getPedOccupiedVehicle(localPlayer) then setElementDimension(getPedOccupiedVehicle(localPlayer), FADE_DIMENSION) end
	
	if not fadeIsHappening then 
		fadeCamera(false)
		if debug then outputDebugString("fade out") end
		fadeIsHappening = true
	end
	
	if isTimer(hideCarTimer) then killTimer(hideCarTimer) end
	hideCarTimer = setTimer(function()
		math.randomseed(getTickCount())
		setElementPosition(getPedOccupiedVehicle(localPlayer), -2050.6, -130.0, math.random(100, 999))
		setElementFrozen(getPedOccupiedVehicle(localPlayer), true)
		if debug then outputDebugString("car hidden") end
	end, 1000, 1)

	-- Unload Level's Materials
	if isElement(triggerCol) then destroyElement(triggerCol) end
	if isElement(triggerCol2) then destroyElement(triggerCol2) end
	if isElement(limitCol) then destroyElement(limitCol) end
	if isElement(finishMarker) then destroyElement(finishMarker) end
	if isElement(blip) then destroyElement(blip) end
	if isElement(levelObject) then destroyElement(levelObject) end
	if isElement(levelObject2) then destroyElement(levelObject2) end
	if isElement(levelVehicle[1]) then destroyElement(levelVehicle[1]) end
	if isElement(levelVehicle[2]) then destroyElement(levelVehicle[2]) end
	if isElement(policeCar) then destroyElement(policeCar) end
	if isElement(policePed) then destroyElement(policePed) end
	
	-- Unload Level's Cones
	if maxCones[level] ~= 0 then
		for i = 1, maxCones[level] do
			if isElement(trafficCones[i]) then destroyElement(trafficCones[i]) end
		end
	end
	
	if level == 10 then setElementData(localPlayer, "dim", DEFAULT_DIMENSION) end
	
	-- Reset Level's State
	levelLoaded = false
	timerPaused = true
	if isTimer(displayHelpTextTimer) then killTimer(displayHelpTextTimer) end
	if isTimer(alleyOopTimer) then killTimer(alleyOopTimer) end
	
	if isTimer(startLevelTimer) then killTimer(startLevelTimer) end
	if not schoolFinished then
		startLevelTimer = setTimer(startLevel, 2000, 1) -- was 3000
	else
		-- after finishing the race
		fadeCamera(true)
		showLevelResults = false
	end
end

-- Function checks every traffic cone on the level and return amount of broken ones
function checkCones()
	if maxCones[level] == 0 then
		return 0
	end
	
	local brokenCones = 0
	for i = 1, maxCones[level] do
		if getElementHealth(trafficCones[i]) == 0 then 
			brokenCones = brokenCones + 1
		end
	end
	
	totalConesBroken = totalConesBroken + brokenCones
	return brokenCones
end

-- Function checks if player is spectating
function isLocalPlayerSpectating()
	local px, py, pz = getElementPosition(localPlayer)
	if getElementData(localPlayer, "state") == "spectating" or pz > 1000 then return true	
	else return false end
end

-- Function that handles player's timer
function oneSecondUpdates()	
	if not timerPaused and playersTimer ~= nil then
		if level == 5 or level == 12 then
			playersTimer = playersTimer + 1
		else
			if playersTimer < 0 then pauseLevel()
			else playersTimer = playersTimer - 1 end
		end
	end
end

-- Function that resets player's timer
function resetPlayersTimer()
	if isTimer(oneSecondTimer) then killTimer(oneSecondTimer) end
	oneSecondTimer = setTimer(oneSecondUpdates, 1000, 0)
end

-- Function inserts key names based on player's MTA binds
function setTexts()
	for accelerateKey, state in pairs(getBoundKeys("accelerate")) do
		for reverseKey, state in pairs(getBoundKeys("brake_reverse")) do
			levelTexts2[1] = "Press and hold " ..string.upper(accelerateKey).. " and " ..string.upper(reverseKey).. " to begin."
			levelTexts2[2] = "Press " ..string.upper(reverseKey).. " to begin."
			break
		end
		levelTexts2[3] = "Press and hold " ..string.upper(accelerateKey).. " to begin."
		break
	end

	for handbrakeKey, state in pairs(getBoundKeys("handbrake")) do
		levelTexts[2] = "To do a 180, accelerate to top speed, press " ..string.upper(handbrakeKey).. " to handbrake\n around the cone and then return."
		boxTexts[1] = handbrakeKey
		break
	end

	for leftKey, state in pairs(getBoundKeys("vehicle_look_left")) do
		for rightKey, state in pairs(getBoundKeys("vehicle_look_right")) do
			levelTexts[9] = "Use the front wheel drive car to reverse then\n quickly spin around 180 degrees.\n Press " ..string.upper(leftKey).. " and " ..string.upper(rightKey).. " together to look behind."
			break
		end
		break
	end 
	
	for upKey, state in pairs(getBoundKeys("steer_back")) do
		for downKey, state in pairs(getBoundKeys("steer_forward")) do
			levelTexts[11] = "Do a barrel roll in mid air and land it perfectly.\n While in the air, release the accelerate button and use\n " ..string.upper(upKey).. " and " ..string.upper(downKey).. " to adjust the car's pitch."
			break
		end
		break
	end 
	
	for sprintKey, state in pairs(getBoundKeys("sprint")) do
		boxTexts[1] = sprintKey
		break
	end
	
	for jumpKey, state in pairs(getBoundKeys("jump")) do
		boxTexts[2] = jumpKey
		break
	end
	
	local b = 1
	local button = {}
	for vehicleMouseLookKey, state in pairs(getBoundKeys("radio_user_track_skip")) do
		button[b] = vehicleMouseLookKey
		bindKey(vehicleMouseLookKey, "down", showStats)
		
		b = b + 1 
		if b > 4 then 
			b = 4
			break
		end
	end 
	
	b = b - 1
	boxTexts[3] = "Press " ..string.upper(button[1])
	if b > 1 then
		for i = 2, b do
			boxTexts[3] = boxTexts[3].. " or " ..string.upper(button[i])
		end
	end
	boxTexts[3] = boxTexts[3].. " for a stats menu"
end 

-- Function that enables stats and requests data from the database
-- Called from key bind and finish of the race
function showStats()
	-- Request data for stats
	triggerServerEvent("getStats", getLocalPlayer())
	
	-- Show stats
	displayStats = not displayStats
end

-- Function that draws stats on the screen
function drawStats()
	if not statsInited then return end
	if statsPage == 0 then -- Player Stats
		local nick = getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", "")
		if displayedStats["playername"] == "guest" then nick = nick..  " (guest)" end
		
		dxDrawText(nick, screenX*(st_offsets[1]+0.005), screenY*(st_offsets[2]+0.003), screenX, screenY, tocolor(0, 0, 0, statsAlpha), st_offsets[5]*4.02, st_offsets[5]*4.15, "beckett")
		dxDrawText(nick, screenX*st_offsets[1], screenY*st_offsets[2], screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[5]*4, st_offsets[5]*4, "beckett")
		
		dxDrawText("BEST TIME AT:", screenX*st_offsets[1], screenY*(st_offsets[2]+0.10), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("Burn and Lap", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.13), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("City Slicking", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.16), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("All Golds", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.19), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
		
		dxDrawText("TOTAL:", screenX*st_offsets[1], screenY*(st_offsets[2]+0.25), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("Cones Destroyed", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.28), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("Tests Passed", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.31), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("Tests Attempted", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.34), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("Times Won", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.37), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("Time Played", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.40), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("Gold Medals", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.43), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("Silver Medals", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.46), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("Bronze Medals", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.49), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
		
		dxDrawText("MAP RECORDS:", screenX*st_offsets[1], screenY*(st_offsets[2]+0.55), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("Cones Destroyed", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.58), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			dxDrawText("Times Played", screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.61), screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic")
			
		--data
		
		dxDrawText(convertToRaceTime(displayedStats["burn"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.13), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		dxDrawText(convertToRaceTime(displayedStats["city"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.16), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		dxDrawText(convertToRaceTime(displayedStats["goldPB"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.19), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		dxDrawText(tostring(displayedStats["cones"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.28), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		dxDrawText(tostring(displayedStats["passed"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.31), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		dxDrawText(tostring(displayedStats["attempts"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.34), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		dxDrawText(tostring(displayedStats["won"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.37), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		dxDrawText(convertToPlayingTime(displayedStats["playing"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.40), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		dxDrawText(tostring(displayedStats["golds"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.43), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		dxDrawText(tostring(displayedStats["silvers"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.46), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		dxDrawText(tostring(displayedStats["bronzes"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.49), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		
		dxDrawText(displayedStats["conesall"], screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.58), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
		dxDrawText(displayedStats["playedall"], screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.61), screenX*(st_offsets[1]+0.45), screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[4], st_offsets[4], "bankgothic", "right")
	elseif statsPage == 1 then -- Burn And Lap Records
		dxDrawText("Burn and Lap", screenX*(st_offsets[1]+0.005), screenY*(st_offsets[2]+0.003), screenX, screenY, tocolor(0, 0, 0, statsAlpha), st_offsets[5]*4.02, st_offsets[5]*4.15, "beckett")
		dxDrawText("Burn and Lap", screenX*st_offsets[1], screenY*st_offsets[2], screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[5]*4, st_offsets[5]*4, "beckett")
		
		local box_height = (screenY*s_offsets[4]) * 0.9
		local textSize = box_height / 75 / (12 / 2)
		local offset = box_height / 12

		-- Draw stats
		for i = 1, 11 do
			local color
			if displayedBurn[i]["playername"]:gsub("#%x%x%x%x%x%x", "") == getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", "") then
				color = tocolor(0, 200, 200, statsAlpha)
			else
				color = tocolor(175, 202, 230, statsAlpha)
			end
			
			if i == 11 and displayedBurn[11]["id"] ~= nil then
				dxDrawText(displayedBurn[11]["id"].. ".", screenX*st_offsets[1], screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1]*1.105, screenY, color, textSize, textSize, "bankgothic", "right")
			else
				dxDrawText(i.. ".", screenX*st_offsets[1], screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1]*1.105, screenY, color, textSize, textSize, "bankgothic", "right")
			end
			
			dxDrawText(tostring(displayedBurn[i]["playername"]):gsub("#%x%x%x%x%x%x", ""), screenX*(st_offsets[1]*1.12), screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1], screenY, color, textSize, textSize, "bankgothic")
			dxDrawText(convertToRaceTime(displayedBurn[i]["time"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.07) + offset, screenX*(st_offsets[1]+0.45), screenY, color, textSize, textSize, "bankgothic", "right")
			offset = offset + (box_height / 12)
		end
	elseif statsPage == 2 then -- City Slicking Records
		dxDrawText("City Slicking", screenX*(st_offsets[1]+0.005), screenY*(st_offsets[2]+0.003), screenX, screenY, tocolor(0, 0, 0, statsAlpha), st_offsets[5]*4.02, st_offsets[5]*4.15, "beckett")
		dxDrawText("City Slicking", screenX*st_offsets[1], screenY*st_offsets[2], screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[5]*4, st_offsets[5]*4, "beckett")
		
		local box_height = (screenY*s_offsets[4]) * 0.9
		local textSize = box_height / 75 / (12 / 2)
		local offset = box_height / 12

		-- Draw stats
		for i = 1, 11 do
			local color
			if displayedCity[i]["playername"]:gsub("#%x%x%x%x%x%x", "") == getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", "") then
				color = tocolor(0, 200, 200, statsAlpha)
			else
				color = tocolor(175, 202, 230, statsAlpha)
			end
			
			if i == 11 and displayedCity[11]["id"] ~= nil then
				dxDrawText(displayedCity[11]["id"].. ".", screenX*st_offsets[1], screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1]*1.105, screenY, color, textSize, textSize, "bankgothic", "right")
			else
				dxDrawText(i.. ".", screenX*st_offsets[1], screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1]*1.105, screenY, color, textSize, textSize, "bankgothic", "right")
			end
			
			dxDrawText(tostring(displayedCity[i]["playername"]):gsub("#%x%x%x%x%x%x", ""), screenX*(st_offsets[1]*1.12), screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1], screenY, color, textSize, textSize, "bankgothic")
			dxDrawText(convertToRaceTime(displayedCity[i]["time"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.07) + offset, screenX*(st_offsets[1]+0.45), screenY, color, textSize, textSize, "bankgothic", "right")
			offset = offset + (box_height / 12)
		end
	elseif statsPage == 3 then -- All Golds Records
		dxDrawText("All Golds", screenX*(st_offsets[1]+0.005), screenY*(st_offsets[2]+0.003), screenX, screenY, tocolor(0, 0, 0, statsAlpha), st_offsets[5]*4.02, st_offsets[5]*4.15, "beckett")
		dxDrawText("All Golds", screenX*st_offsets[1], screenY*st_offsets[2], screenX*st_offsets[1], screenY, tocolor(175, 202, 230, statsAlpha), st_offsets[5]*4, st_offsets[5]*4, "beckett")
		
		local box_height = (screenY*s_offsets[4]) * 0.9
		local textSize = box_height / 75 / (12 / 2)
		local offset = box_height / 12

		-- Draw stats
		for i = 1, 11 do
			local color
			if displayedGolds[i]["playername"]:gsub("#%x%x%x%x%x%x", "") == getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", "") then
				color = tocolor(0, 200, 200, statsAlpha)
			else
				color = tocolor(175, 202, 230, statsAlpha)
			end
			
			if i == 11 and displayedGolds[11]["id"] ~= nil then
				dxDrawText(displayedGolds[11]["id"].. ".", screenX*st_offsets[1], screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1]*1.105, screenY, color, textSize, textSize, "bankgothic", "right")
			else
				dxDrawText(i.. ".", screenX*st_offsets[1], screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1]*1.105, screenY, color, textSize, textSize, "bankgothic", "right")
			end
			
			dxDrawText(tostring(displayedGolds[i]["playername"]):gsub("#%x%x%x%x%x%x", ""), screenX*(st_offsets[1]*1.12), screenY*(st_offsets[2]+0.07) + offset, screenX*st_offsets[1], screenY, color, textSize, textSize, "bankgothic")
			dxDrawText(convertToRaceTime(displayedGolds[i]["time"]), screenX*(st_offsets[1]+0.03), screenY*(st_offsets[2]+0.07) + offset, screenX*(st_offsets[1]+0.45), screenY, color, textSize, textSize, "bankgothic", "right")
			offset = offset + (box_height / 12)
		end
	end
	
	if displayStats then
		dxDrawImage((screenX*s_offsets[1])+(screenX*s_offsets[3])-(screenX/22), (screenY*b_offsets[2])-(screenY*i_size[2]/2)-(screenX/60), screenX/30, screenX/60, arrowTexture, 0, 0, 0, tocolor(255, 255, 255, statsAlpha))
	end
end

-- Function that convers time in ms into string in format "MM:SS.MS"
function convertToRaceTime(time)
	if time ~= nil then
		local m = math.floor(time / 1000 / 60)
		local s = math.floor((time / 1000) - m*60)
		local ms = math.floor(time - (m*60+s)*1000)
		
		if m < 1 then m = ""
		else m = m.. ":" end
		if s < 10 then s = "0" ..s end
		if ms < 10 then ms = "00" ..ms
		elseif ms < 100 and ms > 9 then ms = "0" ..ms end
		
		return m.. "" ..s.. "." ..ms
	end
end

-- Function that convers time in ms into string in format "HH:MM"
function convertToPlayingTime(time)
	if time ~= nil then
		local h = math.floor(time / 3600000)
		local m = math.floor((time - h*60*60*1000) / 60000)
		local s = math.floor(((time - h*60*60*1000) / 1000) - m*60)
		
		if h < 1 then h = ""
		else h = h.. ":" end
		if m < 10 and h ~= "" then m = "0" ..m end
		if s < 10 then s = "0" ..s end
		
		return h.. "" ..m.. ":" ..s
	end
end

-- Function that triggers actual race gamemode checkpoints
function triggerRaceCheckpoint()
	if not getPedOccupiedVehicle(localPlayer) then return end
	playerVehicle = getPedOccupiedVehicle(localPlayer)
	
	local posX, posY, posZ = getElementPosition(playerVehicle)
	local velX, velY, velZ = getElementVelocity(playerVehicle)
	
	-- trigger the actual "race" checkpoint
	setElementPosition(playerVehicle, (getElementData(localPlayer, "race.checkpoint")-2)*1000.0, 5000.0, 100.0)

	-- return original position and velocity of player's vehicle
	setElementPosition(playerVehicle, posX, posY, posZ)
	setElementVelocity(playerVehicle, velX, velY, velZ)
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	setTimer(update, 20, 0)
	oneSecondTimer = setTimer(oneSecondUpdates, 1000, 0)
	setElementData(localPlayer, "carid", 411)
	setElementData(localPlayer, "level", 0)
	setElementData(localPlayer, "trigger", 2)
	setElementData(localPlayer, "dim", 0)
	setElementData(localPlayer, "logged", 0)
	setCameraMatrix(-1991.2, -77, 78.3, -2037.6, -132.60001, 35.6)
	setTexts()
	fadeCamera(false)
end )

addEventHandler("onClientResourceStop", resourceRoot, function()
	-- Unload Level's Materials
	if isElement(triggerCol) then destroyElement(triggerCol) end
	if isElement(triggerCol2) then destroyElement(triggerCol2) end
	if isElement(limitCol) then destroyElement(limitCol) end
	if isElement(finishMarker) then destroyElement(finishMarker) end
	if isElement(blip) then destroyElement(blip) end
	if isElement(levelObject) then destroyElement(levelObject) end
	if isElement(levelVehicle[1]) then destroyElement(levelVehicle[1]) end
	if isElement(levelVehicle[2]) then destroyElement(levelVehicle[2]) end
	
	-- Unload Level's Cones
	if maxCones[level] ~= 0 then
		for i = 1, maxCones[level] do
			if isElement(trafficCones[i]) then destroyElement(trafficCones[i]) end
		end
	end
	
	if isTimer(startLevelTimer) then killTimer(startLevelTimer) end
	if isTimer(displayHelpTextTimer) then killTimer(displayHelpTextTimer) end
	if isTimer(alleyOopTimer) then killTimer(alleyOopTimer) end
end )

-- Event used to getting the objectives in the tests
addEventHandler("onClientColShapeHit", getRootElement(), function(theElement, matchingDimension)
	if theElement ~= localPlayer or isLocalPlayerSpectating() then return end
	
	if level ~= 5 and level ~= 8 and source == triggerCol then
		levelObj = 1
		
		if level == 4 then
			setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), -1, -1, -1, 1)
		end
	elseif level == 5 then -- Burn and lap
		if (levelObj % 2 == 0 and source == triggerCol) or (levelObj % 2 ~= 0 and source == triggerCol2) then
			levelObj = levelObj + 1
		end	
	elseif level == 8 then --Wheelie
		if not isVehicleWheelOnGround(getPedOccupiedVehicle(localPlayer), "front_left") and not isVehicleWheelOnGround(getPedOccupiedVehicle(localPlayer), "rear_left") then
			levelObj = 1
		else pauseLevel() end
	end
end )

-- Event used to display all custom overlays and manages custom ghostmode
addEventHandler("onClientRender", getRootElement(), function()
	-- Disable collisions for other players and hide them
	for _, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) and players ~= localPlayer and getPedOccupiedVehicle(localPlayer) then
			setElementCollidableWith(getPedOccupiedVehicle(localPlayer), getPedOccupiedVehicle(players), false)
			setElementCollidableWith(localPlayer, players, false)
			
			for _, players2 in ipairs(getElementsByType("player")) do
				if getPedOccupiedVehicle(players) and players ~= players2 and getPedOccupiedVehicle(players2) then
					setElementCollidableWith(getPedOccupiedVehicle(players2), getPedOccupiedVehicle(players), false)
					setElementCollidableWith(players2, players, false)
				end
			end
			
			if isLocalPlayerSpectating() then
				local target = getCameraTarget()
				if target then
					if getElementType(target) == "vehicle" then
						setElementAlpha(target, 255)
						setElementAlpha(getVehicleController(target), 255)
						
						setElementDimension(getPedOccupiedVehicle(players), getElementDimension(localPlayer))
						setElementDimension(players, getElementDimension(localPlayer))
					end
				end
			else
				if getElementData(players, "level") == level and not fadeIsHappening then
					-- Other player at the same level
					setElementAlpha(getPedOccupiedVehicle(players), 170)
					setElementAlpha(players, 170)
					
					-- P.I.T fixes
					if level ~= 10 then
						setElementDimension(getPedOccupiedVehicle(players), getElementDimension(localPlayer))
						setElementDimension(players, getElementDimension(localPlayer))
					end
				else
					-- Hide other player
					setElementDimension(getPedOccupiedVehicle(players), HIDE_DIMENSION)
					setElementDimension(players, HIDE_DIMENSION)
				end
			end
		end
	end
	
	if getPedOccupiedVehicle(localPlayer) then
		setElementAlpha(getPedOccupiedVehicle(localPlayer), 255)
		setElementAlpha(localPlayer, 255)
	end
	
	if not showLevelResults and displayStats then
		-- Fade In
		if statsAlpha < 255 then statsAlpha = statsAlpha + 51
		else statsAlpha = 255 end
	else
		-- Fade out
		if statsAlpha > 0 then statsAlpha = statsAlpha - 51
		else statsAlpha = 0 end
	end
	
	-- Draw Stats
	if statsAlpha > 200 then
		dxDrawRectangle(screenX*s_offsets[1], screenY*s_offsets[2], screenX*s_offsets[3], screenY*s_offsets[4], tocolor(0, 0, 0, 200, 50))
	else
		dxDrawRectangle(screenX*s_offsets[1], screenY*s_offsets[2], screenX*s_offsets[3], screenY*s_offsets[4], tocolor(0, 0, 0, statsAlpha, 50))
	end
	drawStats()
	
	if isLocalPlayerSpectating() or schoolFinished then return end
		
	if showLevelResults or not levelLoaded or schoolFinished then
		toggleControl("accelerate", false)
		toggleControl("brake_reverse", false)
	end
	
	if getElementData(localPlayer, "trigger") ~= 2 then
		setCameraMatrix(-1991.2, -77, 78.3, -2037.6, -132.60001, 35.6)
		if getPedOccupiedVehicle(localPlayer) then
			setElementPosition(getPedOccupiedVehicle(localPlayer), -2050.6, -130.0, 35.036)
		end
		
		-- Cleanup
		for index, objs in ipairs(getElementsByType("object")) do
			destroyElement(objs)
		end
		
		levelMedal = 0
		levelUnlocked = 1
		levelObj = 0
		playersTimer = 0

		-- States 
		levelLoaded = false
		carStartedToMove = false
		timerPaused = true
		displayHelpText = false
		newRecord = false
		schoolFinished = false

		-- Stats 
		totalConesBroken = 0
		citySlickingTime = 0
		burnAndLapTime = 0
		testAttempts = 0

		-- Level Results
		results = {0.0, 0.0, 0.0, 0.0}
		levelRecords = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
		levelMedals  = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	end
	
	-- Draw Level Timer
	if playersTimer ~= nil then
		local m = math.floor(playersTimer / 60)
		local s = playersTimer - m*60
		
		if m < 0 then 
			s = 0
			m = 0
		end
		
		if not timerPaused then
			--dxDrawBorderedText(2,"TIME", screenX * offsets[1], screenY * 0.22, screenX, screenY, tocolor(225, 225, 225, 255), 1, "bankgothic")
			if s < 10 then dxDrawBorderedText(2, m.. ":0" ..s, screenX * offsets[2], screenY * 0.22, screenX, screenY, tocolor(225, 225, 225, 255), 1, "bankgothic")	
			else dxDrawBorderedText(2, m.. ":" ..s, screenX * offsets[2], screenY * 0.22, screenX, screenY, tocolor(225, 225, 225, 255), 1, "bankgothic") end
			
			-- Level's Specific Texts
			if level == 5 then
				if (math.floor(levelObj/2)+1) < 5 then
					dxDrawBorderedText(2, "Lap " ..(math.floor(levelObj/2)+1).. " of 5", 0, 0, screenX, screenY*0.83, tocolor(225, 225, 225, 255), 1.2, "bankgothic", "center", "bottom")
				else
					dxDrawBorderedText(2, "Final Lap", 0, 0, screenX, screenY*0.83, tocolor(225, 225, 225, 255), 1.2, "bankgothic", "center", "bottom")
				end
			end
		end
	end
	
	-- Draw Level Help Text
	if displayHelpText and levelLoaded then
		dxDrawBorderedText(2, levelTexts[level], 0, 0, screenX*1.1, screenY*0.98, tocolor (240, 240, 240, 255), messageSize, "bankgothic", "center", "bottom", true, false)
	end
	
	if timerPaused and isControlEnabled("accelerate") and levelLoaded and not carStartedToMove and not displayStats then
		local index = 0
		if level == 1 then index = 1	
		elseif level == 9 then index = 2
		elseif level ~= 1 and level ~= 9 then index = 3 end
		
		dxDrawBorderedText(1, levelTexts2[index], 0, 0, screenX, screenY*0.8, tocolor (145, 103, 21, 255), messageSize+0.5, "bankgothic", "center", "center", true, false)
	end
	
	-- Draw Award Text
	if showLevelResults then
		if newTestAvailable and levelMedal ~= 0 then
			dxDrawBorderedText(1, "new certificate awarded", 0, 0, screenX, screenY*0.25, tocolor (145, 103, 21, 255), textSize, "pricedown", "center", "center", true, false)
			
			local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
			cameraAngle = cameraAngle + 1.0
			if cameraAngle > 360.0 then cameraAngle = 0.0 end
			setCameraMatrix((math.sin(math.rad(cameraAngle)) * 7) + x + 2.5, (math.cos(math.rad(cameraAngle)) * 7) + y - 0.3, z + 1.9, x, y, z)
		elseif not schoolFinished then
			if oldCamera[1] == 0 then
				oldCamera[1], oldCamera[2], oldCamera[3], oldCamera[4], oldCamera[5], oldCamera[6], oldCamera[7], oldCamera[8] = getCameraMatrix()
			end
			setCameraMatrix(oldCamera[1], oldCamera[2], oldCamera[3], oldCamera[4], oldCamera[5], oldCamera[6])
		end
		
		if newRecord then
			dxDrawBorderedText(1, "new record", 0, 0, screenX, screenY*0.4, tocolor (225, 225, 225, 255), textSize, "pricedown", "center", "center", true, false)
		end
		
		-- Fade In
		if drawAlpha < 255 then drawAlpha = drawAlpha + 51	
		else drawAlpha = 255 end
	else
		-- Fade out
		if drawAlpha > 0 then drawAlpha = drawAlpha - 51
		else drawAlpha = 0 end
	end
	
	-- Draw Level Results
	if drawAlpha > 200 then
		dxDrawRectangle(screenX*b_offsets[1], screenY*b_offsets[2], screenX*b_offsets[3], screenY*b_offsets[4], tocolor(0, 0, 0, 200, 50))
	else
		dxDrawRectangle(screenX*b_offsets[1], screenY*b_offsets[2], screenX*b_offsets[3], screenY*b_offsets[4], tocolor(0, 0, 0, drawAlpha, 50))
	end
	
	if level == 12 or level == 5 then 
		dxDrawText("OVERALL TIME:", screenX*t_offsets[1], screenY*t_offsets[2], screenX*t_offsets[1], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText("FINAL TIME:", screenX*t_offsets[1], screenY*(t_offsets[2]+0.03), screenX*t_offsets[1], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText("DAMAGE PENALTY:", screenX*t_offsets[1], screenY*(t_offsets[2]+0.06), screenX*t_offsets[1], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText("OVERALL SCORE:", screenX*t_offsets[1], screenY*(t_offsets[2]+0.09), screenX*t_offsets[1], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
	else
		dxDrawText("FINAL HEADING:", screenX*t_offsets[1], screenY*t_offsets[2], screenX*t_offsets[1], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText("FINAL POSITION:", screenX*t_offsets[1], screenY*(t_offsets[2]+0.03), screenX*t_offsets[1], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText("DAMAGE PENALTY:", screenX*t_offsets[1], screenY*(t_offsets[2]+0.06), screenX*t_offsets[1], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText("OVERALL SCORE:", screenX*t_offsets[1], screenY*(t_offsets[2]+0.09), screenX*t_offsets[1], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
	end
	
	if level ~= 5 and level ~= 12 then dxDrawText(results[1].. "%", screenX*t_offsets[3], screenY*t_offsets[2], screenX*t_offsets[3], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
	else dxDrawText(results[1], screenX*t_offsets[3], screenY*t_offsets[2], screenX*t_offsets[3], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic") end 
	
	dxDrawText(results[2].. "%", screenX*t_offsets[3], screenY*(t_offsets[2]+0.03), screenX*t_offsets[3], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
	dxDrawText(results[3].. "%", screenX*t_offsets[3], screenY*(t_offsets[2]+0.06), screenX*t_offsets[3], screenY, tocolor(164, 55, 46, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
	dxDrawText(results[4].. "%", screenX*t_offsets[3], screenY*(t_offsets[2]+0.09), screenX*t_offsets[3], screenY, tocolor(175, 202, 230, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
	
	if newTestAvailable and level ~= MAX_LEVEL then 
		dxDrawText("NEW TEST AVAILABLE", screenX*t_offsets[1], screenY*(t_offsets[2]+0.15), screenX*t_offsets[1], screenY, tocolor(215, 215, 215, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText("CONTINUE", screenX*t_offsets[1], screenY*(t_offsets[2]+0.18), screenX*t_offsets[1], screenY, tocolor(144, 98, 19, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText(string.upper(boxTexts[1]), screenX*t_offsets[2], screenY*(t_offsets[2]+0.18), screenX*t_offsets[1], screenY, tocolor(144, 98, 19, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		
		dxDrawText("REPEAT", screenX*t_offsets[1], screenY*(t_offsets[2]+0.21), screenX*t_offsets[1], screenY, tocolor(144, 98, 19, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText(string.upper(boxTexts[2]), screenX*t_offsets[2], screenY*(t_offsets[2]+0.21), screenX*t_offsets[1], screenY, tocolor(144, 98, 19, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
	elseif not newTestAvailable then
		dxDrawText("REPEAT", screenX*t_offsets[1], screenY*(t_offsets[2]+0.21), screenX*t_offsets[1], screenY, tocolor(144, 98, 19, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText(string.upper(boxTexts[1]), screenX*t_offsets[2], screenY*(t_offsets[2]+0.21), screenX*t_offsets[1], screenY, tocolor(144, 98, 19, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
	elseif newTestAvailable and level == MAX_LEVEL then
		dxDrawText("FINISH", screenX*t_offsets[1], screenY*(t_offsets[2]+0.18), screenX*t_offsets[1], screenY, tocolor(144, 98, 19, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText(string.upper(boxTexts[1]), screenX*t_offsets[2], screenY*(t_offsets[2]+0.18), screenX*t_offsets[1], screenY, tocolor(144, 98, 19, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		
		dxDrawText("REPEAT", screenX*t_offsets[1], screenY*(t_offsets[2]+0.21), screenX*t_offsets[1], screenY, tocolor(144, 98, 19, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
		dxDrawText(string.upper(boxTexts[2]), screenX*t_offsets[2], screenY*(t_offsets[2]+0.21), screenX*t_offsets[1], screenY, tocolor(144, 98, 19, drawAlpha), t_offsets[4], t_offsets[4]*0.5, "bankgothic")
	end
	
	if levelMedal ~= 0 then
		dxDrawImage((screenX/2)-(screenX*i_size[1]/2), (screenY*b_offsets[2])-(screenY*i_size[2]/2), screenX*i_size[1], screenY*i_size[2], medalTexture[levelMedal], 0, 0, 0, tocolor(255, 255, 255, drawAlpha))
	end
end )

-- Event used to manage player inputs when stats displayed
addEventHandler("onClientKey", root, function(button, press) 
	if isChatBoxInputActive() then return end
	
	if press and displayStats then
		if button == "arrow_r" then
			if statsPage == 3 then statsPage = 0
			else statsPage = statsPage + 1 end
		elseif button == "arrow_l" then
			if statsPage == 0 then statsPage = 3
			else statsPage = statsPage - 1 end
		end
	end
	if isLocalPlayerSpectating() or schoolFinished then return end
	
	if press and showLevelResults then
		if button == boxTexts[1] then
			finishLevel()
			
			if isElement(theme) then stopSound(theme) end
				
			if newTestAvailable and level ~= MAX_LEVEL then 
				level = level + 1
				triggerRaceCheckpoint()
			elseif newTestAvailable and level == MAX_LEVEL then
				-- Finish race
				local data = {}
				
				data["golds"] = 0
				data["silvers"] = 0 
				data["bronzes"] = 0
				
				for i = 1, MAX_LEVEL do
					if levelMedals[i] == 3 then
						data["golds"] = data["golds"] + 1
					elseif levelMedals[i] == 2 then
						data["silvers"] = data["silvers"] + 1
					elseif levelMedals[i] == 1 then
						data["bronzes"] = data["bronzes"] + 1
					end
				end
				
				data["cones"] = totalConesBroken
				data["attempts"] = testAttempts
				
				triggerServerEvent("setPlayerFinish", getLocalPlayer(), data)
				triggerRaceCheckpoint()
				
				schoolFinished = true
				
				showStats()
				displayStats = true
				if isElement(theme) then stopSound(theme) end
			end
			showLevelResults = false
			
		elseif button == boxTexts[2] then
			finishLevel()
			showLevelResults = false
			if isElement(theme) then stopSound(theme) end
		end
	end
	
	--[[for keyName, state in pairs(getBoundKeys("handbrake")) do
		if button == keyName and level == 7 then
			if press and levelObj == 0 then levelObj = 1
			elseif not press and levelObj == 1 then levelObj = 0 end
		end
	end]]--
end )

-- Event used to start a level when player dies or respawns after spectating
addEventHandler("onClientPlayerSpawn", getLocalPlayer(), function()
	if debug then outputDebugString("spawn") end

	if getElementData(localPlayer, "race.checkpoint") ~= nil then
		showLevelResults = false
		finishLevel()
		
		if getElementData(localPlayer, "race.checkpoint") ~= nil and getElementData(localPlayer, "race.checkpoint") ~= false then
			if getElementData(localPlayer, "race.checkpoint") < level then
				level = getElementData(localPlayer, "race.checkpoint")
				setElementData(localPlayer, "level", level)
			end
		end
	end
end )

-- Event used only in PIT test for stopping chase car after 1 second
addEventHandler("onClientVehicleCollision", root, function(hit)
	if source == getPedOccupiedVehicle(localPlayer) and hit ~= nil and level == 10 then
		if getElementType(hit) == "vehicle" and hit == policeCar then
			--setPedAnalogControlState(policePed, "accelerate", 0) 
			setTimer(function() if isElement(policePed) then setPedControlState(policePed, "handbrake", true) end end, 1000, 1)
		end
	end
end )

-- Event used for custom ghostmode
addEventHandler("onClientElementDimensionChange", localPlayer, function(old, new)
	if new == DEFAULT_DIMENSION then
		setElementData(localPlayer, 'race.collideothers', 0)
		if getPedOccupiedVehicle(localPlayer) then
			setElementData(getPedOccupiedVehicle(localPlayer), 'race.collideothers', 0)
		
			for _, players in ipairs(getElementsByType("player")) do
				if getPedOccupiedVehicle(players) and players ~= localPlayer and getPedOccupiedVehicle(localPlayer) then
					setElementCollidableWith(localPlayer, players, false)
					setElementCollidableWith(getPedOccupiedVehicle(localPlayer), getPedOccupiedVehicle(players), false)
				end
			end
			
			if isTimer(miscTimer) then killTimer(miscTimer) end
			miscTimer = setTimer(function() 
				setElementData(getPedOccupiedVehicle(localPlayer), 'race.collideothers', 1) 
				setElementData(localPlayer, 'race.collideothers', 1) 
			end, 3000, 1)
		end
	end
end )

-- Event called from the server script for receiving stats data
addEvent("receiveStats", true)
addEventHandler("receiveStats", getRootElement(), function(playerStats, AllGoldsStats, MiscStats, BurnAndLapStats, CitySlickingStats, PBBurnStats, PBCityStats, GoldStats)	
	-- Handle Players Stats
	for i, statsData in pairs(playerStats) do 
		displayedStats["playername"] = statsData["playername"]
		displayedStats["cones"] = statsData["cones"]
		displayedStats["passed"] = statsData["passed"]
		displayedStats["attempts"] = statsData["attempts"]
		displayedStats["won"] = statsData["won"]
		displayedStats["playing"] = statsData["playing"]
		displayedStats["golds"] = statsData["golds"]
		displayedStats["silvers"] = statsData["silvers"]
		displayedStats["bronzes"] = statsData["bronzes"]
	end
	
	for i, PBBurnData in pairs(PBBurnStats) do 
		displayedStats["burn"] = PBBurnData["score"]
	end
	if #PBBurnStats < 1 then displayedStats["burn"] = 0 end
		
	for i, PBCityData in pairs(PBCityStats) do 
		displayedStats["city"] = PBCityData["score"]
	end
	if #PBCityStats < 1 then displayedStats["city"] = 0 end
	
	for i, GoldData in pairs(GoldStats) do 
		displayedStats["goldPB"] = GoldData["score"]
	end
	if #GoldStats < 1 then displayedStats["goldPB"] = 0 end
	
	-- Handle All Golds Stats
	for i, AllGoldsData in pairs(AllGoldsStats) do 
		displayedGolds[i]["playername"] = AllGoldsData["playername"]
		displayedGolds[i]["time"] = AllGoldsData["score"]
	end
	
	if #AllGoldsStats < 11 then
		for i = #AllGoldsStats + 1, 11 do
			displayedGolds[i]["playername"] = "-- EMPTY --"
			displayedGolds[i]["time"] = 0
		end
	end
	
	-- Handle Burn and Lap Stats
	for i, BurnAndLapData in pairs(BurnAndLapStats) do 
		displayedBurn[i]["playername"] = BurnAndLapData["playername"]
		displayedBurn[i]["time"] = BurnAndLapData["score"]
	end
	
	if #BurnAndLapStats < 11 then
		for i = #BurnAndLapStats + 1, 11 do
			displayedBurn[i]["playername"] = "-- EMPTY --"
			displayedBurn[i]["time"] = 0
		end
	end
	
	-- Handle City Slicking Stats
	for i, CitySlickingData in pairs(CitySlickingStats) do 
		displayedCity[i]["playername"] = CitySlickingData["playername"]
		displayedCity[i]["time"] = CitySlickingData["score"]
	end
	
	if #CitySlickingStats < 11 then
		for i = #CitySlickingStats + 1, 11 do
			displayedCity[i]["playername"] = "-- EMPTY --"
			displayedCity[i]["time"] = 0
		end
	end
	
	-- Handle Misc Stats
	for i, miscData in pairs(MiscStats) do 
		displayedStats["conesall"] = miscData["cones"]
		displayedStats["playedall"] = miscData["played"]
	end
	
	if #MiscStats < 1 then
		displayedStats["conesall"] = 0
		displayedStats["playedall"] = 0
	end
	
	statsInited = true
end )

-- Utils
local WORLD_DOWN = {0, 0, -1} 
local UPSIDE_DOWN_THRESHOLD = math.cos(math.rad(80))
  
function isVehicleUpsideDown(vehicle) 
    local matrix = getElementMatrix(vehicle) 
    local vehicleUp = {matrix_rotate (matrix, 0, 0, 1)} 
    local dotP = math.dotP (vehicleUp, WORLD_DOWN) 
    return (dotP >= UPSIDE_DOWN_THRESHOLD) 
end

function matrix_rotate(matrix, x, y, z) 
    local tx = x * matrix[1][1] + y * matrix[2][1] + z * matrix[3][1]   
    local ty = x * matrix[1][2] + y * matrix[2][2] + z * matrix[3][2]   
    local tz = x * matrix[1][3] + y * matrix[2][3] + z * matrix[3][3]   
    return tx, ty, tz 
end
  
function math.dotP(v1, v2) 
    return v1[1]*v2[1] + v1[2]*v2[2] + v1[3]*v2[3] 
end

function dxDrawBorderedText(outline, text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    if type(scaleY) == "string" then
        scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY = scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX
    end
    local outlineX = (scaleX or 1) * (1.333333333333334 * (outline or 1))
    local outlineY = (scaleY or 1) * (1.333333333333334 * (outline or 1))
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top - outlineY, right - outlineX, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top - outlineY, right + outlineX, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top + outlineY, right - outlineX, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top + outlineY, right + outlineX, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top, right - outlineX, bottom, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top, right + outlineX, bottom, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top - outlineY, right, bottom - outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top + outlineY, right, bottom + outlineY, tocolor (0, 0, 0, 225), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end
