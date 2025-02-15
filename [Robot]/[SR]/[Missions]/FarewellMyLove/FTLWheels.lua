local veh = getPedOccupiedVehicle(localPlayer)

function enterVehicle ( veh ) --when a player enters a vehicle
    if getElementType(source) == "player" then
		addVehicleUpgrade(veh,1025)
	end
	
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicle )