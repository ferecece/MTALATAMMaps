screenX, screenY = guiGetScreenSize()
screenAspect = math.floor((screenX / screenY)*10)/10
textMode = 0
-- 1 - 150$
-- 2 - 300$
-- 3 - lvl1
-- 4 - 50000$

disableControlsTimer = nil
playerStoppedInMarkerTimer = nil

stationMarker = nil
stationBlip = nil
laps = 1
stationNumber = 1 
-- 1,6 = Liden Station
-- 2,7 = Yellow Bell Station
-- 3,8 = Cranberry Station
-- 4,9 = Market Station
-- 5,10 = Unity Station

timesDerailed = 0
spectateTriggered = false

addEvent("enableControlsEvent", true)
addEventHandler("enableControlsEvent", getRootElement(), function()
	if isTimer(disableControlsTimer) then killTimer(disableControlsTimer) end
end )

addEventHandler("onClientMapStarting", getLocalPlayer(), function()
	disableControlsTimer = setTimer(disableControls, 1, 0)
	triggerServerEvent("isRaceStarted", getLocalPlayer())
end )

addEvent("postVoteStuff", true)
addEventHandler("postVoteStuff", getRootElement(), function(serverLaps)
	laps = serverLaps
	for index, blip in ipairs(getElementsByType("blip")) do 
		if isElement(blip) then setBlipVisibleDistance(blip, 0) end -- Hide blips
	end

	stationMarker = createMarker(2866.1, 1266.1, 9.9, "checkpoint", 10.0, 255, 0, 0, 255)
	stationBlip = createBlip(2866.1, 1266.1, 9.9, 0, 2, 224, 191, 100)
	setElementData(localPlayer, "Money", 0, true)
	
	playerStoppedInMarkerTimer = setTimer(playerStoppedInMarker, 1, 0)
end )

addEventHandler("onClientPlayerSpawn", getLocalPlayer(), function()
	setTimer(skipZeroMarker, 1000, 1) 
	setTimer(reRailPlayersTrain, 2000, 1)
	
	for index, blip in ipairs(getElementsByType("blip")) do 
		if isElement(blip) then setBlipVisibleDistance(blip, 0) end -- Hide blips
	end
	if isElement(stationBlip) then setBlipVisibleDistance(stationBlip, 16000) end -- Show station's blip
end )

function getDistanceBetweenElements(arg1, arg2)
	if not isElement(arg1) or not isElement(arg2) then return 0 end
	return getDistanceBetweenPoints3D(Vector3(getElementPosition(arg1)), Vector3(getElementPosition(arg2)))
end

