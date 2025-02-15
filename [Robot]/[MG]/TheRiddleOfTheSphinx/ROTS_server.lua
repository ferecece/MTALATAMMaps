-- The Riddle Of The Sphinx serverside script by Ali Digitali
-- Anyone reading this has permission to copy/modify PARTS of this script

-- Things handled in this script:
-- - switching algorithm
-- - camera movement and animations/special effects
-- - Round cycler

function start(newstate,oldstate)
	currentState = newstate
	if (newstate == "LoadingMap") then		
		-- variables
		Z = 52
		X = -179.3
		middleY = 2223.65
		rightY = 2210.2
		leftY = 2237.2
		
		-- creating of the cones
		leftSpot = createObject(1610,X,leftY,200,0,0,0,true)
		setObjectScale(leftSpot,25)
		middleSpot = createObject(1610,X,middleY,200,0,0,0,true)
		setObjectScale(middleSpot,25)
		rightSpot = createObject(1610,X,rightY,200,0,0,0,true)
		setObjectScale(rightSpot,25)
		
		-- tables
		spots = {middleSpot,rightSpot,leftSpot} --table to pick random spots from
		movements = {"straight","up"} -- table with possible movements

		-- radar area
		radarBlue = createRadarArea(-156.01-20.1,2156-23.4,2*20.1,2*23.4,0,0,255,255)
		radarRed = createRadarArea(-121.5-20.1,2222.5-23.4,2*20.1,2*23.4,255,0,0,255)
		radarGreen = createRadarArea(-158.3-20.1,2288.6-23.4,2*20.1,2*23.4,0,255,0,255)

		-- creation of the explosive barrels
		explosives1 = createObject(1225,X,middleY,200,0,0,0,true)
		explosives2 = createObject(1225,X,middleY,200,0,0,0,true)
		for i=-2,2,1 do -- create barrels at the two cones
				for j = -1.8,1.8,1 do
					for k = 0,3,1 do
						local object1 = createObject(1225,X,middleY,200,0,0,0,true)
						attachElements(object1,explosives1,i,j,k)
						
						local object3 = createObject(1225,X,middleY,200,0,0,0,true)
						attachElements(object3,explosives2,i,j,k)
					end
				end
		end
		
		-- creation of the eyes
		eye1 = createMarker(-232.3,2220.5,76.4,"corona",1,255,0,0)
		eye2 = createMarker(-232.3,2224.6,76.4,"corona",1,255,0,0)
		
		switchResult() -- set up the cones and explosives for the first round
	end
	
	if (newstate == "PreGridCountdown") then
		--triggerClientEvent("laugh",resourceRoot)
	end
	
	if (newstate == "GridCountdown") then 
		for index,thePlayer in ipairs (getElementsByType("player")) do
			--setElementData( thePlayer, 'race.collideothers', 1, true )
			setElementData( thePlayer, "overrideCollide.uniqueblah", 0, false )
		end
		
		if #getAlivePlayers()>15 then
			outputChatBox("Collisions will be turned on when 15 players are left alive!",root,255,0,0)
		end
		-- col shapes
		blueCol = createColRectangle(-156.01-20.1,2156-23.4,2*20.1,2*23.4)
		redCol =  createColRectangle(-121.5-20.1,2222.5-23.4,2*20.1,2*23.4)
		greenCol =  createColRectangle(-158.3-20.1,2288.6-23.4,2*20.1,2*23.4)
		--setAndRememberCam()	
	end
	
	if (newstate == "Running" and oldstate == "GridCountdown") then 
		cycler()
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

function enterVehicle ( thePlayer, seat, jacked ) -- when a player enters a vehicle set his camera on the sphinx
    if (currentState ~= "Running") then
		cameraTarget[thePlayer] = getCameraTarget(thePlayer)
		setCameraMatrix(thePlayer,-125.5,2222.8999023438,86.5,-207.1,2223.2,52.7)
	end
end
addEvent("lookatsphinx",true)
addEventHandler ("lookatsphinx", getRootElement(), enterVehicle ) -- add an event handler for onVehicleEnter

