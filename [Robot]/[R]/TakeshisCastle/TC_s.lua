
------------------
-- Main
--------------------
function start(newstate,oldstate) --function to update the race states
	if (newstate == "GridCountdown") then --when the race countdown starts, load all the obstacles
		knock()
		loadTiles()
		createMovingObjects()
		avalanche()
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )

function randomSkin ( thePlayer, seat, jacked )
    setElementModel(thePlayer,math.random(1,312))
end
addEventHandler ( "onVehicleEnter", getRootElement(), randomSkin )

-----
-- Obstacle 1: Knock Knock
-----
function knock()
	local easy = true --one gate is blocked
	if (#getElementsByType("player") > 7) then --if there are more than 7 players 3 gates will be blocked
		easy = false
	end
	for i=1,3 do --create all the gates, load them into an array and send them to the client
		local gates = {}
		for j=1,4 do
			local gate = getElementByID("gate"..tostring(i).."-"..tostring(j))
			if gate then
				gates[j]={}
				local x,y,z = getElementPosition(gate)
				gates[j][1] = createObject(1447,x+0.1,y-2.7,z-21.7,0,0,90)
				gates[j][2] = createObject(1447,x+0.1,y+2.7,z-21.7,0,0,90)
			end
		end
		local stop = math.random(1,4)
		triggerClientEvent("setUnbreakable",getResourceRootElement(),gates,easy,stop)
	end
end

------------------------
-- Obstacle 2: fallthrough tiles
------------------------
function loadTiles()
	local path = {{},{},{},{},{}} -- array containing the correct path
	--starting point of the first tile
	local a=1
	local b=3 
	path[a][b] = true -- if a tile is set to true it will have collisions enabled
	
	repeat --create a pattern that will reach the end
		local c=a
		local d=b
		repeat
			if (math.random()<0.5) then -- 25% to go right or left, 50% to go up
				if b==5 then --go left when near the edge
					d=b-1
				elseif b==1 then --go right when near the edge
					d=b+1
				else-- go left or right when not near an edge
					d = b+math.random(0,1)*2-1 -- b=b+1 or b=b-1
				end
			else
				c = a+1
			end
		until not path[c][d] --prevent going back to the previous square
		a,b=c,d -- remember the new found values of a and b
		path[a][b]= true
	until (a >= 5)
	
	-- create the physical tiles
	-- x direction = +9
	-- y direction = -9
	tiles = {{},{},{},{},{}}
	local x,y,z = 625,-2082,146.1 --starting position of (1,1)
	for i=1,5 do
		for j=1,5 do
			local x,y,z = x+(i-1)*9,y-(j-1)*9,z
			tiles[i][j]= createObject(3095,x,y,z) --create tiles & neon squares
			local neon = createObject(9126,x,y,z-1.15,90,0,0)
			setObjectScale(neon,0.5)
			
			if not path[i][j] then
				setElementCollisionsEnabled(tiles[i][j],false) --disable collisions on tiles that are not on the correct path
			end
		end
	end
	triggerClientEvent("drawTiles",getResourceRootElement(),path,tiles) --send the path and the tiles to clientside
	
	-- -- Uncomment to output the correct path to the chatbox
	-- for i=5,1,-1 do
		-- for j=1,5 do
			-- if not path[i][j] then
				-- path[i][j]=0
			-- else
				-- path[i][j]=1
			-- end
		-- end
		-- outputChatBox(path[i][1]..path[i][2]..path[i][3]..path[i][4]..path[i][5])-- show the path in the chatbox for debugging
	-- end
end

----------------
--Obstacle 3: Indestructaball
-----------------
function createMovingObjects()
	for i=1,4 do
		local wall = getElementByID("wall"..tostring(i)) -- get the object as defined in .map
		if wall then
			setElementAlpha(wall,0)
			local x,y,z = getElementPosition(wall)
			local wallA= createObject(8656,x,y,z)
			local wallB= createObject(8656,x,y,z)
			attachElements(wallB,wallA,0,0,0,0,180,0)
			moveObject(wallA,10000, x,y,z, 0, -360, 0)
			setTimer(moveObject,10000,0,wallA,10000, x,y,z, 0, -360, 0)
		end
	end

	for i=1,3 do
		local wall = getElementByID("rot"..tostring(i))
		if wall then
			setElementAlpha(wall,0)
			local x,y,z = getElementPosition(wall)
			local wallA= createObject(8656,x,y,z)
			moveObject(wallA,10000, x,y,z, 0, 0, 360)
			setTimer(moveObject,10000,0,wallA,10000, x,y,z, 0, 0, 360)
		end
	end
end

----------------
--Obstacle 4: Avalanche
----------------
function avalanche()
	local position = tostring(math.random(1,2))
	local x,y,z = getElementPosition(getElementByID("boulder"..position)) -- get the position of either boulder1 or boulder2
	local boulder = createObject(1305,x,y,z)-- create a dynamic quarry rock at that location
	
	setTimer(createExplosion,1000,1,x+1,y,z,3) -- make the rock dynamic with an explosion (also looks nice!)
	setTimer(destroyElement,40000,1,boulder) --destroy the rock after 40 seconds
	setTimer(avalanche,5000,1) --do this function again after 5 seconds
end


--------------
-- Castle Jump
--------------
function checkpointcounter(checkpoint,time_)
	if (checkpoint == 21) then
		setElementVelocity(getPedOccupiedVehicle(source),0,1.7,1.2)
	end
end
addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint",root,checkpointcounter)



