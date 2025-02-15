-- Disco Drive script by Ali Digitali --
-- Feel free to copy this script, as long as you don't claim it as your own --

-- script is server side --


function start(newstate,oldstate) --function to update the race states
	
	if (newstate == "LoadingMap") then
		setTrafficLightsLocked(true)
		setTrafficLightState(2)
	end
	
	
	
	
	if (newstate == "GridCountdown") then

		-- setTimer(function()
		-- 	for index, playerid in ipairs(getAlivePlayers())do
		-- 		local theVehicle =  getPedOccupiedVehicle(playerid)
		-- 		if theVehicle then
		-- 				setVehicleColor(theVehicle, 255, 154, 0, 255, 154, 0, 255, 154, 0, 255, 154, 0 )			
		-- 				setNeonColor(theVehicle,255,255,0)
		-- 		end
		-- 	end
		-- end,3000,1)
		setTimer(function()
			for index, playerid in ipairs(getAlivePlayers())do
				local theVehicle =  getPedOccupiedVehicle(playerid)
				if theVehicle then
						--setVehicleColor(theVehicle, 255, 0, 0, 255, 0, 0, 255,0, 0, 255, 0, 0 )			
						--setNeonColor(theVehicle,255,0,0)
						setVehicleColor(theVehicle, 255, 154, 0, 255, 154, 0, 255, 154, 0, 255, 154, 0 )			
						setNeonColor(theVehicle,255,255,0)

				end
			end
		end,4000,1)
		setTimer(function()
			setTrafficLightState(6)
			-- for index, playerid in ipairs(getAlivePlayers())do
			-- 	local theVehicle =  getPedOccupiedVehicle(playerid)
			-- 	if theVehicle then
			-- 			setVehicleColor(theVehicle, 255, 154, 0, 255, 154, 0, 255, 154, 0, 255, 154, 0 )			
			-- 			setNeonColor(theVehicle,255,255,0)
			-- 	end
			-- end
		end,5000,1)
		setTimer(function()
			setTrafficLightState(5)
			for index, playerid in ipairs(getAlivePlayers())do
				local theVehicle =  getPedOccupiedVehicle(playerid)
				if theVehicle then
						setVehicleColor(theVehicle, 0, 204, 0, 0, 204, 0, 0, 204, 0, 0, 204, 0)	
						setNeonColor(theVehicle,0,255,0)
				end
			end
		end,6000,1)
	end

	if (newstate == "Running" and oldstate == "GridCountdown") then
		setTimer(spawnRandomVehicle,8000,0)
	end
end
addEvent ( "onRaceStateChanging", true )
addEventHandler ( "onRaceStateChanging", getRootElement(), start )



-- When the player enters the vehicle at the start of the game it is painted green --
function vehicleEnter ( theVehicle, seat, jacked )
	setVehicleColor(theVehicle, 255, 0, 0, 255, 0, 0, 255,0, 0, 255, 0, 0)
	addNeon(theVehicle,true)
	setNeonColor(theVehicle,255,0,0)
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(),vehicleEnter)

function addNeon(theVehicle)
	local attachedElements = getAttachedElements ( theVehicle)
	if #attachedElements > 0 then
		return
	end
	
	local x,y,z = getElementPosition(theVehicle)
	
	local marker1 = createMarker(x,y,z,"corona",2,255,0,0)
	setTimer(attachElements,200,1,marker1,theVehicle,0,-1,-1.2)
	
	local marker2 = createMarker(x,y,z,"corona",2,255,0,0)
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
405, 587, 409, 466, 550, 492, 566, 546, 540, 551, 421, 516, 529, 512, 476, 593,
513, 581, 510, 509, 522, 481, 461, 462, 448, 521, 468, 463, 586, 485, 552, 431, 
438, 437, 574, 420, 525, 408, 416, 596, 433, 597, 427, 599, 490, 432, 528, 601, 407, 428, 544, 523, 470, 598, 499, 588, 609, 403, 498, 514, 524, 
423, 532, 414, 578, 443, 486, 515, 406, 531, 573, 456, 455, 459, 543, 422, 583, 482, 478, 605, 554, 530, 418, 572, 582, 413, 440, 536, 575, 534, 
567, 535, 576, 412, 402, 542, 603, 475, 441, 464, 501, 465, 564, 568, 557, 424, 471, 504, 495, 457, 539, 483, 508, 571, 500, 
444, 556, 429, 411, 541, 559, 415, 561, 480, 560, 562, 506, 565, 451, 434, 558, 494, 555, 502, 477, 503, 579, 400, 404, 489, 505, 479, 442, 458, 
606, 594 }
			
			
			
-- all the random extra delays you can get --
extratimes = {3000,5000,7000}
discoblips = {}


-- function to spawn a random vehicle for all players and paint it completely green.	  
function spawnRandomVehicle( )
	discoChance = 0.01
	for index, playerid in ipairs(getAlivePlayers())do
		local theVehicle =  getPedOccupiedVehicle(playerid)
		local time1 = (extratimes[math.random(#extratimes)]) --gets extra time randomly on top of counter at end of script--
		local time2 = time1-2000 --timer duration to paint orange--
		local time3 = time1-1000 --timer duration to paint red--
		
		-- timer to paint the car orange after time 2 --	
		setTimer ( function()
				if theVehicle then
					setVehicleColor(theVehicle, 255, 154, 0, 255, 154, 0, 255, 154, 0, 255, 154, 0 )			
					setNeonColor(theVehicle,255,255,0)
				end
			end, time2, 1 )
		
		-- timer to paint the car red after time 3--	
		setTimer ( function()
				if theVehicle then
					setVehicleColor(theVehicle, 255, 0, 0, 255, 0, 0,  255, 0, 0,  255, 0, 0 )
					setNeonColor(theVehicle,255,0,0)
				end
			end, time3, 1 )
		
		setTimer ( function()
			if theVehicle then
				local newcar = (vehicles[math.random(#vehicles)]) -- generates a random car from entered ID's
				local x, y, z = getElementPosition(theVehicle) --gets location of player--
					-- anti-submarine strats
					if z<1000 then
						setElementModel(theVehicle,newcar) -- sets the player car to the random generated vehicle --
						setElementPosition(theVehicle, x, y, z + 0.5) -- sets new player location 4and small boost in case someone gets stuck--
						local health = getElementHealth(theVehicle)
						if health < 1000 then
							setElementHealth(theVehicle,health+200)
						end
					end
				
					if math.random() < discoChance then
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
		setNeonColor(theVehicle,0,255,0)
		destroyElement(discoblips[theVehicle])
		end
	end, 800, 1 )
end


function blowHandler (vehicle)
	if vehicle then
		blowVehicle(vehicle)
	end
end
addEvent("triggerBlow",true)
addEventHandler("triggerBlow",root,blowHandler)


