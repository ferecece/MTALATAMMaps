-- Carball serverside script by Ali Digitali
-- Anyone reading this has permission to copy/modify PARTS of this script

-- Things handled by this script:
-- - Ball spawning
-- - Goal triggers
-- - Goal display
-- - adding upgrades to vehicles
-- - assigning players to teams

-- Radar/variables/team/marker creation

randomTeam1 = math.random(1690)
randomTeam2 = math.random(1659)
teamInt1 = 0
teamInt2 = 0
teamName1 = ""
teamName2 = ""
for i, v in pairs(teamColors) do
	teamInt1 = teamInt1 + 1
	if (teamInt1 == randomTeam1) then
		teamName1 = i
		tr1,tg1,tb1,_ = getColorFromString(v)
	else
		teamInt2 = teamInt2 + 1
	end
	if (teamInt2 == randomTeam2) then
		teamName2 = i
		tr2,tg2,tb2,_ = getColorFromString(v)
		teamInt2 = 9999
	end
end


createRadarArea ( 700, -2250.3000488281-200, 100, 400, tr1,tg1,tb1,255)                
createRadarArea ( 394-100, -2250.3000488281-200, 100, 400, tr2,tg2,tb2,255)  
bluegoalcounter = 0
redgoalcounter = 0
redTeam = createTeam(teamName1,tr1,tg1,tb1)
blueTeam = createTeam(teamName2,tr2,tg2,tb2)
redMarker = createMarker(704.6,-2257.10,14.5,"ring",20,tr1,tg1,tb1)
blueMarker = createMarker(389.4,-2261,14.5,"ring",20,tr2,tg2,tb2)

function start(newstate,oldstate)
	currentState = newstate
	if (newstate == "GridCountdown") then
		
		--Colshapes that represent the goals, might be needed in the future
		--blueColShape = createColCuboid(380,-2282.6,3,13,41,28.3)
		--redColShape = createColCuboid(701.3,-2278.3,3,13,41,28.3)
		
		playArea = createColCuboid(389.4,-2383,5,315,255,100)
		addEventHandler ( "onColShapeLeave", playArea, leftArea )
		addEventHandler ( "onColShapeHit", playArea, enteredArea )
	
		ball = createObject(1305,546.9, -2258.05, 9)
		setObjectScale(ball,8)
		setElementCollisionsEnabled(ball,false)
		local ballBlip = createBlipAttachedTo (ball,0,2,0,255,0)
		
		tug = createVehicle ( 583, 546.9, -2258.05, 14)
		setElementAlpha(tug,0)
		setVehicleDamageProof(tug,true)
		setElementData ( tug, 'race.collideothers', 1 )
		
		attachElements(ball,tug,0,0,0.5)

		addEventHandler("onElementStartSync", tug, syncStart )
		addEventHandler( "onElementStopSync", tug, syncStop )	
		
		-- Make the display for the goals and add players to it
		redgoals = textCreateDisplay()
		redgoalsText = textCreateTextItem(teamName1 .. " Goals:   " .. redgoalcounter,0.5,0.05,"medium",tr1,tg1,tb1,255,2,"center")
		textDisplayAddText ( redgoals, redgoalsText ) 
		
		bluegoals = textCreateDisplay()
		bluegoalsText = textCreateTextItem(teamName2 .. " Goals:    " .. bluegoalcounter,0.5,0.1,"medium",tr2,tg2,tb2,255,2,"center")
		textDisplayAddText ( bluegoals, bluegoalsText ) 
		
		for index, thePlayer in ipairs (getElementsByType("player")) do
			textDisplayAddObserver ( redgoals, thePlayer )
			textDisplayAddObserver ( bluegoals, thePlayer )
		end
	end

	if (newstate == "TimesUp") then -- show which team won at the end
		winningteam = textCreateDisplay()
		if (bluegoalcounter < redgoalcounter) then
			winningteamText = textCreateTextItem("The " .. teamName1 .. " team wins!",0.5,0.4,"medium",tr1,tg1,tb1,255,5,"center")
		elseif (bluegoalcounter > redgoalcounter) then
			winningteamText = textCreateTextItem("The " .. teamName2 .. " team wins!",0.5,0.4,"medium",tr2,tg2,tb2,255,5,"center")
		else
			winningteamText = textCreateTextItem("The game was a draw!",0.5,0.4,"medium",tr1,0,tb2,255,5,"center")
		end
		textDisplayAddText ( winningteam, winningteamText ) 
		for index, thePlayer in ipairs (getElementsByType("player")) do
			textDisplayAddObserver ( winningteam, thePlayer )
		end
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

