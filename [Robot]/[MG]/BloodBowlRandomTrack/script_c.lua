playersCheck = 1
checkpointsForFinish = 10
antiBtimer = nil
shootTimer = nil
countDownState = 10
countDownTimer = nil
shootingEnabled = false
bloodDisplay = nil

screenX, screenY = guiGetScreenSize()

addEventHandler("onClientPlayerSpawn", getLocalPlayer(), function()
	if getElementData(localPlayer, "race.checkpoint") ~= nil then
		if playersCheck > getElementData(localPlayer, "race.checkpoint") and not isTimer(antiBtimer) and getElementData(source, "state") ~= "spectating" then 
			local difference = playersCheck - getElementData(localPlayer, "race.checkpoint")
			antiBtimer = setTimer(triggerRaceCheckpoint, 2500, 1, difference)
		end
	end
end )

addEventHandler("onClientResourceStart", resourceRoot, function()	
	engineImportTXD(engineLoadTXD("bloodra.txd"), 504) -- Special for 123Robot's server
	
	setTimer(unflip, 2000, 0)
	
	setInteriorSoundsEnabled(false)
	outputChatBox("Press M to turn stadium music ON/OFF")
	
	local ScreenX, ScreenY = guiGetScreenSize()
	displaySource = dxCreateScreenSource(ScreenX, ScreenY)
	
	bloodDisplay = createObject(7617, -1392.9, 931.70001, 1049.9, 0.0, 0.0, 10.0)
	setElementInterior(bloodDisplay, 15)
	
	setElementData(localPlayer, "trigger", 1)
end )

addEventHandler("onClientResourceStop", resourceRoot, function()
	setInteriorSoundsEnabled(false)
end )

addCommandHandler("togglemusic", function() setInteriorSoundsEnabled(not getInteriorSoundsEnabled()) end)
bindKey("m","down", "togglemusic")

