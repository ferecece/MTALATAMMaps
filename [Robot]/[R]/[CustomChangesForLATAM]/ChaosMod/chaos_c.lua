DEBUG = false

-- Timers
updateTimer = nil
secondTimer = nil
cleanTimer = nil
effectSpeed = 1
chatVoting = false
ongoingVoting = true
chaosState = 0
boxPosY = 0
forceVotingOptions = false
		
-- Screen stuff
screenX, screenY = guiGetScreenSize()
screenAspect = math.floor((screenX / screenY)*10)/10

-- Chaos Timer
timerRunning = false
timer = 100 -- %
chaosTimer = nil
timerDecr = 0.3

local UIcolors = {
	{20, 112, 53}, -- inside
	{45, 255, 122} -- progress
}

-- Effects states
activeEffects = {}
passiveEffects = {}
activeTimers = {}
effectSound = nil

-- Special effects
blindMode = false
portraitMode = false
dvdMode = false
tunnelMode = false
unlimitedHealth = false
blackVehicles = false
pinkVehicles = false
randomTirePopping = false
randomTire = 0
randomPoppingTimer = nil
invisibleVehicles = false
mouseControl = false
beyblade = false
arcadeCamera = false
topCamera = false
lowResGaming = false
mirrored = false
disabledKey = 0
disabledB = false
noBrakes = false
pedalMedal = false
forceCamera = nil
oldFOV = nil
oldPos = {0, 0, 0, 0, 0, 0}
goodBye = false
respawnDisabled = false
alwaysHONK = false
randomMassEnabled = false
randomMass = nil
engineDisabled = false
rearWheels = false
changedWheelModel = nil
rampObj = nil
mirroredControls = false
mirroredControlsFix = false
jumpingAllowed = false
disableUI = false
floatingPoint = false
honkBoost = false
enableRockets = false
swingingDoors = false
pressWrando = false
bitSteer = false
carAngle = 0
hydraulicsAssistance = false
flyingCamera = false
cameraAngle = 0
shufflePaintjobs = false
rotatory = false
randoBlips = false
halfSteering = false
tilted = false
tiltedRot = 40
tiltedRotation = false
flippedScreen = false
holdTab = false
banSidewalks = false
unflippable = false
drivingMouse = false
steerBiasLeft = false
steerBiasRight = false
WTF = nil
WTFAlpha = 0
underwater = false
halfFrames = true
halfFrame = 0
information = false
firstGear = false
ghostVehicles = false
playerEffect = false
tippingPoint = false
insaneHandling = false
strongBrakes = false
local blackWhiteShader
alarmy = false
gearDisplay = false
vicecityFont = false
CPColor = {nil, nil, nil}
CPType = nil
tinyScreen = false
bottomCamera = false
shader = nil

-- Information
informationText = {}

-- Fake Teleport
storedPos = {0, 0, 0}
storedRot = {0, 0, 0}
storedVel = {0, 0, 0}

-- Effects
effects = {
	{ "Double Gravity", 10, "gravity"}, -- 1 
	{ "Half Gravity", 10, "gravity"},
	{ "Insane Gravity", 5, "gravity"},
	{ "Inverted Gravity", 3, "gravity"},
	{ "Quadruple Gravity", 5, "gravity"},
	{ "Moon Gravity", 10, "gravity"},
	{ "Zero Gravity", 3, "gravity"},
	{ "Woozie Mode", 5, "vision"},
	{ "Disable Radar", 20},
	{ "Portrait Mode", 20, "vision"}, -- 10
	{ "Nothing", 10},
	{ "Tunnel Vision", 10, "vision"},
	{ "Foggy Weather", nil},
	{ "Overcast Weather", nil},
	{ "Rainy Weather", nil}, -- 15
	{ "Sandstorm", nil},
	{ "Sunny Weather", nil},
	{ "Very Sunny Weather", nil},
	{ "Take Damage", nil},
	{ "HESOYAM", nil}, -- 20
	{ "Invincible", 30, "vehicle health"},
	{ "All Cars Have Nitro", nil},
	{ "Black Vehicles", 60, "vehicle color"},
	{ "Pink Vehicles", 60, "vehicle color"},
	{ "Cars Fly", 20}, -- 25
	{ "Cars On Water", 20},
	{ "Remove Pizzas", nil},
	{ "0.25x Game Speed", 10, "game speed"}, -- 28
	{ "0.5x Game Speed", 10, "game speed"},
	{ "2x Game Speed", 10, "game speed"},
	{ "4x Game Speed", 10, "game speed"},
	{ "Always Evening", 60, "time"},
	{ "Always Midnight", 60, "time"},
	{ "Timelapse", 60, "time"}, -- 34
	{ "DE Experience", 60}, -- 35
	{ "Can't See Shit", 20},
	{ "Rain", 30},
	{ "Random Explosion", nil},
	{ "Wheels Only Please", 60},
	{ "Shutdown Engine", 10}, -- 40
	{ "Disable Respawns", 30},
	{ "Teleport To Grove Street", 3},
	{ "Random Vehicle Mass", 30},
	{ "Rear Wheels Steering", 20},
	{ "Monster Truck'ed", 30, "vehicle spawn"}, -- 45
	{ "Spawn A Ramp", 3},
	{ "Mirrored Controls", 30},
	{ "Teleport", 3}, -- 48
	{ "Random Teleport", 3},
	{ "Spawn Bloodring Banger", nil, "vehicle spawn"}, -- 50
	{ "Spawn Caddy", nil, "vehicle spawn"},
	{ "Spawn Dozer", nil, "vehicle spawn"},
	{ "Spawn Hunter", nil, "vehicle spawn"},
	{ "Spawn Hydra", nil, "vehicle spawn"},
	{ "Spawn Monster Truck", nil, "vehicle spawn"},
	{ "Spawn Quad", nil, "vehicle spawn"},
	{ "Spawn Hotring Racer", nil, "vehicle spawn"},
	{ "Spawn Hotring Racer", nil, "vehicle spawn"},
	{ "Spawn Rancher", nil, "vehicle spawn"},
	{ "Spawn Rhino", nil, "vehicle spawn"},
	{ "Spawn Romero", nil, "vehicle spawn"},
	{ "Spawn Stretch", nil, "vehicle spawn"},
	{ "Spawn Stunt Plane", nil, "vehicle spawn"},
	{ "Spawn Tanker", nil, "vehicle spawn"},
	{ "Spawn Trashmaster", nil, "vehicle spawn"},
	{ "Spawn Vortex", nil, "vehicle spawn"},
	{ "Random Vehicle", nil, "vehicle spawn"},
	{ "Drive-By Aiming", 10},
	{ "Huge Bunny Hop", 20},
	{ "Vehicle OHKO", 20, "vehicle health"}, -- 70
	{ "Vehicle Boost", nil},
	{ "Turn Around", nil},
	{ "Spaaaace", nil},
	{ "Pop All Tires", 5},
	{ "Remove Random Tire", 10}, -- 75
	{ "Random Tire Removing", 20},
	{ "Invert Vehicle Speed", nil},	
	{ "Ignite Current Vehicle", nil},	
	{ "HONK", 60, "honk"},	
	{ "Invisible Vehicles", 20}, -- 80
	{ "Ghost Rider", 60},
	{ "Mouse Control", 20, "control"},
	{ "Clear Active Effects", nil},	
	{ "Beyblade", 5},	
	{ "Weird Camera", 10, "camera"}, -- 85
	{ "Add Random Blip", nil},	
	{ "Top Camera", 15, "camera"},	
	{ "Low Res Gaming", 20, "screen"},
	{ "Mirrored World", 20, "screen"},	
	{ "Disable One Movement Key", 30},	-- 90
	{ "Look Back", 10},
	{ "Disable B", 60},
	{ "Oh The Brakes Is Out", 30},
	{ "Pedal To The Medal", 30},
	{ "Vehicle Bumper Camera", 20, "camera"},
	{ "Cinematic Camera", 20, "camera"},
	{ "Reset Camera", nil, "camera"},
	{ "Death 1%", nil},
	{ "Death 69%", nil},
	{ "Drunk Mode", 20}, -- 100
	{ "Night Vision", 10, "special vision"},
	{ "Thermal Vision", 10, "special vision"},
	{ "Random FOV", 15, "fov"},
	{ "High FOV", 15, "fov"},
	{ "Low FOV", 15, "fov"},
	{ "Goodbye!", 5},
	{ "Pizza Time", nil},
	{ "Randomize Moon Size", nil},
	{ "Stop", nil},
	{ "Randomize Wind Velocity", nil}, -- 110
	{ "Jumping Allowed", 30},
	{ "Win Race 1%", nil},
	{ "Hydraulics", nil},
	{ "Disable Chaos UI", 60},
	{ "Explode Random Player", nil},
	{ "Shuffle Players", nil},
	{ "Last To First, First to Last", nil},
	{ "All Vehicle Upgrades", nil},
	{ "Spawn Tree", nil},
	{ "Delete All Custom Trees", nil}, -- 120
	{ "Floating Point Inaccuracy", 30},
	{ "Honk Boost", 30},
	{ "Enable Rockets", 20},
	{ "Swinging Doors", 60},
	{ "Add Annoying Blips", nil},
	{ "Rapid-Fire", nil},
	{ "Press W Randomizer", 30},
	{ "Random Skin", nil},
	{ "Smooth Criminal", 30},
	{ "8-Bit Steering", 30, "control"}, -- 130
	{ "Pimping Ain't Easy", nil},
	{ "Hydraulics Assistance", 30},
	{ "Flying Camera", 10, "camera"}, 
	{ "Freeze Vehicle", 5},
	{ "meowbot", 60 }, -- 135
	{ "Next Map Please!", nil},
	{ "Double B", nil},
	{ "Fail Timer", 60}, 
	{ "Disable Horn", 30},
	{ "Everybody Love Randomizers", 30}, -- 140
	{ "Shuffle Paintjobs", 60},
	{ "Rotatory Vehicles", 30},
	{ "Spam Chat", nil},
	{ "Spawn Heatseeking Rockets", nil},
	{ "No Tasks Allowed", 5},
	{ "Randomize Blips", 150},
	{ "Spawn Blista Compact", nil, "vehicle spawn"},
	{ "Spawn Faggio", nil, "vehicle spawn"},
	{ "Spawn Feltzer", nil, "vehicle spawn"},
	{ "Spawn Betsy", nil, "vehicle spawn"}, -- 150
	{ "Half Steering", 15},
	{ "No Water", 60, "water"},
	{ "Tilted Camera", 20, "screen"},
	{ "Flipped Screen", 20, "screen"},
	{ "Rotation", 30, "screen"}, -- 155
	{ "Scoreboard?", 60},
	{ "Underwater", 60, "water"}, 
	{ "Flood", 20, "water"},
	{ "Sidewalks Prohibition", 45},
	{ "Unflippable Vehicles", 30}, -- 160
	{ "Snow", 150, "world"},
	{ "Mouse Steering", 30},
	{ "Steer Bias Left", 30},
	{ "Steer Bias Right", 30},
	{ "WTF", 150}, -- 165
	{ "Detach All Parts", nil},
	{ "Australia Mode", nil},
	{ "Powerpoint Presentation", 15, "screen"},
	{ "60 FPS Physics", 60, "screen"},
	{ "Random Chaos UI Colors", nil}, -- 170
	{ "Shake Camera", 5},
	{ "Information", 30},
	{ "Force Map", 15},
	{ "First Gear", 20},
	{ "10x Game Speed", 10, "game speed"}, -- 175
	{ "0.01x Game Speed", 10, "game speed"},
	{ "Mute", 30},
	{ "Ghost Vehicles", 30},
	{ "Randomize Effects Pool", nil}, 
	{ "2x Effects Speed", 20, "effects speed"}, -- 180
	{ "5x Effects Speed", 20, "effects speed"},
	{ "10x Effects Speed", 20, "effects speed"},
	{ "Uncapped FPS", 30, "screen"},
	{ "Bright Cars", 20},
	{ "Player Effect", 20}, -- 185
	{ "Tipping Point", 10},
	{ "Insane Handling", 15},
	{ "Switch Seats", nil}, 
	{ "Oh, A Passenger!", nil},
	{ "Attach Random Object", 15}, -- 190
	{ "Mark Finish", nil}, 
	{ "Strong Brakes", 20},
	{ "MOTD", nil},
	{ "1950's", 60, "screen"},
	{ "Alarmy Vehicles", 25, "honk"}, -- 195
	{ "Randomize Vehicle Colors", nil}, 
	{ "Pride Colors", 30, "vehicle color"},
	{ "Vehicle Gear Display", 20},
	{ "Vice City", 120},
	{ "Alle-Oop", nil}, -- 200
	{ "Stack", 20},
	{ "Randomize CP Colors", nil},
	{ "Randomize CP Type", nil},
	{ "AIR HORN", nil},
	{ "Crowd Cheering", 60}, -- 205
	{ "Tiny Screen", 42, "screen"},
	{ "GTA -2", 15, "camera"},
	{ "Disable Ghostmode", 60},
	{ "Who needs textures?", 60, "world"},
	{ "MonkaS", 60, "world"} -- 210
};

