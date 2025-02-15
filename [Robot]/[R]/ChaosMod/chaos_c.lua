-- Timers
updateTimer = nil
secondTimer = nil
cleanTimer = nil

-- Screen stuff
screenX, screenY = guiGetScreenSize()
screenAspect = math.floor((screenX / screenY)*10)/10

-- Chaos Timer
timerRunning = false
timer = 100 -- %
chaosTimer = nil

-- Effects states
activeEffects = {}
passiveEffects = {}
activeTimers = {}
activeVisualTimers = {}
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
ghostVehicles = false
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

-- Fake Teleport
storedPos = {0, 0, 0}
storedRot = {0, 0, 0}
storedVel = {0, 0, 0}

-- Effects
effects = {
	{ "Double Gravity", 10 }, -- 1 
	{ "Half Gravity", 10 },
	{ "Insane Gravity", 5 },
	{ "Inverted Gravity", 3 },
	{ "Quadruple Gravity", 5 },
	{ "Moon Gravity", 10 },
	{ "Zero Gravity", 3 }, -- 8
	{ "Woozie Mode", 5}, -- 9
	{ "Disable Radar", 20},
	{ "Portrait Mode", 20},
	{ "Nothing", 10}, -- DVD
	{ "Tunnel Vision", 10},
	{ "Foggy Weather", nil},
	{ "Overcast Weather", nil},
	{ "Rainy Weather", nil},
	{ "Sandstorm", nil},
	{ "Sunny Weather", nil},
	{ "Very Sunny Weather", nil},
	{ "Death", nil},
	{ "HESOYAM", nil},
	{ "Invincible", 30},
	{ "All Cars Have Nitro", nil},
	{ "Black Vehicles", 60},
	{ "Pink Vehicles", 60},
	{ "Cars Fly", 20},
	{ "Cars On Water", 20},
	{ "Explode All Vehicles", nil},
	{ "0.25x Game Speed", 10}, -- 28
	{ "0.5x Game Speed", 10},
	{ "2x Game Speed", 10},
	{ "4x Game Speed", 10},
	{ "Always Evening", 60},
	{ "Always Midnight", 60},
	{ "Timelapse", 60}, -- 34
	{ "DE Experience", 60}, -- 35
	{ "Can't See Shit", 20},
	{ "Rain", 30},
	{ "Random Explosion", nil},
	{ "Wheels Only Please", 60},
	{ "Shutdown Engine", 10},
	{ "Disable Respawns", 30},
	{ "Teleport To Grove Street", nil},
	{ "Random Vehicle Mass", 30},
	{ "Rear Wheels Steering", 20},
	{ "Monster Truck'ed", 30},
	{ "Spawn A Ramp", 3},
	{ "Mirrored Controls", 30},
	{ "Teleport", 5}, -- 48
	{ "Random Teleport", nil},
	{ "Spawn Bloodring Banger", nil},
	{ "Spawn Caddy", nil},
	{ "Spawn Dozer", nil},
	{ "Spawn Hunter", nil},
	{ "Spawn Hydra", nil},
	{ "Spawn Monster Truck", nil},
	{ "Spawn Quad", nil},
	{ "Spawn Hotring Racer", nil},
	{ "Spawn Hotring Racer", nil},
	{ "Spawn Rancher", nil},
	{ "Spawn Rhino", nil},
	{ "Spawn Romero", nil},
	{ "Spawn Stretch", nil},
	{ "Spawn Stunt Plane", nil},
	{ "Spawn Tanker", nil},
	{ "Spawn Trashmaster", nil},
	{ "Spawn Vortex", nil},
	{ "Random Vehicle", nil},
	{ "Drive-By Aiming", 10},
	{ "Huge Bunny Hop", 20},
	{ "Vehicle OHKO", 20}, -- 70
	{ "Vehicle Boost", nil},
	{ "Turn Around", nil},
	{ "Spaaaace", nil},
	{ "Pop All Tires", nil},
	{ "Remove Random Tire", 10},
	{ "Random Tire Popping", 20},
	{ "Invert Vehicle Speed", nil},	
	{ "Ignite Current Vehicle", nil},	
	{ "HONK", 60},	
	{ "Ghost Vehicles", 20},	
	{ "Ghost Rider", 60},
	{ "Mouse Control", 20},
	{ "Clear Active Effects", nil},	
	{ "Beyblade", 5},	
	{ "Weird Camera", 10},
	{ "Add Random Blip", nil},	
	{ "Top Camera", 15},	
	{ "Low Res Gaming", 20},
	{ "Mirrored World", 20},	
	{ "Disable One Movement Key", 30},	
	{ "Look Back", 10},
	{ "Disable B", 60},
	{ "Oh The Brakes Is Out", 30},
	{ "Pedal To The Medal", 30},
	{ "Vehicle Bumper Camera", 20},
	{ "Cinematic Camera", 20},
	{ "Reset Camera", nil},
	{ "Death 1%", nil},
	{ "Death 69%", nil},
	{ "Drunk Mode", 20}, -- 100
	{ "Night Vision", 10},
	{ "Thermal Vision", 10},
	{ "Random FOV", 15},
	{ "High FOV", 15},
	{ "Low FOV", 15},
	{ "Goodbye!", 5},
	{ "Nothing 2", 5},
	{ "Randomize Moon Size", nil},
	{ "Stop", nil},
	{ "Randomize Wind Velocity", nil},
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
	{ "8-Bit Steering", 30}, -- 130
	{ "Pimping Ain't Easy", nil},
	{ "Hydraulics Assistance", 30},
	{ "Flying Camera", 10}, 
	{ "Freeze Vehicle", 5},
	{ "meowbot", 60 },
	{ "Next Map Please!", nil},
	{ "Double B", nil},
	{ "Fail Timer", 30}, 
	{ "Disable Horn", 30},
	{ "Everybody Love Randomizers", 30}, -- 140
	{ "Shuffle Paintjobs", 60},
	{ "Rotatory Vehicles", 30},
	{ "Spam Chat", nil},
	{ "Spawn Heatseeking Rockets", nil},
	{ "No Tasks Allowed", 5},
	{ "Randomize Blips", 150},
	{ "Spawn Blista Compact", nil},
	{ "Spawn Faggio", nil},
	{ "Spawn Feltzer", nil},
	{ "Spawn Betsy", nil} -- 150
};

