math.randomseed(getTickCount()*math.random(69)*420/69*os.clock())

local MAX_MOVE = 5

local playerState = "not ready"
local spawnX, spawnY, spawnZ
local screenX, screenY = guiGetScreenSize() -- Screen stuff
local screenAspect = math.floor((screenX / screenY)*10)/10

-- Mode
local points = 0
local blips = {}
local nodesData
local introTimer
local oldpos
local keepMove = -5
local showKeepMove = false
local lastAdded = 0
local spawned = false

local mapTexture = dxCreateTexture("map.jpg")

-- Function checks spectate mode
function isLocalPlayerSpectating()
	local px, py, pz = getElementPosition(localPlayer)
	if getElementData(localPlayer, "state") == "spectating" or pz > 20000 then return true	
	else return false end
end

-- Onscreen stuff and seed generation
addEventHandler("onClientRender", getRootElement(), function()
	-- Player State Checks
	local newPlayerState = "not ready"
	
	if getElementData(localPlayer, "state") ~= nil and getElementData(localPlayer, "state") ~= false then
		newPlayerState = getElementData(localPlayer, "state")
		if isLocalPlayerSpectating() then newPlayerState = "spectating" end
	end
	
	if newPlayerState ~= playerState then -- Player race state changed
		if playerState == "spectating" and newPlayerState == "alive" and getElementData(localPlayer, "race.checkpoint") == 1 then 
			setElementPosition(getPedOccupiedVehicle(localPlayer), spawnX, spawnY, spawnZ)
		end
		
		playerState = newPlayerState
		if isLocalPlayerSpectating() then playerState = "spectating" end
	end
	
	if isTimer(introTimer) then 
		dxDrawBorderedText(1, "Everybody spawns at random locations around the map.\nEverybody should keep close to each other to gain points.\nWhoever gets all the points wins.", 0, 0, screenX, screenY*0.75, tocolor (255, 255, 255, 255), screenY/700, "pricedown", "center", "center", true, false)
	end
	
	if keepMove > 0 and playerState ~= "spectating" then
		dxDrawBorderedText(1, "Keep moving! " ..keepMove.. "/" ..MAX_MOVE, 0, 0, screenX, screenY*0.5, tocolor (255, 0, 0, 255), 2, "pricedown", "center", "bottom", true, false)
	end
	
	if getElementData(resourceRoot, "survivor") then 
		local survivor = getElementData(resourceRoot, "survivor")
		--dxDrawBorderedText(1, "Final survivor: " ..getPlayerName(survivor):gsub("#%x%x%x%x%x%x", ""), 0, 0, screenX, screenY*0.5, tocolor (0, 255, 0, 255), 2, "pricedown", "center", "bottom", true, false)
		--dxDrawBorderedText(1, tostring(getElementData(survivor, "points")), 0, 0, screenX, screenY*0.55, tocolor (0, 255, 0, 255), 2, "pricedown", "center", "bottom", true, false)
	end
	
	dxDrawText(points.. "/1000000", screenX / 1.3, screenY /8, screenX, screenY, tocolor(255, 255, 255, 255), screenY/500, "default-bold")
	dxDrawText("+" ..lastAdded, screenX / 1.3, screenY /6, screenX, screenY, tocolor(255, 255, 255, 255), screenY/500, "default-bold")
	
	-- Map
	setPlayerHudComponentVisible("radar", false)
	
	if spawned then
		local centerX, centerY = screenX*0.05, screenY/2
		
		if screenAspect < 1.7 then centerX = screenX*0.05 end
		
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
		
		-- Keep aspect ratio
		local aspect = (maxX-minX)/(maxY-minY)
		if aspect > 4.5 then
			local add = (((maxX - minX) / 4.5) - (maxY-minY)) / 2
			
			if maxY + add > 3000 then minY = minY - add
			else maxY = maxY + add end
			
			if minY - add < -3000 then maxY = maxY + add
			else minY = minY - add end
		elseif aspect < 1 then
			local add = ((maxY-minY) - (maxX-minX)) / 2
			
			maxX = maxX + add
			minX = minX - add
		end

		maxX = math.min(maxX + 100, 3000)
		minX = math.max(minX - 100, -3000)
		maxY = math.min(maxY + 100, 3000)
		minY = math.max(minY - 100, -3000)

		local u = 1024 + minX * (1024/3000)
		local v = 1024 - maxY * (1024/3000)
		
		local usize = (1024 + maxX * (1024/3000)) - u
		local vsize = (1024 - minY * (1024/3000)) - v
		
		local image_width = (usize / vsize) * (screenY*0.5 - screenY*0.25)
		local image_height = screenY*0.5 - screenY*0.25
		
		local box_width = screenX*0.98 - screenX*0.7
		if centerX/2 + image_width > screenX*0.05 + (screenX*0.98 - screenX*0.7) then
			box_width = (centerX/2 + image_width) - (screenX*0.05 + (screenX*0.98 - screenX*0.7)) + box_width + (screenX*0.06 - screenX*0.05)
		end
		
		dxDrawRectangle(centerX/2 - screenX*0.01, screenY*0.6, image_width + screenX*0.02, image_height + screenY*0.04, tocolor(0, 0, 0, 200, 50))
		dxDrawImageSection(centerX/2, screenY*0.62, image_width, image_height, u, v, usize, vsize, mapTexture)
		
		-- Draw CPs
		for _, players in ipairs(getElementsByType("player")) do
			if getPedOccupiedVehicle(players) then
				local pX, pY, pZ = getElementPosition(getPedOccupiedVehicle(players))
				
				if pZ < 20000 and getElementHealth(players) > 10 then
					pX = math.min(pX, maxX)
					pX = math.max(pX, minX)
					pY = math.min(pY, maxY)
					pY = math.max(pY, minY)
				
					local x = (pX - minX) / ((maxX - minX) / image_width)
					local y = (pY - maxY) / ((minY - maxY) / image_height)
					
					if players == localPlayer then
						local closestPlayer
						local closestDistance = 90000
						for p, player in ipairs(getElementsByType("player")) do
							if player ~= localPlayer then
								local x, y, z = getElementPosition(localPlayer)
								local px, py, pz = getElementPosition(player)
								
								if pz < 20000 and getElementHealth(player) > 10 then
									local distance = getDistanceBetweenPoints2D(x, y, px, py)
									if distance < closestDistance and distance > 60 then
										closestDistance = distance
										closestPlayer = player
									end
								end
							end
						end
						
						if closestPlayer ~= nil then
							local u, w, v = getElementPosition(localPlayer)
							local h, j, k = getElementPosition(closestPlayer)
							
							u = math.min(u, maxX)
							u = math.max(u, minX)
							w = math.min(w, maxY)
							w = math.max(w, minY)
							
							h = math.min(h, maxX)
							h = math.max(h, minX)
							j = math.min(j, maxY)
							j = math.max(j, minY)
							
							u = (u - minX) / ((maxX - minX) / image_width)
							w = (w - maxY) / ((minY - maxY) / image_height)
							
							h = (h - minX) / ((maxX - minX) / image_width)
							j = (j - maxY) / ((minY - maxY) / image_height)
							
							dxDrawLine(centerX/2 + u, (screenY*0.62) + w, centerX/2 + h, (screenY*0.62) + j, tocolor(0, 255, 0, 255))
						end
					end
					
					if players == localPlayer then 
						dxDrawCircle(centerX/2 + x, (screenY*0.62) + y, 6, 0, 360, tocolor(math.random(255), 0, 0, 255))
					else dxDrawCircle(centerX/2 + x, (screenY*0.62) + y, 4, 0, 360, tocolor(math.random(255), math.random(255), math.random(255), 255)) end
				end
			end
		end
	end
end )