addEventHandler("onClientRender", getRootElement(), function()
	-- Spectate check
	if getPedOccupiedVehicle(localPlayer) and getCameraTarget(localPlayer) ~= getPedOccupiedVehicle(localPlayer) then
		if not spectateTriggered then 
			triggerServerEvent("setAlphaForSpectate", getLocalPlayer())
			spectateTriggered = true
		end
		return
	end
	
	if spectateTriggered then
		triggerServerEvent("setAlphaAfterSpectate", getLocalPlayer())
		spectateTriggered = false
	end
	
	if screenAspect >= 1.7 then -- 16:9 screen ratio
		messageSize = 5
		offsets = {0.8, 0.92}
	else -- 4:3 and others screens
		messageSize = 3
		offsets = {0.72, 0.9}
	end
	
	if textMode == 1 then
		dxDrawBorderedText(1, "cargo delivered! $150", 0, 0, screenX, screenY - (screenY * 0.1), tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
	elseif textMode == 2 then 
		dxDrawBorderedText(1, "cargo delivered! $300", 0, 0, screenX, screenY - (screenY * 0.1), tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
	elseif textMode == 3 then
		dxDrawBorderedText(1, "level 1 complete", 0, 0, screenX, screenY - (screenY * 0.1), tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
	elseif textMode == 4 then
		dxDrawBorderedText(1, "mission passed!", 0, 0, screenX, screenY - (screenY * 0.1), tocolor (145, 103, 21, 255), messageSize, "pricedown", "center", "center", true, false)
		dxDrawBorderedText(1, "$50000", 0, screenY * 0.1, screenX, screenY, tocolor (204, 204, 204, 255), messageSize, "pricedown", "center", "center", true, false)
	end
	
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle then return end
	
	if isElement(stationMarker) and getVehicleType(vehicle) == "Train" then
		-- distance
		dxDrawBorderedText(2,"DISTANCE", screenX * offsets[1], screenY * 0.25, screenX, screenY, tocolor(172, 203, 241, 255), 1, "bankgothic")
		dxDrawBorderedText(2, "" ..math.floor(getDistanceBetweenElements(getPedOccupiedVehicle(localPlayer), stationMarker)), screenX * offsets[2], screenY * 0.25, screenX, screenY, tocolor(172, 203, 241, 255), 1, "bankgothic")
		-- speed
		dxDrawBorderedText(2,"SPEED", screenX * offsets[1], screenY * 0.33, screenX, screenY, tocolor(172, 203, 241, 255), 1, "bankgothic")
		dxDrawBorderedText(2,"" ..math.abs(math.floor(getTrainSpeed(getPedOccupiedVehicle(localPlayer))*50.0)) + 1, screenX * offsets[2], screenY * 0.33, screenX, screenY, tocolor(172, 203, 241, 255), 1, "bankgothic")
	end
end)

function disableControls()
	if not getPedOccupiedVehicle(localPlayer) then return end
	setTrainSpeed(getPedOccupiedVehicle(localPlayer), 0.0)
end

function reRailPlayersTrain()
	-- Get player's train
	local playerFreight = getPedOccupiedVehicle(localPlayer)
	if not playerFreight then return end
	if not getVehicleType(playerFreight) == "Train" then return end
	
	if isTrainDerailed(playerFreight) then
		timesDerailed = timesDerailed + 1
		setTrainDirection(playerFreight, false)
		local playerFreightSpeed = getTrainSpeed(playerFreight)
		
		if playerFreightSpeed < -0.8 then 
			setTrainDerailed(playerFreight, false)
			setTrainSpeed(playerFreight, playerFreightSpeed+0.2)
		end
	end
end

function checkpointTrigger()
	local colshapes = getElementsByType("colshape", RACE_RESOURCE)
	triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer), true)
end

function skipZeroMarker()
	-- after Linden Station
	if getElementData(localPlayer, "race.checkpoint") == 7 and stationNumber == 2 then checkpointTrigger() end
	if getElementData(localPlayer, "race.checkpoint") == 35 and stationNumber == 7 then checkpointTrigger() end
	-- after Yellow Bell Station
	if getElementData(localPlayer, "race.checkpoint") == 13 and stationNumber == 3 then checkpointTrigger() end
	if getElementData(localPlayer, "race.checkpoint") == 41 and stationNumber == 8 then checkpointTrigger() end
	-- after Cranberry Station
	if getElementData(localPlayer, "race.checkpoint") == 19 and stationNumber == 4 then checkpointTrigger() end
	if getElementData(localPlayer, "race.checkpoint") == 47 and stationNumber == 9 then checkpointTrigger() end
	-- after Market Station
	if getElementData(localPlayer, "race.checkpoint") == 26 and stationNumber == 5 then checkpointTrigger() end
	if getElementData(localPlayer, "race.checkpoint") == 54 and stationNumber == 10 then checkpointTrigger() end
	-- after Unity Station
	if getElementData(localPlayer, "race.checkpoint") == 27 and stationNumber == 6 then checkpointTrigger() end
end

addEvent("checkpointHit", true)
addEventHandler("checkpointHit", getRootElement(), function()
	for index, blip in ipairs(getElementsByType("blip")) do 
		if isElement(blip) then setBlipVisibleDistance(blip, 0) end -- Hide blips
	end
	if isElement(stationBlip) then setBlipVisibleDistance(stationBlip, 16000) end -- Show station's blip
	
	skipZeroMarker()
end )

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

function playerStoppedInMarker()
	setCameraViewMode(5)
	
	if getPedOccupiedVehicle(localPlayer) and getCameraTarget(localPlayer) ~= getPedOccupiedVehicle(localPlayer) then return end -- Spectate check
	if getElementData(localPlayer, "state") == "spectating" then return end -- Spectate check
	if not getPedOccupiedVehicle(localPlayer) then return end -- If player is not in the train
	if not isElement(stationMarker) then return end -- if station marker did not exists
	if not isElementWithinMarker(getPedOccupiedVehicle(localPlayer), stationMarker) then return end -- if player is not inside station's marker
	
	local vX, vY, vZ = getElementVelocity(getPedOccupiedVehicle(localPlayer))
	if vX*vX + vY*vY + vZ*vZ > 0.001 then return end -- if player is not actually stopped
	
	destroyElement(stationMarker)
	destroyElement(stationBlip)

	-- Yellow Bell
	if stationNumber == 1 or stationNumber == 6 then 
		stationMarker = createMarker(1436.9, 2634, 9.9, "checkpoint", 7.0, 255, 0, 0, 255)
		stationBlip = createBlip(1436.9, 2634, 9.9, 0, 2, 224, 191, 100)
	-- Cranberry Station
	elseif stationNumber == 2 or stationNumber == 7 then 
		stationMarker = createMarker(-1944.6, 154.0, 24.7, "checkpoint", 7.0, 255, 0, 0, 255)
		stationBlip = createBlip(-1944.6, 154.0, 24.7, 0, 2, 224, 191, 100)
	-- Market Station 
	elseif stationNumber == 3 or stationNumber == 8 then
		stationMarker = createMarker(817.2, -1370.9, -2.6, "checkpoint", 7.0, 255, 0, 0, 255)
		stationBlip = createBlip(817.2, -1370.9, -2.6, 0, 2, 224, 191, 100)
	-- Unity Station
	elseif stationNumber == 4 or stationNumber == 9 then
		stationMarker = createMarker(1726.0, -1955.3, 12.6, "checkpoint", 7.0, 255, 0, 0, 255)
		stationBlip = createBlip(1726.0, -1955.3, 12.6, 0, 2, 224, 191, 100)
	-- Liden Station
	elseif stationNumber == 5 then
		textMode = 3 -- level one completed
		
		if laps == 1 then -- Finish if vote 1
			killTimer(playerStoppedInMarkerTimer)
			
			for i = 1, 28 do checkpointTrigger() end
			setCameraViewMode(2)
			
			if timesDerailed ~= 1 then
				outputChatBox("#00FF00You have finished the race and derailed #FF0000" ..timesDerailed.. "#00FF00 times", 255, 255, 255, true)
			else
				outputChatBox("#00FF00You have finished the race and derailed #FF0000" ..timesDerailed.. "#00FF00 time", 255, 255, 255, true)
			end
		else
			stationMarker = createMarker(2866.1, 1266.1, 9.9, "checkpoint", 7.0, 255, 0, 0, 255)
			stationBlip = createBlip(2866.1, 1266.1, 9.9, 0, 2, 224, 191, 100)
		end
	elseif stationNumber == 10 then -- finish if Vote 2
		killTimer(playerStoppedInMarkerTimer)
		
		checkpointTrigger()
		textMode = 4
		setCameraViewMode(2)
		setElementData(localPlayer, "Money", getElementData(localPlayer, "Money")+50000, true)
		outputChatBox("#00FF00You have finished the race and derailed #FF0000" ..timesDerailed.. "#00FF00 times", 255, 255, 255, true)
	end 
	
	if textMode == 0 and textMode ~= 3 then 
		if stationNumber < 6 then 
			textMode = 1 -- 150$
			setElementData(localPlayer, "Money", getElementData(localPlayer, "Money")+150, true)
		else 
			textMode = 2 -- 300$
			setElementData(localPlayer, "Money", getElementData(localPlayer, "Money")+300, true)
		end 
	end
	setTimer(function() textMode = 0 end, 5000, 1)
	
	stationNumber = stationNumber + 1
	checkpointTrigger()
end