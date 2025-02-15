local shootTimer = nil
local canShoot = false
local drawCountdown = true
local countdown = 11
local isTooFar = false

function drainHealthIfFarAway()
	local vehicle = getPedOccupiedVehicle(getLocalPlayer())

	clientPositionX, clientPositionY, clientPositionZ = 
		getElementPosition(vehicle)

	local smallestDistance = 9999

	for index, otherPlayer in ipairs(getElementsByType("player")) do
		if otherPlayer ~= getLocalPlayer() and getElementHealth(otherPlayer) > 0 then
			otherPlayerPositionX, otherPlayerPositionY, otherPlayerPositionZ = 
			getElementPosition(getPedOccupiedVehicle(otherPlayer))

			local distanceToPlayer = getDistanceBetweenPoints3D(clientPositionX, clientPositionY,
				clientPositionZ, otherPlayerPositionX, otherPlayerPositionY, otherPlayerPositionZ)
			
			if (distanceToPlayer < smallestDistance) then
				smallestDistance = distanceToPlayer
			end
		end
	end

	isTooFar = false

	if smallestDistance > 150 then
		setElementHealth(vehicle, getElementHealth(vehicle) - 25)
		--outputChatBox("do dmg")
		isTooFar = true
	end

	--utputChatBox(getElementHealth(vehicle))

	setTimer(drainHealthIfFarAway, 1000, 1)
end

function shoot()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not isElement(vehicle) then return end
    if(not isTimer(shootTimer))then
		if (canShoot) then
			local posX, posY, posZ = getElementPosition(vehicle)
			shootTimer = setTimer(function()end, 3000, 1)
			createProjectile(vehicle, 19, posX, posY, posZ, 1.0)
		end
    end
end
bindKey("vehicle_fire", "down", shoot)
bindKey("vehicle_secondary_fire", "down", shoot)

addEventHandler('onClientResourceStart', resourceRoot, function()	
	setTimer(checkForMovement, 500, 1)
end 
)

function checkForMovement()
	if not isElementMoving(getPedOccupiedVehicle ( getLocalPlayer()) ) then
		setTimer(checkForMovement, 500, 1)
	else
		setTimer(turnOnShooting, 10000, 1)
		setTimer(runCountdown, 1000, 1)
		countdown = 10
		setTimer(drainHealthIfFarAway, 10000, 1)
	end
end

function turnOnShooting()
	canShoot = true
	setTimer(hideCountdown, 5000, 1)
end

function runCountdown()
	if countdown > 0 then
		setTimer(runCountdown, 1000, 1)
		countdown = countdown - 1
	end
end

function hideCountdown()
	drawCountdown = false
end

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
				clientPositionZ, cameraPosX, cameraPosY, cameraPosZ), 0.75)

	posX, posY = getScreenFromWorldPosition(clientPositionX, clientPositionY, clientPositionZ + 1)

	if posX == false or posY == false then
		return
	end

	local text = ""

	if drawCountdown then
		if countdown == 11 then
			text = "Firing rockets is enabled after 10 seconds"
		elseif countdown == 0 then
			text = "Rockets Enabled"
		else
			text = tostring(countdown)
		end
	elseif isTooFar then
		text = "Too far from players! Losing Health"
	end

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