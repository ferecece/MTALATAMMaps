updateWheelStateTimer = nil
alphaHoldTimer = nil
taxiInAir = false
airTime = 0
firstSpawn = true
displayAlpha = 255
displayOffset = 0
taxiLight = {}

-- music
songStarted = false
songOn = false
song = nil

-- Screen stuff
screenX, screenY = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot, 
function()
	-- Load car
	engineImportTXD(engineLoadTXD("savanna.txd"), 567)
	engineReplaceModel(engineLoadDFF("savanna.dff"), 567)
	setElementData(localPlayer, "Score", 0)
	setElementData(localPlayer, "Air", 0)
	
	if isTimer(updateWheelStateTimer) then killTimer(updateWheelStateTimer) end
	updateWheelStateTimer = setTimer(updateWheelState, 200, 0)
end )

function isLocalPlayerSpectating()
	local px, py, pz = getElementPosition(localPlayer)
	if getElementData(localPlayer, "state") == "spectating" or pz > 1000 then return true	
	else return false end
end

addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(vehicle)
	if songOn then setRadioChannel(0) end
	if firstSpawn then
		local crazySound = playSound("crazy.mp3", false)
		setSoundVolume(crazySound, 0.5)
	
		addCommandHandler("togglemusic", toggleSong)
		bindKey("m", "down", "togglemusic")
		outputChatBox("Press M to turn the music ON/OFF")
	end
end )

addEventHandler("onClientRender", getRootElement(), function()
	if isLocalPlayerSpectating() then return end -- Spectate check
	
	-- create light for localPlayer
	if getPedOccupiedVehicle(localPlayer) and not isElement(taxiLight[localPlayer]) then
		taxiLight[localPlayer] = createMarker(0.0, 0.0, 0.0, "corona", 0.6, 229, 249, 5, 103)
		attachElements(taxiLight[localPlayer], getPedOccupiedVehicle(localPlayer), 0.0, 0.7, 0.7)
	end
	
	if displayAlpha == 255 and not isTimer(alphaHoldTimer) then alphaHoldTimer = setTimer(function() displayAlpha = 254 end, 800, 1) end
		
	if displayAlpha > 0 and displayAlpha ~= 255 then
		displayAlpha = displayAlpha - 2
		displayOffset = displayOffset + 3
	end
	if airTime ~= 0 then dxDrawBorderedText(1, "+"..airTime, 0, 0, screenX*1.05, screenY*0.95-displayOffset, tocolor (240, 240, 240, displayAlpha), 3, "pricedown", "center", "center", true, false) end
end )

function updateWheelState()
	local taxi = getPedOccupiedVehicle(localPlayer)
	if isLocalPlayerSpectating() or not taxi then return end
	
	if not isVehicleUpsideDown(taxi) and not isVehicleWheelOnGround(taxi, "front_left") and not isVehicleWheelOnGround(taxi, "rear_left") and not isVehicleWheelOnGround(taxi, "front_right") and not isVehicleWheelOnGround(taxi, "rear_right") then
		if firstSpawn then return end
		
		if not taxiInAir then
			airTime_ = getTickCount()
		end
		taxiInAir = true
		setElementData(localPlayer, "air", 1)
	else
		firstSpawn = false
		if taxiInAir then
			-- Calculate current air time
			local airTime_ = math.floor((getTickCount() - airTime_)/100)*100
			if airTime_ > 500 and not isVehicleUpsideDown(taxi) then
				displayAlpha = 255 
				displayOffset = 0
				airTime = airTime_/10
				if isTimer(alphaHoldTimer) then killTimer(alphaHoldTimer) end
				
				-- Add air time to player's score
				setElementData(localPlayer, "Score", getElementData(localPlayer, "Score") + airTime)
			end
		end
		taxiInAir = false
		setElementData(localPlayer, "air", 0)
	end
end

function dxDrawBorderedText(outline, text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    if type(scaleY) == "string" then
        scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY = scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX
    end
    local outlineX = (scaleX or 1) * (1.333333333333334 * (outline or 1))
    local outlineY = (scaleY or 1) * (1.333333333333334 * (outline or 1))
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top - outlineY, right - outlineX, bottom - outlineY, tocolor (0, 0, 0, displayAlpha), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top - outlineY, right + outlineX, bottom - outlineY, tocolor (0, 0, 0, displayAlpha), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top + outlineY, right - outlineX, bottom + outlineY, tocolor (0, 0, 0, displayAlpha), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top + outlineY, right + outlineX, bottom + outlineY, tocolor (0, 0, 0, displayAlpha), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outlineX, top, right - outlineX, bottom, tocolor (0, 0, 0, displayAlpha), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outlineX, top, right + outlineX, bottom, tocolor (0, 0, 0, displayAlpha), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top - outlineY, right, bottom - outlineY, tocolor (0, 0, 0, displayAlpha), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top + outlineY, right, bottom + outlineY, tocolor (0, 0, 0, displayAlpha), scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text, left, top, right, bottom, color, scaleX, scaleY, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

local WORLD_DOWN = {0, 0, -1} 
local UPSIDE_DOWN_THRESHOLD = math.cos(math.rad(20)) 
  
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

function toggleSong()
	if not songStarted then
		song = playSound("ost.mp3", true)
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

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "player" then
		if getPedOccupiedVehicle(source) then
			if isElement(taxiLight[source]) then destroyElement(taxiLight[source]) end

			taxiLight[source] = createMarker(0.0, 0.0, 0.0, "corona", 0.6, 229, 249, 5, 103)
			attachElements(taxiLight[source], getPedOccupiedVehicle(source), 0.0, 0.7, 0.7)
		end
	end
end )

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "player" then
		if getPedOccupiedVehicle(source) and isElement(taxiLight[source]) then 
			destroyElement(taxiLight[source]) 
		end
	end
end )

function test()
	local data = {}
	for i = 400, 609 do
		if getVehicleType(i) == "Automobile" then 
			table.insert(data, i.. " - " ..getVehicleNameFromModel(i))
		end
	end
	
	for i = 1, #data do
		outputChatBox(data[i])
	end
end
bindKey("num_0", "down", test)