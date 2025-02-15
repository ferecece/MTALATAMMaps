function loadJetEngine()
	txd = engineLoadTXD("ap_learjets.txd")
	engineImportTXD(txd,1305)

	dff = engineLoadDFF("jetengine.dff",0)
	engineReplaceModel(dff,1305)
	
	dff = engineLoadDFF("jetengineleft.dff",0)
	engineReplaceModel(dff,1304)
	
	txd = engineLoadTXD("ap_learjets.txd")
	engineImportTXD(txd,1304)
	
	for i, v in ipairs(getElementsByType("object")) do
		local model = getElementModel(v)
		engineSetModelLODDistance(model, 170)   -- Set maximum draw distance
	end
end
addEventHandler("onClientResourceStart",root,loadJetEngine)

local shootTimer = nil
local canShoot = false
local drawCountdown = true
local countdown = 11

function shoot()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not isElement(vehicle) then return end
    if(not isTimer(shootTimer))then
		if (canShoot) then
		
			-- M = getElementMatrix(vehicle)
			
			-- local velx, vely, velz = getElementVelocity ( vehicle )
			
			-- local X, Y, Z = 0, 1, 0
			
			-- setElementVelocity( vehicle, velx + X * M[1][1] + Y * M[2][1] + Z * M[3][1], vely + X * M[1][2] + Y * M[2][2] + Z * M[3][2], velz + X * M[1][3] + Y * M[2][3] + Z * M[3][3] )
			
			setTimer(boost, 50, 20, vehicle)
			shootTimer = setTimer(function()end, 3000, 1)
			Sound = playSFX("genrl", 136, 20, false)
			setSoundVolume(Sound, math.random(0.9, 1.1))
			setSoundSpeed(Sound, 1.5)
			
			setTimer(function()
				Sound = playSFX("genrl", 58, 1, false)
				setSoundVolume(Sound, math.random(0.9, 1.1))
				setSoundSpeed(Sound, 0.8)
			end, 1100, 1)
			
			local posX, posY, posZ = getElementPosition(vehicle)
			createExplosion(posX, posY, posZ, 5, false, 1, false)
		end
    end
end
bindKey("vehicle_fire", "down", shoot)
bindKey("vehicle_secondary_fire", "down", shoot)

function boost(vehicle, Fire)
	-- Speedy gogo
	M = getElementMatrix(vehicle)
			
	local velx, vely, velz = getElementVelocity(vehicle)
	
	local X, Y, Z = 0, 0.09, 0
	
	setElementVelocity( vehicle, velx + X * M[1][1] + Y * M[2][1] + Z * M[3][1], vely + X * M[1][2] + Y * M[2][2] + Z * M[3][2], velz + X * M[1][3] + Y * M[2][3] + Z * M[3][3] )
end

addEventHandler('onClientResourceStart', resourceRoot, function()	
	setTimer(checkForMovement, 500, 1)
end 
)

function checkForMovement()
	if not isElementMoving(getPedOccupiedVehicle ( getLocalPlayer()) ) then
		setTimer(checkForMovement, 500, 1)
	else
		setTimer(turnOnShooting, 5000, 1)
		setTimer(runCountdown, 1000, 1)
		countdown = 5
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
			text = "Jet engines are enabled after 5 seconds"
		elseif countdown == 0 then
			text = "Jet Engines Enabled"
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