addEventHandler("onClientRender", root, function()
	if getPedOccupiedVehicle(localPlayer) then
		local x, y, z = getElementRotation(getPedOccupiedVehicle(localPlayer))
		local k, l = getVehicleTurretPosition(getPedOccupiedVehicle(localPlayer))
		
		if getElementModel(getPedOccupiedVehicle(localPlayer)) == 432 then
			setVehicleTurretPosition(getPedOccupiedVehicle(localPlayer), math.rad((getPedCameraRotation(localPlayer)*(-1) - z)-180), l)
		end
	end
end )

-- No damage from fire and weapons 
addEventHandler("onClientVehicleDamage", root, function(attacker, weapon)
	if source == getPedOccupiedVehicle(localPlayer) and (weapon == 37 or weapon == 31 or weapon == 38 or weapon == 28) then cancelEvent() end
end )