----------------
-- Ball
----------------

function syncStop ( oldSyncer )
    tugX,tugY,tugZ = getElementPosition(tug)
	tugVelX,tugVelY,tugVelZ = getElementVelocity(tug)
	--outputChatBox("stop")
end

function syncStart ( newSyncer )
    if tugX then
		setElementPosition(tug,tugX,tugY,tugZ)
		setElementVelocity(tug,tugVelX,tugVelY,tugVelZ)
	end
end

------------------
-- Goals
------------------
function greetPlayer ( )
	if (currentState == "Running") or (currentState == "GridCountdown") then
		textDisplayAddObserver ( redgoals, source )
		textDisplayAddObserver ( bluegoals, source )
	end
end
addEventHandler ( "onPlayerJoin", getRootElement(), greetPlayer )


function redMarkerHit(hitElement, matchingDimension) -- triggered when blue team scores
	if (hitElement == tug) then
		outputChatBox ("The " .. teamName2 .. " team scored! The ball will respawn at the center.",root,tr2,tg2,tb2)
		bluegoalcounter = bluegoalcounter + 1
		textItemSetText(bluegoalsText, teamName2 .. " Goals:    " .. bluegoalcounter)
		playSoundForEveryone(43)
		
		justScored = true
		if (isTimer(respawnTimer)) then
			killTimer(respawnTimer)
		end
		setTimer ( function()
			setElementPosition(tug, 546.9, -2258.05, 25)
			justScored = false
		end, 1000, 1)
	end
end
addEventHandler( "onMarkerHit", redMarker, redMarkerHit )

function blueMarkerHit( hitElement, matchingDimension ) -- triggered when red team scores
	if (hitElement == tug) then
	    outputChatBox ("The " .. teamName1 .. " team scored! The ball will respawn at the center.",root,tr1,tg1,tb1)
		redgoalcounter = redgoalcounter + 1
		textItemSetText(redgoalsText, teamName1 .. " Goals:   " .. redgoalcounter)
		playSoundForEveryone(44)
		
		justScored = true
		if (isTimer(respawnTimer)) then
			killTimer(respawnTimer)
		end
		setTimer ( function()
			setElementPosition(tug, 546.9, -2258.05, 25)
			justScored = false
		end, 1000, 1)
	end
end
addEventHandler( "onMarkerHit", blueMarker, blueMarkerHit )

function playSoundForEveryone(sound)
		for index, thePlayer in ipairs (getElementsByType("player")) do
			playSoundFrontEnd(thePlayer,sound)
		end	
end

---------------------------
-- Vehicle & Upgrades
---------------------------
function pilars(theVehicle) -- creats the pilars
	local x,y,z = getElementPosition(theVehicle)
	local currentObject3 = createObject(7923,x,y,z)
	local currentObject4 = createObject(7923,x,y,z)
	attachElements(currentObject3,theVehicle,0,0,0,0,0,180)
	attachElements(currentObject4,theVehicle,0,0,0)
end

function wall(thePlayer)
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
	local x,y,z = getElementPosition(theVehicle)
	local smallfence = createObject(970,x,y,z)
	attachElements(smallfence,theVehicle,0,3,0)
end

function ramps(theVehicle)
	local x,y,z = getElementPosition(theVehicle)
	local currentObject1 = createObject(13593,x,y+5,z)
	local currentObject2 = createObject(13593,x,y-5,z)
	attachElements(currentObject1,theVehicle,0,4.5,0,0,0,180)
	attachElements(currentObject2,theVehicle,0,-4.5,0)
