local planePushTimer
local nodesData
local spawned = false

-- Cabine
local attachedTo = nil
local arrows = {}
local angle = 0
local offsets = {
	{0.012, 3, 0.507},
	{0.075, 3, 0.507},
	{0.004, 3, 0.448},
	{0.052, 3, 0.448},
	{0.097, 3, 0.448}
}
local shader = dxCreateShader("shader.fx")
local mapTexture = dxCreateTexture("map.jpg")
local renderTarget = dxCreateRenderTarget(640, 480)
local cabinLight
local dangerState = false

-- Cameras
local currentCamera = 1
local cameras = {
	{0.0, 2.3, 0.6},
	{0.0, 2.8, 0.8}
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
	
	if dangerState then
		local r, g, b = getLightColor(cabinLight)
		if r == 255 and g == 0 and b == 0 then
			setLightColor(cabinLight, 255, 255, 255)
		else
			setLightColor(cabinLight, 255, 0, 0)
		end
	end
end

function convertCoordsToDisplayPos(pos, max_x, min_x, max_y, min_y)
	pos[1] = math.min(pos[1], max_x)
	pos[1] = math.max(pos[1], min_x)
	pos[2] = math.min(pos[2], max_y)
	pos[2] = math.max(pos[2], min_y)
	
	pos[1] = (pos[1] - min_x) / ((max_x - min_x) / 640)
	pos[2] = (pos[2] - max_y) / ((min_y - max_y) / 480)
	
	return pos
end

function updateScreen()
	dxSetRenderTarget(renderTarget, true)
	
	-- Bounds detection
	local maxX, maxY = -6000, -6000
	local minX, minY = 6000, 6000
	
	for _, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then
			local x, y, z = getElementPosition(getPedOccupiedVehicle(players))
			
			if z < 20000 and getElementHealth(players) > 10 then
				maxX = math.max(x, maxX)
				maxY = math.max(y, maxY)
			
				minX = math.min(x, minX)
				minY = math.min(y, minY)
			end
		end
	end
	
	for _, projectiles in ipairs(getElementsByType("projectile")) do
		local x, y, z = getElementPosition(projectiles)
		
		maxX = math.max(x, maxX)
		maxY = math.max(y, maxY)
	
		minX = math.min(x, minX)
		minY = math.min(y, minY)
	end
	
	maxX = math.min(maxX + 300, 3000)
	minX = math.max(minX - 300, -3000)
	maxY = math.min(maxY + 300, 3000)
	minY = math.max(minY - 300, -3000)
	
	-- Keep aspect ratio
	local aspect = (maxX-minX)/(maxY-minY)
	if aspect ~= 640/480 then
		local add = (((maxX - minX) / (640/480)) - (maxY-minY)) / 2
		
		if maxY + add > 3000 then minY = minY - add
		else maxY = maxY + add end
		
		if minY - add < -3000 then maxY = maxY + add
		else minY = minY - add end
	end

	local u = 1024 + minX * (1024/3000)
	local v = 1024 - maxY * (1024/3000)
	
	local usize = (1024 + maxX * (1024/3000)) - u
	local vsize = (1024 - minY * (1024/3000)) - v
	
	dxDrawImageSection(0, 0, 640, 480, u, v, usize, vsize, mapTexture)
	
	-- Draw CPs
	for _, players in ipairs(getElementsByType("player")) do
		if getPedOccupiedVehicle(players) then
			local pX, pY, pZ = getElementPosition(getPedOccupiedVehicle(players))
			
			if pZ < 20000 and getElementHealth(players) > 10 then
				for i, projectiles in ipairs(getElementsByType("projectile")) do
					local projectileScreenPos = convertCoordsToDisplayPos({getElementPosition(projectiles)}, maxX, minX, maxY, minY)
					local attachedToScreenPos = convertCoordsToDisplayPos({getElementPosition(attachedTo)}, maxX, minX, maxY, minY)
					
					if getProjectileTarget(projectiles) then
						projectileTargetScreenPos = convertCoordsToDisplayPos({getElementPosition(getProjectileTarget(projectiles))}, maxX, minX, maxY, minY) 
					end
						
					if getProjectileTarget(projectiles) == attachedTo then
						dxDrawLine(projectileScreenPos[1], projectileScreenPos[2], attachedToScreenPos[1], attachedToScreenPos[2], tocolor(255, 0, 0, 255), 5)
						dxDrawCircle(projectileScreenPos[1], projectileScreenPos[2], 8, 0, 360, tocolor(255, 0, 0, 255))
					else
						if getProjectileTarget(projectiles) then 
							dxDrawLine(projectileScreenPos[1], projectileScreenPos[2], projectileTargetScreenPos[1], projectileTargetScreenPos[2], tocolor(255, 255, 255, 255), 5)
						end
						
						if getProjectileType(projectiles) ~= 58 then
							dxDrawCircle(projectileScreenPos[1], projectileScreenPos[2], 8, 0, 360, tocolor(255, 255, 255, 255))
						end
					end
				end
					
				pX = math.min(pX, maxX)
				pX = math.max(pX, minX)
				pY = math.min(pY, maxY)
				pY = math.max(pY, minY)
			
				local x = (pX - minX) / ((maxX - minX) / 640)
				local y = (pY - maxY) / ((minY - maxY) / 480)
				
				if players == localPlayer then
					local closestPlayer, closestDistance = nil, 90000
					for p, player in ipairs(getElementsByType("player")) do
						if player ~= localPlayer then
							local x, y, z = getElementPosition(localPlayer)
							local px, py, pz = getElementPosition(player)
							
							if pz < 20000 and getElementHealth(player) > 10 then
								local distance = getDistanceBetweenPoints2D(x, y, px, py)
								if distance < closestDistance and distance > 60 then
									closestPlayer = player
								end
							end
						end
					end
					
					if closestPlayer ~= nil then
						local localPlayerScreenPos = convertCoordsToDisplayPos({getElementPosition(localPlayer)}, maxX, minX, maxY, minY)
						local closetPlayerScreenPos = convertCoordsToDisplayPos({getElementPosition(closestPlayer)}, maxX, minX, maxY, minY)
						
						dxDrawLine(localPlayerScreenPos[1], localPlayerScreenPos[2], closetPlayerScreenPos[1], closetPlayerScreenPos[2], tocolor(0, 255, 0, 255), 5)
					end
				end
				
				if players == localPlayer then dxDrawCircle(x, y, 20, 0, 360, tocolor(0, 0, 255, 255))
				else dxDrawCircle(x, y, 10, 0, 360, tocolor(0, 255, 0, 255)) end
			end
		end
	end
	
	dxSetRenderTarget()
end

addEventHandler("onClientProjectileCreation", root, function()
	if not attachedTo then return end 
	
	if getProjectileTarget(source) == attachedTo then dangerState = true
	else dangerState = false end
end )

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
			setProjectileCounter(createProjectile(localPlayer, 20, dangerZones[detectedZone][1], dangerZones[detectedZone][2], dangerZones[detectedZone][3] + 5, 200.0, getPedOccupiedVehicle(localPlayer)), 70000)
			zoneTimers[detectedZone] = setTimer(function() end, 5000, 1)
		end
	end
end )

