local tvs = {}
local tvPos = {
	{-0.7002, -2.4, 0.15},
    {-0.1, -2.4, 0.2},
    {0.5, -2.4, 0.2},
    {0.5, -2.4, 0.8},
    {-0.1, -2.3, 0.8},
    {-0.7, -2.4, 0.7},
    {-0.7, -2.4, 1.2},
    {-0.1, -2.3, 1.3},
    {0.5, -2.4, 1.3},
    {0.6, -2.9, 0.2},
    {-0.1, -2.9, 0.2},
    {-0.7, -2.9, 0.2},
    {-0.7, -2.9, 0.8},
    {-0.7, -2.9, 1.4},
    {-0.1, -2.9, 0.8},
    {-0.1, -2.9, 1.3},
    {0.6, -2.9, 0.7},
    {0.6, -2.9, 1.3}
}
screenX, screenY = guiGetScreenSize()
local failed = false
local brakesHasFailed = false
local otherTVs = {}
local streak
local stuntCamera = false
local colSphere
local finished = false
local firstSpawn = true

-- music
local songStarted = false
local songOn = false
local song = nil

addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(vehicle)
	if songOn then setRadioChannel(0) end
	if firstSpawn then
		addCommandHandler("togglemusic", toggleSong)
		bindKey("m", "down", "togglemusic")
		outputChatBox("Press M to turn the music ON/OFF")
		firstSpawn = false
		
		for i = 1, #tvs do
			attachElements(tvs[i], getPedOccupiedVehicle(localPlayer), tvPos[i][1], tvPos[i][2], tvPos[i][3])
		end
		setElementData(getPedOccupiedVehicle(localPlayer), "tvs", 18)
	end
end )

function toggleSong()
	if not songStarted then
		song = playSound("music.mp3", true)
		setSoundVolume(song, 0.8)
		
		songOn = true
		songStarted = true
	else
		if songOn then
			setSoundVolume(song, 0)
			songOn = false
		else
			setSoundVolume(song, 0.8)
			setRadioChannel(0)
			songOn = true
		end
	end
end

addEventHandler("onClientPlayerRadioSwitch", getRootElement(), function()
	if songOn then cancelEvent() end
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

addEventHandler("onClientResourceStart", resourceRoot, function()
	engineReplaceModel(engineLoadDFF("benson.dff"), 499)
	
	for i = 1, #tvPos do
		table.insert(tvs, createObject(1518, 0.0, 0.0, 0.0))
	end
	
	--setTimer(function()
	--	for i = 1, #tvs do
	--		attachElements(tvs[i], getPedOccupiedVehicle(localPlayer), tvPos[i][1], tvPos[i][2], tvPos[i][3])
	--	end
	--	setElementData(getPedOccupiedVehicle(localPlayer), "tvs", 18)
	--end, 5000, 1)
	
	local freight = createVehicle(537, 2244.9004, -2089.3994, 15.1, 0, 0, -134)
	setTrainDerailed(freight, true)
	setElementFrozen(freight, true)
	
	streak = {
		[1] = createVehicle(538, 1925.0, -1954, 15.1, 0, 0, 90),
		[2] = createVehicle(570, 1943.5, -1954, 15.1, 0, 0, -90),
		[3] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[4] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[5] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[6] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[7] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[8] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[9] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[10] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[11] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[12] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[13] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[14] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[15] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[16] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[17] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[18] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[19] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[20] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90),
		[21] = createVehicle(570, 1964.2, -1954, 15.1, 0, 0, -90)
	}
	
	for i = 1, #streak do
		detachTrailerFromVehicle(streak[i])
		setTrainDirection(streak[i], not getTrainDirection(streak[i]))
	end
	
	for i = 1, #streak do
		if i > 1 then attachTrailerToVehicle(streak[i-1], streak[i]) end
	end
	
	colSphere = createColSphere(2375.2, -2015.5, 15.6, 5)
end )

addEventHandler("onClientElementColShapeHit", getRootElement(), function(shape, dim)
	if source == getPedOccupiedVehicle(localPlayer) and shape == colSphere then
		destroyElement(colSphere)
		setGameSpeed(0.25)
		stuntCamera = true
		
		setTimer(function() 
			setGameSpeed(1.0)
			stuntCamera = false
			setCameraTarget(localPlayer)
		end, 6000, 1)
	end
end )

