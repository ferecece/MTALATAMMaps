local sirens = {}
local sirensLight = {}
local sirensLight2 = {}
local sirensTimer = nil
local doorsVehicle = {}
local staticVehicles = {}
local oldZ = 0.82

function changeSirensColors()
	if not isElement(sirensLight[localPlayer]) then return end
	local c1, c2, c3, c4 = getMarkerColor(sirensLight[localPlayer])
	if c1 == 255 then
		for i, players in ipairs(getElementsByType("player")) do
			if isElement(sirensLight[players]) then 
				setMarkerColor(sirensLight[players], 0, 0, 255, 120)
				setMarkerColor(sirensLight2[players], 255, 0, 0, 120)
				
				local x, y, z, rx, ry, rz = getElementAttachedOffsets(sirens[players])
				setElementAttachedOffsets(sirens[players], x, y, z, rx, ry, 180)
			end
		end
	elseif c1 == 0 then
		for i, players in ipairs(getElementsByType("player")) do
			if isElement(sirensLight[players]) then 
				setMarkerColor(sirensLight[players], 255, 0, 0, 120)
				setMarkerColor(sirensLight2[players], 0, 0, 255, 120)
				
				local x, y, z, rx, ry, rz = getElementAttachedOffsets(sirens[players])
				setElementAttachedOffsets(sirens[players], x, y, z, rx, ry, 0)
			end
		end
	end
end

function doors()
	for v, vehicles in ipairs(getElementsByType("vehicle")) do
		if getVehicleController(vehicles) == false and vehicles ~= staticVehicles[1] and vehicles ~= staticVehicles[2] and vehicles ~= staticVehicles[3] and vehicles ~= staticVehicles[4] and vehicles ~= staticVehicles[5] and vehicles ~= staticVehicles[6] then
			for i in pairs(getVehicleComponents(vehicles)) do setVehicleComponentVisible(vehicles, i, false) end

			setVehicleComponentVisible(vehicles, "door_rf_dummy", true)
			setVehicleComponentVisible(vehicles, "door_lf_dummy", true)
			setVehicleComponentVisible(vehicles, "door_rr_dummy", true)
			setVehicleComponentVisible(vehicles, "door_lr_dummy", true)
			
			setVehicleColor(vehicles, 1, 1, 0, 0)
		end
	end
end

function createSirensForAVehicle(player)
	-- Get player
	if not player then return end
	local vehicle = getPedOccupiedVehicle(player)
	if not vehicle then return end

	-- Destroy old stuff
	if isElement(sirens[player]) then destroyElement(sirens[player]) end

	if isElement(sirensLight[player]) then 
		destroyElement(sirensLight[player])
		destroyElement(sirensLight2[player])
	end

	-- Check for some models
	if getElementModel(vehicle) == 596 or getElementModel(vehicle) == 598 or getElementModel(vehicle) == 599 or getElementModel(vehicle) == 597 or getElementModel(vehicle) == 407 or getElementModel(vehicle) == 427 or getElementModel(vehicle) == 416 then return end

	--Recreate sirens
	sirens[player] = createObject(1946, 0.0, 0.0, 0.0)

	-- Calculate offset
	local x, y, z = getElementPosition(vehicle)
	local rx, ry, rz = getElementRotation(vehicle)
	local px, py, pz = getVehicleDummyPosition(vehicle, "seat_front")
	setElementRotation(vehicle, 0, 0, 0)

	if getElementModel(vehicle) == 531 then
		hit, texU, texV, textureName, frameName, worldX, worldY, worldZ = processLineAgainstMesh(vehicle, x+0.2, y+py+1.1, z+20, x+0.2, y+py+1, z-10)
	else
		hit, texU, texV, textureName, frameName, worldX, worldY, worldZ = processLineAgainstMesh(vehicle, x+0.2, y+py+1.1, z+20, x+0.2, y+py-0.1, z-10)
	end
	setElementRotation(vehicle, rx, ry, rz)
	if not hit then return end

	-- Recreate Lights
	sirensLight[player] = createMarker(0.0, 0.0, 0.0, "corona", 0.6, 255, 0, 0, 120)
	sirensLight2[player] = createMarker(0.0, 0.0, 0.0, "corona", 0.6, 0, 0, 255, 120)

	-- Attach
	if getElementModel(vehicle) == 531 then
		attachElements(sirens[player], vehicle, 0, py+1.1, worldZ - z + 0.1)
		attachElements(sirensLight[player], vehicle, -0.45, py+1.1, worldZ - z + 0.1)
		attachElements(sirensLight2[player], vehicle, 0.45, py+1.1, worldZ - z + 0.1)
	else
		attachElements(sirens[player], vehicle, 0, py-0.1, worldZ - z + 0.1)
		attachElements(sirensLight[player], vehicle, -0.45, py-0.1, worldZ - z + 0.1)
		attachElements(sirensLight2[player], vehicle, 0.45, py-0.1, worldZ - z + 0.1)
	end

	-- Police Colors
	setVehicleColor(vehicle, 0, 0, 1, 1)

	-- Attach "Sirens"
	setVehicleSirens(vehicle, 1, -0.45, py-0.1, worldZ - z, 255, 0, 0)
	setVehicleSirens(vehicle, 2, 0.45, py-0.1, worldZ - z, 0, 0, 255)

	-- Remove doors
	setVehicleComponentVisible(vehicle, "door_rf_dummy", false)
	setVehicleComponentVisible(vehicle, "door_lf_dummy", false)
	setVehicleComponentVisible(vehicle, "door_rr_dummy", false)
	setVehicleComponentVisible(vehicle, "door_lr_dummy", false)
