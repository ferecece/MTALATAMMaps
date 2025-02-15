-- Josh's (modified)
handling_values = {
	mass                       = {100, 5000     },
    tractionMultiplier         = {5,    20,  10 },
    tractionLoss               = {5,    20,  10 },
    tractionBias               = {20,   80, 100 },        
    engineAcceleration         = {2,    30      },
    brakeDeceleration          = {2,    30      },
    brakeBias                  = {20,   80, 100 },
    suspensionForceLevel       = {3,    40,  10 },
    suspensionLowerLimit       = {-40,  -1, 100 },
    suspensionFrontRearBias    = {10,   90, 100 },
    suspensionDamping          = {0,    10      },
    suspensionHighSpeedDamping = {0,    10      },
    steeringLock               = {4,    60      },
}


-- Tony's
--[[
handling_values = {
	mass                    = {100, 5000     },
	tractionMultiplier      = {2,    20,  10 },
	tractionLoss            = {2,    20,  10 },
	engineAcceleration      = {2,    30      },
	brakeDeceleration       = {2,    25      },
	suspensionForceLevel    = {0.3,  30,  10 },
	suspensionLowerLimit    = {-50,  -1, 100 },
	suspensionFrontRearBias = {100, 900, 1000},
	steeringLock            = {4,    60      },
}
]]

handling_checkpoints = {}
vehicle_id = 421 -- washington

rear_wheel_sizes  = {0x0, 0x1000, 0x2000, 0x4000, 0x8000}
front_wheel_sizes = {0x0, 0x100,  0x200,  0x400,  0x800}

----------------------------------------
-- Events
----------------------------------------

addEvent("onClientRequestHandlingPresets", true)
addEventHandler("onClientRequestHandlingPresets", root, function()
	triggerClientEvent(source, "onServerSendHandlingPresets", resourceRoot, handling_values)
end)

addEventHandler("onResourceStart", resourceRoot, function()
	-- Randomly change time and weather every 10 seconds
	setRandomWeather()
	setTimer(setRandomWeather, 10000, 0)
	
	-- Choose random handling values for each checkpoint
	setupCheckpoints()
	
	-- Set to same FPS limit as server since FPS heavily affects physics
	setFPSLimit(60)
end)

addEventHandler("onResourceStop", resourceRoot, function()
	-- Restore vehicle handling
	for property,_ in pairs(getModelHandling(vehicle_id)) do
		setModelHandling(vehicle_id, property, nil)
	end
end)

addEventHandler("onPlayerReachCheckpoint", root, function(checkpoint, time_)
	local vehicle = getPedOccupiedVehicle(source)
	
	-- Randomly break/remove the vehicle's panels and doors
	breakPanels(vehicle)
	
	-- Set the vehicle's handling to this checkpoint's values
	for property,value in pairs(handling_checkpoints[checkpoint]) do
		if property == "handlingFlags" then
			local flag = value
			flag = flag + rear_wheel_sizes[math.random(1,5)]
			flag = flag + front_wheel_sizes[math.random(1,5)]
			setVehicleHandling(vehicle, "handlingFlags", flag)
		else
			setVehicleHandling(vehicle, property, value)
		end
	end
	
	setVehicleHandling(vehicle, "driveType", "awd") -- Set to AWD to avoid issues with wheels being bad (like in the ground)
	triggerClientEvent(source, "onServerSendHandlingValues", root, handling_checkpoints[checkpoint])
	
	-- Move vehicle up/down when suspension height changes
	local height_change = handling_checkpoints[checkpoint].suspensionLowerLimit - handling_checkpoints[checkpoint-1].suspensionLowerLimit
	local x,y,z = getElementPosition(vehicle)
	setElementPosition(vehicle, x,y,z-height_change + 0.2)
end)

addEventHandler("onPlayerVehicleEnter", root, function(vehicle)
	setTimer(function(source)
		local vehicle = getPedOccupiedVehicle(source)
		local checkpoint = getElementData(source, "race.checkpoint")-1
		
		for property,value in pairs(handling_checkpoints[checkpoint]) do
			setVehicleHandling(vehicle, property, value)
		end
		
		setVehicleHandling(vehicle, "driveType", "awd") -- Set to AWD to avoid issues with wheels being bad (like in the ground)
		triggerClientEvent(source, "onServerSendHandlingValues", root, handling_checkpoints[checkpoint])
		
	end, 1000, 1, source)
end)

----------------------------------------
-- Commands
----------------------------------------

--[[
addCommandHandler("prop", function(player, command, property, value)
	local vehicle = getPedOccupiedVehicle(player)
	setVehicleHandling(vehicle, property, value)
end)

addCommandHandler("hflag", function(player, command, property, value)
	local vehicle = getPedOccupiedVehicle(player)
	setVehicleHandlingFlag(vehicle, property, (value == "true"))
end)
]]

addCommandHandler("getprop", function(player, command, checkpoint)
	for property,value in pairs(handling_checkpoints[tonumber(checkpoint)]) do
		outputChatBox(property .. ": " .. value, player)
	end
end)


----------------------------------------
-- Functions
----------------------------------------

function setupCheckpoints()
	local cpcount = #getElementsByType("checkpoint")
	
	-- Set the 0th entry (start of race) to default Washington stats
	local start_handling = {}
	local default_handling = getModelHandling(vehicle_id)
	for property,values in pairs(handling_values) do
		start_handling[property] = default_handling[property]
	end
	handling_checkpoints[0] = start_handling
	
	-- Generate random values for every checkpoint
	for i=1,cpcount do
		local handling = {}
		
		for property,values in pairs(handling_values) do
			local value = math.random(values[1], values[2])/(values[3] or 1)
			handling[property] = value
		end
		
		local rand = math.random(1,10)
		local flag = 0x0
		
		if rand==7 or rand==8 then
			flag = 0x20
		elseif rand==9 or rand==10 then
			flag = 0x40
		end
		
		-- Randomly set center of mass to 5 meters below ground
		-- Fun, but sometimes causes really broken physics
		--[[
		local rand2 = math.random(1,30)
		if rand2 == 30 then
			handling["centerOfMass"] = {0,0,-5}
		else
			handling["centerOfMass"] = {0,0,-0.1}
		end
		]]
		
		handling["handlingFlags"] = flag
		
		handling_checkpoints[i] = handling
	end
	
	handling_checkpoints[1].suspensionLowerLimit = -0.4
	handling_checkpoints[2].suspensionLowerLimit = -0.1
	handling_checkpoints[3].suspensionLowerLimit = -0.4
end

function breakPanels(vehicle)
	-- Panels
	for i=0,6 do
		local rand = math.random(1,2)
		setVehiclePanelState(vehicle, i, (rand==1 and 0 or 3))
	end
	
	-- Doors
	for i=0,5 do
		local state
		local rand = math.random(1,3)
		
		if rand == 1 then		-- Door shut
			state = (math.random(0,1)==0 and 0 or 2)
		elseif rand == 2 then	-- Door open
			state = (math.random(0,1)==0 and 1 or 3)
		else					-- Door missing
			state = 4
		end
		
		setVehicleDoorState(vehicle, i, state)
	end
end

function setRandomWeather()
	setWeather(math.random(0,19))
	setTime(math.random(0,23), 0)
end