-- Voting 
local votingOptions = {
	effects[math.random(#effects)][1], 
	effects[math.random(#effects)][1], 
	effects[math.random(#effects)][1]
}

-- Function checks if player is spectating
function isLocalPlayerSpectating()
	local px, py, pz = getElementPosition(localPlayer)
	if getElementData(localPlayer, "state") == "spectating" or pz > 2000 then return true	
	else return false end
end

function update()
	if isLocalPlayerSpectating() then return end
	if not getPedOccupiedVehicle(localPlayer) then return end
	
	if unflippable then
		local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
		
		if rx <= 180 then rx = math.min(80, rx)
		else rx = math.max(280, rx) end
		
		if ry <= 180 then rx = math.min(80, ry)
		else ry = math.max(280, ry) end
		
		setElementRotation(getPedOccupiedVehicle(localPlayer), rx, ry, rz)
	end
	
	if underwater then
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		setWaterLevel(z + 50)
	end
	
	if firstGear then setVehicleHandling(getPedOccupiedVehicle(localPlayer), "numberOfGears", 1) end
	
	if tippingPoint then setVehicleHandling(getPedOccupiedVehicle(localPlayer), "centerOfMass", {0, 0, 2}) end
	
	if insaneHandling then
		  setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionMultiplier", 10)
          setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionLoss", 1)
	end
	
	if randomTire ~= 0 then
		if randomTire == 1 then
			setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 2, -1, -1, -1)
		elseif randomTire == 2 then
			setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), -1, 2, -1, -1)
		elseif randomTire == 3 then
			setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), -1, -1, 2, -1)
		elseif randomTire == 4 then
			setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), -1, -1, -1, 2)
		end
	end
	
	if unlimitedHealth then setElementHealth(getPedOccupiedVehicle(localPlayer), 1000) end
	
	if allCarsHaveNitro then
		if getVehicleUpgradeOnSlot(getPedOccupiedVehicle(localPlayer), 8) ~= 1010 then
			addVehicleUpgrade(getPedOccupiedVehicle(localPlayer), 1010)
		end
	end
	
	if blackVehicles then
		for index, vehicles in ipairs(getElementsByType("vehicle")) do
			setVehicleColor(vehicles, 0, 0, 0, 0)
		end
	end
	
	if pinkVehicles then
		for index, vehicles in ipairs(getElementsByType("vehicle")) do
			setVehicleColor(vehicles, 126, 126, 126, 126)
		end
	end
	
	if alwaysMidnight then setTime(0, 0) end
	
	if alwaysEvening then setTime(21, 0) end
	
	if speedTime then
		local h, m = getTime()
		m = m + 10
		if m > 59 then 
			m = 0 
			h = h + 1
			
			if h > 23 then h = 0 end
		end
		
		setTime(h, m)
	end
	
	if invisibleVehicles then
		for index, vehicles in ipairs(getElementsByType("vehicle")) do
			setElementInterior(vehicles, 5)
		end
	else
		for index, vehicles in ipairs(getElementsByType("vehicle")) do
			setElementInterior(vehicles, 0)
		end
	end
	
	if mouseControl then
		setElementRotation(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, getPedCameraRotation(localPlayer)*(-1))
	end
	
	if drivingMouse then
		toggleControl("vehicle_right", false)
		toggleControl("vehicle_left", false)
		
		local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
		local rot = getPedCameraRotation(localPlayer)*(-1) + (360 - rz)
		
		rot = math.min(15, rot)
		rot = math.max(-15, rot)
		
		if rot < 0 then setAnalogControlState("vehicle_right", math.abs(rot / 15))
		elseif rot >= 0 then setAnalogControlState("vehicle_left", math.abs(rot / 15)) end
	end
	
	if steerBiasLeft then setAnalogControlState("vehicle_left", 0.6) end
	if steerBiasRight then setAnalogControlState("vehicle_right", 0.6) end
	
	if beyblade then
		local x, y, z = getElementRotation(getPedOccupiedVehicle(localPlayer))
		setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, z+60)
	end
	
	if arcadeCamera then
		local tempObj = createObject(1946, 0, 0, 0)
		attachElements(tempObj, getPedOccupiedVehicle(localPlayer), getElementRadius(getPedOccupiedVehicle(localPlayer)) + 3, 0, 2)
		
		local x, y, z = getElementPosition(tempObj)
		local x2, y2, z2 = getElementPosition(getPedOccupiedVehicle(localPlayer))
		destroyElement(tempObj)
		
		setCameraMatrix(x, y, z, x2, y2, z2)
	end
	
	if topCamera or bottomCamera then
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		local vel = (vx*vx + vz*vz + vy*vy)*100
		local j = 1
		
		if bottomCamera then j = -1 end
		
		if vel >= 70 then vel = 70 end
		setCameraMatrix(x, y, (z+15+vel*1.2)*j, x, y, z)
	end
	
	if disabledKey ~= 0 then
		if disabledKey == 1 then toggleControl("accelerate", false)
		elseif disabledKey == 2 then toggleControl("brake_reverse", false)
		elseif disabledKey == 3 then toggleControl("vehicle_left", false)
		elseif disabledKey == 4 then toggleControl("vehicle_right", false) end
	end
	
	if pedalMedal then
		toggleControl("accelerate", false)
		setPedControlState(localPlayer, "accelerate", true)
	end
	
	if holdTab then executeCommandHandler("Toggle scoreboard", "1") end
	
	if noBrakes then
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "brakeDeceleration", 0)
		toggleControl("handbrake", false)
	end
	
	if forceCamera ~= nil then setCameraViewMode(forceCamera) end
	
	if goodBye then
		setCameraMatrix(oldPos[1], oldPos[2], oldPos[3], oldPos[4], oldPos[5], oldPos[6])
	end
	
	if alwaysHONK then
		toggleControl("horn", false)
		setPedControlState(localPlayer, "horn", true)
	end
	
	if randomMassEnabled then
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "mass", randomMass)
	end
	
	if engineDisabled then
		setVehicleEngineState(getPedOccupiedVehicle(localPlayer), false)
	end
	
	if rearWheels then
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "handlingFlags", 0x340220)
	end
	
	if floatingPoint then
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
		
		setElementPosition(getPedOccupiedVehicle(localPlayer), math.floor(x*5)/5, math.floor(y*5)/5, math.floor(z*5)/5)
		setElementRotation(getPedOccupiedVehicle(localPlayer), math.floor(rx*5)/5, math.floor(ry*5)/5, math.floor(rz*5)/5)
	end
	
	if bitSteer then
		-- Disable vehicle controls
		toggleControl("vehicle_left", false)
		toggleControl("vehicle_right", false)
		
		-- Force Angle
		local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
		setElementRotation(getPedOccupiedVehicle(localPlayer), rx, ry, carAngle)
		setElementAngularVelocity(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, 0.0)
	end
	
	if hydraulicsAssistance then
		if getVehicleUpgradeOnSlot(getPedOccupiedVehicle(localPlayer), 9) ~= 1087 then
			addVehicleUpgrade(getPedOccupiedVehicle(localPlayer), 1087)
			toggleControl("horn", false)
		end
		
		toggleControl("horn", false)
		toggleControl("special_control_left", false)
		toggleControl("special_control_right", false)
		toggleControl("special_control_up", false)
		toggleControl("special_control_down", false)
	end
	
	if flyingCamera then
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		cameraAngle = cameraAngle + 3.0
		if cameraAngle > 360.0 then cameraAngle = 0.0 end
		setCameraMatrix((math.sin(math.rad(cameraAngle)) * 7) + x + 2.5, (math.cos(math.rad(cameraAngle)) * 7) + y - 0.3, z + 1.9, x, y, z)
	end
	
	if shufflePaintjobs then
		setVehiclePaintjob(getPedOccupiedVehicle(localPlayer), math.random(0, 2))
	end
	
	if rotatory then
		for i in pairs(getVehicleComponents(getPedOccupiedVehicle(localPlayer))) do
			local x = math.random(0, 359)
			local y = math.random(0, 359)
			local z = math.random(0, 359)
			
			setVehicleComponentRotation(getPedOccupiedVehicle(localPlayer), i, x, y, z)
		end
	end
	
	if randoBlips then
		for index, blips in ipairs(getElementsByType("blip")) do
			if getBlipIcon(blips) < 2 then 
				setBlipSize(blips, 2)
				setBlipIcon(blips, math.random(2, 63))
			end
		end 
	end
	
	if halfSteering then
		local handling = getOriginalHandling(getElementModel(getPedOccupiedVehicle(localPlayer)))
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "steeringLock", handling["steeringLock"]/2)
	end
	
	if tiltedRotation then
		tiltedRot = tiltedRot + 1
		if tiltedRot > 360 then tiltedRot = 0 end
	end
	
	if banSidewalks then
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(x, y, z+1, x, y, -20, true, false, false, false, false)
		if hit then
			if material == 4 then blowVehicle(getPedOccupiedVehicle(localPlayer)) end
		end
	end
	
	if strongBrakes then
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "brakeDeceleration", 100000.0)
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "brakeBias", 1.0)
	end
end

