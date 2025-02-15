-- Disco Derby script by Ali Digitali --
-- Feel free to copy this script, as long as you don't claim it as your own --

-- script is server side --

-- this script will assign a random vehicle to every player with a random interval of 15-35 seconds, 
--the distributions is as follows:
--25 30 35
--20 25 30
--15 20 25

function start(newstate,oldstate) --function to update the race states
	
	if (newstate == "LoadingMap") then
		setSkyGradient(0,255,0,30, 100, 196)
	end
	
	
	if (newstate == "GridCountdown") then
		outputChatBox("#00ff00When your vehicle turns #ff0000red#00ff00, prepare for a random vehicle!", getRootElement(), 231, 217, 0, true)
		for i,v in ipairs (getElementsByType("vehicle")) do
			setVehicleColor(v, 0, 204, 0, 0, 204, 0, 0, 204, 0, 0, 204, 0)
		end
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
		setTimer(spawnRandomVehicle,5000,1)
		setTimer(spawnRandomVehicle, 25000,0)
		setTimer(cycleSky,7000,0)
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )



-- When the player enters the vehicle at the start of the game it is painted green --
markers = {}
function vehicleEnter ( theVehicle, seat, jacked )
	setVehicleColor(theVehicle, 0, 204, 0, 0, 204, 0, 0, 204, 0, 0, 204, 0)
	local myMarker = createMarker(0,0,0,"arrow",1,0,255,0)
	markers[theVehicle]= myMarker
	attachElements(myMarker,theVehicle,0,0,2.5)
	
	addNeon(theVehicle,true)
	setNeonColor(theVehicle,0,255,0)
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(),vehicleEnter)

function addNeon(theVehicle)
	local x,y,z = getElementPosition(theVehicle)
	
	local marker1 = createMarker(x,y,z,"corona",2,0,255,0)
	setTimer(attachElements,200,1,marker1,theVehicle,0,-1,-1.2)
	
	local marker2 = createMarker(x,y,z,"corona",2,0,255,0)
	setTimer(attachElements,200,1,marker2,theVehicle,0,1,-1.2)
	
	local neon1 = createObject(1578,x,y,z,0,0,0,true)
	attachElements(neon1,theVehicle,-0.9,0,-0.6)
	
	local neon2 = createObject(1578,x,y,z,0,0,0,true)
	attachElements(neon2,theVehicle,0.9,0,-0.6)
	
	local neon3 = createObject(1578,x,y,z,0,0,0,true)
	attachElements(neon3,theVehicle,0,2,-0.55,0,0,90)
	
	local neon4 = createObject(1578,x,y,z,0,0,0,true)
	attachElements(neon4,theVehicle,0,-2,-0.55,0,0,90)
end

neons = {[1576]=true,[1577]=true,[1578]=true,[1580]=true}

function setNeonColor(theVehicle,r,g,b)
	local neonObject
	
	if (r == 255) and (g == 255) then
		neonObject = 1577
	elseif (r==255) then
		neonObject = 1580
	elseif (g == 255) then
		neonObject = 1578
	end
	
	for index,theObject in ipairs (getAttachedElements(theVehicle)) do
		if getElementType(theObject) == "marker" then
			if getMarkerType(theObject) == "corona" then
				setMarkerColor(theObject,r,g,b,255)
			end
		end
		
		if neons[getElementModel(theObject)] then
			setElementModel(theObject,neonObject)
		end
	end
end



vehicles = { 602, 545, 496, 517, 401, 410, 518, 600, 527, 436, 589, 580, 419, 439, 533, 549, 526, 491, 474, 445, 467, 604, 426, 507, 547, 585,
405, 587, 409, 466, 550, 492, 566, 546, 540, 551, 421, 516, 529, 592, 553, 577, 488, 511, 497, 548, 563, 512, 476, 593, 447, 425, 519, 520, 460,
417, 469, 487, 513, 581, 510, 509, 522, 481, 461, 462, 448, 521, 468, 463, 586, 485, 552, 431, 
438, 437, 574, 420, 525, 408, 416, 596, 433, 597, 427, 599, 490, 432, 528, 601, 407, 428, 544, 523, 470, 598, 499, 588, 609, 403, 498, 514, 524, 
423, 532, 414, 578, 443, 486, 515, 406, 531, 573, 456, 455, 459, 543, 422, 583, 482, 478, 605, 554, 530, 418, 572, 582, 413, 440, 536, 575, 534, 
567, 535, 576, 412, 402, 542, 603, 475, 441, 464, 501, 465, 564, 568, 557, 424, 471, 504, 495, 457, 539, 483, 508, 571, 500, 
444, 556, 429, 411, 541, 559, 415, 561, 480, 560, 562, 506, 565, 451, 434, 558, 494, 555, 502, 477, 503, 579, 400, 404, 489, 505, 479, 442, 458, 
606, 594 }
			
			
			
-- all the random extra delays you can get --
extratimes = {5000,10000,15000}
discoblips = {}