-- Function checks if player is spectating
function isLocalPlayerSpectating()
	local px, py, pz = getElementPosition(localPlayer)
	if getElementData(localPlayer, "state") == "spectating" or pz > 2000 then return true	
	else return false end
end

function update()
	if isLocalPlayerSpectating() then return end
	if not getPedOccupiedVehicle(localPlayer) then return end
	
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
	
	if unlimitedHealth then
		setElementHealth(getPedOccupiedVehicle(localPlayer), 1000)
	end
	
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
	
	if alwaysMidnight then
		setTime(0, 0)
	end
	
	if alwaysEvening then
		setTime(21, 0)
	end
	
	if speedTime then
		local h, m = getTime()
		if m > 60 then 
			m = -10 
			h = h + 1
		end
		
		if h > 24 then
			h = 0
		end
		setTime(h, m+10)
	end
	
	if ghostVehicles then
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
	
	if topCamera then
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		local vel = (vx*vx + vz*vz + vy*vy)*100
		
		if vel >= 70 then vel = 70 end
		setCameraMatrix(x, y, z+15+vel*1.2, x, y, z)
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
end

function secondUpdate()
	if randomTirePopping then
		-- Choose
		local r = math.random(4)
		
		-- Set
		if r == 1 then
			setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 2, 0, 0, 0)
		elseif r == 2 then
			setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 0, 2, 0, 0)
		elseif r == 3 then
			setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 0, 0, 2, 0)
		elseif r == 4 then
			setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 0, 0, 0, 2)
		end
		
		-- Reset
		if isTimer(randomPoppingTimer) then killTimer(randomPoppingTimer) end
		randomPoppingTimer = setTimer(function() setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 0, 0, 0, 0) end, 300, 0)
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
	elseif effect > 27 and effect < 32 then setGameSpeed(1)
	elseif effect == 32 then alwaysEvening = false
	elseif effect == 33 then alwaysMidnight = false
	elseif effect == 34 then speedTime = false
	elseif effect == 35 then setFarClipDistance(800)
	elseif effect == 36 then setFarClipDistance(800)
	elseif effect == 37 then 
		setWeather(0)
		setRainLevel(0)
	elseif effect == 39 then
		for i in pairs(getVehicleComponents(getPedOccupiedVehicle(localPlayer))) do
			setVehicleComponentVisible(getPedOccupiedVehicle(localPlayer), i, true)
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
	elseif effect == 48 then
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
	elseif effect == 80 then ghostVehicles = false
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
	--elseif effect == 107 then restoreAllGameBuildings()
	elseif effect == 111 then jumpingAllowed = false
	elseif effect == 114 then disableUI = false
	elseif effect == 121 then floatingPoint = false
	elseif effect == 122 then honkBoost = false
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
	end
	
	-- Remove Data from old effect
	for i = 1, #activeEffects do
		if activeEffects[i] == effect then
			-- Kill chaos effect timer
			if isTimer(activeTimers[i]) then killTimer(activeTimers[i]) end
			
			-- Remove data of that effect
			table.remove(activeEffects, i)
			table.remove(activeTimers, i)
			table.remove(activeVisualTimers, i)

			break
		end
	end
	
	-- Move effect into passive effects
	table.insert(passiveEffects, effect)
	if #passiveEffects > math.floor(screenY/77) then
		table.remove(passiveEffects, 1)
	end
