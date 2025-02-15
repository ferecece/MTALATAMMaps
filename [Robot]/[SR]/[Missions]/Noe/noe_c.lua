local aboveRadar = false
local barFull = false
local barActive = false
local barNumber = 0
local punishMessageShown = false

local vehicle

MarkerStrip = getElementByID("MarkerStrip")

function isPlayerSpectating(player) 
    return getElementData(player, 'race.spectating') 
end 

function CheckHeight()
	if not isPlayerSpectating(localPlayer) and not isPedDead(localPlayer) then
		triggerServerEvent("HeightCheck", resourceRoot)
		if (barFull) then
			triggerServerEvent("ReduceHandling", resourceRoot)
		end
		-- if vehicle == false then
			-- outputChatBox("Vehicle is false")
			-- setTimer(CheckHeight, 500, 1)
			-- return
		-- end

		-- local x, y, z = getElementPosition(source)
		-- if z > 30 then
			-- barNumber = barNumber + 1
			-- outputChatBox("Above limit " + tostring(barNumber))
		-- end
	end
	setTimer(CheckHeight, 70, 1)
end

function ApplyEffectsOfAboveLimit()
	if (barNumber >= 100 and barFull == false) then
		barFull = true
		caughtLine = playSFX("script", 57, 15, false)
		setSoundVolume(caughtLine, 1)
		plane = getPedOccupiedVehicle(getLocalPlayer())
		setVehicleHandling(plane, "mass", 50000.0)
		setVehicleHandling(plane, "engineAcceleration", 20.0)
		-- triggerServerEvent("ReduceHandling", resourceRoot)
	elseif (barNumber < 100) then
		barNumber = barNumber + 1
	end
	aboveRadar = true
end
addEvent("PlayerAboveLimit", true)
addEventHandler("PlayerAboveLimit", getRootElement(), ApplyEffectsOfAboveLimit)

function NotAboveLimit()
	if (barNumber > 0) then
		barNumber = barNumber - 1
		if (barFull) and (barNumber < 75) then
			punishMessageShown = true
		end
	end
	aboveRadar = false
end
addEvent("NotAboveLimit", true)
addEventHandler("NotAboveLimit", getRootElement(), NotAboveLimit)

function StartDialogue()
	barActive = true
	CheckHeight()
	setTimer(function()
		startLine1 = playSFX("script", 57, 0, false)
		setSoundVolume(startLine1, 1)
	end, 1500, 1)
	setTimer(function()
        startLine2 = playSFX("script", 57, 1, false)
        setSoundVolume(startLine2, 1)
    end, 2300, 1)
	setTimer(function()
        startLine3 = playSFX("script", 57, 2, false)
        setSoundVolume(startLine3, 1)
    end, 5800, 1)
	setTimer(function()
        startLine4 = playSFX("script", 57, 3, false)
        setSoundVolume(startLine4, 1)
    end, 7000, 1)
	setTimer(function()
        startLine5 = playSFX("script", 57, 4, false)
        setSoundVolume(startLine5, 1)
    end, 10350, 1)
	setTimer(function()
        startLine6 = playSFX("script", 57, 5, false)
        setSoundVolume(startLine6, 1)
    end, 12600, 1)
	setTimer(function()
        startLine7 = playSFX("script", 57, 6, false)
        setSoundVolume(startLine7, 1)
    end, 15500, 1)
	setTimer(function()
        startLine8 = playSFX("script", 57, 7, false)
        setSoundVolume(startLine8, 1)
    end, 17250, 1)
	setTimer(function()
        startLine9 = playSFX("script", 57, 8, false)
        setSoundVolume(startLine9, 1)
    end, 19000, 1)
	setTimer(function()
        startLine10 = playSFX("script", 57, 9, false)
        setSoundVolume(startLine10, 1)
    end, 23100, 1)
	setTimer(function()
        startLine11 = playSFX("script", 57, 10, false)
        setSoundVolume(startLine11, 1)
    end, 24250, 1)
end
addEvent("PlayStartDialogue", true)
addEventHandler("PlayStartDialogue", getRootElement(), StartDialogue)

function HideMarker()
	setElementDimension(MarkerStrip, 2)
end
addEvent("PlayerLoadedIn", true)
addEventHandler("PlayerLoadedIn", getRootElement(), HideMarker)