-- function to spawn a random vehicle for all players and paint it completely green. If the player gets a bus (431) they will enter party mode --		  
function spawnRandomVehicle( )
	local alivePlayers = getAlivePlayers()
	local discoPlayer
	if #alivePlayers > 1 then
		discoPlayer = (alivePlayers[math.random(#alivePlayers)])--((1/math.exp((#getAlivePlayers()/5)-6))/2000)+0.05
	else
		discoPlayer = false
	end
	for index, playerid in ipairs(alivePlayers)do
		local theVehicle =  getPedOccupiedVehicle(playerid)
		local time1 = (extratimes[math.random(#extratimes)]) --gets extra time randomly on top of counter at end of script--
		local time2 = time1-4000 --timer duration to paint orange--
		local time3 = time1-2000 --timer duration to paint red--
		
		-- timer to paint the car orange after time 2 --	
		setTimer ( function()
				setVehicleColor(theVehicle, 255, 154, 0, 255, 154, 0, 255, 154, 0, 255, 154, 0 )			
				setMarkerColor(markers[theVehicle],255, 154, 0,255)
				setNeonColor(theVehicle,255,255,0)
			end, time2, 1 )
		
		-- timer to paint the car red after time 3--	
		setTimer ( function()
				setVehicleColor(theVehicle, 255, 0, 0, 255, 0, 0,  255, 0, 0,  255, 0, 0 )
				setMarkerColor(markers[theVehicle],255, 0, 0,255)
				setNeonColor(theVehicle,255,0,0)
			end, time3, 1 )
		
		setTimer ( function()
			local newcar = (vehicles[math.random(#vehicles)]) -- generates a random car from entered ID's
			local x, y, z = getElementPosition(theVehicle) --gets location of player--
				-- anti-submarine strats
				if z < 10 then
					blowVehicle(theVehicle)
				elseif z<1000 then
					setElementModel(theVehicle,newcar) -- sets the player car to the random generated vehicle --
					setElementPosition(theVehicle, x, y, z + 0.5) -- sets new player location 4and small boost in case someone gets stuck--
					local health = getElementHealth(theVehicle)
					if health < 1000 then
						setElementHealth(theVehicle,health+200)
					end
				end
				
				setMarkerColor(markers[theVehicle],0,204,0,255)
				if playerid == discoPlayer then--math.random() < discoChance then
					setElementData(theVehicle,"disco",true,true)
					setVehicleDamageProof(theVehicle,true)	-- if the player gets the bus, they cannot be harmed						
					discoblips[theVehicle] = createBlipAttachedTo(theVehicle,0,2,255,255,0)				
					discoColors(theVehicle)
				else
					setElementData(theVehicle,"disco",false,true)
					setVehicleDamageProof(theVehicle,false) 
					setVehicleColor(theVehicle, 0, 204, 0, 0, 204, 0, 0, 204, 0, 0, 204, 0) -- paints it green --
					setNeonColor(theVehicle,0,255,0)
				end		
				
		end, time1, 1 )
		
		
	end
end
--timer to start it off and to keep repeating the vehicle swaps by looping function spawnRandomVehicle infinitely after set delay --

function changeVehColors(theVehicle,r1,g1,b1,r2,g2,b2)
	if theVehicle then
		setVehicleColor(theVehicle,r1,g1,b1,r2,g2,b2)     -- yellow		
		setNeonColor(theVehicle,r1,g1,b1)
		if discoblips[theVehicle] then
			setBlipColor(discoblips[theVehicle], r1,g1,b1,255)
		end
	end
end




function discoColors(theVehicle)
	changeVehColors(theVehicle,255,255,0,0,255,255)     -- yellow		

	setTimer ( function()
		changeVehColors(theVehicle,0,255,255,0,255,0) -- cyan
	end, 200, 1 )

	setTimer ( function()
		changeVehColors(theVehicle,0,255,0,255,0,255)	   -- lime
	end, 400, 1 )

	setTimer ( function()
		changeVehColors(theVehicle,255,0,255,255,255,0) -- magenta
	end, 600, 1 )

	setTimer ( function()
		if getElementData(theVehicle,"disco") == true and getVehicleOccupant(theVehicle) then
		discoColors(theVehicle)
		else
		setVehicleColor(theVehicle, 0, 204, 0, 0, 204, 0, 0, 204, 0, 0, 204, 0) -- paints it green --
		setMarkerColor(markers[theVehicle],0, 255, 0,255)
		setNeonColor(theVehicle,0,255,0)
		destroyElement(discoblips[theVehicle])
		end
	end, 800, 1 )
end


----------
-- SKY
----------
function getRandomBrightColor()
	local r,g,b
	
	r = math.random(0,1)*255
	g = math.random(0,1)*255
	
	if (r == 255) and (g == 255) then
		b = 0
	elseif (r==0) and (g == 0) then
		b = 255
	else
		b = math.random(0,1)*255
	end
	return r,g,b
end

g_red = 0
g_green = 255
g_blue = 0

function cycleSky()
	local red,green,blue 
	repeat 
		red,green,blue = getRandomBrightColor()
	until (red ~= g_red) or (blue ~= g_blue) or (green ~= g_green)
	
	--outputChatBox("brightColor = " .. red .. "  " .. green .. "   " .. blue)
	
	local directionRed = ((red-g_red)/255)
	local directionGreen = (green-g_green)/255
	local directionBlue = (blue-g_blue)/255
	
	--outputChatBox(directionRed)
	
	setTimer(function()
		g_red = g_red + directionRed*5
		g_green = g_green + directionGreen*5
		g_blue = g_blue + directionBlue*5
	
		setSkyGradient(g_red,g_green,g_blue,30, 100, 196)
	end,100,51)
end

function blowHandler (vehicle)
	if vehicle then
		blowVehicle(vehicle)
	end
end
addEvent("triggerBlow",true)
addEventHandler("triggerBlow",root,blowHandler)


