-- Serverside Script
-- Author: Ali_Digitali
-- twitch.tv/AliDigitali
-- Anyone reading this has permission to copy parts of this script


-- Generate a string that is unique for this resource (the resource name) to be used as a data key.
uniqueKey = tostring(getResourceName(getThisResource()))
resourceRoot = getResourceRootElement(getThisResource())

-- Possible race states: undefined,NoMap,LoadingMap,PreGridCountdown,GridCountdown,Running,MidMapVote,SomeoneWon,TimesUp,EveryoneFinished,PostFinish,NextMapSelect,NextMapVote,ResourceStopping

--function to update the race states
function raceState(newstate,oldstate)
	currentState = newstate
	setElementData(resourceRoot,uniqueKey.."raceState",newstate)
	if (newstate == "LoadingMap") then
	
	end
	
	if (newstate == "GridCountdown") then
		
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
		answerCol = {}
		for i=1,4 do
			local x,y,z = getElementPosition(getElementByID("answer"..i))
			answerCol[i] = createColRectangle(x-20,y-23,40,46)
		end
		
		cover = createObject(8431,2065.1,-133.2,100)
		setElementCollisionsEnabled(cover,false)
		setObjectScale(cover,0.62)
		setElementDoubleSided(cover,true)
		
		
		poll = exports.votemanager:startPoll {
		   --start settings (dictionary part)
		   title="Choose Starting Difficulty:",
		   percentage=90,
		   timeout=5,

		   --start options (array part)
		   [1]={"Easy", uniqueKey..".vote",root, 5000,2},
		   [2]={"Medium",  uniqueKey..".vote",root, 4000,6},
		   [3]={"Difficult",  uniqueKey..".vote",root, 2000,10},
		   [4]={"OMGWTFBBQ",  uniqueKey..".vote",root, 500,10},
		}
		if not poll then
			voteResult(5000,2)
		end
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), raceState )

function voteResult(rt,size)
	startRound(rt,size,25000)
end
addEvent(uniqueKey..".vote",true)
addEventHandler(uniqueKey..".vote",root,voteResult)

spawnDirections = {}
spawnDirections[1] = {-1,0,0}
spawnDirections[2] = {0,1,0}
spawnDirections[3] = {1,0,0}
spawnDirections[4] = {0,-1,0}

spawnDirections[5] = {-1,0,0}
spawnDirections[6] = {0,1,0}
spawnDirections[7] = {1,0,0}
spawnDirections[8] = {0,-1,0}

function startRound(segmentLenght,roundSize,idleTime)
	-- segmentLenght = 5000
	-- roundSize = 2
	-- idleTime = 5000
	
	--clean up all the dumpers from the previous iteration
	for i,v in ipairs (getElementsByType("vehicle")) do
		if getElementModel(v) == 406 then
			local o = getVehicleOccupant(v)
			if o then
				if not getElementType(o)=="player" then
					destroyElement(v)
				end
			else
				destroyElement(v)
			end
		end
	end
	
	-- set everyones camera to look at the puzzle, camera functions at the bottom
	setAndRememberCam()
	
	-- reset the inside counter and move the cover down
	inside = 0
	moveObject(cover,segmentLenght/5,2065.1,-133.2,36.8)
	
	--create explosions when the cover lands
	setTimer(function()
		createExplosion (2083,-115,36.8,10)
		createExplosion (2051,-115,36.8,10)
		createExplosion (2051,-152,36.8,10)
		createExplosion (2083,-152,36.8,10)
	end,segmentLenght/5,1)
	
	--start the puzzle. Function puzzle will repeat roundSize times, total duration = roundSize*segmentLenght
	setTimer(puzzle,segmentLenght,roundSize,segmentLenght)
	
	--set timer for finish function to execute when the puzzle is done
	setTimer(finishPuzzle,segmentLenght*(roundSize)+6000,1,idleTime)
	
	--set timer to kill off players when time is up
	setTimer(finishAnswer,segmentLenght*(roundSize)+6000+idleTime,1)
	
	--start another round
	setTimer(function()
		if #getAlivePlayers() < 2 then
			setTimer(spawn,2000,0,1,406,1,true)
			setTimer(spawn,2000,0,2,406,1,true)
			setTimer(spawn,2000,0,3,406,1,true)
			setTimer(spawn,2000,0,4,406,1,true)
		else
			local newRoundsize = roundSize + 2
			local newSegmentLenght = segmentLenght - 500
			
			if newSegmentLenght < 600 then
				newSegmentLenght = 500
			end
			startRound(newSegmentLenght,newRoundsize,idleTime)
		end
	end,segmentLenght*(roundSize)+6000+idleTime+10000,1)