function secondUpdate()
	if randomTirePopping then
		-- Choose
		local r = math.random(4)
		
		-- Set
		if r == 1 then setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 2, 0, 0, 0)
		elseif r == 2 then setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 0, 2, 0, 0)
		elseif r == 3 then setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 0, 0, 2, 0)
		elseif r == 4 then setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 0, 0, 0, 2) end
		
		-- Reset
		if isTimer(randomPoppingTimer) then killTimer(randomPoppingTimer) end
		randomPoppingTimer = setTimer(function() setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 0, 0, 0, 0) end, 300, 0)
	end
	
	if alarmy then
		setPedControlState(localPlayer, "horn", not getPedControlState(localPlayer, "horn"))
	end
	
	if ghostRider then
		setElementHealth(getPedOccupiedVehicle(localPlayer), 200)
		setTimer(function() setElementHealth(getPedOccupiedVehicle(localPlayer), 1000) end, 950, 1) 
	end
	
	if swingingDoors then
		for index, vehicles in ipairs(getElementsByType("vehicle")) do
			for i = 0, 5 do 
				if getVehicleDoorOpenRatio(vehicles, i) == 1 then setVehicleDoorOpenRatio(vehicles, i, 0, 1000)
				else setVehicleDoorOpenRatio(vehicles, i, 1, 1000) end
			end
		end
	end
end

function clearEffect(effect)
	if effect == nil then return end
	
	if effect < 8 then setGravity(0.008)
	elseif effect == 8 then blindMode = false
	elseif effect == 9 then setPlayerHudComponentVisible("radar", true)
	elseif effect == 10 then portraitMode = false
	elseif effect == 11 then dvdMode = false
	elseif effect == 12 then tunnelMode = false
	elseif effect == 21 then unlimitedHealth = false
	elseif effect == 23 then blackVehicles = false
	elseif effect == 24 then pinkVehicles = false
	elseif effect == 25 then setWorldSpecialPropertyEnabled("aircars", false)
	elseif effect == 26 then setWorldSpecialPropertyEnabled("hovercars", false)
	elseif (effect > 27 and effect < 32) or effect == 175 or effect == 176 then setGameSpeed(1)
	elseif effect == 32 then alwaysEvening = false
	elseif effect == 33 then alwaysMidnight = false
	elseif effect == 34 then speedTime = false
	elseif effect == 35 then setFarClipDistance(800)
	elseif effect == 36 then setFarClipDistance(800)
	elseif effect == 37 then 
		setWeather(0)
		setRainLevel(0)
	elseif effect == 39 then 
		wheelsOnly = false
		for _, vehicles in ipairs(getElementsByType("vehicle")) do
			for i in pairs(getVehicleComponents(vehicles)) do setVehicleComponentVisible(vehicles, i, true) end
		end
	elseif effect == 40 then 
		engineDisabled = false
		setVehicleEngineState(getPedOccupiedVehicle(localPlayer), true)
	elseif effect == 41 then respawnDisabled = false
	elseif effect == 43 then 
		randomMassEnabled = false
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "mass", nil)
	elseif effect == 44 then 
		rearWheels = false
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "handlingFlags", nil)
	elseif effect == 45 then
		if getElementModel(getPedOccupiedVehicle(localPlayer)) == changedWheelModel then
			for i in pairs (getVehicleComponents(getPedOccupiedVehicle(localPlayer))) do
				local x, y, z = getVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), i)
				setVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), i, x, y, z-1)
			end
		
			local x, y, z = getVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_rf_dummy")
			setVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_rf_dummy", x-0.5, y, z)
			
			x, y, z = getVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_rb_dummy")
			setVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_rb_dummy", x-0.5, y, z)
			
			x, y, z = getVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_lf_dummy")
			setVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_lf_dummy", x+0.5, y, z)
			
			x, y, z = getVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_lb_dummy")
			setVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_lb_dummy", x+0.5, y, z)
		end
		
		setVehicleModelWheelSize(changedWheelModel, "all_wheels", 0.7)
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "centerOfMass", nil)
	elseif effect == 46 and isElement(rampObj) then destroyElement(rampObj) 
	elseif effect == 47 then 
		mirroredControls = false
		toggleControl("vehicle_left", true)
		toggleControl("vehicle_right", true)
		toggleControl("accelerate", true)
		toggleControl("brake_reverse", true)
	elseif effect == 48 or effect == 42 or effect == 49 then
		if getPedOccupiedVehicle(localPlayer) then
			setElementPosition(getPedOccupiedVehicle(localPlayer), storedPos[1], storedPos[2], storedPos[3])
			setElementRotation(getPedOccupiedVehicle(localPlayer), storedRot[1], storedRot[2], storedRot[3])
			setElementVelocity(getPedOccupiedVehicle(localPlayer), storedVel[1], storedVel[2], storedVel[3])
			setElementInterior(getPedOccupiedVehicle(localPlayer), 0)
			setElementInterior(localPlayer, 0)
			setCameraTarget(localPlayer)
		end
	elseif effect == 68 then
		setPedWeaponSlot(localPlayer, 0)
		setPedDoingGangDriveby(localPlayer, false)
	elseif effect == 69 then setWorldSpecialPropertyEnabled("extrabunny", false)
	elseif effect == 70 then OHKO = false
	elseif effect == 74 then setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 0, 0, 0, 0)
	elseif effect == 75 then 
		randomTire = 0
		setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 0, 0, 0, 0)
	elseif effect == 76 then
		if isTimer(randomPoppingTimer) then killTimer(randomPoppingTimer) end
		randomTirePopping = false
		setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 0, 0, 0, 0)
	elseif effect == 79 then
		alwaysHONK = false
		toggleControl("horn", true)
		setPedControlState(localPlayer, "horn", false)
	elseif effect == 80 then invisibleVehicles = false
	elseif effect == 81 then ghostRider = false
	elseif effect == 82 then mouseControl = false
	elseif effect == 84 then beyblade = false
	elseif effect == 85 then 
		arcadeCamera = false
		setCameraTarget(localPlayer)
	elseif effect == 87 then 
		topCamera = false
		setCameraTarget(localPlayer)
	elseif effect == 88 then 
		lowResGaming = false
		destroyElement(displaySource)
	elseif effect == 89 then
		mirrored = false
		mirroredControlsFix = false
		destroyElement(screenSrc)
		
		toggleControl("vehicle_left", true)
		toggleControl("vehicle_right", true)
	elseif effect == 90 then
		local h = disabledKey
		disabledKey = 0
		
		if h == 1 then toggleControl("accelerate", true)
		elseif h == 2 then toggleControl("brake_reverse", true)
		elseif h == 3 then toggleControl("vehicle_left", true)
		elseif h == 4 then toggleControl("vehicle_right", true)
		elseif h == 5 then toggleControl("handbrake", true) end
	elseif effect == 91 then
		toggleControl("vehicle_look_behind", true)
		setPedControlState(localPlayer, "vehicle_look_behind", false)
	elseif effect == 93 then 
		noBrakes = false
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "brakeDeceleration", nil)
		toggleControl("handbrake", true)
	elseif effect == 94 then
		pedalMedal = false
		toggleControl("accelerate", true)
		setPedControlState(localPlayer, "accelerate", false)
	elseif effect == 95 or effect == 96 then 
		forceCamera = nil
		setCameraViewMode(3)
		setCameraTarget(localPlayer)
	elseif effect == 100 then setCameraDrunkLevel(0) 
	elseif effect == 101 or effect == 102 then setCameraGoggleEffect("normal")
	elseif effect == 103 or effect == 104 or effect == 105 then setCameraFieldOfView("vehicle", oldFOV)
	elseif effect == 106 then 
		goodBye = false
		setCameraTarget(localPlayer)
	elseif effect == 111 then jumpingAllowed = false
	elseif effect == 114 then disableUI = false
	elseif effect == 121 then floatingPoint = false
	elseif effect == 122 then 
		killTimer(honkBoost)
		unlimitedHealth = false
	elseif effect == 123 then enableRockets = false
	elseif effect == 124 then swingingDoors = false
	elseif effect == 127 then pressWrando = false
	elseif effect == 130 then 
		bitSteer = false
		toggleControl("vehicle_left", true)
		toggleControl("vehicle_right", true)
	elseif effect == 132 then 
		hydraulicsAssistance = false
		toggleControl("horn", true)
		toggleControl("special_control_left", true)
		toggleControl("special_control_right", true)
		toggleControl("special_control_up", true)
		toggleControl("special_control_down", true)
	elseif effect == 133 then 
		flyingCamera = false
		setCameraTarget(localPlayer)
	elseif effect == 134 then setElementFrozen(getPedOccupiedVehicle(localPlayer), false)
	elseif effect == 138 then blowVehicle(getPedOccupiedVehicle(localPlayer))
	elseif effect == 139 then toggleControl("horn", true)
	elseif effect == 141 then shufflePaintjobs = false
	elseif effect == 142 then 
		rotatory = false
		for i in pairs(getVehicleComponents(getPedOccupiedVehicle(localPlayer))) do
			setVehicleComponentRotation(getPedOccupiedVehicle(localPlayer), i, 0, 0, 0)
		end
	elseif effect == 146 then 
		randoBlips = false
		for index, blips in ipairs(getElementsByType("blip")) do
			if getBlipIcon(blips) > 0 then setBlipIcon(blips, 0) end
		end
	elseif effect == 151 then 
		halfSteering = false
		local handling = getOriginalHandling(getElementModel(getPedOccupiedVehicle(localPlayer)))
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "steeringLock", handling["steeringLock"])
	elseif effect == 152 then setWaterLevel(0)
	elseif effect == 153 then 
		tilted = false
		destroyElement(tiltedSource)
	elseif effect == 154 then
		flippedScreen = false
		destroyElement(flippedSource)
	elseif effect == 155 then
		tilted = false
		tiltedRot = 40
		tiltedRotation = false
		destroyElement(tiltedSource)
	elseif effect == 156 then 
		holdTab = false
		executeCommandHandler("Toggle scoreboard", "0")
	elseif effect == 157 or effect == 158 then 
		destroyElement(water)
		underwater = false
		setWaterLevel(0)
	elseif effect == 159 then banSidewalks = false
	elseif effect == 160 then unflippable = false
	elseif effect == 161 then disableSnow()
	elseif effect == 162 then 
		drivingMouse = false
		setAnalogControlState("vehicle_left", 0)
		setAnalogControlState("vehicle_right", 0)
		toggleControl("vehicle_left", true)
		toggleControl("vehicle_right", true)
	elseif effect == 163 then steerBiasLeft = false
	elseif effect == 164 then steerBiasRight = false
	elseif effect == 165 then killTimer(WTF)
	elseif effect == 168 or effect == 169 then
		destroyElement(halfSource)
		halfFrames = false
	elseif effect == 171 then resetShakeCamera()
	elseif effect == 172 then fallInformation = true
	elseif effect == 173 then forcePlayerMap(false)
	elseif effect == 174 then
		firstGear = false
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "numberOfGears", 5)
	elseif effect == 177 then for i = 1, 44 do setWorldSoundEnabled(i, true) end
	elseif effect == 178 then
		ghostVehicles = false
		for _, vehicles in ipairs(getElementsByType("vehicle")) do
			if getVehicleController(vehicles) then
				setElementAlpha(vehicles, 255)
				setElementAlpha(getVehicleController(vehicles), 255)
			end
		end
	elseif effect == 180 or effect == 181 or effect == 182 then effectSpeed = 1
	elseif effect == 184 then setWorldProperty("Illumination", 1)
	elseif effect == 185 then playerEffect = false
	elseif effect == 186 then 
		tippingPoint = false
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "centerOfMass", nil, false)
	elseif effect == 187 then
		insaneHandling = false
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionMultiplier", nil, false)
        setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionLoss", nil, false)
	elseif effect == 192 then 
		strongBrakes = false
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "brakeDeceleration", nil, false)
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "brakeBias", nil, false)
	elseif effect == 194 then
		destroyElement(blackWhiteShader)
		destroyElement(screenSource)
		
		blackWhiteShader = nil
	elseif effect == 195 then 
		toggleControl("horn", true)
		alarmy = false
	elseif effect == 198 then gearDisplay = false
	elseif effect == 199 then vicecityFont = false
	elseif effect == 205 then if isTimer(cheers) then killTimer(cheers) end
	elseif effect == 206 then
		tinyScreen = false
		destroyElement(displaySource)
	elseif effect == 207 then 
		bottomCamera = false
		setCameraTarget(localPlayer)
	elseif effect == 208 then enableCollisions = false
	elseif effect == 209 or effect == 210 then destroyElement(shader)
	end
	
	-- Remove Data from old effect
	for i = 1, #activeEffects do
		if activeEffects[i][1] == effect then
			-- Remove data of that effect
			table.remove(activeEffects, i)
			table.remove(activeTimers, i)
			break
		end
	end
	
	-- Move effect into passive effects
	table.insert(passiveEffects, {effect, nil})
	if #passiveEffects > math.floor(screenY/77) then
		table.remove(passiveEffects, 1)
	end
