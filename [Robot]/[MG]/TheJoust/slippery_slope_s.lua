slippery_slope = {}

slippery_slope['name'] = "Slippery Slope"
slippery_slope['instructions'] = "W,S and Handbrake are disabled. Try to get closer to the target than your opponent!"

function slippery_slope:startGame ()
	for i,p in pairs(getAlivePlayers()) do
        toggleControl(p, "accelerate", false)
    	toggleControl(p, "brake_reverse", false)
    	toggleControl(p, "handbrake", false)
    	setControlState(p, "brake_reverse", true)
	end

	for i,veh in pairs(getElementsByType('vehicle')) do
		if getElementModel(veh) == 583 then --tug
	        setVehicleHandling(veh, "engineAcceleration", 0 )
	        setVehicleHandling(veh, "brakeDeceleration", 0.1)
			setElementFrozen(veh,false)
   		end
	end

	triggerClientEvent ("pedState", resourceRoot, true)
	triggerClientEvent("showProgressBar", resourceRoot, 20000)

	setTimer(function()
		triggerClientEvent ("pedState", resourceRoot, false)
		for i,p in pairs(getElementsByType('player')) do
		    toggleControl(p, "accelerate", true)
			toggleControl(p, "brake_reverse", true)
			toggleControl(p, "handbrake", true)
			setControlState(p, "brake_reverse", false)
		end
		finishManager()  -- finish conditions, 20 seconds
	end, 20000,1)
end

function slippery_slope:createArena(x,y,z)
	-- shielding
	local arena_elements = {}
	table.insert(arena_elements, createObject ( 7017, x + -9.8,  y + -36.56 ,  z+ 40.89, 0, 0,   -90))
	table.insert(arena_elements, createObject ( 7017, x + -9.8,  y + 37.08 ,   z+ 40.89, 0, 0,   -90))
	table.insert(arena_elements, createObject ( 7017, x + 10.52, y + 37.08 ,   z+ 40.89, 0, 0,   -90))
	table.insert(arena_elements, createObject ( 7017, x + 10.46, y + -36.56 ,  z+ 40.89, 0, 0,   -90))
	table.insert(arena_elements, createObject ( 7017, x + -9.8,  y + -80.06 ,  z+ 50.39, 0, -15, -90))
	table.insert(arena_elements, createObject ( 7017, x + -9.8,  y + -125.31 , z+ 59.39, 0, -5,  -90))
	table.insert(arena_elements, createObject ( 7017, x + 9.48,  y + -125.31 , z+ 59.39, 0, -5,  -90))
	table.insert(arena_elements, createObject ( 7017, x + 9.77,  y + -80.06 ,  z+ 50.39, 0, -15, -90))
	table.insert(arena_elements, createObject ( 7017, x + -9.8,  y + 81.21 ,   z+ 50.39, 0, 15,  -90))
	table.insert(arena_elements, createObject ( 7017, x + -9.8,  y + 122.31 ,  z+ 59.39, 0, 5,   -90))
	table.insert(arena_elements, createObject ( 7017, x + 10.45, y + 81.21 ,   z+ 50.39, 0, 15,  -90))
	table.insert(arena_elements, createObject ( 7017, x + 10.25, y + 122.31 ,  z+ 59.39, 0, 5,   -90))

	for i,o in pairs(arena_elements)do
		setElementAlpha(o, 0)
	end

	-- roads
    table.insert(arena_elements, createObject (6448,  x-34.51, y+90,    z+54.13,0,0,0))
    table.insert(arena_elements, createObject (6448,  x+34.5,  y-90,    z+54.13,0,0,-180))
    table.insert(arena_elements, createObject (6450,  x+9.91,  y+27.75, z+31.92,0,0,0))
    table.insert(arena_elements, createObject (6458,  x+9.85,  y-6.25,  z+42.08,0,0,0))

    -- railings
	table.insert(arena_elements, createObject (11482, x+10.27, y-12.58, z+40.37,0,0,53.75))
    table.insert(arena_elements, createObject (11482, x-9.63,  y-12.58, z+40.37,0,0,53.745))

    -- target
    table.insert(arena_elements, createObject (3108,  x+0,     y+0,     z+39.99,0,0,0))

    -- spawnpoints
    local spawnpoints = {[1]={["model"]=583, ["position"]={x,y+126.4,z+60.78,0,0,-180}},
    					 [2]={["model"]=583, ["position"]={x,y-126.4,z+60.78,0,0,0}},
					    }

	local target = {x+0, y+0, z+39.99}

	return {arena_elements, spawnpoints, target}
end

function slippery_slope:determineMatchWinner(match, target)
	-- must always return player1 or player2, so build in a default in case both players are invalid

	local player1_score = 10000
	local player2_score = 10000
	local x,y,z = unpack(target)
	if match['player1']['veh'] ~= nil then
		local veh1 = match['player1']['veh']
		if veh1 then
			local x1,y1,z1 = getElementPosition(veh1)
			if z1 < 1000 then
				player1_score = getDistanceBetweenPoints3D(x,y,z,x1,y1,z1)
			end
		end
	end
	if match['player2']['veh'] ~= nil then
		local veh2 = match['player2']['veh']
		if veh2 then
			local x2,y2,z2 = getElementPosition(veh2)
			if z2 < 1000 then
				player2_score = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
			end
		end
	end

	if player1_score < player2_score then
		-- player 1 win
		return 'player1'
	else
		return 'player2'
	end

end
