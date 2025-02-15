-- if anyone reads this, this script is horribly inefficient and bad, but it works so idc.

function ramp1()
start = getElementByID("b1")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b2")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

if (rota-rotx) > 180 then
d = -(360-rota-rotx)
else
d = rota-rotx
end

if (rotb-roty) > 180 then
e = -(360-rotb-roty)
else
e = rotb-roty
end

if (rotc-rotz) > 180 then
f = -(360-rotc-rotz)
else
f = rotc-rotz
end

scale = 30
for i=0,scale,1 do
local zoffset =(i*(c-z)/scale)/1
local xoffset =((scale-i)*(x-a)/scale)/1
local yoffset =(i*(b-y)/scale)/1

createObject(18450,a+xoffset,y+yoffset,z+zoffset,-30,0,rotz+i*f/scale)
end
end
ramp1()

function ramp2()
start = getElementByID("b3")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b5")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = 0
e = 0
f = -100

scale = 30
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,i*e/scale,rotz+i*f/scale)
			
	end
end
ramp2()

function ramp8()
start = getElementByID("b15")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b14")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = 30
e = 0
f = 0.75

scale = 50
	for i=0,scale-1,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,i*e/scale,rotz+i*f/scale)
			
	end
end
ramp8()


function ramp3()
start = getElementByID("w1")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("w3")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d=30
e=0
f=0

scale = 100

	for i=0,scale,1 do
	--outputChatBox("ok")
	local yoffset =(i*(b-y)/scale)
	local xoffset =(i*(a-x)/scale)
	createObject(8656,x+xoffset,y+yoffset,z,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
	end
end
--ramp3()

function ramp4()
start = getElementByID("b6")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b7")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = -30
e = 0
f = 0

scale = 50
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
			
	end
end
ramp4()

function ramp5()
start = getElementByID("b8")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b9")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = 0
e = 24
f = 0

scale = 20
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,i*e/scale,rotz+i*f/scale)
			
	end
end
ramp5()

function ramp6()
start = getElementByID("b10")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b11")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = 0--   -45
e = 0-- 10
f = -90

scale = 30
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1
if i < (scale/2) then
specialxrot = i*(-40)/((scale/2)-1)
else
specialxrot = -40+(i-15)*40/(scale/2)
end
			--createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
			createObject(18450,a+xoffset,y+yoffset,z+zoffset,specialxrot,roty+i*e/scale,rotz+i*f/scale)
	end
end
ramp6()

function ramp7()
start = getElementByID("b12")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b13")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = 0
e = 0
f = 0

scale = 5
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
			
	end
end
ramp7()

function ramp9()
start = getElementByID("b16")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b17")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = 45
e = 15
f = 80

scale = 30
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
			
	end
end
ramp9()

function ramp10()
start = getElementByID("b19")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b18")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = 0
e = 0
f = 90

scale = 30
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
			
	end
end
ramp10()

function ramp11()
start = getElementByID("b20")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b21")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = 0
e = 0
f = 90

scale = 30
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
			
	end
end
ramp11()

function ramp500()
start = getElementByID("b22")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b23")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = 0
e = 0
f = 80

scale = 30
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
			
	end
end
ramp500()

function ramp12()
start = getElementByID("b24")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b25")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = -45
e = 0
f = 10

scale = 30
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
			
	end
end
ramp12()

function ramp13()
start = getElementByID("b26")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b27")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = 0
e = 16
f = 0

scale = 10
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
			
	end
end
--ramp13()

function ramp14()
start = getElementByID("b67")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b68")
a,b,c = getElementPosition(stop)
rota,rotb,rotc = getElementRotation(stop)

d = 0--   -45
e = 0-- 10
f = -80

scale = 30
	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/1
		local xoffset =((scale-i)*(x-a)/scale)/1
		local yoffset =(i*(b-y)/scale)/1
if i < (scale/2) then
specialxrot = i*(-40)/((scale/2)-1)
else
specialxrot = -40+(i-15)*40/(scale/2)
end
			--createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
			createObject(18450,a+xoffset,y+yoffset,z+zoffset,specialxrot,roty+i*e/scale,rotz+i*f/scale)
	end
end
ramp14()

function looping()
start = getElementByID("b69")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

stop = getElementByID("b70")
a,b,c = getElementPosition(stop)

zcenter = z+40

scale = 200
scaleincrement = 360/scale
	for i=0,scale,1 do
		local zoffset = - math.cos(math.rad(i*scaleincrement))*40
		local yoffset = math.sin(math.rad(i*scaleincrement))*40
		local xoffset = i*scaleincrement*(a-x)/360

		createObject(18450,x+xoffset,y+yoffset,zcenter+zoffset,rotx,i*scaleincrement,rotz)
			
	end
end
looping()

function looping2()
start = getElementByID("b73")
x,y,z = getElementPosition(start)
rotx,roty,rotz = getElementRotation(start)

-- stop = getElementByID("b70")
-- a,b,c = getElementPosition(stop)

xcenter = x-125

scale = 100
scaleincrement = 180/scale
	for i=0,scale,1 do
		local xoffset = math.cos(math.rad(i*scaleincrement))*125
		local yoffset = math.sin(math.rad(i*scaleincrement))*125

		createObject(18450,xcenter+xoffset,y+yoffset,z,rotx,roty,rotz+i*scaleincrement)
			
	end
end
looping2()