end

function applyEffect(effect, playerName)
	if effect == 0 then 
		timer = 100
		return
	end
	
	-- Effects
	for i = #activeEffects, 1, -1 do
		if #effects[effect] > 2 and #effects[activeEffects[i][1]] > 2 then
			if effects[effect][3] == effects[activeEffects[i][1]][3] then
				-- Clear effects of the same type
				clearEffect(activeEffects[i][1])
			end
		end
	end
	
	skip = false
	-- Add time if effect is the same
	for i = 1, #activeEffects do
		if effect == activeEffects[i][1] then
			-- Reset visual timer
			activeTimers[i] = effects[effect][2]
			skip = true
		end
	end
	
	-- Effects
	if effect == 1 then setGravity(0.016)
	-- Half Gravity
	elseif effect == 2 then setGravity(0.004)
	-- Insane Gravity
	elseif effect == 3 then setGravity(0.5)
	-- Inverted Gravity
	elseif effect == 4 then setGravity(-0.008)
	-- Quadruple Gravity
	elseif effect == 5 then setGravity(0.032)
	-- Quarter Gravity
	elseif effect == 6 then setGravity(0.002)
	-- Zero Gravity
	elseif effect == 7 then setGravity(0)
	-- Blind
	elseif effect == 8 then blindMode = true 
	-- Disable radar
	elseif effect == 9 then	setPlayerHudComponentVisible("radar", false)
	-- Portrait mode
	elseif effect == 10 then portraitMode = true	
	-- DVD Sceensaver mode
	elseif effect == 11 then dvdMode = true
	-- Tunnel Mode
	elseif effect == 12 then tunnelMode = true
	-- Foggy Weather
	elseif effect == 13 then setWeather(9)
	-- Overcast Weather
	elseif effect == 14 then setWeather(15)
	-- Rainy Weather
	elseif effect == 15 then setWeather(8)
	-- Sandstorm
	elseif effect == 16 then setWeather(19)
	-- Sunny Weather
	elseif effect == 17 then setWeather(18)
	-- Very Sunny Weather
	elseif effect == 18 then setWeather(17)
	-- Take Damage
	elseif effect == 19 then setElementHealth(getPedOccupiedVehicle(localPlayer), getElementHealth(getPedOccupiedVehicle(localPlayer)) - 400) 
	-- Hesoyam
	elseif effect == 20 then fixVehicle(getPedOccupiedVehicle(localPlayer))
	-- Invincible
	elseif effect == 21 then unlimitedHealth = true
	-- All Cars Have Nitro
	elseif effect == 22 then allCarsHaveNitro = not allCarsHaveNitro 
	-- Black Vehicles
	elseif effect == 23 then blackVehicles = true
	-- Pink Vehicles
	elseif effect == 24 then pinkVehicles = true
	-- Cars Fly
	elseif effect == 25 then setWorldSpecialPropertyEnabled("aircars", true) 
	-- Cars on water
	elseif effect == 26 then setWorldSpecialPropertyEnabled("hovercars", true) 
	-- 0.25x Game Speed
	elseif effect == 28 then setGameSpeed(0.25) 
	-- 0.5x Game Speed
	elseif effect == 29 then setGameSpeed(0.5) 
	-- 2x Game Speed
	elseif effect == 30 then setGameSpeed(2) 
	-- 4x Game Speed
	elseif effect == 31 then setGameSpeed(4)
	-- Always Evening
	elseif effect == 32 then alwaysEvening = true
	-- Always Midnight
	elseif effect == 33 then alwaysMidnight = true
	-- Timelapse
	elseif effect == 34 then speedTime = true
	-- DE Experience
	elseif effect == 35 then 
		setFarClipDistance(5000)
	-- Can't See Shit
	elseif effect == 36 then
		setFarClipDistance(30)
	-- Rain
	elseif effect == 37 then 
		setWeather(8)
		setRainLevel(10)
	-- Random Explosion
	elseif effect == 38 then 
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		createExplosion(x, y, z, math.random(0, 12), true, -1.0, false)
	-- Only wheels
	elseif effect == 39 then wheelsOnly = true
	-- Shutdown Vehicle Engine
	elseif effect == 40 then
		engineDisabled = true
	-- Disable Respawns
	elseif effect == 41 then
		respawnDisabled = true
	-- Teleport to a grove
	elseif effect == 42 then
		-- Store data
		storedPos[1], storedPos[2], storedPos[3] = getElementPosition(getPedOccupiedVehicle(localPlayer))
		storedRot[1], storedRot[2], storedRot[3] = getElementRotation(getPedOccupiedVehicle(localPlayer))
		storedVel[1], storedVel[2], storedVel[3] = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		
		setElementPosition(getPedOccupiedVehicle(localPlayer), 2487.8, -1667.8, 13.1)
		setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, 0)
	-- Random Vehicle Mass
	elseif effect == 43 then 
		randomMass = math.random(600, 50000)
		randomMassEnabled = true
	-- Rear Wheels Steering
	elseif effect == 44 then 
		rearWheels = true
	-- Monstered
	elseif effect == 45 then
		changedWheelModel = getElementModel(getPedOccupiedVehicle(localPlayer))
		
		for i in pairs (getVehicleComponents(getPedOccupiedVehicle(localPlayer))) do
			local x, y, z = getVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), i)
			setVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), i, x, y, z+1)
		end
		
		local x, y, z = getVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_rf_dummy")
		setVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_rf_dummy", x+0.5, y, z)
		
		x, y, z = getVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_rb_dummy")
		setVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_rb_dummy", x+0.5, y, z)
		
		x, y, z = getVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_lf_dummy")
		setVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_lf_dummy", x-0.5, y, z)
		
		x, y, z = getVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_lb_dummy")
		setVehicleComponentPosition(getPedOccupiedVehicle(localPlayer), "wheel_lb_dummy", x-0.5, y, z)
		
		setVehicleModelWheelSize(getElementModel(getPedOccupiedVehicle(localPlayer)), "all_wheels", getVehicleModelWheelSize(getElementModel(getPedOccupiedVehicle(localPlayer)), "front_axle")*3)
		addVehicleUpgrade(getPedOccupiedVehicle(localPlayer), 1025)
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "centerOfMass", {0, 0, -2.0})
	-- Spawn a Ramp
	elseif effect == 46 then
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))

		local radians = math.rad(rz - 90)
		local newX = x - 10 * math.cos(radians)
		local newY = y - 10 * math.sin(radians)

		if isElement(rampObj) then destroyElement(rampObj) end
		rampObj = createObject(1634, newX, newY, z-0.5, 0, 0, rz)

	-- Mirrored Controls
	elseif effect == 47 then 
		-- Reset Controls First
		toggleControl("vehicle_left", false)
		toggleControl("vehicle_right", false)
		toggleControl("accelerate", false)
		toggleControl("brake_reverse", false)
		
		setPedControlState(localPlayer, "vehicle_left", false)
		setPedControlState(localPlayer, "vehicle_right", false)
		setPedControlState(localPlayer, "accelerate", false)
		setPedControlState(localPlayer, "brake_reverse", false)
		
		mirroredControls = true
	-- Fake Teleport
	elseif effect == 48 then
		-- Store data
		storedPos[1], storedPos[2], storedPos[3] = getElementPosition(getPedOccupiedVehicle(localPlayer))
		storedRot[1], storedRot[2], storedRot[3] = getElementRotation(getPedOccupiedVehicle(localPlayer))
		storedVel[1], storedVel[2], storedVel[3] = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		
		-- Teleport
		local r = math.random(12)
		if r == 1 then
			setElementPosition(getPedOccupiedVehicle(localPlayer), -2669.5, 1595.1, 217)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, -90)
		-- Teleport to a mountain
		elseif r == 2 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), -2245.6001, -1723, 480.6)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, -138.75)
		-- Teleport to a pier
		elseif r == 3 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), 836.79999, -2044, 12.6)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, 180)
		-- Teleport to a quarry
		elseif r == 4 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), 783.09961, 835.7998, 5.6)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, 90)
		-- Teleport to a 69
		elseif r == 5 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), 215.60001, 1858.5, 12.9)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, 5)
		-- Teleport to a tower
		elseif r == 6 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), 1543.0996, -1352.4004, 329.2)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, 22)
		-- Teleport to a ear
		elseif r == 7 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), -322.5, 1516.3, 75.1)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, -150)
		-- Teleport to a grove
		elseif r == 8 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), 2487.8, -1667.8, 13.1)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, 0)
		-- Teleport to a docks
		elseif r == 9 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), 2761.5, -2453.7, 13.3)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, 0)
		-- Teleport to a ls air
		elseif r == 10 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), 1917.6, -2542.5, 13.3)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, 90)
		-- Teleport to a sf air
		elseif r == 11 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), -1395.3, 98.2, 13.9)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, -46)
		-- Teleport to a lv air
		elseif r == 12 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), 1484.1, 1613.8, 14.6)
			setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, 0)
		end
	-- Random Teleport
	elseif effect == 49 then
		-- Store data
		storedPos[1], storedPos[2], storedPos[3] = getElementPosition(getPedOccupiedVehicle(localPlayer))
		storedRot[1], storedRot[2], storedRot[3] = getElementRotation(getPedOccupiedVehicle(localPlayer))
		storedVel[1], storedVel[2], storedVel[3] = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		
		setElementPosition(getPedOccupiedVehicle(localPlayer), math.random(-3000, 3000), math.random(-3000, 3000), -5000)
	-- Spawn Bloodring Banger
	elseif effect == 50 then setElementData(localPlayer, "changecar", 504)
	-- Spawn Caddy
	elseif effect == 51 then setElementData(localPlayer, "changecar", 457)
	-- Spawn Dozer
	elseif effect == 52 then setElementData(localPlayer, "changecar", 486)
	-- Spawn Hunter
	elseif effect == 53 then setElementData(localPlayer, "changecar", 425)
	-- Spawn Hydra
	elseif effect == 54 then setElementData(localPlayer, "changecar", 520)
	-- Spawn Monster Truck
	elseif effect == 55 then setElementData(localPlayer, "changecar", 556)	
	-- Spawn Quad
	elseif effect == 56 then setElementData(localPlayer, "changecar", 471) 
	-- Spawn Hotring Racer
	elseif effect == 57 then setElementData(localPlayer, "changecar", 502)
	-- Spawn Hotring Racer 2
	elseif effect == 58 then setElementData(localPlayer, "changecar", 503)
	-- Spawn Rancher
	elseif effect == 59 then setElementData(localPlayer, "changecar", 505)
	-- Spawn Rhino
	elseif effect == 60 then setElementData(localPlayer, "changecar", 432)
	-- Spawn Romero
	elseif effect == 61 then setElementData(localPlayer, "changecar", 442)	
	-- Spawn Stretch
	elseif effect == 62 then setElementData(localPlayer, "changecar", 409)
	-- Spawn Stunt Plane
	elseif effect == 63 then setElementData(localPlayer, "changecar", 513)
	-- Spawn Tanker
	elseif effect == 64 then setElementData(localPlayer, "changecar", 514)	
	-- Spawn Trashmaster
	elseif effect == 65 then setElementData(localPlayer, "changecar", 408)
	-- Spawn Vortex
	elseif effect == 66 then setElementData(localPlayer, "changecar", 539)
	-- Random Car
	elseif effect == 67 then setElementData(localPlayer, "changecar", math.random(400, 606))
	-- Drive-by aiming
	elseif effect == 68 then setElementData(localPlayer, "giveweapon", 1)
	-- Huge Bunny Hop
	elseif effect == 69 then 
		setWorldSpecialPropertyEnabled("extrabunny", true)
		setElementData(localPlayer, "changecar", 481)
	-- Vehicle OHKO
	elseif effect == 70 then OHKO = true
	-- Vehicle Boost
	elseif effect == 71 then 
		local x, y, z = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		setElementVelocity(getPedOccupiedVehicle(localPlayer), x*5, y*5, z)
	-- Turn Around
	elseif effect == 72 then
		local x, y, z = getElementRotation(getPedOccupiedVehicle(localPlayer))
		local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		
		setElementRotation(getPedOccupiedVehicle(localPlayer), x, y, z+180)
		setElementVelocity(getPedOccupiedVehicle(localPlayer), vx*(-1), vy*(-1), vz)
	-- Spaaaace
	elseif effect == 73 then
		local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		setElementVelocity(getPedOccupiedVehicle(localPlayer), vx, vy, (vz+2)*20)
	-- Pop tires
	elseif effect == 74 then
		setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 1, 1, 1, 1)
	-- Remove Random Tire
	elseif effect == 75 then
		randomTire = math.random(4)
	-- Random tire popping
	elseif effect == 76 then
		randomTirePopping = true
	-- Invert Vehicle Speed
	elseif effect == 77 then
		local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		setElementVelocity(getPedOccupiedVehicle(localPlayer), vx*(-1), vy*(-1), vz)
	-- Ignite Car
	elseif effect == 78 then
		setElementHealth(getPedOccupiedVehicle(localPlayer), 240)
	-- HONK
	elseif effect == 79 then
		alwaysHONK = true
	-- Ghost Vehicles
	elseif effect == 80 then invisibleVehicles = true
	-- Ghost Rider
	elseif effect == 81 then ghostRider = true
	-- Mouse control
	elseif effect == 82 then mouseControl = true
	-- Clear active effects
	elseif effect == 83 then
		for i = 1, #activeEffects do clearEffect(activeEffects[1][1]) end
	-- Beyblade
	elseif effect == 84 then beyblade = true 
	-- Arcade Racer Camera
	elseif effect == 85 then arcadeCamera = true
	-- Add Random Blip
	elseif effect == 86 then createBlip(math.random(-3000, 3000), math.random(-3000, 3000), math.random(60), math.random(0, 63))
	-- Top Camera
	elseif effect == 87 then topCamera = true 
	-- Low Res Gaming
	elseif effect == 88 then
		displaySource = dxCreateScreenSource(math.random(50, 300), math.random(50, 300))
		lowResGaming = true
	-- Mirrored World
	elseif effect == 89 then
		screenSrc = dxCreateScreenSource(screenX, screenY)
		
		-- Reset Controls First
		toggleControl("vehicle_left", false)
		toggleControl("vehicle_right", false)
		
		setPedControlState(localPlayer, "vehicle_left", false)
		setPedControlState(localPlayer, "vehicle_right", false)
		
		mirrored = true
		mirroredControlsFix = true
	-- Disable one movement key
	elseif effect == 90 then
		disabledKey = math.random(4)
	-- Look Back
	elseif effect == 91 then
		toggleControl("vehicle_look_behind", false)
		setPedControlState(localPlayer, "vehicle_look_behind", true)
	-- Disable B
	elseif effect == 92 then disabledB = true
	-- Brakes
	elseif effect == 93 then 
		noBrakes = true
	-- pedalMedal
	elseif effect == 94 then pedalMedal = true
	-- Bumper Camera 
	elseif effect == 95 then forceCamera = 0
	-- Cinematic Camera 
	elseif effect == 96 then forceCamera = 5
	-- Reset Camera
	elseif effect == 97 then
		forceCamera = 3
		setCameraTarget(localPlayer)
		forceCamera = nil
	-- Death 1%
	elseif effect == 98 then
		local r = math.random(100)
		if r == 69 then blowVehicle(getPedOccupiedVehicle(localPlayer)) end
	-- Death 69%
	elseif effect == 99 then
		local r = math.random(100)
		if r < 70 then blowVehicle(getPedOccupiedVehicle(localPlayer)) end
	-- Drunk
	elseif effect == 100 then setCameraDrunkLevel(255)
	-- Night Vision
	elseif effect == 101 then setCameraGoggleEffect("nightvision")
	-- Thermal Visison
	elseif effect == 102 then setCameraGoggleEffect("thermalvision")
	-- Random FOV 
	elseif effect == 103 then
		if oldFOV == nil then oldFOV = getCameraFieldOfView("vehicle") end
		setCameraFieldOfView("vehicle", math.random(0, 100))
	-- Quake FOV
	elseif effect == 104 then
		if oldFOV == nil then oldFOV = getCameraFieldOfView("vehicle") end 
		setCameraFieldOfView("vehicle", 100)
	-- Low FOV
	elseif effect == 105 then
		if oldFOV == nil then oldFOV = getCameraFieldOfView("vehicle") end
		setCameraFieldOfView("vehicle", 10)
	-- Goodbye!
	elseif effect == 106 then
		oldPos[1], oldPos[2], oldPos[3], oldPos[4], oldPos[5], oldPos[6] = getCameraMatrix()
		goodBye = true
	-- Random Moon Size
	elseif effect == 108 then setMoonSize(math.random(1, 10))
	-- Stop
	elseif effect == 109 then setElementVelocity(getPedOccupiedVehicle(localPlayer), 0, 0, 0)
	-- Randomize Wind
	elseif effect == 110 then setWindVelocity(math.random(0, 10), math.random(0, 10), math.random(0, 10))
	-- Jumping 
	elseif effect == 111 then jumpingAllowed = true
	-- Win 1% 
	elseif effect == 112 then 
		local r = math.random(100)
		if r == 69 then
			for i = getElementData(localPlayer, "race.checkpoint"), 100 do
				local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
				if (#colshapes == 0) then break end
				triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer))
			end
			
			triggerServerEvent("onePercentWin", getLocalPlayer())
		end
	-- Get Hydraulics
	elseif effect == 113 then 
		addVehicleUpgrade(getPedOccupiedVehicle(localPlayer), 1087)
	-- Disable UI
	elseif effect == 114 then disableUI = true
	-- All Vehicle Upgrades
	elseif effect == 118 then addVehicleUpgrade(getPedOccupiedVehicle(localPlayer), "all")
	-- Floating Point Inaccuracy
	elseif effect == 121 then floatingPoint = true
	-- Honk Boost
	elseif effect == 122 then 
		unlimitedHealth = true
		honkBoost = setTimer(function()
			if getPedControlState(localPlayer, "horn") then
				local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
				setElementVelocity(getPedOccupiedVehicle(localPlayer), vx*1.5, vy*1.5, vz)
			end
		end, 100, 0)
	-- Enable Rockets
	elseif effect == 123 then enableRockets = true
	-- Swinging Doors
	elseif effect == 124 then swingingDoors = true
	-- Add Annoying Blips
	elseif effect == 125 then
		createBlip(math.random(-3000, 3000), math.random(-3000, 3000), math.random(60), 0, 25)
		createBlip(math.random(-3000, 3000), math.random(-3000, 3000), math.random(60), 0, 25)
		createBlip(math.random(-3000, 3000), math.random(-3000, 3000), math.random(60), 0, 25)
		createBlip(math.random(-3000, 3000), math.random(-3000, 3000), math.random(60), 0, 25)
	-- Press W Randomizer
	elseif effect == 127 then pressWrando = true
	-- 8-Bit Steering
	elseif effect == 130 then
		local x, y, z = getElementRotation(getPedOccupiedVehicle(localPlayer))
		carAngle = z
		bitSteer = true
	-- Pimping Ain't Easy
	elseif effect == 131 then
		setElementData(localPlayer, "changecar", 575)
		setElementData(localPlayer, "changeskin", 249)
	-- Hydraulics Assistance
	elseif effect == 132 then hydraulicsAssistance = true
	-- Flying Camera
	elseif effect == 133 then flyingCamera = true
	-- Froze Vehicle
	elseif effect == 134 then setElementFrozen(getPedOccupiedVehicle(localPlayer), true)
	-- Spectate 
	elseif effect == 136 then executeCommandHandler("spectate")
	-- Double B
	elseif effect == 137 then
		executeCommandHandler("spectate")
		setTimer(function() executeCommandHandler("spectate") end, 200, 1)
	-- Disable Horn
	elseif effect == 139 then toggleControl("horn", false)
	-- shufflePaintjobs
	elseif effect == 141 then shufflePaintjobs = true
	-- Rotatory Vehicles
	elseif effect == 142 then rotatory = true
	-- Spam Chat
	elseif effect == 143 then
		for i = 1, 100 do
			outputChatBox("COCK")
		end
	-- Spawn Heatseeking Rockets
	elseif effect == 144 then
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		for i = 1, 8 do
			createProjectile(localPlayer, 20, x+math.random(-200, 200), y+math.random(-200, 200), z+250, 1.0, localPlayer)
		end
	-- Randomize Blips
	elseif effect == 146 then randoBlips = true
	-- Spawn Blista Compact
	elseif effect == 147 then setElementData(localPlayer, "changecar", 496)	
	-- Spawn Faggio
	elseif effect == 148 then setElementData(localPlayer, "changecar", 462)
	-- Spawn Feltzer
	elseif effect == 149 then setElementData(localPlayer, "changecar", 533)
	-- Spawn Betsy
	elseif effect == 150 then setElementData(localPlayer, "changecar", 532)
	-- Half Steering
	elseif effect == 151 then halfSteering = true
	-- No Water
	elseif effect == 152 then setWaterLevel(-300)
	-- Tilted Screen
	elseif effect == 153 then
		tiltedSource = dxCreateScreenSource(screenX, screenY)
		tilted = true
	-- Flipped Screen
	elseif effect == 154 then
		flippedSource = dxCreateScreenSource(screenX, screenY)
		flippedScreen = true
	-- Rotation
	elseif effect == 155 then
		tiltedSource = dxCreateScreenSource(screenX, screenY)
		tilted = true
		tiltedRotation = true
	-- Scoreboard?
	elseif effect == 156 then
		holdTab = true
	-- Underwater
	elseif effect == 157 then
		water = createWater(-3000, -3000, 500, 3000, -3000, 500, -3000, 3000, 500, 3000, 3000, 500)
		underwater = true
	-- Flood
	elseif effect == 158 then
		water = createWater(-3000, -3000, 12.5, 3000, -3000, 12.5, -3000, 3000, 12.5, 3000, 3000, 12.5)
		setWaterLevel(12.5)
	-- Sidewalks Prohibition
	elseif effect == 159 then banSidewalks = true
	-- Unflippable Vehicles
	elseif effect == 160 then unflippable = true
	-- Snow
	elseif effect == 161 then enableSnow()
	-- Mouse Steering
	elseif effect == 162 then drivingMouse = true
	-- Steer Bias Left
	elseif effect == 163 then steerBiasLeft = true
	-- Steer Bias Right
	elseif effect == 164 then steerBiasRight = true
	-- WTF
	elseif effect == 165 then 
		WTF = setTimer(function() WTFAlpha = WTFAlpha + 1 end, 588, 0)
		WTFAlpha = 0
	-- Detach all parts
	elseif effect == 166 then
		for _, vehicles in ipairs(getElementsByType("vehicle")) do
			for door = 0, 5 do
				setVehicleDoorState(vehicles, door, 4, true)
				setVehicleWindowOpen(vehicles, door, true)
			end
			setVehicleWindowOpen(vehicles, 6, true)
		end
	-- Australia Mode
	elseif effect == 167 then
		local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
		setElementRotation(getPedOccupiedVehicle(localPlayer), rx, 180, rz)
	-- Powerpoint Presentation
	elseif effect == 168 or effect == 169 then 
		halfSource = dxCreateScreenSource(screenX, screenY)
		halfFrames = true
	-- Random UI colors
	elseif effect == 170 then 
		UIcolors[2] = hue2RGB(math.random(0, 3600)/10)
		UIcolors[1] = {UIcolors[2][1] / 2, UIcolors[2][2] / 2, UIcolors[2][3] / 2}
	-- Shake Camera
	elseif effect == 171 then shakeCamera(15)
	-- Information
	elseif effect == 172 then 
		for i = 1, 28 do informationText[i] = {"", math.random(0, screenX), math.random(0, screenY)} end
		informationText[29] = {"", math.random(0, screenX), math.random(0, 15)}
		information = true
	-- Force map
	elseif effect == 173 then forcePlayerMap(true)
	-- First Gear
	elseif effect == 174 then firstGear = true
	-- 10x Game Speed
	elseif effect == 175 then setGameSpeed(10)
	-- 0.01 Game Speed
	elseif effect == 176 then setGameSpeed(0.01)
	-- Mute 
	elseif effect == 177 then
		for i = 1, 44 do setWorldSoundEnabled(i, false, true) end
	-- Ghost Vehicles
	elseif effect == 178 then ghostVehicles = true
	-- 2x effects speed
	elseif effect == 180 then effectSpeed = 2
	-- 5x effects speed
	elseif effect == 181 then effectSpeed = 5
	-- 10x effects speed
	elseif effect == 182 then effectSpeed = 10
	-- Bright Cars
	elseif effect == 184 then setWorldProperty("Illumination", 20)
	-- Player Effect
	elseif effect == 185 then playerEffect = true
	-- Tipping point
	elseif effect == 186 then tippingPoint = true
	-- Insane Handling
	elseif effect == 187 then insaneHandling = true
	-- Mark Finish
	elseif effect == 191 then createBlip(2394.3999, 41.7, 25.4, 53)
	-- Strong Brakes
	elseif effect == 192 then strongBrakes = true
	-- Motd 
	elseif effect == 193 then executeCommandHandler("motd")
	-- 50s
	elseif effect == 194 then 
		blackWhiteShader = dxCreateShader("bin/blackwhite.fx")
		screenSource = dxCreateScreenSource(screenX, screenY)
	-- Alarmy Vehicles
	elseif effect == 195 then 
		alarmy = true
		toggleControl("horn", false)
	-- Gear Display
	elseif effect == 198 then gearDisplay = true
	-- Vice City
	elseif effect == 199 then 
		vicecityFont = dxCreateFont("bin/rageitalic.ttf", 30)
		UIcolors[2] = {246, 149, 220}
		UIcolors[1] = {123, 85, 110}
	-- Alle-Oop
	elseif effect == 200 then 
		local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
		local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		setElementVelocity(getPedOccupiedVehicle(localPlayer), vx, vy, vz+0.3)
		setElementAngularVelocity(getPedOccupiedVehicle(localPlayer), 0.115*math.cos(math.rad(rz+90)), 0.115*math.sin(math.rad(rz+90)), 0)
	-- CP Color
	elseif effect == 202 then CPColor = {math.random(255), math.random(255), math.random(255)}
	-- CP Type 
	elseif effect == 203 then 
		local types = {"ring", "cylinder", "corona"}
		CPType = types[math.random(#types)]
	-- AIR HORN
	elseif effect == 204 then
		playSFX("script", 6, 1, false)
		playSFX("script", 6, 1, false)
		playSFX("script", 6, 1, false)
		playSFX("script", 6, 1, false)
		playSFX("script", 6, 1, false)
	-- Cheers
	elseif effect == 205 then
		cheers = setTimer(function()
			local rand = math.random(0, 5)
			playSFX("script", 171, rand, false)
			playSFX("script", 171, rand, false)
			playSFX("script", 171, rand, false)
			playSFX("script", 171, rand, false)
			playSFX("script", 171, rand, false)
		end, math.random(6000, 12000), 0)
	-- Tiny Screen
	elseif effect == 206 then 
		displaySource = dxCreateScreenSource(256, (screenY * 256)/screenX)
		tinyScreen = true
	-- GTA -2
	elseif effect == 207 then bottomCamera = true
	-- Collisions
	elseif effect == 208 then enableCollisions = true
	-- Who needs textures
	elseif effect == 209 then
		shader = dxCreateShader("bin/shader.fx")
		dxSetShaderValue(shader, "gTexture", dxCreateTexture("bin/image.png"))
		engineApplyShaderToWorldTexture(shader, "*")
	elseif effect == 210 then
		shader = dxCreateShader("bin/shader.fx")
		dxSetShaderValue(shader, "gTexture", dxCreateTexture("bin/peppa.png"))
		engineApplyShaderToWorldTexture(shader, "*")
	end
	
	-- Effect timer
	if effects[effect][2] ~= nil and not skip then -- check if effect even has a timer
		table.insert(activeEffects, {effect, playerName})
		table.insert(activeTimers, effects[effect][2])
	else
		setTimer(function()
			table.insert(passiveEffects, {effect, playerName})
			
			if #passiveEffects > math.floor(screenY/77) then
				table.remove(passiveEffects, 1)
			end
		end, 100, 1)
	end
	
	-- Sound 
	if isElement(effectSound) then destroyElement(effectSound) end
	effectSound = playSound("s.mp3")
	setSoundVolume(effectSound, 0.5)
	
	-- Reset chaos timer 
	timer = 100
end

-- Function updates main progress bar on top of the screen
function chaosTimerUpdate()
	if timerRunning and timer > 0 then timer = timer - timerDecr end
end

-- Function updates visual timers of chaos effects
function updateVusialTimers()
	if timerRunning then
		for i = 1, #activeEffects do
			if activeTimers[i] ~= nil then 
				if activeEffects[i][1] ~= 180 and activeEffects[i][1] ~= 181 and activeEffects[i][1] ~= 182 then
					activeTimers[i] = activeTimers[i] - effectSpeed
				else activeTimers[i] = activeTimers[i] - 1 end
			end
			
			if activeTimers[i] ~= nil then
				if activeTimers[i] < 1 then clearEffect(activeEffects[i][1]) end
			end
		end
	end
end

function dxDrawBorderedText(outline, text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    if type(scaleY) == "string" or type(scaleY) == "userdata" then
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

-- Event triggered when race starts or player join server midrace
addEvent("raceInit", true)
addEventHandler("raceInit", getRootElement(), function() 
	if not isTimer(updateTimer) then updateTimer = setTimer(update, 20, 0) end
	if not isTimer(secondTimer) then secondTimer = setTimer(secondUpdate, 1000, 0) end
	if not isTimer(cleanTimer)  then cleanTimer  = setTimer(function() 
		if #passiveEffects > 5 then table.remove(passiveEffects, 1) end
	end, 8000, 0) end
	if not isTimer(visualEffectsTimer) then visualEffectsTimer = setTimer(updateVusialTimers, 1000, 0) end
	
	setElementData(localPlayer, "changecar", 545)
	timerRunning = true
end )

-- Event that applies chaos effect
addEvent("triggerEffect", true)
addEventHandler("triggerEffect", getRootElement(), applyEffect)

addEventHandler("onClientKey", root, function(button, press)
	if isChatBoxInputActive() then return end
	if button == "b" and not isLocalPlayerSpectating() and (disabledB or respawnDisabled) then cancelEvent() end 
	if button == "enter" and respawnDisabled then cancelEvent() end 
	
	local keys = getBoundKeys("enter_exit")
	for keyName, state in pairs(keys) do 
		if button == keyName and respawnDisabled then cancelEvent() end
	end
	
	if strongBrakes then
		local getMatrix = getElementMatrix(getPedOccupiedVehicle(localPlayer))
		local getVelocity = Vector3(getElementVelocity(getPedOccupiedVehicle(localPlayer)))
		local getVectorDirection = (getVelocity.x * getMatrix[2][1]) + (getVelocity.y * getMatrix[2][2]) + (getVelocity.z * getMatrix[2][3])
	
		for keyName, state in pairs(getBoundKeys("brake_reverse")) do
			if button == keyName and getVectorDirection > 0 then 
				setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionMultiplier", 100000.0)
				break
			else 
				for keyName, state in pairs(getBoundKeys("accelerate")) do
					if button == keyName and getVectorDirection < 0 then 
						setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionMultiplier", 100000.0)
						break
					end
				end
			end
			
			setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionMultiplier", nil, false)
		end
	end
	
	-- Mirrored Controls
	if mirroredControls then
		local keys = getBoundKeys("vehicle_left")
		for keyName, state in pairs(keys) do
			if button == keyName then
				cancelEvent()
				setPedControlState(localPlayer, "vehicle_right", press)
				break
			end
		end
		
		local keys = getBoundKeys("vehicle_right")
		for keyName, state in pairs(keys) do
			if button == keyName then
				cancelEvent()
				setPedControlState(localPlayer, "vehicle_left", press)
				break
			end
		end
		
		local keys = getBoundKeys("accelerate")
		for keyName, state in pairs(keys) do
			if button == keyName then
				cancelEvent()
				setPedControlState(localPlayer, "brake_reverse", press)
				break
			end
		end
		
		local keys = getBoundKeys("brake_reverse")
		for keyName, state in pairs(keys) do
			if button == keyName then
				cancelEvent()
				setPedControlState(localPlayer, "accelerate", press)
				break
			end
		end
	end
	
	-- Mirrored Controls (fix for mirrored world)
	if mirroredControlsFix then
		local keys = getBoundKeys("vehicle_left")
		for keyName, state in pairs(keys) do
			if button == keyName then
				cancelEvent()
				setPedControlState(localPlayer, "vehicle_right", press)
				break
			end
		end
		
		local keys = getBoundKeys("vehicle_right")
		for keyName, state in pairs(keys) do
			if button == keyName then
				cancelEvent()
				setPedControlState(localPlayer, "vehicle_left", press)
				break
			end
		end
	end
	
	-- Jumping 
	if jumpingAllowed then
		local keys = getBoundKeys("jump")
		for keyName, state in pairs(keys) do
			if button == keyName and press and isVehicleWheelOnGround(getPedOccupiedVehicle(localPlayer), "front_left") then
				local x, y, z = getElementVelocity(getPedOccupiedVehicle(localPlayer))
				setElementVelocity(getPedOccupiedVehicle(localPlayer), x, y, (z+0.4)*1.3)
			end
			break
		end
	end
	
	if enableRockets then
		local keys = getBoundKeys("vehicle_fire")
		for keyName, state in pairs(keys) do
			if button == keyName and press then
				if isTimer(shootTimer) then return end
				
				local posX, posY, posZ = getElementPosition(getPedOccupiedVehicle(localPlayer))
				shootTimer = setTimer(function() end, 5000, 1)
				createProjectile(getPedOccupiedVehicle(localPlayer), 19, posX, posY, posZ+0.7, 1.0)
				break
			end
		end
	end
	
	if pressWrando then
		local keys = getBoundKeys("accelerate")
		for keyName, state in pairs(keys) do
			if button == keyName and press then
				setElementData(localPlayer, "changecar", math.random(400, 609))
				break
			end
		end
	end
	
	if bitSteer then
		if press then
			local keys = getBoundKeys("vehicle_left")
			for keyName, state in pairs(keys) do
				if button == keyName or getAnalogControlState("vehicle_left", true) > 0.2 then
					-- + 30
					if carAngle == 330.0 then carAngle = 0.0	
					else carAngle = carAngle + 30.0 end
					
					local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
					setElementVelocity(getPedOccupiedVehicle(localPlayer), vx*1.02, vy*1.02, vz*1.02)
					
					break
				end
			end
			
			local keys = getBoundKeys("vehicle_right")
			for keyName, state in pairs(keys) do
				if button == keyName or getAnalogControlState("vehicle_right", true) > 0.2 then
					-- -30
					if carAngle == 0.0 then carAngle = 330.0	
					else carAngle = carAngle - 30.0 end
					
					local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
					setElementVelocity(getPedOccupiedVehicle(localPlayer), vx*1.02, vy*1.02, vz*1.02)
					
					break
				end
			end
		end
	end
	
	if hydraulicsAssistance then
		-- vehicle_left
		local keys = getBoundKeys("vehicle_left")
		for keyName, state in pairs(keys) do
			if button == keyName then
				setPedControlState(localPlayer, "special_control_left", press)
			end
		end
		
		-- vehicle_right
		local keys = getBoundKeys("vehicle_right")
		for keyName, state in pairs(keys) do
			if button == keyName then
				setPedControlState(localPlayer, "special_control_right", press)
			end
		end
		
		-- accelerate
		local keys = getBoundKeys("accelerate")
		for keyName, state in pairs(keys) do
			if button == keyName and press then
				setPedControlState(localPlayer, "special_control_down", true)
				
				if isTimer(jumpTimer) then killTimer(jumpTimer) end
				jumpTimer = setTimer(function() setPedControlState(localPlayer, "special_control_down", false) end, 100, 1)
			end
		end
		
		-- brake_reverse
		local keys = getBoundKeys("brake_reverse")
		for keyName, state in pairs(keys) do
			if button == keyName then
				setPedControlState(localPlayer, "special_control_up", press)
			end
		end
	end
end )

-- Visuals
addEventHandler("onClientRender", getRootElement(), function()
	-- collisions
	if getPedOccupiedVehicle(localPlayer) then
		if enableCollisions then setElementData(getPedOccupiedVehicle(localPlayer), "race.collideothers", 1)
		else setElementData(getPedOccupiedVehicle(localPlayer), "race.collideothers", 0) end
	end
	
	-- HUD Effects
	if isTimer(WTF) then
		dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, WTFAlpha))
	elseif blindMode then
		dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255))
	elseif portraitMode then
		dxDrawRectangle(0, 0, screenX/3, screenY, tocolor(0, 0, 0, 255))
		dxDrawRectangle((screenX/3)*2, 0, screenX, screenY, tocolor(0, 0, 0, 255))
	elseif tunnelMode then
		dxDrawRectangle(0, 0, screenX/3, screenY, tocolor(0, 0, 0, 255))
		dxDrawRectangle((screenX/3)*2, 0, screenX, screenY, tocolor(0, 0, 0, 255))
		
		dxDrawRectangle(0, 0, screenX, screenY/3, tocolor(0, 0, 0, 255))
		dxDrawRectangle(0, (screenY/3)*2, screenX, screenY, tocolor(0, 0, 0, 255))
	end
	
	if CPColor[1] ~= nil or CPType ~= nil then
		for _, cps in ipairs(getElementsByType("marker"), getResourceDynamicElementRoot(getResourceFromName("race"))) do
			if CPColor[1] ~= nil then
				local r, g, b, a = getMarkerColor(cps)
				if r ~= CPColor[1] then setMarkerColor(cps, CPColor[1], CPColor[2], CPColor[3], 255) end
			end
			if CPType ~= nil then setMarkerType(cps, CPType) end 
		end
	end
	
	if ghostVehicles then
		for _, vehicles in ipairs(getElementsByType("vehicle")) do
			if getVehicleController(vehicles) then
				setElementAlpha(vehicles, 55)
				setElementAlpha(getVehicleController(vehicles), 55)
			end
		end
	end
	
	if gearDisplay then
		dxDrawBorderedText(0, tostring(getVehicleCurrentGear(getPedOccupiedVehicle(localPlayer))), screenX/2, screenY/6, screenX/2, screenY/2, tocolor(255, 255, 255, 255), 60, "default", "center", "top", false, false, false, false, true)
	end
	
	if wheelsOnly then
		for _, vehicles in ipairs(getElementsByType("vehicle")) do
			for i in pairs(getVehicleComponents(vehicles)) do setVehicleComponentVisible(vehicles, i, false) end
			
			setVehicleComponentVisible(vehicles, "wheel_rf_dummy", true)
			setVehicleComponentVisible(vehicles, "wheel_lf_dummy", true)
			setVehicleComponentVisible(vehicles, "wheel_rb_dummy", true)
			setVehicleComponentVisible(vehicles, "wheel_lb_dummy", true)
		end
	end
	
	-- Information effect
	if information then
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
		local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		local h, m = getTime()
		
		-- Fill data
		informationText[1][1] = "Yes: no"
		informationText[2][1] = "No: yes"
		informationText[3][1] = "X: " ..x
		informationText[4][1] = "Y: " ..y
		informationText[5][1] = "Z: " ..z
		informationText[6][1] = "RX: " ..rx
		informationText[7][1] = "RY: " ..ry
		informationText[8][1] = "RZ: " ..rz
		informationText[9][1] = "VX: " ..vx
		informationText[10][1] = "VY: " ..vy
		informationText[11][1] = "VZ: " ..vz
		informationText[12][1] = "Model: " ..getElementModel(getPedOccupiedVehicle(localPlayer))
		informationText[13][1] = "Ped: " ..getElementModel(localPlayer)
		informationText[14][1] = engineGetModelNameFromID(getElementModel(getPedOccupiedVehicle(localPlayer)))
		informationText[15][1] = getZoneName(x, y, z)
		informationText[16][1] = "Players: " ..#getElementsByType("player")
		informationText[17][1] = "Hour: " ..h
		informationText[18][1] = "Minute: " ..m
		informationText[19][1] = "State: " ..getElementData(localPlayer, "state")
		informationText[20][1] = "Money: " ..(getElementData(localPlayer, "Money") or 0)
		informationText[21][1] = getPlayerName(localPlayer)
		informationText[22][1] = getResourceName(getThisResource())
		informationText[23][1] = "Hello SpeedyFolf"
		informationText[24][1] = "Ping: " ..getPlayerPing(localPlayer)
		informationText[25][1] = "Version: " ..(getVersion()["sortable"] or 0)
		informationText[26][1] = "Interior: " ..getElementInterior(localPlayer)
		informationText[27][1] = "Bytes: " ..(getNetworkStats()["bytesReceived"] or 0)
		informationText[28][1] = "Random: " ..math.random(-7555, 755599)
		informationText[29][1] = "Weather: " ..getWeather()
		
		-- Draw texts
		local allDown = false
		for i = 1, #informationText do
			if fallInformation then
				informationText[i][3] = informationText[i][3] + 15
				if informationText[i][3] > screenY*0.98 then
					informationText[i][3] = screenY*0.98
					allDown = true
				else allDown = false end
			end
			dxDrawBorderedText(1, informationText[i][1], informationText[i][2], informationText[i][3], screenX, screenY, tocolor(255, 255, 255, 255), screenY/444, vicecityFont or "default-bold", "left", "top")
		end
		
		if allDown then 
			information = false
			fallInformation = false
		end
	end
	
	if playerEffect then
		dxDrawBorderedText(1, "Enter effect name in the chat\nand it will be triggered!", screenX/2, screenY/3, screenX/2, screenY/2, tocolor(255, 255, 255, 255), screenY/250, vicecityFont or "default-bold", "center", "top")
	end
	
	-- Chaos UI
	if not disableUI then
		dxDrawRectangle(0, 0, screenX, screenY / 60, tocolor(0, 0, 0, 255)) -- border
		dxDrawRectangle(3, 0, screenX - 3, screenY / 90, tocolor(UIcolors[1][1], UIcolors[1][2], UIcolors[1][3], 255)) -- inside
		dxDrawRectangle(3, 0, ((screenX - 3) / 100)*timer, screenY / 90, tocolor(UIcolors[2][1], UIcolors[2][2], UIcolors[2][3], 255)) -- progress
		
		timer = math.max(0, timer)
		
		if not chatVoting then 
			timer = math.max(0, timer)
			if timer/10 < 10 then dxDrawText("00:0" ..math.floor(timer/10), screenX / 2, -2, screenX, screenY, tocolor(255, 255, 255, 255), screenY/1080, vicecityFont or "default-bold", "left", "top")
			else dxDrawText("00:" ..math.floor(timer/10), screenX / 2, -2, screenX, screenY, tocolor(255, 255, 255, 255), screenY/1080, vicecityFont or "default-bold", "left", "top") end
		else
			if ongoingVoting then
				dxDrawText("Voting: " ..math.floor(timer/10), screenX / 2, -2, screenX, screenY, tocolor(255, 255, 255, 255), screenY/1080, vicecityFont or "default-bold", "left", "top")
			else
				dxDrawText("Waiting: " ..math.floor(timer/10), screenX / 2, -2, screenX, screenY, tocolor(255, 255, 255, 255), screenY/1080, vicecityFont or "default-bold", "left", "top")
			end
		end
	end
	
	-- Chat Voting
	if chatVoting and (ongoingVoting or forceVotingOptions) then
		local boxPos = {screenX/2 - screenX/3.5, screenX/2, screenX/2 + screenX/3.5}
		local boxSize = {screenX * 0.2, screenY * 0.03}
		
		if animDirection then
			-- UP
			boxPosY = boxPosY - 20
			if boxPosY < screenY*0.7 then boxPosY = screenY*0.7 end
		else
			-- DOWN
			boxPosY = boxPosY + 20
			if boxPosY > screenY*1.1 then forceVotingOptions = false end
		end
		
		for i = 1, 3 do
			dxDrawRectangle(boxPos[i]-3.0, (boxPosY)-3.0, boxSize[1]+6.0, boxSize[2]*1.25, tocolor(0, 0, 0, 255)) -- border
			dxDrawRectangle(boxPos[i], boxPosY, boxSize[1], boxSize[2], tocolor(UIcolors[1][1], UIcolors[1][2], UIcolors[1][3], 255)) -- inside
			dxDrawRectangle(boxPos[i], boxPosY, 1.0*((getElementData(resourceRoot, "voted" ..i) or 0)/#getElementsByType("player"))*boxSize[1], boxSize[2], tocolor(UIcolors[2][1], UIcolors[2][2], UIcolors[2][3], 255)) -- progress
			
			-- Effect name
			if getElementData(resourceRoot, "effect" ..i) then dxDrawBorderedText(1, i.. ". " ..effects[getElementData(resourceRoot, "effect" ..i)][1], boxPos[i] - 3.0, boxPosY - screenY / 30, boxPos[i] - 3.0 + boxSize[1]+6.0, 0, tocolor(172, 203, 241, 255), screenX/1900, vicecityFont or "bankgothic", "center", "top")
			else dxDrawBorderedText(1, i.. ". " .."Error", boxPos[i] - 3.0, boxPosY - screenY / 30, boxPos[i] - 3.0 + boxSize[1]+6.0, 0, tocolor(172, 203, 241, 255), screenX/1900, vicecityFont or "bankgothic", "center", "top") end
			
			-- Counts
			local votingCount = (getElementData(resourceRoot, "voted" ..i) or 0).. "/" ..#getElementsByType("player")
			dxDrawBorderedText(0, votingCount, boxPos[i] - 3.0, boxPosY, boxPos[i] - 3.0 + boxSize[1]+6.0, 0, tocolor(0, 0, 0, 255), 1, vicecityFont or "bankgothic", "center", "top")
		end
	end
	
	-- Timed Effects
	local startX = screenX*0.88
	local startY = 250
	for i = 1, #activeEffects do
		if (disableUI and activeEffects[i][1] == 114) or not disableUI then
			-- Draw Circle
			dxDrawCircle(startX, startY, screenX/75, 0, 360, tocolor(0, 0, 0, 255), tocolor(0, 0, 0, 255), 32, 1, false)
			dxDrawCircle(startX, startY, screenX/80, 0, 360, tocolor(UIcolors[1][1], UIcolors[1][2], UIcolors[1][3], 255), tocolor(UIcolors[1][1], UIcolors[1][2], UIcolors[1][3], 255), 32, 1, false)
			dxDrawCircle(startX, startY, screenX/80, 0, (activeTimers[i]*360)/effects[activeEffects[i][1]][2], tocolor(UIcolors[2][1], UIcolors[2][2], UIcolors[2][3], 255), tocolor(UIcolors[2][1], UIcolors[2][2], UIcolors[2][3], 255), 32, 1, false)
			
			-- Draw Effect Name
			if activeEffects[i][2] ~= nil then dxDrawBorderedText(1, effects[activeEffects[i][1]][1].. " (" ..activeEffects[i][2].. ")", 0, 0, startX-screenX/50, startY+screenX/120, tocolor(225, 225, 225, 255), screenY/1080, vicecityFont or "bankgothic", "right", "bottom")
			else dxDrawBorderedText(1, effects[activeEffects[i][1]][1], 0, 0, startX-screenX/50, startY+screenX/120, tocolor(225, 225, 225, 255), screenY/1080, vicecityFont or "bankgothic", "right", "bottom") end
			startY = startY + screenY/15
		end
	end
	
	if disableUI then return end 
	
	-- Usual effects
	local startX2 = screenX*0.05
	local startY2 = 250
	for i = 1, #passiveEffects do
		-- Draw Effect Name
		if passiveEffects[i][2] ~= nil then dxDrawBorderedText(1, effects[passiveEffects[i][1]][1].. " (" ..passiveEffects[i][2].. ")", startX2, 0, startX2, startY2, tocolor(225, 225, 225, 255), screenY/1080, vicecityFont or "bankgothic", "left", "bottom")
		else dxDrawBorderedText(1, effects[passiveEffects[i][1]][1], startX2, 0, startX2, startY2, tocolor(225, 225, 225, 255), screenY/1080, vicecityFont or "bankgothic", "left", "bottom") end
		startY2 = startY2 + screenY/30
	end
end )

function vote(option)
	triggerServerEvent("chaosVoted", getLocalPlayer(), option)
	unbindKey("1", "down")
	unbindKey("2", "down")
	unbindKey("3", "down")
	unbindKey("num_1", "down")
	unbindKey("num_2", "down")
	unbindKey("num_3", "down")
end

addEvent("checkEffect", true)
addEventHandler("checkEffect", getRootElement(), function(effect)
	local effectName = tostring(effect)
	if effectName then 
		for i = 1, #effects do
			if string.lower(effects[i][1]) == string.lower(effectName) then
				triggerServerEvent("getPlayerEffect", getLocalPlayer(), i)
				break
			end
		end
	end
end )

addEvent("startVoting", true)
addEventHandler("startVoting", getRootElement(), function()
	ongoingVoting = true
	animDirection = true -- up
	boxPosY = screenY*1.2
	timerDecr = 0.3 -- 10 sec
	
	if not chatVoting then chatVoting = true end
	
	bindKey("1", "down", function() vote(1) end )
	bindKey("2", "down", function() vote(2) end )
	bindKey("3", "down", function() vote(3) end )
	bindKey("num_1", "down", function() vote(1) end )
	bindKey("num_2", "down", function() vote(2) end )
	bindKey("num_3", "down", function() vote(3) end )
end )

addEvent("stopVoting", true)
addEventHandler("stopVoting", getRootElement(), function(state)
	ongoingVoting = false
	animDirection = false -- down
	forceVotingOptions = true
	chaosState = state
end )

addEventHandler("onClientPreRender", root, function()
	if displaySource and lowResGaming then
		dxUpdateScreenSource(displaySource)
		dxDrawImage(0.0, 0.0, screenX, screenY, displaySource)
	end
	
	if displaySource and tinyScreen then
		dxUpdateScreenSource(displaySource)
		dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255))
		dxDrawImage(screenX/2 - 128, screenY/2 - ((screenY * 256)/screenX)/2, 256, (screenY * 256)/screenX, displaySource)
	end
	
	if blackWhiteShader and screenSource then
        dxUpdateScreenSource(screenSource)     
        dxSetShaderValue(blackWhiteShader, "screenSource", screenSource)
        dxDrawImage(0, 0, screenX, screenY, blackWhiteShader)
    end
