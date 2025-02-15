vehicleIds = {400, 401, 402, 403, 404, 405,
	407, 408, 409, 410, 411, 412, 413, 414, 415,
	416, 418, 419, 420, 421, 422, 423, 424, 
	426, 427, 428, 429, 430,
	436, 438, 439, 440, 441, 442, 443, 444, 445, 446, 448, 451,
	452, 453, 454, 455, 456, 457, 458, 459, 461, 462, 463, 466, 467, 468,
	471, 472, 473, 474, 475, 477, 478, 479, 480, 481, 482, 483, 484,
	489, 490, 491, 492, 493, 494, 495, 496, 498, 499, 500, 502, 503, 504, 505,
	506, 507, 508, 509, 510, 514, 515, 516, 517, 518, 521, 522,
	524, 526, 527, 529, 530, 531, 533, 534, 535, 536, 539, 540, 541,
	542, 543, 544, 545, 546, 547, 549, 550, 551, 552, 554, 555, 558, 559,
	560, 561, 562, 565, 566, 567, 571, 572, 573, 574, 575, 576,
	578, 579, 580, 581, 582, 583, 585, 586, 587, 588, 589, 595,
	596, 597, 598, 599, 600, 602, 603, 604, 605, 608 }


function raceState(newstate,oldstate)

	if (newstate == "LoadingMap") then
		colUp   = createColTube (-1805, 558, 400, 20, 100 )
		colDown = createColTube (-1805, 558, 0,   20, 80 )

		markerUp   = createMarker(-1805, 558, 400,'ring',12,255,0,0)
		markerDown = createMarker(-1805, 558, 80, 'ring',12,0,255,0)
		setMarkerTarget ( markerUp,  -1805, 558, 1000 )   
		setMarkerTarget ( markerDown,-1805, 558, 1000 )   

	end

	
	if (newstate == "GridCountdown") then
		setCloudsEnabled ( false ) 
		
		outputChatBox("Use the HORN (H) to temporarily disable collisions.",root,255,165,0)
		outputChatBox("Be warned: low hume reality severely damages vehicle integrity!",root,255,165,0)
		--outputChatBox("Sit back and relax.",root,0,255,0)
		--outputChatBox("There is absolutely nothing you can do.",root,255,165,0)
		--outputChatBox("Except curse those beneath and annoy those above.",root,255,0,0)
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then

		--targetMarker = {}
		for i,p in ipairs(getElementsByType('player')) do
			setPedGravity(p,0) --Setting gravity to 0 makes setting negative gravity more reliable (does not always return true otehrwise)
		end

		setTimer(function()
			for i,p in ipairs(getElementsByType('player')) do
				bindKey(p,"horn","both",noCollide)
				
				v = getPedOccupiedVehicle(p)
				
				if v then 

					local r,g,b = 0,0,0
					local x,y,z = getElementPosition(p)

					if z < 100 then
						--targetMarker[p] = colUp
						setPedGravity(p,-0.005) -- go up
				 	   	r,g,b = 0,255,0
					else
						--targetMarker[p] = colDown
						setPedGravity(p,0.005) -- go down
						r,g,b = 255,0,0
					end
					setVehicleColor(v,r,g,b,r,g,b,r,g,b)
					--outputChatBox("start " .. getPlayerName(p) .. " " .. getPedGravity(p))
					setVehicleDamageProof (v, true)
				end

			end
		end,2000,1)

		if #getAlivePlayers() == 1 then
			outputChatBox("You are playing alone, here are some friends.", root, 0,255,0)
			setTimer(function()
				local v = createVehicle(427,-1805, 558, 400)
				local p = createPed(0,-1805, 558, 420)
				warpPedIntoVehicle(p,v)
				setElementData(v,'race.collideothers',1)
				r,g,b = 255,0,0
				setVehicleColor(v,r,g,b,r,g,b,r,g,b)
			end,5000,30)
		end

		addEventHandler ( "onColShapeHit", colUp, colHit )
		addEventHandler ( "onColShapeHit", colDown, colHit )

	end

end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), raceState )

function enterVehicle ( v, seat, jacked ) --when a player enters a vehicle

	local r,g,b = 0,0,0
	local x,y,z = getElementPosition(v)
	-- local p = getVehicleOccupant(v)
	if z < 100 then
 	   	r,g,b = 0,255,0
	else
		r,g,b = 255,0,0
	end
	setVehicleColor(v,r,g,b,r,g,b,r,g,b)
	--setVehicleDamageProof (v, true)

end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enterVehicle ) -- add an event handler for onPlayerVehicleEnter



function colHit ( e, matchingDimension)
    if not (getElementType ( e ) == "vehicle") then
    	return
    end

	p = getVehicleOccupant(e)
	if not p then 
		return 
	end

	--outputChatBox("colHit " .. getPlayerName(p))
	setElementModel(e,vehicleIds[math.random(1,#vehicleIds)])

	local r,g,b = 0,0,0
	if source == colUp then
		setPedGravity(p,0.005) -- go down
		r,g,b = 255,0,0
		
	elseif source == colDown then
 	   	setPedGravity(p,-0.005) -- go up
 	   	r,g,b = 0,255,0
	end

	if getElementType(p) == "player" then -- do not trigger for non-players
		if getControlState(p,"handbrake") then
			r,g,b = 255,165,0
		end
		triggerClientEvent ( p, "collectCP", p)
	end

	setVehicleColor(e,r,g,b,r,g,b,r,g,b)
	setVehicleDamageProof(e,true)
	--outputChatBox("colHit " .. getPedGravity(p))

end


timers = {}
function noCollide(p,key,state)
	local v = getPedOccupiedVehicle(p)
	if v then
		local r,g,b = 255,165,0
		
		if state == "down" then
			local vx,vy,vz = getElementVelocity(v)
			--outputChatBox((vx^2+vy^2+vz^2))
			if (vx^2+vy^2+vz^2) < 0.001 then
				local x,y,z = getElementPosition(v)
				setElementPosition(v,-1805, 558,z)

			end
			setElementData(v,'race.collideothers',0)
			setElementAlpha(v,150)
			r,g,b = 255,165,0

			if isTimer(timers[p]) then
				killTimer(timers[p])
				timers[p] = nil
			end

			timers[p] = setTimer(function()
				local h = getElementHealth(v)
				setElementHealth(v,h-5)
			end,100,0)

		end

		if state == "up" then
			setElementData(v,'race.collideothers',1)
			setElementAlpha(v,255)
			
			local grav = getPedGravity(p) 
			if grav < 0 then
				r,g,b = 0,255,0
			end
			if grav > 0 then
				r,g,b = 255,0,0
			end

			if isTimer(timers[p]) then
				killTimer(timers[p])
				timers[p] = nil
			end
		end

		setVehicleColor(v,r,g,b,r,g,b,r,g,b)
	end

end

function unBrake()
	if isTimer(timers[p]) then
		killTimer(timers[p])
		timers[p] = nil
	end
end
addEvent("onPlayerRaceWasted")
addEventHandler("onPlayerRaceWasted",root, unBrake)
addEvent("onPlayerFinish")
addEventHandler("onPlayerFinish",root, unBrake)


-- Reset gravity
function onCurrentResourceStop (theResource)
	for i,p in ipairs(getElementsByType("player")) do
		setPedGravity(p,0.008)
	end
end

-- add the event handler
addEventHandler("onResourceStop", getResourceRootElement(), onCurrentResourceStop)