addEventHandler("onClientRender", getRootElement(), function()
	if not getPedOccupiedVehicle(localPlayer) then return end 
	
	updateScreen()
	setVehicleAdjustableProperty(getPedOccupiedVehicle(localPlayer), 5000)
	
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
			detachElements(cabinLight)
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
					attachElements(cabinLight, attachedTo, cameras[currentCamera][1], cameras[currentCamera][2], cameras[currentCamera][3])
					
					for i = 1, #arrows do 
						detachElements(arrows[i])
						attachElements(arrows[i], attachedTo, 0, 0, 0)
					end
				end	
			else 
				attachElements(getCamera(), getPedOccupiedVehicle(localPlayer), cameras[currentCamera][1], cameras[currentCamera][2], cameras[currentCamera][3], 0, 0, lookBack)
				attachElements(cabinLight, getPedOccupiedVehicle(localPlayer), cameras[currentCamera][1], cameras[currentCamera][2], cameras[currentCamera][3])
				
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
				
				setElementPosition(getPedOccupiedVehicle(localPlayer), newNodes[randomNode][1], newNodes[randomNode][2], newNodes[randomNode][3] + math.random(100, 155))
				setElementRotation(getPedOccupiedVehicle(localPlayer), 0, 0, math.random(360))
				
				setVehicleLandingGearDown(getPedOccupiedVehicle(localPlayer), false)
				
				spawned = true
			end
		end
	end
	
	if attachedTo ~= nil then
		local x, y, altitude = getElementPosition(attachedTo)
		local rx, ry, rz = getElementRotation(attachedTo)
		local vx, vy, vz = getElementVelocity(attachedTo)
		local zSpeed
		
		if vz > 0 then zSpeed = math.min((vz * 195) + 90, 270)
		else zSpeed = math.max((vz * 195) + 90, -90) end
		
		if lookBack == 0 then setElementAlpha(getVehicleOccupant(attachedTo), 0)
		else setElementAlpha(getVehicleOccupant(attachedTo), 255) end 
		
		local data = {
			(Vector3(vx, vy, vz).length * 195) + 176, -- Air Speed
			zSpeed, -- Vertical Speed
			rz + 180, -- Course
			altitude + 180, -- Altitude
			getElementHealth(attachedTo) / 3 -- Plane's Health
		}
		
		-- update 
		for i = 1, #offsets do setElementAttachedOffsets(arrows[i], offsets[i][1], offsets[i][2], offsets[i][3], -20, data[i], 0) end
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
	
	engineImportTXD(engineLoadTXD("hydra.txd"), 520)
	engineReplaceModel(engineLoadDFF("hydra.dff"), 520)
	setTimer(update, 1000, 0)
	
	engineReplaceModel(engineLoadDFF("needle.dff"), 1946)
	for i = 1, 5 do arrows[i] = createObject(1946, 0, 0, 0) end
	
	setObjectScale(arrows[3], 0.55)
	setObjectScale(arrows[4], 0.55)
	setObjectScale(arrows[5], 0.55)
	
	cabinLight = createLight(0, 0, 0, 0, 20, 255, 255, 255)
	
	-- Cols
	for i = 1, #dangerZones do
		dangerCols[i] = createColCircle(dangerZones[i][1], dangerZones[i][2], 120)
	end
	
	engineApplyShaderToWorldTexture(shader, "hydra_screen")
	dxSetShaderValue(shader, "gTexture", renderTarget)
end )