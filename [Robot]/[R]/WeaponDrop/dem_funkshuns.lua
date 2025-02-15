local cps = {
[1]={ -300, 8.3, 1, 2 },
[2]={ -292, 3.6, 0.3, 3 },
[3]={ -287, 2.1, 0.3, 2 },
[4]={ -296, 5.3, 0.3, 1 },
[5]={ -283, 1.5, 0.6, 1},
[6]={ -255, -275.5, 0.3, 1},
[7]={ -261, -273.5, 0.3, 2},
[8]={ -267, -271.2, 0.5, 3},
[9]={ -932, -224.5, 39.2, 1},
[10]={ -942, -228.7, 37.9, 2},
[11]={ -937, -226.4, 38.5, 3},
[12]={ -947, -231.5, 37.6, 1},
[13]={ -951, -234.5, 37.4, 2},
[14]={ -669, 13, 69.3, 1},
[15]={ -673, 10.7, 69.3, 2},
[16]={ -677, 8.4, 69.3, 3},
[17]={ -664, 91.8, 24.5, 1},
[18]={ -675, 106.8, 21.5, 2},
[19]={ -689, 117.7, 19.7, 3},
[20]={ -705, 126, 16.6, 1},
[21]={ -730, 237.7, 1.3, 1},
[22]={ -733, 244, 1, 2},
[23]={ -509, 274.7, 2.2, 1},
[24]={ -508, 296, 1.4, 2}
}

markers = { }

function makeMarkers()
	for i = 1,#cps do
		markers[i] = createMarker(cps[i][1],cps[i][2],cps[i][3],"cylinder",3,255,0,0,100)
    end
	boost1 = createMarker (-365, -262, 16, "cylinder", 13, 255, 0, 0, 0)
	boost2 = createMarker (-508, 284, 0, "cylinder", 9, 255, 0, 0, 0)
	markerColourChange(1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), makeMarkers)

function markerColourChange(point)
	if point == 1 then
		for i = 1,#cps do
			if cps[i][4] == 1 then
				setMarkerColor (markers[i], 255, 0, 0, 100)
			elseif cps[i][4] == 2 then
				setMarkerColor (markers[i], 0, 255, 0, 180)
			elseif cps[i][4] == 3 then
				setMarkerColor (markers[i], 0, 0, 255, 180)
			end
		end
		setTimer(markerColourChange, 200, 1, 2)
	elseif point == 2 then
		for i = 1,#cps do
			if cps[i][4] == 3 then
				setMarkerColor (markers[i], 255, 0, 0, 100)
			elseif cps[i][4] == 1 then
				setMarkerColor (markers[i], 0, 255, 0, 100)
			elseif cps[i][4] == 2 then
				setMarkerColor (markers[i], 0, 0, 255, 100)
			end
		end
		setTimer(markerColourChange, 200, 1, 3)
	elseif point == 3 then
		for i = 1,#cps do
			if cps[i][4] == 2 then
				setMarkerColor (markers[i], 255, 0, 0, 100)
			elseif cps[i][4] == 3 then
				setMarkerColor (markers[i], 0, 255, 0, 100)
			elseif cps[i][4] == 1 then
				setMarkerColor (markers[i], 0, 0, 255, 100)
			end
		end
		setTimer(markerColourChange, 200, 1, 1)
	end
end

function randomCar(player, dimension)
	for i = 1,#cps do
		if source == markers[i] then
			if getElementType(player) == "player" then
				local veh = getPedOccupiedVehicle(player)
				if veh then
					triggerClientEvent ( player, "hitmarker", getRootElement(),1)
					setElementPosition (markers[i], 0,0,0)
					setTimer ( function()
						setElementPosition (markers[i], cps[i][1], cps[i][2], cps[i][3])
					end, 1000, 1 )
				end
			end
		end
	end
	if source == boost1 then
		if getElementType(player) == "player" then
			local veh = getPedOccupiedVehicle(player)
			if veh then
				local sx,sy,sz = getElementVelocity(veh)
				setElementVelocity(veh, sx*1.8, sy*1.8, sz)
			end
		end
	elseif source == boost2 then
		if getElementType(player) == "player" then
			local veh = getPedOccupiedVehicle(player)
			if veh then
				local sx,sy,sz = getElementVelocity(veh)
				setElementVelocity(veh, sx*1.6, sy*1.6, sz)
			end
		end
	end
end
addEventHandler('onMarkerHit', getRootElement(), randomCar)