-- Function triggers race checkpoints with colshape event (DOES NOT WORK WHEN FIRST LOADED)
--function addScore()
	--local colshapes = getElementsByType("colshape", RACE_RESOURCE)
	--triggerEvent("onClientColShapeHit", colshapes[#colshapes], getPedOccupiedVehicle(localPlayer), true)
--end

function triggerRaceCheckpoint(amount)
	if not getPedOccupiedVehicle(localPlayer) then return end
	playerVehicle = getPedOccupiedVehicle(localPlayer)
	
	local i = 0
	while i ~= amount do
		local posX, posY, posZ = getElementPosition(playerVehicle)
		local velX, velY, velZ = getElementVelocity(playerVehicle)
		local trnX, trnY, trnZ = getElementAngularVelocity(playerVehicle)
		
		-- trigger the actual "race" checkpoint
		setElementPosition(playerVehicle, -1316.5996, 1211.7998, 1100+getElementData(localPlayer, "race.checkpoint")*100)

		-- return original position and velocity of player's vehicleHealth
		setElementPosition(playerVehicle, posX, posY, posZ)
		setElementVelocity(playerVehicle, velX, velY, velZ)
		setElementAngularVelocity(playerVehicle, trnX, trnY, trnZ)
	
		i = i + 1
	end
	
	if getElementData(localPlayer, "race.checkpoint") > checkpointsForFinish then
		for i = 1, 20 do setElementPosition(playerVehicle, -1316.5996, 1211.7998, 2100+getElementData(localPlayer, "race.checkpoint")*100) end
	end
end

addEventHandler("onClientMarkerHit", getRootElement(), function(hitPlayer, matchingDimension) 
	if hitPlayer == localPlayer then
		triggerServerEvent("checkClientMarker", getLocalPlayer(), source) 
	end
end )

addEvent("onBloodMarkerHit", true)
addEventHandler("onBloodMarkerHit", getRootElement(), function()	
	playersCheck = playersCheck + 1
	setTimer(triggerRaceCheckpoint, 200, 1, 1)
	
	math.randomseed(getTickCount())
	local rand = math.random(0, 5)
	playSFX("script", 171, rand, false)
end )

function unflip()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle then return end
	
	local rX, rY, rZ = getElementRotation(vehicle)
	local vX, vY, vZ = getElementVelocity(vehicle)
	local pX, pY, pZ = getElementPosition(vehicle)
	
	local tmp = vX*vX + vY*vY + vZ*vZ
	
	if tmp < 0.01 and isVehicleUpsideDown(vehicle) then
		setElementRotation(vehicle, 0, 0, rZ)
		setElementPosition(vehicle, pX, pY, pZ+0.2)
		
		if getElementHealth(vehicle) < 251 then setElementHealth(vehicle, 251) end
		outputChatBox("This may help you, don't flip again!")
	end
end

local WORLD_DOWN = {0, 0, -1} 
local UPSIDE_DOWN_THRESHOLD = math.cos(math.rad(20)) 
  
function isVehicleUpsideDown (vehicle) 
    local matrix = getElementMatrix (vehicle) 
    local vehicleUp = {matrix_rotate (matrix, 0, 0, 1)} 
    local dotP = math.dotP (vehicleUp, WORLD_DOWN) 
    return (dotP >= UPSIDE_DOWN_THRESHOLD) 
end 
  
function matrix_rotate (matrix, x, y, z) 
    local tx = x * matrix[1][1] + y * matrix[2][1] + z * matrix[3][1]   
    local ty = x * matrix[1][2] + y * matrix[2][2] + z * matrix[3][2]   
    local tz = x * matrix[1][3] + y * matrix[2][3] + z * matrix[3][3]   
    return tx, ty, tz 
end 
  
function math.dotP(v1, v2) 
    return v1[1]*v2[1] + v1[2]*v2[2] + v1[3]*v2[3] 
end 

function shoot()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle or isTimer(shootTimer) or not shootingEnabled then return end
	
	local posX, posY, posZ = getElementPosition(vehicle)
	shootTimer = setTimer(function() end, 5000, 1)
	createProjectile(vehicle, 19, posX, posY, posZ+0.7, 1.0)
end
bindKey("vehicle_fire", "down", shoot)

addEvent("postVoteStuff", true)
addEventHandler("postVoteStuff", getRootElement(), function(CPS, rockets)
	checkpointsForFinish = CPS
	outputChatBox("You need to collect " ..CPS.. " checkpoints to finish a race!")
	
	if rockets == 1 then
		shootingEnabled = true
		if isTimer(shootTimer) then killTimer(shootTimer) end 
		shootTimer = setTimer(function() end, 10000, 1)
		
		if isTimer(countDownTimer) then killTimer(countDownTimer) end
		countDownTimer = setTimer(countdown, 1000, 0)
	elseif rockets == 0 then
		shootingEnabled = false
		if isTimer(shootTimer) then killTimer(shootTimer) end 
	end
	
	setTimer(function() 
		math.randomseed(getTickCount())
		local rand = math.random(0, 5)
		playSFX("script", 171, rand, false)
	end, 15000, 0)
end )

function countdown()
	countDownState = countDownState - 1
	if countDownState == -1 then
		killTimer(countDownTimer)
		countDownState = 99 
	end
end

addEventHandler("onClientRender", root, function()
	if displaySource and isElement(bloodDisplay) then
		xlook, ylook, zlook = getPositionFromElementOffset(bloodDisplay, 0, 10, 0)
		dxUpdateScreenSource(displaySource)
		dxDrawImage3D(-1393.2, 933.2, 1045.0, 23, 17, displaySource, xlook, ylook, zlook)
	end
	
	if isTimer(shootTimer) and countDownState ~= 99 then
		if countDownState > 0 then 
			dxDrawBorderedText(1, tostring(countDownState), 0, 0, screenX, screenY, tocolor(145, 103, 21, 255), 3, "pricedown", "center", "center", true, false)
		else
			dxDrawBorderedText(1, "Rockets enabled!", 0, 0, screenX, screenY, tocolor(145, 103, 21, 255), 3, "pricedown", "center", "center", true, false)
		end
	end
end )

local white = tocolor(255,255,255,255)
function dxDrawImage3D(x,y,z,w,h,m,...)
	return dxDrawMaterialLine3D(x, y, z+h,x,y,z, m, w,white,...)
end


function getPositionFromElementOffset(element, offX, offY, offZ)
	local m = getElementMatrix (element)  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z                               -- Return the transformed point
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