------------------------
-- Functions to switch up the cones
------------------------
function moveToSpot(object,time,x,y,z) -- function to move a cone to a different spot
	local direction = movements[math.random(#movements)]
	if (direction == "straight") then
		moveObject(object,time,x,y,z)
	end
	
	if (direction == "up") then
		local sign = math.random(-1,1)
		local a,b,c = getElementPosition(object)
	
		moveObject(object,time/4,a+sign*10,b,c)
		setTimer(function()
			moveObject(object,time/2,x+sign*10,y,z)
		end,time/4,1)
		setTimer(function()
			moveObject(object,time/4,x,y,z)
		end,time*3/4,1)
	end
end

function switch2objects(time) -- function to switch two cones
	local direction = movements[math.random(#movements)]
	
	switch1 = spots[math.random(#spots)]
	repeat	
		switch2 = spots[math.random(#spots)]
	until (switch1 ~= switch2) -- make sure an object is not switched with itself
	
	local x,y,z = getElementPosition(switch1)
	local a,b,c = getElementPosition(switch2)
	moveToSpot(switch1,time,a,b,c)
	moveToSpot(switch2,time,x,y,z)
end

function switch3objects(time) -- function to switch 3 cones
	switch3 = spots[math.random(#spots)] -- get a random cone
	repeat	
		switch4 = spots[math.random(#spots)]
	until (switch4 ~= switch3) -- make sure an object is not switched with itself
	
	repeat
		switch5 = spots[math.random(#spots)]
	until (switch5 ~= switch4) and (switch5 ~= switch3)
	
	local x,y,z = getElementPosition(switch3)
	local a,b,c = getElementPosition(switch4)
	local d,e,f = getElementPosition(switch5)
	
	moveToSpot(switch3,time,a,b,c) -- move 3 to 4
	moveToSpot(switch4,time,d,e,f) -- move 4 to 5
	moveToSpot(switch5,time,x,y,z) -- move 5 to 3
end

function switchResult(time,amount)
	setElementPosition(leftSpot,X,leftY,Z+10)
	setElementPosition(middleSpot,X,middleY,Z+10)
	setElementPosition(rightSpot,X,rightY,Z+10)
	
	if (cycle ~= 1) then -- does not have to be defined in the first cycle because it happens when the map loads
		noExplosion = spots[math.random(#spots)] -- pick a cone that has no explosion
		repeat	
			explosion1 = spots[math.random(#spots)] -- pick a cone that has explosions
		until (explosion1 ~= noExplosion)
		
		repeat
			explosion2 = spots[math.random(#spots)] -- pick the last cone that has explosions
		until (explosion2 ~= noExplosion)and (explosion2 ~= explosion1)
	end
	
	local x,y,z = getElementPosition(explosion1)
	local a,b,c = getElementPosition(explosion2)
	
	setElementPosition(explosives1,X,y,Z) -- move the explosives for show
	setElementPosition(explosives2,X,b,Z) -- move the explosives for show
	
	if not time then
		return
	end
	
	setTimer(function() -- move the cones down
		moveObject(leftSpot,time,X,leftY,Z)
		moveObject(middleSpot,time,X,middleY,Z)
		moveObject(rightSpot,time,X,rightY,Z)
	end,3000,1)
	
	setTimer(function() -- move the barrels and start switching the cones
		setElementPosition(explosives1,X,y,Z+100)
		setElementPosition(explosives2,X,b,Z+100)

		setTimer(function()
			if (math.random() < 0.5) then
				switch3objects(time)
			else
				switch2objects(time)
			end
		end,time+100,amount)
	end,time+3000,1)
	
	local duration = time+3000+(time+100)*amount+2*time
	return noExplosion,duration -- return which cone has no barrels and how long it takes before the switching is complete
end

---------------
-- functions to manage the cones
---------------
function setAndRememberCam()
	for index,thePlayer in ipairs (getElementsByType("player")) do -- make players watch the sphinx and save their camera target and freeze them
		local veh = getPedOccupiedVehicle(thePlayer)
		if veh then
			setElementFrozen(veh,true)
		end
		cameraTarget[thePlayer] = getCameraTarget(thePlayer)
		setCameraMatrix(thePlayer,-125.5,2222.8999023438,86.5,-207.1,2223.2,52.7)
	end
end

cameraTarget = {}
function initiateSwitch(time,amount)
	sphinxEyes("flicker",0,255,0)
	setAndRememberCam()
	for index,alivePlayer in ipairs (getAlivePlayers()) do
		setVehicleDamageProof(getPedOccupiedVehicle(alivePlayer), true)
	end
	
	local safeZone,duration = switchResult(time,amount) -- run the switching and retrieve the safe zone and how long it will take to switch everything
	
	setTimer(function()
		-- make the camera retarget the original target and unfreeze the vehicle for the alive players
		for index,thePlayer in ipairs (getElementsByType("player")) do
			setCameraTarget(thePlayer,cameraTarget[thePlayer])
			-- setElementFrozen(thePlayer,false)
		end

		for index,alivePlayer in ipairs (getAlivePlayers()) do
			setVehicleDamageProof(getPedOccupiedVehicle(alivePlayer), false)
			setElementFrozen(getPedOccupiedVehicle(alivePlayer),false)
		end
	end,duration+1000,1)
	
	return safeZone,duration
end

function reveal(safeZone) -- reveal which cone was correct and kill all the players that are in the wrong area
	local x,y,z = getElementPosition(safeZone)
	if (y>2230) then
		colShape = greenCol
		setRadarAreaFlashing (radarGreen, true )
		sphinxEyes("color",0,255,0)
		outputChatBox("The correct answer was green!",root,0,255,0)
	elseif (y<2215) then
		colShape = blueCol
		setRadarAreaFlashing (radarBlue, true )
		sphinxEyes("color",0,0,255)
		outputChatBox("The correct answer was blue!",root,0,0,255)
	else
		colShape = redCol
		setRadarAreaFlashing (radarRed, true )
		sphinxEyes("color",255,0,0)
		outputChatBox("The correct answer was red!",root,255,0,0)
	end
	
	local x,y,z = getElementPosition(explosion1)
	local a,b,c = getElementPosition(explosion2)
	setElementPosition(explosives1,x,y,z)
	setElementPosition(explosives2,a,b,c)
	
	local d,e,f = getElementPosition(leftSpot)
	local g,h,i = getElementPosition(middleSpot)
	local j,k,l = getElementPosition(rightSpot)
	moveObject(leftSpot,1000,d,e,f+10)
	moveObject(middleSpot,1000,g,h,i+10)
	moveObject(rightSpot,1000,j,k,l+10)
	
	for index,theElement in ipairs (getElementsByType("object")) do
		if (getElementModel(theElement) == 8838) then
			setElementDimension(theElement,1)
		end
	end
	
	for index,thePlayer in ipairs (getAlivePlayers()) do -- if the player is not in the correct area, kill them
			local x,y,z = getElementPosition(thePlayer)
			if not(isElementWithinColShape(thePlayer,colShape)) or (z<33) then
				setTimer(function()
					blowVehicle(getPedOccupiedVehicle(thePlayer))
				end,2000,1)
				triggerClientEvent(thePlayer,"laugh",thePlayer)
			end
	end
	
	setTimer(function()
		createExplosion(x,y,z,10)
		createExplosion(a,b,c,10)
		setElementPosition(explosives1,x,y,z+100)
		setElementPosition(explosives2,a,b,c+100)

		setRadarAreaFlashing (radarRed, false )
		setRadarAreaFlashing (radarBlue, false )
		setRadarAreaFlashing (radarGreen, false )
		
		setTimer(function()
			for index,theElement in ipairs (getElementsByType("object")) do
				if (getElementModel(theElement) == 8838) then
					setElementDimension(theElement,0)
				end
			end
			
			cycler()
		end,3000,1)
	end,2000,1)
end

-----------------------
-- Eye Colors
-----------------------
function sphinxEyes(what,r,g,b)
	if (what == "color") then
		killTimer(eyeTimer)
		if isTimer(eyeGreen) then
			killTimer(eyeGreen)
		end
		if isTimer(eyeblue) then
			killTimer(eyeBlue)
		end
		setMarkerColor(eye1,r,g,b,255)
		setMarkerColor(eye2,r,g,b,255)
	end
	
	if (what == "flicker") then
		eyeTimer = setTimer(function()
			setMarkerColor(eye1,255,0,0,255) -- red
			setMarkerColor(eye2,255,0,0,255)
			eyeGreen = setTimer(function()
				setMarkerColor(eye1,0,255,0,255) -- green
				setMarkerColor(eye2,0,255,0,255)
			end,300,1)
			eyeBlue = setTimer(function()
				setMarkerColor(eye1,0,0,255,255) -- blue
				setMarkerColor(eye2,0,0,255,255)
			end,600,1)
		end,900,0)
	end
end

----------------------------------------------------------------------------------
-------
-- Main function - cycles
-------
cycle = 0
ghostmode = true
roundtime = 15000
function cycler()
	-- disable ghostmode if needed, check amount of alive players first
	-- if less than 16 disable ghostmode
	if (#getAlivePlayers()<16) and ghostmode then
		ghostmode = false
		outputChatBox("Collisions have been turned on!",root,255,0,0)
		roundtime = 15000
		for index,thePlayer in ipairs (getElementsByType("player")) do
			--setElementData( thePlayer, 'race.collideothers', 1, true )
			setElementData( thePlayer, "overrideCollide.uniqueblah", nil, false ) -- return ghostmode back to default (off)
		end
	end

	-- Actual cycle manager, set how fast the cones should be shuffled and how many times
	cycle = cycle + 1
	switchTime = 1000 - 200*cycle -- 1000, 800, 600,400,200
	if (cycle > 4) then
		switchTime = 200
	end
	switchAmount = 4 + cycle*3
	local safeZone,duration = initiateSwitch(switchTime,switchAmount) -- switch the cones
	
	setTimer(function()
		triggerClientEvent("showProgressBar",resourceRoot,roundtime-1000) -- show the progress bar
	end,duration+1000,1)
	
	-- setTimer(function() -- output the answer in the debugstrings
	-- 	local x,y,z = getElementPosition(safeZone)
	-- 	if (y>2230) then
	-- 		outputDebugString("Answer to the Riddle of the Spinx: Green")
	-- 	elseif (y<2215) then
	-- 		outputDebugString("Answer to the Riddle of the Spinx: Blue")
	-- 	else
	-- 		outputDebugString("Answer to the Riddle of the Spinx: Red")
	-- 	end
	-- end,duration+1000,1)
	
	setTimer(function()
		reveal(safeZone) -- reveal the correct location
	end,duration+roundtime,1)
end





