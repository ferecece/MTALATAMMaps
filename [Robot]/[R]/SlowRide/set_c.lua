jumpTimer = nil

addEventHandler("onClientRender", getRootElement(), function()
	setWorldProperty("AmbientColor", 20, 0, 40)
	setWorldProperty("AmbientObjColor", 20, 0, 40)
	setWorldProperty("LowCloudsColor", 20, 0, 40)
	setWorldProperty("BottomCloudsColor", 20, 0, 40)
	setWorldSpecialPropertyEnabled ("vehiclesunglare", true)
	
	if getPedOccupiedVehicle(localPlayer) then
		if getVehicleUpgradeOnSlot(getPedOccupiedVehicle(localPlayer), 9) ~= 1087 then
			addVehicleUpgrade(getPedOccupiedVehicle(localPlayer), 1087)
			toggleControl("horn", false)
		end
	end
	
	toggleControl("horn", false)
	toggleControl("sub_mission", false)
	toggleControl("special_control_left", false)
	toggleControl("special_control_right", false)
	toggleControl("special_control_up", false)
	toggleControl("special_control_down", false)
end )

addEventHandler("onClientKey", root, function(button, press) 
	if isChatBoxInputActive() then return end -- if chatbox is opened
	
	-- Spectate checks
	local x, y, z = getElementPosition(localPlayer)
	local taxi = getPedOccupiedVehicle(localPlayer)
	if z > 1000 or getElementData(localPlayer, "state") == "spectating" or not taxi then return end
	
	-- vehicle_left
	local keys = getBoundKeys("vehicle_left")
	for keyName, state in pairs(keys) do
		if button == keyName then
			setPedControlState(localPlayer, "special_control_left", press)
		end
	end
	
	-- vehicle_right
	local keys = getBoundKeys("vehicle_right")
	for keyName, state in pairs(keys) do
		if button == keyName then
			setPedControlState(localPlayer, "special_control_right", press)
		end
	end
	
	-- accelerate
	local keys = getBoundKeys("accelerate")
	for keyName, state in pairs(keys) do
		if button == keyName and press then
			setPedControlState(localPlayer, "special_control_down", true)
			
			if isTimer(jumpTimer) then killTimer(jumpTimer) end
			jumpTimer = setTimer(function() setPedControlState(localPlayer, "special_control_down", false) end, 100, 1)
		end
	end
	
	-- brake_reverse
	local keys = getBoundKeys("brake_reverse")
	for keyName, state in pairs(keys) do
		if button == keyName then
			setPedControlState(localPlayer, "special_control_up", press)
		end
	end
end )