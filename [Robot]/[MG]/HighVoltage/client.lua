function damage()
local veh = getPedOccupiedVehicle(localPlayer)
if veh then
	local x,y,z = getElementPosition(veh)
	if z < 79.5 then
		setPedOnFire(localPlayer,true)
	end
end
end
addEventHandler("onClientRender",root,damage)