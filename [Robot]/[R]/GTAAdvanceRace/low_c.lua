local ScreenX, ScreenY = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot, function()	
	displaySource = dxCreateScreenSource(256, 128)
end )

addEventHandler("onClientPreRender", root, function()
	if displaySource then
		dxUpdateScreenSource(displaySource)
		dxDrawImage(0.0, 0.0, ScreenX, ScreenY, displaySource)
	end
end )

addEventHandler("onClientRender", root, function()
	if not getPedOccupiedVehicle(localPlayer) then return end
	
	local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
	if z > 1000 or getElementData(localPlayer, "state") == "spectating" then return end
	
	local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
	local vel = (vx*vx + vz*vz + vy*vy)*100
	
	if vel >= 70 then vel = 70 end
	setCameraMatrix(x, y, z+15+vel*1.2, x, y, z)
end )
