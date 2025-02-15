addEventHandler("onClientKey", root, function(button,press) 
	-- Disable vehicle controls
	toggleControl("vehicle_left", false)
	toggleControl("vehicle_right", false)
	
	if getElementData(localPlayer, "state") == "spectating" then return end -- Spectate check
	if not getPedOccupiedVehicle(localPlayer) then return end -- If player is not in the vehicle
	if isChatBoxInputActive() then return end -- if chatbox is opened

	if press then
		local keys = getBoundKeys("vehicle_left")
		for keyName, state in pairs(keys) do
			if button == keyName or getAnalogControlState("vehicle_left", true) > 0.2 then
				local rotX, rotY, rotZ = getElementRotation(getPedOccupiedVehicle(localPlayer))
				setElementRotation(getPedOccupiedVehicle(localPlayer), rotX, rotY, rotZ+30)
				setElementAngularVelocity(getPedOccupiedVehicle(localPlayer), 0, 0, 0)
				
				break
			end
		end
		
		local keys = getBoundKeys("vehicle_right")
		for keyName, state in pairs(keys) do
			if button == keyName or getAnalogControlState("vehicle_right", true) > 0.2 then
				local rotX, rotY, rotZ = getElementRotation(getPedOccupiedVehicle(localPlayer))
				setElementRotation(getPedOccupiedVehicle(localPlayer), rotX, rotY, rotZ-30)
				setElementAngularVelocity(getPedOccupiedVehicle(localPlayer), 0, 0, 0)
				
				break
			end
		end
	end
end )