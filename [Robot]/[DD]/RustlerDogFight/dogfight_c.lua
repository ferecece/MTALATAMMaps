local planePushTimer
local nodesData
local spawned = false

-- Cabine
local attachedTo = nil
local arrows = {}
local angle = 0

-- Cameras
local currentCamera = 1
local cameras = {
	{-0.0, -0.8, 0.4},
	{-0.0, 0.5, 0.5}
}
local lookBack = 0

-- Rockets
local dangerCols = {nil, nil, nil, nil, nil, nil}
local zoneTimers = {nil, nil, nil, nil, nil, nil}
local dangerZones = {
	{238, 1696.6, 25.3},
	{354, 2027.8, 25.1},
	{188, 2081.2, 25.3},
	{15.7, 1719.5, 25.3},
	{-1324.1, 494.3, 24.1},
	{-1394.5, 494.4, 21.1}
}

function update()
	if not getPedOccupiedVehicle(localPlayer) then return end 
	
	local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
	if getDistanceBetweenPoints2D(x, 0, 0, 0) > 3000 or getDistanceBetweenPoints2D(0, y, 0, 0) > 3000 then
		setElementHealth(getPedOccupiedVehicle(localPlayer), getElementHealth(getPedOccupiedVehicle(localPlayer)) - 30)
	end
end

addEventHandler("onClientColShapeHit", root, function(element, matchingDimension)
	if not getPedOccupiedVehicle(localPlayer) then return end 
	
	if element == getPedOccupiedVehicle(localPlayer) then
		local detectedZone = nil
		for i = 1, #dangerCols do
			if source == dangerCols[i] then
				detectedZone = i
				break
			end
		end
		
		if not isTimer(zoneTimers[detectedZone]) then 
			setProjectileCounter(createProjectile(localPlayer, 20, dangerZones[detectedZone][1], dangerZones[detectedZone][2], dangerZones[detectedZone][3] + 5, 200.0, localPlayer), 300000)
			zoneTimers[detectedZone] = setTimer(function() end, 5000, 1)
		end
	end
end )