function updatePoints()
	if isLocalPlayerSpectating() then return end
	local x, y, z = getElementPosition(localPlayer)
	
	if oldpos == nil then oldpos = {x, y, z}
	else
		if getDistanceBetweenPoints3D(oldpos[1], oldpos[2], oldpos[3], x, y, z) < 6 then 
			keepMove = keepMove + 1
			
			if keepMove == MAX_MOVE then
				setElementHealth(localPlayer, 0)
			end
			
			if keepMove > MAX_MOVE then keepMove = MAX_MOVE end
		else
			keepMove = keepMove - 1
			if keepMove < 0 then 
				keepMove = 0 
			end
		end
		
		oldpos = {x, y, z}
	end
	
	-- Add points based on distance to others players
	lastAdded = 0
	for i, players in ipairs(getElementsByType("player")) do
		if players ~= localPlayer then
			local px, py, pz = getElementPosition(players)
			local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
			
			if pz < 25000 and getElementHealth(players) > 10 then 				
				if keepMove == 0 then 
					points = points + math.max(500 - math.floor(distance), 0)
					setElementData(localPlayer, "points", points)
					lastAdded = lastAdded + math.max(500 - math.floor(distance), 0)
				else lastAdded = 0 end
				
				-- Handle Blips
				if not isElement(blips[players]) and distance > 50 then
					blips[players] = createBlip(0, 0, 0, 37)
					attachElements(blips[players], players)
					setBlipVisibleDistance(blips[players], 10000)
				end
			end 
			
			-- Destroy blips
			if isElement(blips[players]) and (distance < 50 or pz > 25000) then
				destroyElement(blips[players])
			end
		end
	end
	
	-- Checkpoints stuff
	local difference = math.floor(points / 40000) - getElementData(localPlayer, "race.checkpoint") + 1
	for i = 1, difference do
		local colshapes = getElementsByType("colshape", getResourceDynamicElementRoot(getResourceFromName("race")))
		if #colshapes ~= 0 then  
			triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer))
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

-- Event called from the server for client to process current race data
addEvent("spawn", true)
addEventHandler("spawn", localPlayer, function()
	local randomNode = math.random(#nodesData)
	setElementPosition(getPedOccupiedVehicle(localPlayer), nodesData[randomNode][1], nodesData[randomNode][2], nodesData[randomNode][3] + 2)
	
	-- Set Timer for updating points
	if isTimer(pointsTimer) then killTimer(pointsTimer) end
	pointsTimer = setTimer(updatePoints, 1000, 0)
	spawned = true
	
	-- Message 
	outputChatBox("#E7D9B0The #00FF00closer #E7D9B0you are to other players the more points you will get per #00FF00second", 0, 0, 0, true)
end )

addEventHandler("onClientResourceStart", resourceRoot, function()
	-- Load Nodes File
	local file = fileOpen("nodes.json", true)
	local contents = fileRead(file, fileGetSize(file))
	fileClose(file)
	nodesData = fromJSON(contents)
	
	introTimer = setTimer(function() end, 15000, 1)
end )