end

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "player" then
		if getPedOccupiedVehicle(source) and not isElement(sirens[source]) then createSirensForAVehicle(source) end
	end
end )

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "player" then
		if getPedOccupiedVehicle(source) and isElement(sirens[source]) then
			destroyElement(sirens[source])
			if isElement(sirensLight[source]) then destroyElement(sirensLight[source]) end
			if isElement(sirensLight2[source]) then destroyElement(sirensLight2[source]) end
		end
	end
end )

addEventHandler("onClientElementModelChange", getRootElement(), function(oldModel, newModel)
	if getElementType(source) == "vehicle" then
		createSirensForAVehicle(getVehicleController(source))
		setVehicleSirensOn(source, getElementData(source, "sirensState"))

		if source == getPedOccupiedVehicle(localPlayer) then
			local newZ = getElementDistanceFromCentreOfMassToBaseOfModel(getPedOccupiedVehicle(localPlayer))
			if getVehicleType(getPedOccupiedVehicle(localPlayer)) == "Monster Truck" then newZ = newZ + 1 end

			local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
			setElementPosition(getPedOccupiedVehicle(localPlayer), x, y, z + (newZ - oldZ))
			oldZ = newZ
		end
	end
end )

addEventHandler("onClientResourceStart", resourceRoot,
function()
	engineImportTXD(engineLoadTXD("sirens.txd"), 1946)
	engineReplaceModel(engineLoadDFF("sirens.dff"), 1946)

	if isTimer(sirensTimer) then killTimer(sirensTimer) end
	sirensTimer = setTimer(changeSirensColors, 500, 0)

	staticVehicles[1] = createVehicle(427, 2469.3, -1653.4, 13.7, 0, 0, 120)
	staticVehicles[2] = createVehicle(596, 2474.6, -1674.3, 13.2, 0, 0, -50)
	staticVehicles[3] = createVehicle(596, 2460.1, -1662.8, 13.1, 0, 0, -90)
	staticVehicles[4] = createVehicle(596, 2477.8, -1668.7, 13.1, 0, 0, -10)
	staticVehicles[5] = createVehicle(412, 2488.6, -1677.2, 13.3, 0, 0, -10)
	staticVehicles[6] = createVehicle(492, 2496.6, -1663.1, 13.2, 0, 0, -10)
end )

addEventHandler("onClientRender", getRootElement(), doors)