addEventHandler("onClientRender", getRootElement(), function()
	if not getPedOccupiedVehicle(localPlayer) then return end 
	if isVehicleWheelOnGround(getPedOccupiedVehicle(localPlayer), 0) or isVehicleWheelOnGround(getPedOccupiedVehicle(localPlayer), 1) or isVehicleWheelOnGround(getPedOccupiedVehicle(localPlayer), 2) or isVehicleWheelOnGround(getPedOccupiedVehicle(localPlayer), 3) then
		setElementHealth(localPlayer, 0)
		blowVehicle(getPedOccupiedVehicle(localPlayer))
	end
	
	local health = getElementHealth(getPedOccupiedVehicle(localPlayer))
	if health < 500 and health > 400 then 
		setVehiclePanelState(getPedOccupiedVehicle(localPlayer), 0, 2)
		setVehiclePanelState(getPedOccupiedVehicle(localPlayer), 1, 2)
	elseif health < 400 then 
		setVehiclePanelState(getPedOccupiedVehicle(localPlayer), 0, 3)
		setVehiclePanelState(getPedOccupiedVehicle(localPlayer), 1, 3)
	elseif health < 10 then
		setVehicleEngineState(getPedOccupiedVehicle(localPlayer), false)
		setVehicleRotorSpeed(getPedOccupiedVehicle(localPlayer), 0)
	end

	if attachedTo == getPedOccupiedVehicle(localPlayer) and (getElementHealth(getPedOccupiedVehicle(localPlayer)) == 0 or getElementHealth(localPlayer) == 0) then
		for i = 1, #arrows do 
			detachElements(arrows[i]) 
			setElementPosition(arrows[i], 0, 0, 0)
		end
	end
	
	local cameraTarget = getCameraTarget()
	if cameraTarget then
		if getElementType(cameraTarget) == "vehicle" then
			if cameraTarget ~= getPedOccupiedVehicle(localPlayer) then
				-- Spectate mode
				if attachedTo ~= cameraTarget then
					attachedTo = cameraTarget -- vehicle
					attachElements(getCamera(), attachedTo, cameras[currentCamera][1], cameras[currentCamera][2], cameras[currentCamera][3], 0, 0, lookBack)
					
					for i = 1, #arrows do 
						detachElements(arrows[i])
						attachElements(arrows[i], attachedTo, 0, 0, 0)
					end
				end	
			else 
				--attachElements(getCamera(), getPedOccupiedVehicle(localPlayer), -0.0, 2.5, 0.6)  -- hydra
				attachElements(getCamera(), getPedOccupiedVehicle(localPlayer), cameras[currentCamera][1], cameras[currentCamera][2], cameras[currentCamera][3], 0, 0, lookBack)
				
				for i = 1, #arrows do attachElements(arrows[i], getPedOccupiedVehicle(localPlayer), 0, 0, 0) end
				attachedTo = getPedOccupiedVehicle(localPlayer) -- vehicle
			end
		
			if planePushTimer == nil then 
				if isTimer(planePushTimer) then killTimer(planePushTimer) end
				planePushTimer = setTimer(function() 
					if not isElementFrozen(getPedOccupiedVehicle(localPlayer)) then
						local matrix = getElementMatrix(getPedOccupiedVehicle(localPlayer))
						local x, y, z = matrix[2][1]*5, matrix[2][2]*5, matrix[2][3]
						setElementVelocity(getPedOccupiedVehicle(localPlayer), x, y, z)
						
						killTimer(planePushTimer)
						planePushTimer = "fuck off"
					end
				end, 50, 0)
			end
			
			if isElementFrozen(getPedOccupiedVehicle(localPlayer)) and not spawned then 
				local newNodes = {}
				for i = 1, #nodesData do
					if getDistanceBetweenPoints2D(-1293.1, 2305.8, nodesData[i][1], nodesData[i][2]) < 1000 then
						table.insert(newNodes, nodesData[i])
					end
				end
		
				math.randomseed(math.floor(getTickCount()/math.random(69)*os.clock()))
				local randomNode = math.random(#newNodes)
				
				setElementPosition(getPedOccupiedVehicle(localPlayer), newNodes[randomNode][1], newNodes[randomNode][2], newNodes[randomNode][3] + math.random(50, 120))
				setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, math.random(360))
				
				setVehicleLandingGearDown(getPedOccupiedVehicle(localPlayer), false)
				setVehicleComponentVisible(getPedOccupiedVehicle(localPlayer), "door_lf", false)
				
				spawned = true
			end
		end
	end
	
	if attachedTo ~= nil then
		local x, y, altitude = getElementPosition(attachedTo)
		local rx, ry, rz = getElementRotation(attachedTo)
		
		local data = {
			Vector3(getElementVelocity(attachedTo)).length * 220, -- Speed
			altitude, -- Altitude
			altitude * 10, -- Altitude * 10
			getElementHealth(attachedTo) / 3, -- Plane's Health
			getVehicleRotorSpeed(getPedOccupiedVehicle(localPlayer)) * 1000 -- Plane's rotor's speed
		}
		
		local offsets = {
			{-0.085, 0.5, 0.25},
			{0.085, 0.5, 0.25},
			{-0.185, 0.4, 0.095},
			{0, 0.4, 0.095},
			{0.185, 0.4, 0.095}
		}
		
		-- update 
		for i = 1, #offsets do
			setElementAttachedOffsets(arrows[i], offsets[i][1], offsets[i][2], offsets[i][3], -20, data[i], 0)
		end
	end
end )

addEventHandler("onClientKey", root, function(button, press)
	if isChatBoxInputActive() then return end
	
	if press then
		for keyName, state in pairs(getBoundKeys("change_camera")) do
			if button == keyName then
				-- Player pressed "camera change" button	
				currentCamera = currentCamera + 1
				if currentCamera > #cameras then currentCamera = 1 end
				setElementAttachedOffsets(getCamera(), cameras[currentCamera][1], cameras[currentCamera][2], cameras[currentCamera][3], 0, 0, lookBack)
				
				break
			end
		end
	end
	
	for keyName, state in pairs(getBoundKeys("look_behind")) do
		if button == keyName and press then
			lookBack = 180
			setElementAttachedOffsets(getCamera(), cameras[currentCamera][1], cameras[currentCamera][2] + 1, cameras[currentCamera][3], 0, 0, lookBack)
			break
		elseif button == keyName and not press then
			lookBack = 0
			setElementAttachedOffsets(getCamera(), cameras[currentCamera][1], cameras[currentCamera][2], cameras[currentCamera][3], 0, 0, lookBack)
			break
		end
	end
end )

addEventHandler("onClientResourceStart", resourceRoot, function()
	-- Load Nodes File
	local file = fileOpen("nodes.json", true)
	local contents = fileRead(file, fileGetSize(file))
	fileClose(file)
	nodesData = fromJSON(contents)
	
	engineReplaceModel(engineLoadDFF("rustler.dff"), 476)
	setTimer(update, 1000, 0)
	
	engineReplaceModel(engineLoadDFF("junk_tyre.dff"), 1946)
	for i = 1, 5 do arrows[i] = createObject(1946, 0, 0, 0) end
	
	-- Cols
	for i = 1, #dangerZones do
		dangerCols[i] = createColCircle(dangerZones[i][1], dangerZones[i][2], 120)
	end
end )