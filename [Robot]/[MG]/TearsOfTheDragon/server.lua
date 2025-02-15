-- Serverside Script
-- Author: Ali_Digitali
-- twitch.tv/AliDigitali
-- Anyone reading this has permission to copy parts of this script


-- Generate a string that is unique for this resource (the resource name) to be used as a data key.
uniqueKey = tostring(getResourceName(getThisResource()))
resourceRoot = getResourceRootElement(getThisResource())

moveTime = 800
pathLenght = 10
tileUptime = moveTime
startx,starty,startz = -250,-550,160


-- Possible race states: undefined,NoMap,LoadingMap,PreGridCountdown,GridCountdown,Running,MidMapVote,SomeoneWon,TimesUp,EveryoneFinished,PostFinish,NextMapSelect,NextMapVote,ResourceStopping

--function to update the race states
function raceState(newstate,oldstate)
	setElementData(resourceRoot,uniqueKey.."raceState",newstate)
	if (newstate == "LoadingMap") then
		fountain = createObject(3515,startx,starty,startz)
		object = createObject(3095,startx,starty,startz)
		dragon = createObject(3528,startx,starty,startz)
		attachElements(dragon,object,0,0,3.2,0,0,90)
		attachElements(fountain,object)
		tileCounter = 0
		g_x = 0
		g_y = 0
		oldx,oldy = g_x,g_y
		
		startPath = {}
		for i=pathLenght,1,-1 do
			startPath[i]=createObject(3095,startx,starty-i*9,startz)
		end
	end
	
	if (newstate == "GridCountdown") then
		outputChatBox("Stay on the path as long as you can!",root,0,255,0)
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
		for key, value in ipairs(getAlivePlayers()) do
			setVehicleDamageProof(getPedOccupiedVehicle(value), true)
		end
		setTimer(snake,2000,1)
		setTimer(killPlayers,1000,0)
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), raceState )

function killPlayers()
	for i,p in ipairs (getElementsByType("player")) do
		local x,y,z = getElementPosition(p)
		if z < 155 then
			--setPedOnFire(p,true)
			killPed(p)
		end
	end
end

function wasted()
	local time = exports.race:getTimePassed()
	local time = math.floor(time/1000) * 60 * 1000
	triggerEvent('onPlayerFinish', source, 0 ,  - time)	--post negative time to have the highest on top

end
addEvent("onPlayerRaceWasted")
addEventHandler("onPlayerRaceWasted",root,wasted)


snakeTiles = {}
function snake()
	tileCounter = tileCounter + 1
	
	if startPath[pathLenght-tileCounter+1] then
		moveObject(startPath[pathLenght-tileCounter+1],moveTime,startx,starty-(pathLenght-tileCounter)*9,startz)
		setTimer(destroyElement,moveTime,1,startPath[pathLenght-tileCounter+1])
	end
	
	local x,y,z = startx+g_x*9,starty+g_y*9,startz
	snakeTiles[tileCounter] = {g_x,g_y}
	
	local placeholder = createObject(3095,x,y,z)

	
	local neon = createObject(9126,x,y,z-1.15)
	setObjectScale(neon,0.5)
	setElementRotation(neon,90,0,0)
	
	local dynamite = createObject(1654,x,y,z+0.8)
	setElementCollisionsEnabled(dynamite,false)
	
	setTimer(destroyEndSnake,pathLenght*tileUptime,1,placeholder,dynamite,tileCounter)
	
	--before
	skip1x,skip1y = g_x,g_y
	
	local tempx,tempy
	local attachOffset
	repeat 
		tempx,tempy=g_x,g_y
		if math.random() < 0.25 then
			tempx=g_x-1
			--outputChatBox("attempt left")
			attachOffset = 180
		elseif math.random() < 0.25 then
			tempx=g_x+1
			attachOffset=0
			--outputChatBox("attempt right")
		else
			tempy=g_y+1
			attachOffset=90
			--outputChatBox("attempt up")
		end
	until (tempx~=oldx) or (tempy~=oldy)
	setElementAttachedOffsets(dragon,0,0,3.2,0,0,attachOffset)
	
	--outputChatBox("end")
	oldx,oldy = skip1x,skip1y
	--new
	g_x,g_y = tempx,tempy
	
	--outputChatBox("moving to: "..g_x.."  "..g_y)
	moveObject(object,moveTime,startx+g_x*9,starty+g_y*9,startz)
	
	
	difficulty()
	
	-- if tileCounter == 350 then
	-- 	local trigger =  createColSphere (startx+g_x*9,starty+g_y*9,startz,5 )
	-- 	addEventHandler ( "onColShapeHit", trigger, teleportPlayerToFinish )
	-- end
	setTimer(snake,moveTime,1)
end

function destroyEndSnake(tile,dynamite,tileCounter)
	if snakeTiles[tileCounter+1] then
		local x,y = unpack(snakeTiles[tileCounter+1])
		moveObject(tile,moveTime,startx+x*9,starty+y*9,startz)
		setTimer(destroyElement,moveTime,1,tile)
		
		if snakeTiles[tileCounter] then
			local a,b = unpack(snakeTiles[tileCounter])
			createExplosion(startx+a*9,starty+b*9,startz+0.8,1)
			destroyElement(dynamite)
		end
	end
end

function difficulty()
	--outputChatBox(tileCounter)
	
	if tileCounter == 10 then
		moveTime = 500
		tileUptime = 500
	end
	
	if tileCounter == 30 then
		moveTime = 400
		tileUptime = 400
	end
	
	if tileCounter == 50 then
		moveTime = 300
		tileUptime = 300
	end
	
	if tileCounter == 100 then
		moveTime = 250
		tileUptime = 250
	end
	
	if tileCounter == 200 then
		moveTime = 200
		tileUptime = 200
	end
	
	if tileCounter == 300 then
		moveTime = 150
		tileUptime = 150
	end
end

-- function teleportPlayerToFinish(hitElement,dimension)
-- 	if getElementType(hitElement) == "vehicle" then
-- 		setElementVelocity(hitElement,0,0,0)
-- 		setElementPosition(hitElement,2013.5,1073.3,100)
-- 	end
-- end