end

function applyEffect(effect)
	outputDebugString("Triggered effect: " ..effects[effect][1].. " (" ..effect.. ")")
	
	-- Effects
	
	-- Clear effects of same group
	for i = 1, #activeEffects do
		if (effect < 8 and activeEffects[i] < 8) 
		or (effect > 7 and effect < 13 and activeEffects[i] > 7 and activeEffects[i] < 13) 
		or (effect == 23 and activeEffects[i] == 24) 
		or (effect == 24 and activeEffects[i] == 23)
		or (effect > 27 and effect < 35 and activeEffects[i] > 27 and activeEffects[i] < 35) 
		or (effect == 70 and activeEffects[i] == 21)
		or (effect == 85 and activeEffects[i] == 82)
		or (effect == 82 and activeEffects[i] == 85)
		or (effect == 88 and activeEffects[i] == 89)
		or (effect == 89 and activeEffects[i] == 88) 
		or ((effect == 95 or effect == 97) and activeEffects[i] == 96)
		or ((effect == 96 or effect == 97) and activeEffects[i] == 95) 
		or (effect > 49 and effect < 68 and activeEffects[i] == 45)  -- Vehicle spawn effects
		or (effect > 146 and effect < 151 and activeEffects[i] == 45) -- Vehicle spawn effects
		then
			clearEffect(activeEffects[i])
		end
	end
	
	skip = false
	-- Add time if effect is the same
	for i = 1, #activeEffects do
		if effect == activeEffects[i] then
			-- Reset timer of that effect
			if isTimer(activeTimers[i]) then killTimer(activeTimers[i]) end
			activeTimers[i] = setTimer(clearEffect, effects[effect][2]*1000, 1, effect)
			
			-- Reset visual timer
			activeVisualTimers[i] = effects[effect][2]
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
	-- Death
	elseif effect == 19 then setElementHealth(localPlayer, 0) 
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
	-- Explode all Cars
	elseif effect == 27 then 
		for index, vehicles in ipairs(getElementsByType("vehicle")) do blowVehicle(vehicles) end
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
	elseif effect == 39 then
		for i in pairs(getVehicleComponents(getPedOccupiedVehicle(localPlayer))) do
			setVehicleComponentVisible(getPedOccupiedVehicle(localPlayer), i, false)
		end
		setVehicleComponentVisible(getPedOccupiedVehicle(localPlayer), "wheel_rf_dummy", true)
		setVehicleComponentVisible(getPedOccupiedVehicle(localPlayer), "wheel_lf_dummy", true)
		setVehicleComponentVisible(getPedOccupiedVehicle(localPlayer), "wheel_rb_dummy", true)
		setVehicleComponentVisible(getPedOccupiedVehicle(localPlayer), "wheel_lb_dummy", true)
	-- Shutdown Vehicle Engine
	elseif effect == 40 then
		engineDisabled = true
	-- Disable Respawns
	elseif effect == 41 then
		respawnDisabled = true
	-- Teleport to a grove
	elseif effect == 42 then
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
		setElementVelocity(getPedOccupiedVehicle(localPlayer), 0, 0, 0)
		setElementPosition(getPedOccupiedVehicle(localPlayer), math.random(-3000, 3000), math.random(-3000, 3000), -500)
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
	elseif effect == 80 then ghostVehicles = true
	-- Ghost Rider
	elseif effect == 81 then ghostRider = true
	-- Mouse control
	elseif effect == 82 then mouseControl = true
	-- Clear active effects
	elseif effect == 83 then
		for i = 1, #activeEffects do clearEffect(activeEffects[1]) end
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
	-- Destroy World
	--elseif effect == 107 then removeAllGameBuildings()
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
		if r == 42 then
			for i = getElementData(localPlayer, "race.checkpoint"), 100 do
				local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
				if (#colshapes == 0) then break end
				triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer))
			end
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
	elseif effect == 122 then honkBoost = true
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
	end
	
	-- Effect timer
	if effects[effect][2] ~= nil and not skip then -- check if effect even has a timer
		table.insert(activeEffects, effect)
		table.insert(activeTimers, setTimer(clearEffect, effects[effect][2]*1000, 1, effect))
		table.insert(activeVisualTimers, effects[effect][2])
	else
		table.insert(passiveEffects, effect)
		
		if #passiveEffects > math.floor(screenY/77) then
			table.remove(passiveEffects, 1)
		end
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
	if timerRunning and timer > 0 then timer = timer - 0.3 end
end