function IsPlayerDone()
	if not isPlayerSpectating(localPlayer) and not isPedDead(localPlayer) then
		if not isElementMoving(getPedOccupiedVehicle ( getLocalPlayer())) then
			triggerServerEvent("CheckLandingPos", resourceRoot)
		end
	end
	setTimer(IsPlayerDone, 10, 1)
end

function PrepareForEnd()
	setElementDimension(MarkerStrip, 0)
	IsPlayerDone()
end
addEvent("PlayerOnLastSection", true)
addEventHandler("PlayerOnLastSection", getRootElement(), PrepareForEnd)

function EndDialogue()
	setElementDimension(MarkerStrip, 2)
	endLine = playSFX("script", 57, 19, false)
	setSoundVolume(endLine, 1)
end
addEvent("PlayEndDialogue", true)
addEventHandler("PlayEndDialogue", getRootElement(), EndDialogue)

function isElementMoving(theElement)
    if isElement(theElement)then --First check if the given argument is an element
        local x, y, z = getElementVelocity(theElement) --Get the velocity of the element given in our argument
            return x ~= 0 or y ~= 0 or z ~= 0 --When there is a movement on X, Y or Z return true because our element is moving
    end
    return false
end

function drawing()	
	-- Get the player's car's position and draw the text above isTimer
	local screenWidth,screenHeight = guiGetScreenSize() 

	clientPositionX, clientPositionY, clientPositionZ = 
		getElementPosition(getPedOccupiedVehicle(getLocalPlayer()))

	cameraPosX, cameraPosY, cameraPosZ = getElementPosition(getCamera())

	local textSize = (screenHeight / 1080) * math.max(10/getDistanceBetweenPoints3D(clientPositionX, clientPositionY,
				clientPositionZ, cameraPosX, cameraPosY, cameraPosZ), 1.75)

	posX, posY = getScreenFromWorldPosition(clientPositionX, clientPositionY, clientPositionZ + 1)

	if posX == false or posY == false then
		return
	end

	local text = ""

	if not barActive then
		text = "Stay low - make sure your visibility does not reach 10."
	elseif barFull and aboveRadar and not punishMessageShown then
		text = "You have reached maximum visibility. Your plane's speed has now been reduced."
	elseif aboveRadar then
		text = "Above radar limit!"
	end
	
	local visibilityText = ""
	
	if (barNumber >= 0 and barNumber <= 9) then
		visibilityText = "Visibility: 0"
	elseif (barNumber >= 10 and barNumber <= 19) then
		visibilityText = "Visibility: 1"
	elseif (barNumber >= 20 and barNumber <= 29) then
		visibilityText = "Visibility: 2"
	elseif (barNumber >= 30 and barNumber <= 39) then
		visibilityText = "Visibility: 3"
	elseif (barNumber >= 40 and barNumber <= 49) then
		visibilityText = "Visibility: 4"
	elseif (barNumber >= 50 and barNumber <= 59) then
		visibilityText = "Visibility: 5"
	elseif (barNumber >= 60 and barNumber <= 69) then
		visibilityText = "Visibility: 6"
	elseif (barNumber >= 70 and barNumber <= 79) then
		visibilityText = "Visibility: 7"
	elseif (barNumber >= 80 and barNumber <= 89) then
		visibilityText = "Visibility: 8"
	elseif (barNumber >= 90 and barNumber <= 99) then
		visibilityText = "Visibility: 9"
	elseif (barNumber >= 100) then
		visibilityText = "Visibility: 10"
	end
	
	dxDrawBorderedText(1, visibilityText, 425, 150, 1000, 1000, tocolor ( 0, 255, 0, 255 ), 2.5, "pricedown")

	width = dxGetTextWidth(text, textSize, "pricedown")
	dxDrawBorderedText (1, text, posX - (width / 2), posY, 1000, 1000, tocolor ( 255, 255, 255, 255 ), textSize, "pricedown")
			
end
addEventHandler ( "onClientRender", root, drawing ) -- keep the text visible with onClientRender.


function dxDrawBorderedText (outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    local outline = (scale or 1) * (1.333333333333334 * (outline or 1))
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top - outline, right - outline, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top - outline, right + outline, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top + outline, right - outline, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top + outline, right + outline, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left - outline, top, right - outline, bottom, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left + outline, top, right + outline, bottom, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top - outline, right, bottom - outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text:gsub("#%x%x%x%x%x%x", ""), left, top + outline, right, bottom + outline, tocolor (0, 0, 0, 225), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    dxDrawText (text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end
