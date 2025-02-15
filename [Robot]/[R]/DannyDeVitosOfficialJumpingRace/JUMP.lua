function makeicon()
	bindKey("2","down",jumpy)
	bindKey("lctrl","down",jumpy)
	bindKey("rctrl","down",jumpy)
	bindKey("mouse2","down",jumpy)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), makeicon)

function jumpy()
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if (veh) then
		if isVehicleOnGround ( veh ) == true then
			local sx,sy,sz = getElementVelocity(veh)
			setElementVelocity (veh, sx, sy, 0.25)
		end
	end
end