function generalramps(startitem,stopitem,d,e,f,scale,draw)
	start = getElementByID(startitem)
	x,y,z = getElementPosition(start)
	rotx,roty,rotz = getElementRotation(start)

	stop = getElementByID(stopitem)
	a,b,c = getElementPosition(stop)
	rota,rotb,rotc = getElementRotation(stop)

	for i=0,scale,1 do
		local zoffset =(i*(c-z)/scale)/draw
		local xoffset =((scale-i)*(x-a)/scale)/draw
		local yoffset =(i*(b-y)/scale)/draw

			createObject(18450,a+xoffset,y+yoffset,z+zoffset,rotx+i*d/scale,roty+i*e/scale,rotz+i*f/scale)
			
	end
end
generalramps("b28","b29",0,0,-77,30,1)
generalramps("b31","b30",-45,0,0,30,1)
generalramps("b33","b34",0,0,-90,30,1)
generalramps("b35","b36",0,0,-90,30,1)
generalramps("b37","b38",45,0,3,100,1)
generalramps("b39","b40",30,0,2.5,20,1)
generalramps("b41","b42",0,0,87.5,20,1)
generalramps("b43","b44",-60,0,-5,60,1)
generalramps("b45","b46",0,0,-85,60,1)
generalramps("b47","b48",0,5,-20,20,1)
generalramps("b49","b50",0,-15,-50,20,1)
generalramps("b51","b52",0,10,-10,20,1)
generalramps("b53","b54",0,0,-30,10,1)
generalramps("b55","b56",60,5,0,60,1)
generalramps("b57","b58",0,0,90,30,1)
generalramps("b59","b60",-30,0,0,30,1)
generalramps("b61","b62",30,0,0,50,1)
generalramps("b63","b64",0,0,100,30,1)
generalramps("b65","b66",-30,0,0,30,1)
generalramps("b71","b72",30,0,0,30,1)
generalramps("b74","b75",0,10,85,30,1)
generalramps("b76","b77",-30,0,5,30,1)
generalramps("b78","b79",0,-10,95,30,1)
generalramps("b80","b81",30,0,0,30,1)
generalramps("b82","b83",-30,0,-5,30,1)
generalramps("b84","b85",0,10,0,10,1)
generalramps("b86","b87",0,10,0,30,1)


playercheckpoint = {}
function checkpointcounter(checkpoint,time_)
	playercheckpoint[source] = checkpoint
	if (checkpoint == 39) then
		local x,y,z = getElementVelocity(getPedOccupiedVehicle(source))
		setElementVelocity(getPedOccupiedVehicle(source),0,2.2,0.8)
		
		if (playerspawn[source] == 0) and (playerreverse[source] == nil) then
			outputChatBox("You managed to finish the race without respawning!",source,0,255,0)
			outputChatBox("Cheat code unlocked: Next time you play you can use /reverse to try the track in reverse!",source,0,255,0)
		end
	end

	if (checkpoint == 1) then
		if (playerreverse[source] == true) then
			-- anti cheat check
			if (check1_players[source] == nil) or (check2_players[source] == nil) or (check3_players[source] == nil) then
				outputChatBox(getPlayerName(source) .. " #ff0000got caught cheating by skipping part of the track in reverse!",root,255,255,255, true)
			else
				triggerClientEvent (source, "coastFinish", source)
			end
		end
	end

end
addEvent("onPlayerReachCheckpoint")
addEventHandler("onPlayerReachCheckpoint",root,checkpointcounter)


check1_players = {}
check1 = createColSphere ( 1311.52, -1262.2, 155.46, 15 )
addEventHandler ( "onColShapeHit", check1, function(hitElement, dim)
	check1_players[hitElement] = true
end )


check2_players = {}
check2 = createColSphere ( 758.32,  -2307.66, 12.62, 15 )
addEventHandler ( "onColShapeHit", check2, function(hitElement, dim)
	check2_players[hitElement] = true
end )

check3_players = {}
check3 = createColSphere ( 1445.96, 1410.34, 19.86, 15 )
addEventHandler ( "onColShapeHit", check3, function(hitElement, dim)
	check3_players[hitElement] = true
end )


playerreverse = {}
usedCommand = {}
function reversetrack ( playerSource )
	if (usedCommand[playerSource] == nil) then
		usedCommand[playerSource] = true
	else
		outputChatBox("You can only try the track in reverse once per game!", playerSource)
		return
	end
	
	if (getPedOccupiedVehicle(playerSource)) then
		if  (playercheckpoint[playerSource] == nil) then
			setElementPosition(getPedOccupiedVehicle(playerSource),1761.6,2318,63)
			playerreverse[playerSource] = true
		else
			outputChatBox("You cannot try the track in reverse after going through the first checkpoint.",playerSource)
		end
	end
end
addCommandHandler ( "reverse", reversetrack )

playerspawn = {}
function player_Spawn ( posX, posY, posZ, spawnRotation, theTeam, theSkin, theInterior, theDimension )
	if (playerspawn[source] == nil) then
		playerspawn[source] = 0
	else
		playerspawn[source] = playerspawn[source] + 1
	end
	
	if (playerreverse[source] == true) then
		outputChatBox(getPlayerName(source) .. " #ff0000tried to race the track in reverse and failed miserably.",root,255,255,255, true)
		playerreverse[source] = false
	end
end
addEventHandler ( "onPlayerSpawn", getRootElement(), player_Spawn )