end

function puzzle(segmentLenght)
	-- vehicle enter
	local amountEnter = math.random(1,4)
	inside = inside+amountEnter
	--outputChatBox("entering: "..amountEnter.." total inside: "..inside)
	for i=1,amountEnter do
		spawn(i,406,1)
	end
	
	local amountExit = math.min(4,math.random(0,inside))
	
	setTimer(function()
		inside = inside-amountExit
		--outputChatBox("leaving: "..amountExit.." total inside: "..inside)
		for i = 1,amountExit do
			spawn(i+4,406,1)
		end
	end, segmentLenght/2,1)
end

local loads = {}
loads[0]={2,2976,6,{0,0,1},{0,-3,1}}
loads[1]={2,1550,6,{0,0,1},{0,-3,1}}
loads[2]={2,2918,1,{0,0,1.5},{0,-3,1}}
loads[3]={1,6865,1,{0,-1,1.5}}
loads[4]={1,3374,1,{0,-1,1.5}}
--create a vehicle at one of the 8 spawnpoints and launch it
function spawn(spawnPoint,vehicle,speed,special) 
	local spawnName
	if spawnPoint > 4 then
		spawnName = tostring("spawn5")
	else
		spawnName = tostring("spawn"..spawnPoint)
	end
	
	local x,y,z = getElementPosition(getElementByID(spawnName))
	local veh = createVehicle(vehicle,x,y,z+4,0,0,180-spawnPoint*90)
	
	local baggage = math.random(0,4)
	local n,id,scale = unpack(loads[baggage])
	for q=1,n do
		local o = createObject(id,x,y,z)
		setElementCollisionsEnabled(o,false)
		setObjectScale(o,scale)
		local offx,offy,offz = unpack(loads[baggage][q+3])
		attachElements(o,veh,offx,offy,offz)
		setTimer(destroyElement,2000,1,o)
	end
	setElementSyncer(veh,false)
	local velx,vely,velz = unpack(spawnDirections[spawnPoint])
	setElementVelocity(veh,velx*speed,vely*speed,velz*speed)
	if special then
		setElementData (veh, 'race.collideothers', 1 )
		setTimer(destroyElement,10000,1,veh)
	else
		setTimer(destroyElement,2000,1,veh)
	end
end

function finishPuzzle(idleTime)
	--reset cameras for all the players
	for index,thePlayer in ipairs (getElementsByType("player")) do
		setCameraTarget(thePlayer,cameraTarget[thePlayer])
		-- setElementFrozen(thePlayer,false)
	end

	--unfreeze all the players that are alive
	for index,alivePlayer in ipairs (getAlivePlayers()) do
		setElementFrozen(getPedOccupiedVehicle(alivePlayer),false)
	end
	
	
	outputDebugString("The correct dumper count is: "..inside)
	
	--pick a position for the correct answer and display it there
	correctAnswerPosition = math.random(1,4)
	createAnswer(correctAnswerPosition,inside)
	
	--create a wrong answer at the other positions
	for i=1,4 do
		if i ~= correctAnswerPosition then
			local a 
			repeat 
				if inside == 0 then
					a = math.random(1,10)
				else
					a = math.random(-inside,inside)
				end
			until a ~= 0
			createAnswer(i,inside+a)
		end
	end
	
	triggerClientEvent("showProgressBar",resourceRoot,idleTime)
end