addEventHandler("onClientVehicleCollision", root, function(a, b)
	local loss = b * getVehicleHandling(source).collisionDamageMultiplier * 0.1
	if source == getPedOccupiedVehicle(localPlayer) and not isTimer(timeout) and loss > 3 and not finished then
		local x, y, z = getElementVelocity(getPedOccupiedVehicle(localPlayer))
		if Vector3(getElementVelocity(getPedOccupiedVehicle(localPlayer))).length < 0.1 then return end
		
		if #tvs > 0 then
			detachElements(tvs[#tvs])
			setElementVelocity(tvs[#tvs], -x*0.005, -y*0.005, 0.05)
			
			setElementData(getPedOccupiedVehicle(localPlayer), "tvs", #tvs-1)
			destroyTVs(getPedOccupiedVehicle(localPlayer))
			createTVs(getPedOccupiedVehicle(localPlayer))
		end
		
		timeout = setTimer(function()
			destroyElement(tvs[#tvs])
			table.remove(tvs)
			
			
			-- mission failed
			if #tvs == 0 then
				blowVehicle(getPedOccupiedVehicle(localPlayer))
				failed = true
				setTimer(function() failed = false end, 6000, 1)
			end
		end, 2000, 1)
	end
end )

function createTVs(vehicle)
	local getTVs = getElementData(vehicle, "tvs")
	if tonumber(getTVs) == false or tonumber(getTVs) == nil then getTVs = 0 end 
	
	otherTVs[vehicle] = {}
	for i = 1, tonumber(getTVs) do
		otherTVs[vehicle][i] = createObject(1518, 0.0, 0.0, 0.0)
		setElementAlpha(otherTVs[vehicle][i], getElementAlpha(vehicle))
		attachElements(otherTVs[vehicle][i], vehicle, tvPos[i][1], tvPos[i][2], tvPos[i][3])
	end
end

function destroyTVs(vehicle)
	if otherTVs[vehicle] ~= nil then
		for i = 1, #otherTVs[vehicle] do
			if isElement(otherTVs[vehicle][i]) then
				destroyElement(otherTVs[vehicle][i])
			end
		end
	end
end

addEvent("launchTrain", true)
addEventHandler("launchTrain", getRootElement(), function()
	setTrainSpeed(streak[1], 1.3)
end )

addEvent("brakesFail", true)
addEventHandler("brakesFail", getRootElement(), function()
	setTimer(function() brakesFailMessage = true end, 2000, 1)
	setTimer(function() brakesFailMessage = false end, 8000, 1)
	
	brakesHasFailed = true
	
	setTimer(function() 
		local newBraking = getVehicleHandling(getPedOccupiedVehicle(localPlayer), "brakeDeceleration") - 0.7
		if newBraking < 2 then newBraking = 2 end
		
		setVehicleHandling(getPedOccupiedVehicle(localPlayer), "brakeDeceleration", newBraking)
	end, 15000, 0)
end )

addEvent("playerFinished", true)
addEventHandler("playerFinished", getRootElement(), function(time)
	finished = true
	setTimer(function() finished = false end, 6000, 1)
end )

addEventHandler("onClientRender", root, function()
	-- mission failed text
	if failed then dxDrawBorderedText(1, "Mission Failed", 0, 0, screenX, screenY*0.75, tocolor (255, 0, 0, 255), 3, "pricedown", "center", "center", true, false) end
	if brakesFailMessage then dxDrawBorderedText(1, "I hope that jump didn't damage \nthe truck's brake system...", 0, 0, screenX, screenY*0.75, tocolor (255, 255, 255, 255), 2, "pricedown", "center", "center", true, false) end
	if stuntCamera then
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		setCameraMatrix(2378.3999, -2008.4, 13.1, x, y, z)
	end
	
	if finished then
		dxDrawBorderedText(1, "Mission Passed!", 0, 0, screenX, screenY*0.75, tocolor (145, 103, 21, 255), 3, "pricedown", "center", "center", true, false)
		dxDrawBorderedText(1, "$" ..(#tvs*1000), 0, 0, screenX, screenY*0.9, tocolor (194, 194, 194, 255), 3, "pricedown", "center", "center", true, false)
	end
	
	for index, vehicles in ipairs(getElementsByType("vehicle")) do
		if getElementModel(vehicles) == 499 then
			if otherTVs[vehicles] ~= nil and tonumber(getElementData(vehicles, "tvs")) ~= false and tonumber(getElementData(vehicles, "tvs")) ~= nil then
				if #otherTVs[vehicles] ~= tonumber(getElementData(vehicles, "tvs")) then
					destroyTVs(vehicles)
					createTVs(vehicles)
				end
			end
		end
	end
	
	if brakesHasFailed then
		toggleControl("handbrake", false)
	end
end )

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "vehicle" then createTVs(source) end
end )

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "vehicle" then destroyTVs(source) end
end )