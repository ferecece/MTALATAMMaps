local shootTimer = nil
local canShoot = false
local vehicle = getPedOccupiedVehicle(localPlayer)
local drawCountdown = true
local countdown = 11

function shootLeft()
	local vehicle = getPedOccupiedVehicle(localPlayer)
    if not isElement(vehicle) then return end
    if(not isTimer(shootTimer))then
		if (canShoot) then
			local posX, posY, posZ = getElementPosition(vehicle)
			local rotX, rotY, rotZ = getElementRotation(vehicle)
			shootTimer = setTimer(function()end, 3000, 1)
			
			-- Warning, retarded method of making this work ahead
			setElementRotation(vehicle,rotX,rotY,rotZ+90) -- Rotate player 90 clockwise
			-- Create the rockets now (So they go left)
			x,y,z = getPositionFromElementOffset(vehicle,13,0,0) -- Offest
			
			createProjectile(vehicle, 19, posX, posY, posZ + 0.5, 1.0) -- Create
			
			x,y,z = getPositionFromElementOffset(vehicle,7,0,0)
			
			createProjectile(vehicle, 19, x, y, z + 0.5, 1.0) 
			
			x,y,z = getPositionFromElementOffset(vehicle,1,0,0)
			
			createProjectile(vehicle, 19, x, y, z + 0.5, 1.0) 
			
			x,y,z = getPositionFromElementOffset(vehicle,-5,0,0)
			
			createProjectile(vehicle, 19, x, y, z + 0.5, 1.0) 
			
			setElementRotation(vehicle,rotX,rotY,rotZ) -- Put player back to their original rotation
		end
	end
end
bindKey("vehicle_fire", "down", shootLeft)

function shootRight()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not isElement(vehicle) then return end
    if(not isTimer(shootTimer))then
		if (canShoot) then
			local posX, posY, posZ = getElementPosition(vehicle)
			local rotX, rotY, rotZ = getElementRotation(vehicle)
			shootTimer = setTimer(function()end, 3000, 1)
			
			-- Warning, retarded method of making this work ahead
			setElementRotation(vehicle,rotX,rotY,rotZ-90) -- Rotate player 90 clockwise
			
			-- Create the rockets now (So they go right)
			x,y,z = getPositionFromElementOffset(vehicle,13,0,0)
			
			createProjectile(vehicle, 19, posX, posY, posZ + 0.5, 1.0) 
			
			x,y,z = getPositionFromElementOffset(vehicle,7,0,0)
			
			createProjectile(vehicle, 19, x, y, z + 0.5, 1.0) 
			
			x,y,z = getPositionFromElementOffset(vehicle,1,0,0)
			
			createProjectile(vehicle, 19, x, y, z + 0.5, 1.0) 
			
			x,y,z = getPositionFromElementOffset(vehicle,-5,0,0)
			
			createProjectile(vehicle, 19, x, y, z + 0.5, 1.0) 
			
			setElementRotation(vehicle,rotX,rotY,rotZ) -- Put player back to their original rotation
		end
    end
end
bindKey("vehicle_secondary_fire", "down", shootRight)

function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z                               -- Return the transformed point
end

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
	end
end

function turnOnShooting()
	canShoot = true
	--outputChatBox ("Shooting Enabled!!!")
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

	posX, posY = getScreenFromWorldPosition(clientPositionX, clientPositionY, clientPositionZ + 5)

	if posX == false or posY == false then
		return
	end

	local text = ""

	if drawCountdown then
		if countdown == 11 then
			text = "Firing rockets is enabled after 10 seconds"
		elseif countdown == 0 then
			text = "Rockets Enabled! Primary fire to shoot left, Secondary for right!"
		else
			text = tostring(countdown)
		end
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

--outputChatBox ( "Use Primary fire to shoot left, Secondary to shoot right! AAARR!", getRootElement(), 255, 255, 255, true )