function createAnswer(location,amount)
	local element = getElementByID("display"..location)
	local startx,starty,startz = getElementPosition(element)
	local _,_,rot = getElementRotation(element)
	rotr = math.rad(rot)
	local pyramidCounter = 0
	local x = 0
	while pyramidCounter < amount do
		for y = 0,x do
			
			local veh
			if location == 5 then
			veh = createVehicle(406,
				startx+math.cos(rotr)*(x*5.5-(y-1)*2.5),
				starty+math.sin(rotr)*(x*5.5-(y-1)*2.5),
				startz+4+y*4.8
				,0,0,rot+180)
			else
			veh = createVehicle(406,
				startx+math.cos(rotr)*(x*5.5-(y-1)*2.5-19),
				starty+math.sin(rotr)*(x*5.5-(y-1)*2.5-19),
				startz+4+y*4.8
				,0,0,rot+180)
			end
			setElementData (veh, 'race.collideothers', 1 )
			setElementFrozen(veh,true)
			pyramidCounter = pyramidCounter + 1
			if pyramidCounter >= amount then
				return
			end
		end
		x = x+1
	end
end

function finishAnswer()
	-- move the cover up
	moveObject(cover,10000,2065.1,-133.2,100)
	
	--display correct answer in chatbox
	outputChatBox("The correct answer is "..inside.."!",root,0,255,0)
	
	--create answer at center
	createAnswer(5,inside)
	
	
	for a=1,4 do
		if a ~= correctAnswerPosition then
			local el = getElementByID("answer"..a)
			--setElementAlpha(el,0)
			local x,y,z = getElementPosition(el)
					local dummy = createObject(4585,x,y,z)
			--moveObject(dummy,1000,x,y,z+10,0,0,45,"InBack",_,_,3)
			moveObject(dummy,1000,x,y,z+10,0,0,45,"SineCurve")
			setTimer(destroyElement,1200,1,dummy)
			
			for i,veh in ipairs (getElementsWithinColShape(answerCol[a],"vehicle")) do
				local x,y,z = getElementPosition(veh)
				setElementPosition(veh,x,y,z+1)
				setElementVelocity(veh,math.random(),math.random(),3)
				setTimer(blowVehicle,2000,1,veh)
			end
			
		end
	end
	
	--kill off all players who are at the wrong location
	setTimer(function()
		for i,p in ipairs (getAlivePlayers()) do
			local veh = getPedOccupiedVehicle(p)
			if veh then
				if not isElementWithinColShape(veh,answerCol[correctAnswerPosition]) then
					local x,y,z = getElementPosition(veh)
					if z < 60 then
						blowVehicle(veh)
					end
				end
			end
		end
	end,500,1)
end


-------------------
--	Camera Handling
-------------------

-- array to remember the camera target of all players
cameraTarget = {}

-- when a player enters the vehicle the camera will be set at the center
function enterVehicle ( thePlayer ) -- when a player enters a vehicle set his camera on the center
	if (currentState ~= "Running") then
		cameraTarget[thePlayer] = getCameraTarget(thePlayer)
		local x,y,z = getElementPosition(getElementByID("camera1"))
		local lookx,looky,lookz= getElementPosition(getElementByID("spawn5"))
		setCameraMatrix(thePlayer,x,y,z,lookx,looky,lookz)
	end
end
addEvent("fadeIn",true)
addEventHandler("fadeIn",root,enterVehicle)
addEventHandler ("onVehicleEnter", getRootElement(), enterVehicle ) -- add an event handler for onVehicleEnter

-- make players watch the center, save their cam target and freeze their vehicles
function setAndRememberCam()
	for index,thePlayer in ipairs (getElementsByType("player")) do 
		local veh = getPedOccupiedVehicle(thePlayer)
		if veh then
			setElementFrozen(veh,true)
		end
		cameraTarget[thePlayer] = getCameraTarget(thePlayer)
		local x,y,z = getElementPosition(getElementByID("camera1"))
		local lookx,looky,lookz= getElementPosition(getElementByID("spawn5"))
		setCameraMatrix(thePlayer,x,y,z,lookx,looky,lookz)
	end
end





