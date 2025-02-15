local camX, camY, camZ = 1979, -1199, 28
local camLookX, camLookY, camLookZ = 1970.2, -1200.1, 25.3
local fov = 70
local forwardAmount = 3
local currentTarget = "Zero"

function targetTheCar()
    currentTarget = "Car"
end
addEvent( "targetCar", true )
addEventHandler( "targetCar", root, targetTheCar )

function ClientStart()
	for i, v in ipairs(getElementsByType("object")) do
		local model = getElementModel(v)
		engineSetModelLODDistance(model, 300)   -- Set maximum draw distance
	end
	
	local BridgeRoad = createObject(5487, 1972.6094, -1198.3125, 23.97656)
	local BridgeRight = createObject(5458, 1995.0156, -1198.3516, 21.10938)
	local BridgeRightEdge = createObject(5677, 1969.0938, -1197.6406, 25.4375)

	local UnderBridge = createColCuboid(1953, -1255, 17, 39, 110, 4)
	
	local HitRamp = createColCuboid(2005, -1203.5, 21, 5, 10, 10)
	
	setTimer(function()
		local ax, ay, az, lx, ly, lz, roll, fov = getCameraMatrix ()
		--outputChatBox("fov = "..fov)
		
		if isElementWithinColShape(localPlayer, UnderBridge) then
			setElementAlpha(BridgeRoad, 0)
			setElementAlpha(BridgeRight, 200)
			setElementAlpha(BridgeRightEdge, 0)
		else
			setElementAlpha(BridgeRoad, 255)
			setElementAlpha(BridgeRight, 255)
			setElementAlpha(BridgeRightEdge, 255)
		end
		
		if isElementWithinColShape(localPlayer, HitRamp) then
			currentTarget = "Heli"
		end
	end, 200, 0)
	
	--setDevelopmentMode (true)
	
	triggerServerEvent( "justJoined", resourceRoot)
	
	--outputChatBox("Current Target = "..currentTarget)
end
addEventHandler("onClientResourceStart",root,ClientStart)

function LookAtTarget()
	local carX,carY,carZ = getElementPosition(localPlayer)
	local M = getElementMatrix(getPedOccupiedVehicle(localPlayer))
	
	local distance = getDistanceBetweenPoints3D(carX, carY, carZ, camX, camY, camZ)
	
	fov = lerp(fov, math.min(90,90 / (distance / 17)), 0.05)

	--outputChatBox("Current state = "..getElementData(localPlayer, "state"))
	
	if (currentTarget == "Zero") then
		camLookX, camLookY, camLookZ = 1959, -1201.1, 26.7
		fov = 55
		
		camX = lerp(camX, math.min(1980, math.max(1959, carX)), 0.05)
		camY = lerp(camY, math.min(-1150, math.max(-1250, carY + 5)), 0.05)
		camZ = 28
	elseif (currentTarget == "Car") then
		camLookX = lerp(camLookX, carX + 0 * M[1][1] + forwardAmount * M[2][1] + 0 * M[3][1], 0.1)
		camLookY = lerp(camLookY, carY + 0 * M[1][2] + forwardAmount * M[2][2] + 0 * M[3][2], 0.1)
		camLookZ = lerp(camLookZ, carZ + 0 * M[1][3] + forwardAmount * M[2][3] + 0 * M[3][3], 0.1)
		
		camX = lerp(camX, math.min(1980, math.max(1959, carX)), 0.05)
		camY = lerp(camY, math.min(-1150, math.max(-1250, carY + 5)), 0.05)
		camZ = lerp(camZ, 26 + (distance / 10), 0.05)
	elseif (currentTarget == "Heli") then
		camLookX = lerp(camLookX, carX + 0 * M[1][1] + forwardAmount * M[2][1] + 0 * M[3][1], 0.1)
		camLookY = lerp(camLookY, carY + 0 * M[1][2] + forwardAmount * M[2][2] + 0 * M[3][2], 0.1)
		camLookZ = lerp(camLookZ, carZ + 0 * M[1][3] + forwardAmount * M[2][3] + 0 * M[3][3], 0.1)
		
		camX = lerp(camX, math.min(1982, math.max(1959, carX + 7)), 0.05)
		camY = lerp(camY, math.min(-1152, math.max(-1250, carY + 7)), 0.05)
		camZ = lerp(camZ, 28, 0.05)
	end
	
	if getElementData(localPlayer, "state") == "spectating" then
	elseif	getElementData(localPlayer, "state") == "finished" then
	else
		setCameraMatrix(camX, camY, camZ, camLookX, camLookY, camLookZ, 0, fov)
	end
end
addEventHandler ( "onClientPreRender", root, LookAtTarget )

function lerp(a, b, t)
	return a + (b - a) * t
end