end

function displayVehicleLoss(loss)
    fixVehicle(source)
end
addEventHandler("onVehicleDamage", getRootElement(), displayVehicleLoss)

--------------
-- Team Assignment
--------------
function paint ( thePlayer, seat, jacked ) -- assign players to a team (if they are not already) and paint their vehicle accordingly
	destroyAttachedElements(source) -- remove all attached objects from possible upgrades
	
	if not (getPlayerTeam(thePlayer)) then
		local x,y,z = getElementPosition(source)
		if (x < 546) then
			setPlayerTeam(thePlayer,blueTeam)
		else
			setPlayerTeam(thePlayer,redTeam)
		end 
	end
	local r,g,b = getTeamColor(getPlayerTeam(thePlayer))
	local playerTeam = getTeamName(getPlayerTeam(thePlayer))
	if (playerTeam == teamName1) then
		r2 = 0
		g2 = 0
		b2 = 0
	else
		r2 = 255
		g2 = 255
		b2 = 255
	end
	setVehicleColor(source,r,g,b,r2,g2,b2)
	wall(thePlayer)
end
addEventHandler ( "onVehicleEnter", getRootElement(), paint )

function vehicleChange(oldModel, newModel)
	if (getElementType(source)=="vehicle") then
		local thePlayer = getVehicleOccupant(source)
		if thePlayer then
			setTimer(function()
				local r,g,b = getTeamColor(getPlayerTeam(thePlayer))
				local playerTeam = getTeamName(getPlayerTeam(thePlayer))
				if (playerTeam == teamName1) then
					r2 = 0
					g2 = 0
					b2 = 0
				else
					r2 = 255
					g2 = 255
					b2 = 255
				end
				setVehicleColor(getPedOccupiedVehicle(thePlayer),r,g,b)
			end,200,1)
		end
	end
end
addEventHandler("onElementModelChange", root, vehicleChange) -- Bind the event to every element

----------------
-- Area Triggers
----------------
function leftArea(theVehicle)
	if (getElementType(theVehicle) == "vehicle") and (getVehicleOccupant(theVehicle)) then
		destroyAttachedElements(theVehicle)
		setElementData(getVehicleOccupant(theVehicle), "overrideCollide.uniqueblah", 0, false )
	end
	
	if (theVehicle == tug) then
		if not justScored then
			respawnTimer = setTimer ( function()
				playSoundForEveryone(45)
				setElementPosition(tug,  546.9, -2258.05, 25)
				outputChatBox("The ball has respawned at the center because it went out of bounds!",root,tr2,255,tb1)
			end, 3000, 1 )
		end
	end
	
end

function destroyAttachedElements(theVehicle)
	for key, theElement in ipairs (getAttachedElements(theVehicle)) do -- destroy the elements attached to the vehicle
			if (getElementType(theElement) == "object") then
				destroyElement(theElement)
			end
	end
end

function enteredArea(theVehicle)
	if (getElementType(theVehicle) == "vehicle") then
		local thePlayer = getVehicleOccupant(theVehicle)
		if thePlayer then
			setElementData( thePlayer, "overrideCollide.uniqueblah", nil, false )		
			local vehicleModel = getElementModel(theVehicle)
			setTimer(function()
				local r,g,b = getTeamColor(getPlayerTeam(thePlayer))
				local playerTeam = getTeamName(getPlayerTeam(thePlayer))
				if (playerTeam == teamName1) then
					r2 = 0
					g2 = 0
					b2 = 0
				else
					r2 = 255
					g2 = 255
					b2 = 255
				end
				setVehicleColor(theVehicle,r,g,b)
			end,200,1)
			if (vehicleModel == 496) then
				wall(getVehicleOccupant(theVehicle))
			end
			if (vehicleModel == 429) then
				ramps(theVehicle)
			end
			if (vehicleModel == 583) then
				pilars(theVehicle)
			end
		end
	end
end