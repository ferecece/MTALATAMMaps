addEventHandler("onClientRender", root, function()
	if not getPedOccupiedVehicle(localPlayer) then return end

	local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
	if z > 1000 or getElementData(localPlayer, "state") == "spectating" then return end

	local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
	local vel = (vx * vx + vz * vz + vy * vy) * 100

	if vel >= 40 then vel = 40 end
	setCameraMatrix(x, y, z + 40 + vel * 0.5, x, y, z, 270)
end )
