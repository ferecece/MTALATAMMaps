Me = getLocalPlayer()
Root = getRootElement()

function Main () 
bumper1 = createMarker(2172.2998046875, -3896.5, 20.5, 'corona', 3, 249, 5, 5, 255)
bumper2 = createMarker(2584.6005859375, -3896.5, 20.5, 'corona', 3, 249, 5, 5, 255)
bumper3 = createMarker(2584.6005859375, -4372.099609375, 21.10000038147, 'corona', 3, 249, 5, 5, 255)
bumper4 = createMarker(2172.3000488281,-4372.099609375, 21.10000038147, 'corona', 3, 249, 5, 5, 255)
addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
if source == bumper1 then
		setElementVelocity(vehicle,2,0,0)
		addEventHandler ( "onClientRender", getRootElement (), drawen1 )
	end
if source == bumper2 then
		setElementVelocity(vehicle,-2,0,0)
		addEventHandler ( "onClientRender", getRootElement (), drawen1 )
	end
if source == bumper3 then
		setElementVelocity(vehicle,-2,0,0)
		addEventHandler ( "onClientRender", getRootElement (), drawen1 )
	end
if source == bumper4 then
		setElementVelocity(vehicle,2,0,0)
		addEventHandler ( "onClientRender", getRootElement (), drawen1 )
	end

end