local carAngle = 0.0

addEventHandler("onClientResourceStart", resourceRoot, 
function()
	-- Load cars
	engineImportTXD(engineLoadTXD("copcarvg.txd"), 598)
	engineReplaceModel(engineLoadDFF("copcarvg.dff"), 598)
	
	setTimer(forceAngle, 1, 0)
end )

function isLocalPlayerSpectating()
	local px, py, pz = getElementPosition(localPlayer)
	if getElementData(localPlayer, "state") == "spectating" or pz > 1000 then 
		return true
	else 
		return false
	end
end

addEventHandler("onClientPlayerVehicleEnter", localPlayer, function()
	if not getPedOccupiedVehicle(localPlayer) or isLocalPlayerSpectating() then return end
	
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "dragCoeff", 1.5)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "tractionMultiplier", 0.95)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "maxVelocity", 220.0)
	setVehicleHandling(getPedOccupiedVehicle(localPlayer), "engineAcceleration", 20.0 )
	
	setVehicleOverrideLights(getPedOccupiedVehicle(localPlayer), 2)
end )

function forceAngle()
	if not getPedOccupiedVehicle(localPlayer) or isLocalPlayerSpectating() then return end
		
	local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(localPlayer))
	setElementRotation(getPedOccupiedVehicle(localPlayer), rx, ry, carAngle)
	setElementAngularVelocity(getPedOccupiedVehicle(localPlayer), 0.0, 0.0, 0.0)
end

addEventHandler("onClientKey", root, function(button,press) 
	local car = getPedOccupiedVehicle(localPlayer)
	local px, py, pz = getElementPosition(localPlayer)
	
	-- Disable vehicle controls
	toggleControl("vehicle_left", false)
	toggleControl("vehicle_right", false)
	toggleControl("horn", false)
	
	if isLocalPlayerSpectating() or not car or isChatBoxInputActive() then return end -- Spec check
	if press then
		local keys = getBoundKeys("vehicle_left")
		for keyName, state in pairs(keys) do
			if button == keyName or getAnalogControlState("vehicle_left", true) > 0.2 then
				-- + 30
				if carAngle == 330.0 then carAngle = 0.0	
				else carAngle = carAngle + 30.0 end
				
				local vx, vy, vz = getElementVelocity(car)
				setElementVelocity(car, vx*1.02, vy*1.02, vz*1.02)
				
				break
			end
		end
		
		local keys = getBoundKeys("vehicle_right")
		for keyName, state in pairs(keys) do
			if button == keyName or getAnalogControlState("vehicle_right", true) > 0.2 then
				-- -30
				if carAngle == 0.0 then carAngle = 330.0	
				else carAngle = carAngle - 30.0 end
				
				local vx, vy, vz = getElementVelocity(car)
				setElementVelocity(car, vx*1.02, vy*1.02, vz*1.02)
				
				break
			end
		end
	end
end )

addEvent("onClientPlayerFinish", true)
addEventHandler("onClientPlayerFinish", localPlayer, function()
	if isLocalPlayerSpectating() or not getPedOccupiedVehicle(localPlayer) then return end
	
	setVehicleWheelStates(getPedOccupiedVehicle(localPlayer), 2, 2, 2, 2)
end )