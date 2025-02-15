local carids = {441, 564, 572, 457, 485, 531, 583, 574, 530, 571}

function randomCar(checkpoint, time)
	local veh = getPedOccupiedVehicle(source)
	local x,y,z = getElementPosition(veh)
	local id = getElementModel (veh)
		if id == 441 or id == 564 then
			setElementPosition (veh, x, y, z+1)
		end
	local randoff = getElementData ( veh, "bikey")
	outputChatBox ( randoff )
	if randoff == 0 then
			setElementModel (veh, carids[math.random(#carids)])
		end
	end
end
addEvent('onPlayerReachCheckpoint')
addEventHandler('onPlayerReachCheckpoint', getRootElement(), randomCar)

function makeMarkers()
	gotBMX = createMarker (-158.8, -281.3, 2.8, "cylinder", 4, 255, 255, 255, 0)
	outputChatBox ( "hello")
	
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), makeMarkers)

function getBMX(player, dimension)
	if source == gotBMX then
		if getElementType(player) == "player" then
			local vehh = getPedOccupiedVehicle(player)
			if vehh then
				 setElementData ( vehh, "bikey", 1 )
			end
		end
	end
end
addEventHandler('onMarkerHit', getRootElement(), getBMX)