end )

addEventHandler("onClientHUDRender", getRootElement(), function()
	if screenSrc and mirrored then
		dxUpdateScreenSource(screenSrc) 
		dxDrawImage(screenX, 0, -screenX, screenY, screenSrc)
	end
	
	if flippedSource and flippedScreen then
		dxUpdateScreenSource(flippedSource)
		dxDrawImage(0, screenY, screenX, -screenY, flippedSource)
	end
	
	if tiltedSource and tilted then
		dxUpdateScreenSource(tiltedSource)
		dxDrawRectangle(0, 0, screenX, screenY, tocolor(0, 0, 0, 255))
		dxDrawImage(0.0, 0.0, screenX, screenY, tiltedSource, tiltedRot)
	end
	
	if halfSource and halfFrames then
		if halfFrame == 1 then dxUpdateScreenSource(halfSource) end
		halfFrame = halfFrame + 1
		if halfFrame > 1 then halfFrame = 0 end
		dxDrawImage(0.0, 0.0, screenX, screenY, halfSource)
	end
end )

-- OHKO
addEventHandler("onClientVehicleDamage", root, function()
	if OHKO and source == getPedOccupiedVehicle(localPlayer) then blowVehicle(getPedOccupiedVehicle(localPlayer)) end
end )

addEventHandler("onClientResourceStart", resourceRoot, function()
	chaosTimer = setTimer(chaosTimerUpdate, 20, 0)
	setTimer(function() triggerServerEvent("isRaceStarted", getLocalPlayer()) end, 3500, 1)
end )

addEventHandler("onClientResourceStop", resourceRoot, function()
	for i = 1, #activeEffects do clearEffect(activeEffects[1][1]) end
	setWaterLevel(0)
end )

function modifyPosition()
	if getElementType(source) == "vehicle" and source == getPedOccupiedVehicle(localPlayer) then 
		local newZ = getElementDistanceFromCentreOfMassToBaseOfModel(getPedOccupiedVehicle(localPlayer))
		if newZ > 2 then newZ = newZ - 1 end
		if getVehicleType(getPedOccupiedVehicle(localPlayer)) == "Monster Truck" then newZ = newZ + 1 end
		if oldZ == nil then oldZ = newZ end
		
		if oldZ ~= newZ then
			if DEBUG then outputChatBox("oldZ: " ..tostring(oldZ).. "; newZ: " ..tostring(newZ)) end
			
			local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
			setElementPosition(getPedOccupiedVehicle(localPlayer), x, y, z + (newZ - oldZ))
			oldZ = newZ
		end
	end
end

-- Client events
addEventHandler("onClientElementModelChange", getRootElement(), modifyPosition)
addEventHandler("onClientVehicleEnter", getRootElement(), modifyPosition)

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

	return {r * 255, g * 255, b * 255}
end