-- Function updates visual timers of chaos effects
function updateVusialTimers()
	if timerRunning then
		for i = 1, #activeEffects do
			activeVisualTimers[i] = activeVisualTimers[i] - 1
		end
	end
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

-- Event triggered when race starts or player join server midrace
addEvent("raceInit", true)
addEventHandler("raceInit", getRootElement(), function() 
	if not isTimer(updateTimer) then updateTimer = setTimer(update, 20, 0) end
	if not isTimer(secondTimer) then secondTimer = setTimer(secondUpdate, 1000, 0) end
	if not isTimer(cleanTimer)  then cleanTimer  = setTimer(function() 
		if #passiveEffects > 5 then table.remove(passiveEffects, 1) end
	end, 8000, 0) end
	if not isTimer(visualEffectsTimer) then visualEffectsTimer = setTimer(updateVusialTimers, 1000, 0) end
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
	
	if honkBoost then
		local keys = getBoundKeys("horn")
		for keyName, state in pairs(keys) do
			if button == keyName and press then
				local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
				setElementVelocity(getPedOccupiedVehicle(localPlayer), vx*2, vy*2, vz)
				break
			end
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
	-- HUD Effects
	if blindMode then
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
	
	-- Chaos UI
	if not disableUI then
		dxDrawRectangle(0, 0, screenX, screenY / 60, tocolor(0, 0, 0, 255)) -- border
		dxDrawRectangle(3, 0, screenX - 3, screenY / 90, tocolor(20, 112, 53, 255)) -- inside
		dxDrawRectangle(3, 0, ((screenX - 3) / 100)*timer, screenY / 90, tocolor(45, 255, 122, 255)) -- progress
		
		if timer < 0 then timer = 0 end
		if timer/10 < 10 then
			dxDrawText("00:0" ..math.floor(timer/10), screenX / 2, -2, screenX, screenY, tocolor(255, 255, 255, 255), screenY/1080, "default-bold", "left", "top")
		else
			dxDrawText("00:" ..math.floor(timer/10), screenX / 2, -2, screenX, screenY, tocolor(255, 255, 255, 255), screenY/1080, "default-bold", "left", "top")
		end
	end
	
	-- Timed Effects
	local startX = screenX*0.88
	local startY = 250
	for i = 1, #activeEffects do
		if (disableUI and activeEffects[i] == 114) or not disableUI then
			-- Draw Circle
			dxDrawCircle(startX, startY, screenX/75, 0, 360, tocolor(0, 0, 0, 255), tocolor(0, 0, 0, 255), 32, 1, false)
			dxDrawCircle(startX, startY, screenX/80, 0, 360, tocolor(20, 112, 53, 255), tocolor(20, 112, 53, 255), 32, 1, false)
			dxDrawCircle(startX, startY, screenX/80, 0, (activeVisualTimers[i]*360)/effects[activeEffects[i]][2], tocolor(45, 255, 122, 255), tocolor(45, 255, 122, 255), 32, 1, false)
			
			-- Draw Effect Name
			dxDrawBorderedText(1, effects[activeEffects[i]][1], 0, 0, startX-screenX/50, startY+screenX/120, tocolor(225, 225, 225, 255), screenY/1080, "bankgothic", "right", "bottom")
			startY = startY + screenY/15
		end
	end
	
	if disableUI then return end 
	
	-- Usual effects
	local startX2 = screenX*0.05
	local startY2 = 250
	for i = 1, #passiveEffects do
		-- Draw Effect Name
		dxDrawBorderedText(1, effects[passiveEffects[i]][1], startX2, 0, startX2, startY2, tocolor(225, 225, 225, 255), screenY/1080, "bankgothic", "left", "bottom")
		startY2 = startY2 + screenY/30
	end
end )

addEventHandler("onClientPreRender", root, function()
	if displaySource and lowResGaming then
		dxUpdateScreenSource(displaySource)
		dxDrawImage(0.0, 0.0, screenX, screenY, displaySource)
	end
end )

addEventHandler("onClientHUDRender", getRootElement(), function()
	if screenSrc and mirrored then
		dxUpdateScreenSource(screenSrc) 
		dxDrawImage(screenX, 0, -screenX, screenY, screenSrc)
	end
end )

-- OHKO
addEventHandler("onClientVehicleDamage", root, function()
	if OHKO and source == getPedOccupiedVehicle(localPlayer) then blowVehicle(getPedOccupiedVehicle(localPlayer)) end
end )

addEventHandler("onClientResourceStart", resourceRoot, function()
	chaosTimer = setTimer(chaosTimerUpdate, 20, 0)
	triggerServerEvent("isRaceStarted", getLocalPlayer())
end )

addEventHandler("onClientResourceStop", resourceRoot, function()
	for i = 1, #activeEffects do clearEffect(activeEffects[1]) end
end )