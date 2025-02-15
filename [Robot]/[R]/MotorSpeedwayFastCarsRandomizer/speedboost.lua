local multiplier = 1.3 -- 
function boost()
	local theVehicle = getPedOccupiedVehicle(source)  
	if theVehicle then  
		local speedx, speedy, speedz = getElementVelocity(theVehicle)  
		setElementVelocity(theVehicle, speedx*multiplier, speedy*multiplier, speedz*multiplier)  
	end	
end
addEvent("onPlayerReachCheckpoint", true) 
addEventHandler("onPlayerReachCheckpoint", getRootElement(), boost) 