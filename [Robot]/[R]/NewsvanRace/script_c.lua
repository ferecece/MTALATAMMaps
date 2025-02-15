local width, height = guiGetScreenSize()
ant = {}
antAngle = {}

addEventHandler("onClientResourceStart", resourceRoot, 
function()
	engineImportTXD(engineLoadTXD("newsvan.txd"), 582)
	engineReplaceModel(engineLoadDFF("newsvan.dff"), 582)
	
	engineImportTXD(engineLoadTXD("ant.txd"), 1946)
	engineReplaceModel(engineLoadDFF("ant.dff"), 1946)
	
	-- Flip 
	screenSrc = dxCreateScreenSource(width, height)
	setTimer(update, 1, 0)
end )

addEventHandler("onClientHUDRender", getRootElement(), function()
	dxUpdateScreenSource(screenSrc) 
    dxDrawImage(width, 0, -width, height, screenSrc) 
end )

addEventHandler("onClientKey", root, function(button, press) 
	if isChatBoxInputActive() then return end -- if chatbox is opened
	
	-- Spectate checks
	local x, y, z = getElementPosition(localPlayer)
	local taxi = getPedOccupiedVehicle(localPlayer)
	if z > 1000 or getElementData(localPlayer, "state") == "spectating" or not taxi then return end
	
	-- Submission key
	local keys = getBoundKeys("vehicle_left")
	for keyName, state in pairs(keys) do
		if button == keyName then
			cancelEvent()
			setPedControlState(localPlayer, "vehicle_right", press)
		end
	end
	
	local keys = getBoundKeys("vehicle_right")
	for keyName, state in pairs(keys) do
		if button == keyName then
			cancelEvent()
			setPedControlState(localPlayer, "vehicle_left", press)
		end
	end
end )

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "player" then
		if getPedOccupiedVehicle(source) then
			if isElement(ant[source]) then destroyElement(ant[source]) end
			ant[source] = createObject(1946, 0.0, 0.0, 0.0)
			antAngle[source] = 0.0
			attachElements(ant[source], getPedOccupiedVehicle(source), 0.0, -1.4, 1.5)
		end
	end
end )

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "player" then
		if getPedOccupiedVehicle(source) and isElement(ant[source]) then 
			destroyElement(ant[source]) 
		end
	end
end )

function update()
	-- create obj for localPlayer
	if getPedOccupiedVehicle(localPlayer) and not isElement(ant[localPlayer]) then
		ant[localPlayer] = createObject(1946, 0.0, 0.0, 0.0)
		antAngle[localPlayer] = 0.0
		attachElements(ant[localPlayer], getPedOccupiedVehicle(localPlayer), 0.0, -1.4, 1.5)
	end
	
	-- change angle
	for index, players in ipairs(getElementsByType("player")) do
		if isElement(ant[players]) then
			if isElementAttached(ant[players]) and getPedOccupiedVehicle(players) then
				antAngle[players] = antAngle[players] + 1.5
				if antAngle[players] > 360 then antAngle[players] = 0 end
				
				setElementAlpha(ant[players], getElementAlpha(getPedOccupiedVehicle(players)))
				
				setElementAttachedOffsets(ant[players], 0.0, -1.4, 1.5, 0.0, 0.0, antAngle[players])
				setVehicleColor(getPedOccupiedVehicle(players), 255, 255, 255, 255, 255, 255)
			end
		end
	end
end